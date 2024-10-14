/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.Proveedor;

/**
 *
 * @author Bomiki
 */
public class sr_proveedor extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
     Proveedor proveedor;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet sr_proveedor</title>");
            out.println("</head>");
            out.println("<body>");
            
            proveedor = new Proveedor(Integer.parseInt(request.getParameter("txt_id")),request.getParameter("txt_proveedor"),Integer.parseInt(request.getParameter("txt_nit")),request.getParameter("txt_direccion"),request.getParameter("txt_telefono"));
            
            if ("agregar".equals(request.getParameter("btn_agregar"))) {
                if (proveedor.agregar() > 0) {
                    request.getSession().setAttribute("mensaje", "Proveedor agregado con éxito.");
                } else {
                    request.getSession().setAttribute("mensaje", "Error al agregar el Proveedor.");
                }
                response.sendRedirect("index.jsp");
            }
            
            if ("modificar".equals(request.getParameter("btn_modificar"))) {
                if (proveedor.modificar() > 0) {
                    request.getSession().setAttribute("mensaje", "Proveedor modificado con éxito.");
                } else {
                    request.getSession().setAttribute("mensaje", "Error al modificar el proveedor.");
                }
                response.sendRedirect("index.jsp");
            }
            
            if ("eliminar".equals(request.getParameter("btn_eliminar"))) {
                if (proveedor.eliminar() > 0) {
                    request.getSession().setAttribute("mensaje", "Proveedor eliminado con éxito.");
                } else {
                    request.getSession().setAttribute("mensaje", "Error al eliminar el proveedor.");
                }
                response.sendRedirect("index.jsp");
            }
            
            out.println("</body>");
            out.println("</html>");
        
    }
    }
// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// <//*editor-fold>*/
}

