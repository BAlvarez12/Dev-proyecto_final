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
import modelo.Cliente;

/**
 *
 * @author Bomiki
 */
public class sr_cliente extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
     Cliente cliente;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet sr_cliente</title>");
            out.println("</head>");
            out.println("<body>");
            
            String gparametro = request.getParameter("txt_genero");
        int genero = 0;
        if (gparametro != null && !gparametro.isEmpty()) {
            genero = Integer.parseInt(gparametro);
        }
        
            
           cliente = new Cliente(Integer.parseInt(request.getParameter("txt_id")),request.getParameter("txt_nombres"),
                   request.getParameter("txt_apellidos"),Integer.parseInt(request.getParameter("txt_nit")),
                   genero,Integer.parseInt(request.getParameter("txt_telefono")),request.getParameter("txt_ce"),
                   new java.sql.Timestamp(System.currentTimeMillis()));
            
            if ("agregar".equals(request.getParameter("btn_agregar"))) {
                if (cliente.agregar() > 0) {
                    request.getSession().setAttribute("mensaje", "Cliente agregado con éxito.");
                } else {
                    request.getSession().setAttribute("mensaje", "Error al agregar el cliente.");
                }
                response.sendRedirect("index.jsp");
            }
            
            if ("modificar".equals(request.getParameter("btn_modificar"))) {
                if (cliente.modificar() > 0) {
                    request.getSession().setAttribute("mensaje", "Cliente modificado con éxito.");
                } else {
                    request.getSession().setAttribute("mensaje", "Error al modificar el cliente.");
                }
                response.sendRedirect("index.jsp");
            }
            
            if ("eliminar".equals(request.getParameter("btn_eliminar"))) {
                if (cliente.eliminar() > 0) {
                    request.getSession().setAttribute("mensaje", "Cliente eliminado con éxito.");
                } else {
                    request.getSession().setAttribute("mensaje", "Error al eliminar el cliente.");
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

