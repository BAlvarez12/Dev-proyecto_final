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

        System.out.println("=== Iniciando processRequest ===");
        request.getParameterMap().forEach((key, value) -> {
            System.out.println("Parámetro: " + key + " - Valor: " + String.join(", ", value));
        });
        try (PrintWriter out = response.getWriter()) {
            try {
                int estadoInicial = 1;
                String[] productos = request.getParameterValues("drop_producto[]");
                String[] cantidades = request.getParameterValues("txt_cantidad[]");
                String[] preciosUnitarios = request.getParameterValues("txt_precio_unitario[]");

                if (productos == null || cantidades == null || preciosUnitarios == null) {
                    request.getSession().setAttribute("mensaje", "Debe agregar al menos un producto a la venta.");
                    response.sendRedirect("index.jsp");
                    return;
                }

                ventas = new Ventas(
                        Integer.parseInt(request.getParameter("txt_id")),
                        estadoInicial,
                        Integer.parseInt(request.getParameter("txt_no_factura")),
                        Integer.parseInt(request.getParameter("txt_serie")),
                        request.getParameter("txt_fecha_factura"),
                        Integer.parseInt(request.getParameter("drop_cliente")),
                        Integer.parseInt(request.getParameter("drop_empleado")),
                        new java.sql.Timestamp(System.currentTimeMillis())
                );
                if ("agregar".equals(request.getParameter("btn_agregar"))) {
                    System.out.println("Iniciando proceso de agregar venta...");
                    int resultadoAgregarVenta = ventas.agregar();

                    if (resultadoAgregarVenta > 0) {
                        System.out.println("Venta agregada con éxito.");
                        for (int i = 0; i < productos.length; i++) {
                            int idProducto = Integer.parseInt(productos[i]);
                            int cantidad = Integer.parseInt(cantidades[i]);
                            double precioUnitario = Double.parseDouble(preciosUnitarios[i]);
                            
                            if (ventas.agregarDetalle(idProducto, cantidad, precioUnitario) > 0) {
                                System.out.println("Detalle de producto agregado: Producto ID: " + idProducto);
                                Productos producto = new Productos();
                                if (producto.actualizarExistencia(idProducto, cantidad) > 0) {
                                    System.out.println("Stock actualizado para el producto ID: " + idProducto);
                                } else {
                                    System.out.println("Error al actualizar el stock del producto ID: " + idProducto);
                                    request.getSession().setAttribute("mensaje", "Venta agregada, pero hubo un error al actualizar el stock del producto ID: " + idProducto);
                                }
                            } else {
                                System.out.println("Error al agregar detalle de venta para el producto ID: " + idProducto);
                                request.getSession().setAttribute("mensaje", "Venta agregada, pero hubo un error al agregar detalles de los productos.");
                            }
                        }
                        
                        request.getSession().setAttribute("mensaje", "Venta agregada y detalles registrados con éxito.");
                    } else {
                        System.out.println("Error al agregar la venta.");
                        request.getSession().setAttribute("mensaje", "Error al agregar la venta.");
                    }
                    response.sendRedirect("index.jsp");
                    return;
                }
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
                e.printStackTrace();
                request.getSession().setAttribute("mensaje", "Ocurrió un error durante el procesamiento: " + e.getMessage());
                response.sendRedirect("index.jsp");
            }
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
