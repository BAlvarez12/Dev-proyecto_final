package controlador;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import modelo.Conexion;

public class login extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Obtener parámetros del formulario de login
        String username = request.getParameter("username").trim();
        String password = request.getParameter("password").trim();
        // Crear instancia de la clase Conexion
        Conexion cn = new Conexion();
        cn.abrir_conexion();

        try {
            // Verificar si la conexión fue exitosa
            if (cn.conexionDB == null) {
                System.out.println("Error: Conexion a la base de datos fallida.");
                response.sendRedirect("home.jsp?error=1");
                return;
            }
            String query = "SELECT * FROM usuarios WHERE usuario = ? AND contrasena = ?";
            PreparedStatement parametro = cn.conexionDB.prepareStatement(query);
            parametro.setString(1, username);
            parametro.setString(2, password);
            ResultSet rs = parametro.executeQuery();

            if (rs.next()) {
                // Usuario y contraseña correctos
                HttpSession session = request.getSession();
                session.setAttribute("usuario", username);
                System.out.println("Inicio de sesión exitoso para el usuario: " + username);
                response.sendRedirect("index.jsp");
            } else {
                // Usuario o contraseña incorrectos
                System.out.println("Credenciales incorrectas para el usuario: " + username);
                response.sendRedirect("home.jsp?error=1");
            }
        } catch (SQLException ex) {
            System.out.println("Error al autenticar el usuario: " + ex.getMessage());
            response.sendRedirect("home.jsp?error=1");
        } finally {
            cn.cerrar_conexion();
        }
    }
}