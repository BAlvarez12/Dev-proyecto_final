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
public class Ventas {
    private String fecha_factura;
    private int no_factura, serie, id_cliente, id_empleado, id_venta, id_producto, cantidad;
    private double precio_unitario;
    private java.sql.Timestamp fecha_ingreso;
    private Conexion cn;

    
    
    public Ventas (){
        
    }
    
    public Ventas( int no_factura, int serie, String fecha_factura,int id_cliente,int id_empleado, Timestamp fecha_ingreso, int id_venta, int id_producto,int cantidad, double precio_unitario ) {
        this.no_factura = no_factura;
        this.serie = serie;
        this.fecha_factura = fecha_factura;
        this.id_cliente = id_cliente;
        this.id_empleado = id_empleado;
        this.fecha_ingreso = fecha_ingreso;
        this.id_venta = id_venta;
        this.id_producto = id_producto;
        this.cantidad = cantidad;
        this.precio_unitario = precio_unitario;
    }
    
    public String getFecha_factura() {
        return fecha_factura;
    }

    public void setFecha_factura(String fecha_factura) {
        this.fecha_factura = fecha_factura;
    }

    public int getNo_factura() {
        return no_factura;
    }

    public void setNo_factura(int no_factura) {
        this.no_factura = no_factura;
    }

    public int getSerie() {
        return serie;
    }

    public void setSerie(int serie) {
        this.serie = serie;
    }

    public int getId_cliente() {
        return id_cliente;
    }

    public void setId_cliente(int id_cliente) {
        this.id_cliente = id_cliente;
    }

    public int getId_empleado() {
        return id_empleado;
    }

    public void setId_empleado(int id_empleado) {
        this.id_empleado = id_empleado;
    }

    public int getId_venta() {
        return id_venta;
    }

    public void setId_venta(int id_venta) {
        this.id_venta = id_venta;
    }

    public int getId_producto() {
        return id_producto;
    }

    public void setId_producto(int id_producto) {
        this.id_producto = id_producto;
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

    public java.sql.Timestamp getFecha_ingreso() {
        return fecha_ingreso;
    }

    public void setFecha_ingreso(java.sql.Timestamp fecha_ingreso) {
        this.fecha_ingreso = fecha_ingreso;
    }
    
    
    // Metodo leer productos
   public DefaultTableModel leer() {
    DefaultTableModel tabla = new DefaultTableModel();
    try {
        cn = new Conexion();
        cn.abrir_conexion();
        String query = "select a.id_venta , a.no_factura , a.serie , a.fecha_factura , s.id_cliente , CONCAT(s.nombres, ' ', s.apellidos) AS cliente , d.id_empleados , "
                + "CONCAT(d.nombres , ' ', d.apellidos ) AS empleado ,a.fecha_ingreso , x.id_producto , c.producto , x.cantidad , x.precio_unitario from ventas a "
                + " inner join clientes s on s.id_cliente = a.id_cliente inner join empleados d on d.id_empleados = a.id_empleado "
                + "inner join ventas_detalle x on x.id_venta = a.id_venta inner join productos c on c.id_producto = x.id_producto order by a.id_venta asc;";
        ResultSet consulta = cn.conexionDB.createStatement().executeQuery(query);
        String encabezado[] = {"id_venta", "no_factura", "serie", "fecha_factura", "id_cliente", "cliente", "id_empleados", "empleado", "fecha_ingreso", "id_producto", "producto", "cantidad", "precio_unitario"};
        tabla.setColumnIdentifiers(encabezado);
        String datos[] = new String[13];
        while (consulta.next()) {
            datos[0] = consulta.getString("id_venta");
            datos[1] = consulta.getString("no_factura");
            datos[2] = consulta.getString("serie");
            datos[3] = consulta.getString("fecha_factura");
            datos[4] = consulta.getString("id_cliente");
            datos[5] = consulta.getString("cliente");
            datos[6] = consulta.getString("id_empleados");
            datos[7] = consulta.getString("empleado");
            datos[8] = consulta.getString("fecha_ingreso");
            datos[9] = consulta.getString("id_producto");
            datos[10] = consulta.getString("producto");
            datos[11] = consulta.getString("cantidad");
            datos[12] = consulta.getString("precio_unitario");
            tabla.addRow(datos);
        }

        cn.cerrar_conexion();
    } catch (SQLException ex) {
        System.out.println(ex.getMessage());
    }

    return tabla;
}
    
     public int agregar() {
    int retorno = 0;
    try {
        PreparedStatement parametro;
        cn = new Conexion();
        String query = "INSERT INTO ventas (no_factura, serie, fecha_factura, id_cliente, id_empleado, fecha_ingreso) VALUES (?, ?, ?, ?, ?, ?);";
        cn.abrir_conexion();
        
        parametro = cn.conexionDB.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
        parametro.setInt(1, getNo_factura());
        parametro.setInt(2, getSerie());
        parametro.setString(3, getFecha_factura());
        parametro.setInt(4, getId_cliente());
        parametro.setInt(5, getId_empleado());
        parametro.setTimestamp(6, getFecha_ingreso());
        retorno = parametro.executeUpdate();

        // Obtener el id generado para la venta
        ResultSet generatedKeys = parametro.getGeneratedKeys();
        int idVentaGenerado = 0;
        if (generatedKeys.next()) {
            idVentaGenerado = generatedKeys.getInt(1);
        }

        // Insertar detalle de venta usando el id generado
        if (idVentaGenerado > 0) {
            query = "INSERT INTO ventas_detalle (id_venta, id_producto, cantidad, precio_unitario) VALUES (?, ?, ?, ?);";
            parametro = cn.conexionDB.prepareStatement(query);
            parametro.setInt(1, idVentaGenerado); // Usar el id generado
            parametro.setInt(2, getId_producto());
            parametro.setInt(3, getCantidad());
            parametro.setDouble(4, getPrecio_unitario());
            retorno += parametro.executeUpdate();
        }
        
        cn.cerrar_conexion();
    } catch (SQLException ex) {
        System.out.println("Error al insertar la venta: " + ex.getMessage());
        retorno = 0;
    }
    return retorno;
}


    // Metodo modificar venta
    public int modificar() {
        int retorno = 0;
        try {
            PreparedStatement parametro;
            cn = new Conexion();
            String query = "UPDATE ventas SET no_factura=?, serie=?, fecha_factura=?, id_cliente=?, id_empleado=?, fecha_ingreso=? WHERE id_venta=?;";
            cn.abrir_conexion();
            parametro = cn.conexionDB.prepareStatement(query);
            parametro.setInt(1, getNo_factura());
            parametro.setInt(2, getSerie());
            parametro.setString(3, getFecha_factura());
            parametro.setInt(4, getId_cliente());
            parametro.setInt(5, getId_empleado());
            parametro.setTimestamp(6, getFecha_ingreso());
            parametro.setInt(7, getId_venta());
            retorno = parametro.executeUpdate();

            // Modificar detalle de venta
            query = "UPDATE ventas_detalle SET id_producto=?, cantidad=?, precio_unitario=? WHERE id_venta=?;";
            parametro = cn.conexionDB.prepareStatement(query);
            parametro.setInt(1, getId_producto());
            parametro.setInt(2, getCantidad());
            parametro.setDouble(3, getPrecio_unitario());
            parametro.setInt(4, getId_venta());
            retorno += parametro.executeUpdate();
            
            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println("Error al modificar la venta: " + ex.getMessage());
            retorno = 0;
        }
        return retorno;
    }

    // Metodo eliminar venta
    public int eliminar() {
        int retorno = 0;
        try {
            PreparedStatement parametro;
            cn = new Conexion();
            String query = "DELETE FROM ventas_detalle WHERE id_venta=?;";
            cn.abrir_conexion();
            parametro = cn.conexionDB.prepareStatement(query);
            parametro.setInt(1, getId_venta());
            retorno = parametro.executeUpdate();

            // Eliminar venta principal
            query = "DELETE FROM ventas WHERE id_venta=?;";
            parametro = cn.conexionDB.prepareStatement(query);
            parametro.setInt(1, getId_venta());
            retorno += parametro.executeUpdate();
            
            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println("Error al eliminar la venta: " + ex.getMessage());
            retorno = 0;
        }
        return retorno;
    }
}
