package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.Productos;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "checkStock", urlPatterns = {"/checkStock"})
public class Stock extends HttpServlet {
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            try {
                String idProductoStr = request.getParameter("id_producto");
                String cantidadStr = request.getParameter("cantidad");

                if (idProductoStr == null || cantidadStr == null) {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    out.print("{\"status\": \"ERROR\", \"message\": \"Parámetros faltantes.\"}");
                    return;
                }
                int id_producto = Integer.parseInt(idProductoStr);
                int cantidad = Integer.parseInt(cantidadStr);
                Productos producto = new Productos();
                int existencia = producto.Existencia(id_producto);
                if (existencia >= cantidad) {
                    out.print("{\"status\": \"OK\", \"message\": \"Stock suficiente.\"}");
                } else {
                    out.print("{\"status\": \"ERROR\", \"message\": \"Stock insuficiente. Solo hay " + existencia + " unidades disponibles.\"}");
                }
            } catch (NumberFormatException e) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"status\": \"ERROR\", \"message\": \"Parámetros incorrectos.\"}");
            } catch (Exception e) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                out.print("{\"status\": \"ERROR\", \"message\": \"Ocurrió un error en el servidor: " + e.getMessage() + "\"}");
                e.printStackTrace();
            }
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
        return "Servlet para verificar la existencia de stock de un producto";
    }
}
