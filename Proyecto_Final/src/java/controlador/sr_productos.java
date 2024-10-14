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
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;
import java.io.File;
import modelo.Productos;

/**
 *
 * @author Bomiki
 */

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,
    maxFileSize = 1024 * 1024 * 10,      
    maxRequestSize = 1024 * 1024 * 50     
)
public class sr_productos extends HttpServlet {

    Productos productos;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet sr_productos</title>");
            out.println("</head>");
            out.println("<body>");
           
            Part filePart = request.getPart("file_imagen");
            String fileName = getFileName(filePart);
            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";

            // Crear el directorio si no existe
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }
            // Guardar el archivo en el servidor
            String filePath = uploadPath + File.separator + fileName;
            filePart.write(filePath);
            // La URL que se guarda en la base de datos
            String imageUrl = "uploads/" + fileName;

            Productos producto = new Productos(
                    Integer.parseInt(request.getParameter("txt_id")),
                    request.getParameter("txt_producto"),
                    Integer.parseInt(request.getParameter("drop_marca")),
                    request.getParameter("txt_descripcion"),
                    imageUrl,
                    Double.parseDouble(request.getParameter("txt_precio")),
                    Double.parseDouble(request.getParameter("txt_precio_v")),
                    request.getParameter("txt_existencia"),
                    new java.sql.Timestamp(System.currentTimeMillis())
            );

            if ("agregar".equals(request.getParameter("btn_agregar"))) {
                if (producto.agregar() > 0) {
                    request.getSession().setAttribute("mensaje", "Producto agregado con éxito.");
                } else {
                    request.getSession().setAttribute("mensaje", "Error al agregar el producto.");
                }
                response.sendRedirect("index.jsp");
            }
            
            if ("modificar".equals(request.getParameter("btn_modificar"))) {
                if (producto.modificar() > 0) {
                    request.getSession().setAttribute("mensaje", "Producto modificado con éxito.");
                } else {
                    request.getSession().setAttribute("mensaje", "Error al modificar el producto.");
                }
                response.sendRedirect("index.jsp");
            }
            if ("eliminar".equals(request.getParameter("btn_eliminar"))) {
                if (producto.eliminar() > 0) {
                    request.getSession().setAttribute("mensaje", "Producto eliminado con éxito.");
                } else {
                    request.getSession().setAttribute("mensaje", "Error al eliminar el producto.");
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

    private String getFileName(Part filePart) {
        String contentDisposition = filePart.getHeader("content-disposition");
        for (String content : contentDisposition.split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf("=") + 2, content.length() - 1);
            }
        }
        return "unknown";
    }
}
