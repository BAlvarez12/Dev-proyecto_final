package controlador;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.Roles;

public class sr_roles extends HttpServlet {

    Roles roles;
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet sr_rol</title>");
            out.println("</head>");
            out.println("<body>");
            
            roles = new Roles(Integer.parseInt(request.getParameter("txt_id")), request.getParameter("txt_rol"));
            
            if ("agregar".equals(request.getParameter("btn_agregar"))) {
                if (roles.agregar() > 0) {
                    request.getSession().setAttribute("mensaje", "Rol agregado con éxito.");
                } else {
                    request.getSession().setAttribute("mensaje", "Error al agregar el rol.");
                }
                response.sendRedirect("index.jsp");
            }
            
            if ("modificar".equals(request.getParameter("btn_modificar"))) {
                if (roles.modificar() > 0) {
                    request.getSession().setAttribute("mensaje", "Rol modificado con éxito.");
                } else {
                    request.getSession().setAttribute("mensaje", "Error al modificar el rol.");
                }
                response.sendRedirect("index.jsp");
            }
            
            if ("eliminar".equals(request.getParameter("btn_eliminar"))) {
                if (roles.eliminar() > 0) {
                    request.getSession().setAttribute("mensaje", "Rol eliminado con éxito.");
                } else {
                    request.getSession().setAttribute("mensaje", "Error al eliminar el rol.");
                }
                response.sendRedirect("index.jsp");
            }

            out.println("</body>");
            out.println("</html>");
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