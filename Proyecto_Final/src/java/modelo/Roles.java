package modelo;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import javax.swing.table.DefaultTableModel;

public class Roles {
    private int id_rol;
    private String rol;
    private Conexion cn;

    public Roles() {}

    public Roles(int id_rol, String rol) {
        this.id_rol = id_rol;
        this.rol = rol;
    }

    public int getId_rol() {
        return id_rol;
    }

    public void setId_rol(int id_rol) {
        this.id_rol = id_rol;
    }

    public String getRol() {
        return rol;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }

    // Metodo cargar roles
    public HashMap<String, String> drop_rol() {
        HashMap<String, String> drop = new HashMap<>();
        try {
            cn = new Conexion();
            String query = "select id_rol, roles from roles;";
            cn.abrir_conexion();
            ResultSet consulta = cn.conexionDB.createStatement().executeQuery(query);
            while (consulta.next()) {
                drop.put(consulta.getString("id_rol"), consulta.getString("roles"));
            }
            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return drop;
    }

    // Metodo leer roles
    public DefaultTableModel leer() {
        DefaultTableModel tabla = new DefaultTableModel();
        try {
            cn = new Conexion();
            cn.abrir_conexion();
            String query = "select id_rol, roles from roles order by id_rol asc;";
            ResultSet consulta = cn.conexionDB.createStatement().executeQuery(query);
            String encabezado[] = {"id_rol", "roles"};
            tabla.setColumnIdentifiers(encabezado);
            String datos[] = new String[2];
            while (consulta.next()) {
                datos[0] = consulta.getString("id_rol");
                datos[1] = consulta.getString("roles");
                tabla.addRow(datos);
            }
            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return tabla;
    }

    // Metodo insertar rol
    public int agregar() {
        int retorno = 0;
        try {
            PreparedStatement parametro;
            cn = new Conexion();
            String query = "INSERT INTO roles (roles) VALUES (?);";
            cn.abrir_conexion();
            parametro = cn.conexionDB.prepareStatement(query);
            parametro.setString(1, getRol());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println("Error al insertar el rol: " + ex.getMessage());
            retorno = 0;
        }
        return retorno;
    }

    // Metodo modificar rol
    public int modificar() {
        int retorno = 0;
        try {
            PreparedStatement parametro;
            cn = new Conexion();
            String query = "UPDATE roles SET roles = ? WHERE id_rol = ?;";
            cn.abrir_conexion();
            parametro = cn.conexionDB.prepareStatement(query);
            parametro.setString(1, getRol());
            parametro.setInt(2, getId_rol());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println("Error al modificar el rol: " + ex.getMessage());
            retorno = 0;
        }
        return retorno;
    }

    // Metodo eliminar rol
    public int eliminar() {
        int retorno = 0;
        try {
            PreparedStatement parametro;
            cn = new Conexion();
            String query = "DELETE FROM roles WHERE id_rol = ?;";
            cn.abrir_conexion();
            parametro = cn.conexionDB.prepareStatement(query);
            parametro.setInt(1, getId_rol());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println("Error al eliminar el rol: " + ex.getMessage());
            retorno = 0;
        }
        return retorno;
    }
}