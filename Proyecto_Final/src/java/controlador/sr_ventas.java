package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.Ventas;
import modelo.Productos;

public class sr_ventas extends HttpServlet {

    Ventas ventas;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Logging para depuración
        System.out.println("=== Iniciando processRequest ===");
        request.getParameterMap().forEach((key, value) -> {
            System.out.println("Parámetro: " + key + " - Valor: " + String.join(", ", value));
        });

        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet sr_ventas</title>");
            out.println("</head>");
            out.println("<body>");

            try {
                int estadoInicial = 1;

                ventas = new Ventas(
                        Integer.parseInt(request.getParameter("txt_id")),
                        estadoInicial,
                        Integer.parseInt(request.getParameter("txt_no_factura")),
                        Integer.parseInt(request.getParameter("txt_serie")),
                        request.getParameter("txt_fecha_factura"),
                        Integer.parseInt(request.getParameter("drop_cliente")),
                        Integer.parseInt(request.getParameter("drop_empleado")),
                        new java.sql.Timestamp(System.currentTimeMillis()),
                        Integer.parseInt(request.getParameter("drop_producto")),
                        Integer.parseInt(request.getParameter("txt_cantidad")),
                        Double.parseDouble(request.getParameter("txt_precio_unitario"))
                );

                // Manejar la solicitud para agregar una venta
                if ("agregar".equals(request.getParameter("btn_agregar"))) {
                    System.out.println("Iniciando proceso de agregar venta...");
                    if (ventas.agregar() > 0) {
                        System.out.println("Venta agregada con éxito.");

                        // Actualizar la existencia del producto
                        Productos producto = new Productos();
                        int id_producto = Integer.parseInt(request.getParameter("drop_producto"));
                        int cantidadVendida = Integer.parseInt(request.getParameter("txt_cantidad"));

                        if (producto.actualizarExistencia(id_producto, cantidadVendida) > 0) {
                            System.out.println("Stock actualizado con éxito.");
                            request.getSession().setAttribute("mensaje", "Venta agregada y stock actualizado con éxito.");
                        } else {
                            System.out.println("Error al actualizar el stock del producto.");
                            request.getSession().setAttribute("mensaje", "Venta agregada, pero no se pudo actualizar el stock.");
                        }
                    } else {
                        System.out.println("Error al agregar la venta.");
                        request.getSession().setAttribute("mensaje", "Error al agregar la venta.");
                    }
                    response.sendRedirect("index.jsp");
                    return;
                }

                // Manejar la solicitud para anular una venta
                if ("anular".equals(request.getParameter("btn_anular"))) {
                    System.out.println("Iniciando proceso de anular venta...");
                    ventas.setId_venta(Integer.parseInt(request.getParameter("txt_id")));
                    if (ventas.anular() > 0) {
                        System.out.println("Venta anulada con éxito.");
                        request.getSession().setAttribute("mensaje", "Venta anulada con éxito.");
                    } else {
                        System.out.println("Error al anular la venta.");
                        request.getSession().setAttribute("mensaje", "Error al anular la venta.");
                    }
                    response.sendRedirect("index.jsp");
                    return;
                }
            } catch (Exception e) {
                System.out.println("Error durante el procesamiento: " + e.getMessage());
                e.printStackTrace(); // Imprimir la traza de la excepción para depuración
                request.getSession().setAttribute("mensaje", "Ocurrió un error durante el procesamiento: " + e.getMessage());
                response.sendRedirect("index.jsp");
            }

            out.println("</body>");
            out.println("</html>");
        } catch (Exception e) {
            System.out.println("Error al escribir la respuesta: " + e.getMessage());
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
