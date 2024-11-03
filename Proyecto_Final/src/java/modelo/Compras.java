/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.Timestamp;
import javax.swing.table.DefaultTableModel;
import java.sql.Statement;

/**
 *
 * @author Bomiki
 */
public class Compras {
    private String fecha_orden;
    private int no_orden, id_proveedores, id_producto, id_compra, cantidad, estado;
    private double precio_unitario;
    private java.sql.Timestamp fecha_ingreso;
    private Conexion cn;

    public Compras() {
    }

    public Compras(int id_compra, int no_orden, int id_proveedores, String fecha_orden, Timestamp fecha_ingreso, int id_producto, int cantidad, double precio_unitario, int estado) {
        this.id_compra = id_compra;
        this.no_orden = no_orden;
        this.id_proveedores = id_proveedores;
        this.fecha_orden = fecha_orden;
        this.fecha_ingreso = fecha_ingreso;
        this.id_producto = id_producto;
        this.cantidad = cantidad;
        this.precio_unitario = precio_unitario;
        this.estado = estado;
    }

    public String getFecha_orden() {
        return fecha_orden;
    }

    public void setFecha_orden(String fecha_orden) {
        this.fecha_orden = fecha_orden;
    }

    public int getNo_orden() {
        return no_orden;
    }

    public void setNo_orden(int no_orden) {
        this.no_orden = no_orden;
    }

    public int getId_proveedores() {
        return id_proveedores;
    }

    public void setId_proveedores(int id_proveedores) {
        this.id_proveedores = id_proveedores;
    }

    public int getId_producto() {
        return id_producto;
    }

    public void setId_producto(int id_producto) {
        this.id_producto = id_producto;
    }

    public int getId_compra() {
        return id_compra;
    }

    public void setId_compra(int id_compra) {
        this.id_compra = id_compra;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public double getPrecio_unitario() {
        return precio_unitario;
    }

    public void setPrecio_unitario(double precio_unitario) {
        this.precio_unitario = precio_unitario;
    }

    public Timestamp getFecha_ingreso() {
        return fecha_ingreso;
    }

    public void setFecha_ingreso(Timestamp fecha_ingreso) {
        this.fecha_ingreso = fecha_ingreso;
    }

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

    // Metodo leer compras
    public DefaultTableModel leer() {
        DefaultTableModel tabla = new DefaultTableModel();
        try {
            cn = new Conexion();
            cn.abrir_conexion();
            String query = "select t.id_compra, t.no_orden_compra, t.id_proveedores, a.proveedor, t.fecha_orden, t.fecha_ingreso, "
                    + "s.id_producto, x.producto, s.cantidad, s.precio_costo_unitario, t.estado from compras t inner join proveedores a on a.id_proveedores = t.id_proveedores "
                    + "inner join compras_detalle s on s.id_compra = t.id_compra inner join productos x on x.id_producto = s.id_producto where t.estado = 1";
            ResultSet consulta = cn.conexionDB.createStatement().executeQuery(query);
            String encabezado[] = {"id_compra", "no_orden_compra", "id_proveedores", "proveedor", "fecha_orden", "fecha_ingreso", "id_producto", "producto", "cantidad", "precio_costo_unitario", "estado"};
            tabla.setColumnIdentifiers(encabezado);
            String datos[] = new String[11];
            while (consulta.next()) {
                datos[0] = consulta.getString("id_compra");
                datos[1] = consulta.getString("no_orden_compra");
                datos[2] = consulta.getString("id_proveedores");
                datos[3] = consulta.getString("proveedor");
                datos[4] = consulta.getString("fecha_orden");
                datos[5] = consulta.getString("fecha_ingreso");
                datos[6] = consulta.getString("id_producto");
                datos[7] = consulta.getString("producto");
                datos[8] = consulta.getString("cantidad");
                datos[9] = consulta.getString("precio_costo_unitario");
                datos[10] = consulta.getString("estado");
                tabla.addRow(datos);
            }

            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }

        return tabla;
    }

    // Metodo agregar compra
    public int agregar() {
        int retorno = 0;
        try {
            PreparedStatement parametro;
            cn = new Conexion();
            String query = "INSERT INTO compras (no_orden_compra, id_proveedores, fecha_orden, fecha_ingreso, estado) VALUES (?, ?, ?, ?, ?);";
            cn.abrir_conexion();

            parametro = cn.conexionDB.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            parametro.setInt(1, getNo_orden());
            parametro.setInt(2, getId_proveedores());
            parametro.setString(3, getFecha_orden());
            parametro.setTimestamp(4, getFecha_ingreso());
            parametro.setInt(5, getEstado());
            retorno = parametro.executeUpdate();

            // Obtener el id generado para la compra
            ResultSet generatedKeys = parametro.getGeneratedKeys();
            int idCompraGenerado = 0;
            if (generatedKeys.next()) {
                idCompraGenerado = generatedKeys.getInt(1);
            }

            // Insertar detalle de compra usando el id generado
            if (idCompraGenerado > 0) {
                query = "INSERT INTO compras_detalle (id_compra, id_producto, cantidad, precio_costo_unitario) VALUES (?, ?, ?, ?);";
                parametro = cn.conexionDB.prepareStatement(query);
                parametro.setInt(1, idCompraGenerado); // Usar el id generado
                parametro.setInt(2, getId_producto());
                parametro.setInt(3, getCantidad());
                parametro.setDouble(4, getPrecio_unitario());
                retorno += parametro.executeUpdate();
            }

            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println("Error al insertar la compra: " + ex.getMessage());
            retorno = 0;
        }
        return retorno;
    }

    // Metodo modificar compra
    public int modificar() {
        int retorno = 0;
        try {
            PreparedStatement parametro;
            cn = new Conexion();
            String query = "UPDATE compras SET no_orden_compra=?, id_proveedores=?, fecha_orden=?, fecha_ingreso=?, estado=? WHERE id_compra=?;";
            cn.abrir_conexion();
            parametro = cn.conexionDB.prepareStatement(query);
            parametro.setInt(1, getNo_orden());
            parametro.setInt(2, getId_proveedores());
            parametro.setString(3, getFecha_orden());
            parametro.setTimestamp(4, getFecha_ingreso());
            parametro.setInt(5, getEstado());
            parametro.setInt(6, getId_compra());
            retorno = parametro.executeUpdate();

            // Modificar detalle de compra
            query = "UPDATE compras_detalle SET id_producto=?, cantidad=?, precio_costo_unitario=? WHERE id_compra=?;";
            parametro = cn.conexionDB.prepareStatement(query);
            parametro.setInt(1, getId_producto());
            parametro.setInt(2, getCantidad());
            parametro.setDouble(3, getPrecio_unitario());
            parametro.setInt(4, getId_compra());
            retorno += parametro.executeUpdate();

            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println("Error al modificar la compra: " + ex.getMessage());
            retorno = 0;
        }
        return retorno;
    }

    // Metodo anular compra
    public int anular() {
        int retorno = 0;
        try {
            PreparedStatement parametro;
            cn = new Conexion();
            String query = "UPDATE compras SET estado = 0 WHERE id_compra=?;";
            cn.abrir_conexion();
            parametro = cn.conexionDB.prepareStatement(query);
            parametro.setInt(1, getId_compra());
            retorno = parametro.executeUpdate();

            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println("Error al anular la compra: " + ex.getMessage());
            retorno = 0;
        }
        return retorno;
    }
}