package modelo;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import javax.swing.table.DefaultTableModel;

public class Usuarios {
    private String usuario, nombres, apellidos, correo_electronico, contrasena;
    private int id_usuario, id_rol;
    private Conexion cn;

    public Usuarios() {}

    public Usuarios(int id_usuario, String usuario, String nombres, String apellidos, String correo_electronico, String contrasena, int id_rol) {
        this.id_usuario = id_usuario;
        this.usuario = usuario;
        this.nombres = nombres;
        this.apellidos = apellidos;
        this.correo_electronico = correo_electronico;
        this.contrasena = contrasena;
        this.id_rol = id_rol;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getNombres() {
        return nombres;
    }

    public void setNombres(String nombres) {
        this.nombres = nombres;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public String getCorreo_electronico() {
        return correo_electronico;
    }

    public void setCorreo_electronico(String correo_electronico) {
        this.correo_electronico = correo_electronico;
    }

    public String getContrasena() {
        return contrasena;
    }

    public void setContrasena(String contrasena) {
        this.contrasena = contrasena;
    }

    public int getId_usuario() {
        return id_usuario;
    }

    public void setId_usuario(int id_usuario) {
        this.id_usuario = id_usuario;
    }

    public int getId_rol() {
        return id_rol;
    }

    public void setId_rol(int id_rol) {
        this.id_rol = id_rol;
    }

    // Metodo leer usuarios
    public DefaultTableModel leer() {
        DefaultTableModel tabla = new DefaultTableModel();
        try {
            cn = new Conexion();
            cn.abrir_conexion();
            String query = "select a.id_usuarios, a.usuario, a.nombres, a.apellidos, a.correo_electronico, a.contrasena, a.id_rol , d.roles from usuarios a inner join roles d on d.id_rol = a.id_rol order by id_usuarios asc;";
            ResultSet consulta = cn.conexionDB.createStatement().executeQuery(query);
            String encabezado[] = {"id_usuarios", "usuario", "nombres", "apellidos", "correo_electronico", "contrasena", "id_rol", "roles"};
            tabla.setColumnIdentifiers(encabezado);
            String datos[] = new String[8];
            while (consulta.next()) {
                datos[0] = consulta.getString("id_usuarios");
                datos[1] = consulta.getString("usuario");
                datos[2] = consulta.getString("nombres");
                datos[3] = consulta.getString("apellidos");
                datos[4] = consulta.getString("correo_electronico");
                datos[5] = consulta.getString("contrasena");
                datos[6] = consulta.getString("id_rol");
                datos[7] = consulta.getString("roles");
                tabla.addRow(datos);
            }
            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return tabla;
    }

    // Metodo insertar usuario
    public int agregar() {
        int retorno = 0;
        try {
            PreparedStatement parametro;
            cn = new Conexion();
            String query = "INSERT INTO usuarios (usuario, nombres, apellidos, correo_electronico, contrasena, id_rol) VALUES (?, ?, ?, ?, ?, ?);";
            cn.abrir_conexion();
            parametro = cn.conexionDB.prepareStatement(query);
            parametro.setString(1, getUsuario());
            parametro.setString(2, getNombres());
            parametro.setString(3, getApellidos());
            parametro.setString(4, getCorreo_electronico());
            parametro.setString(5, getContrasena());
            parametro.setInt(6, getId_rol());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println("Error al insertar el usuario: " + ex.getMessage());
            retorno = 0;
        }
        return retorno;
    }

    // Metodo modificar usuario
    public int modificar() {
        int retorno = 0;
        try {
            PreparedStatement parametro;
            cn = new Conexion();
            String query = "UPDATE usuarios SET usuario = ?, nombres = ?, apellidos = ?, correo_electronico = ?, contrasena = ?, id_rol = ? WHERE id_usuarios = ?;";
            cn.abrir_conexion();
            parametro = cn.conexionDB.prepareStatement(query);
            parametro.setString(1, getUsuario());
            parametro.setString(2, getNombres());
            parametro.setString(3, getApellidos());
            parametro.setString(4, getCorreo_electronico());
            parametro.setString(5, getContrasena());
            parametro.setInt(6, getId_rol());
            parametro.setInt(7, getId_usuario());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println("Error al modificar el usuario: " + ex.getMessage());
            retorno = 0;
        }
        return retorno;
    }

    // Metodo eliminar usuario
    public int eliminar() {
        int retorno = 0;
        try {
            PreparedStatement parametro;
            cn = new Conexion();
            String query = "DELETE FROM usuarios WHERE id_usuarios = ?;";
            cn.abrir_conexion();
            parametro = cn.conexionDB.prepareStatement(query);
            parametro.setInt(1, getId_usuario());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println("Error al eliminar el usuario: " + ex.getMessage());
            retorno = 0;
        }
        return retorno;
    }
}