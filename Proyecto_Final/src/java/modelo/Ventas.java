package modelo;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.Timestamp;
import javax.swing.table.DefaultTableModel;
import java.sql.Statement;

public class Ventas {
    private String fecha_factura;
    private int no_factura, serie, id_cliente, id_empleado, id_venta, id_producto, cantidad, estado;
    private double precio_unitario;
    private java.sql.Timestamp fecha_ingreso;
    private Conexion cn;

    public Ventas (){
    }

    public Ventas(int id_venta, int estado, int no_factura, int serie, String fecha_factura,int id_cliente,int id_empleado, Timestamp fecha_ingreso) {
        this.no_factura = no_factura;
        this.serie = serie;
        this.fecha_factura = fecha_factura;
        this.id_cliente = id_cliente;
        this.id_empleado = id_empleado;
        this.fecha_ingreso = fecha_ingreso;
        this.id_venta = id_venta;
        this.estado = estado;
    }

    public String getFecha_factura() {
        return fecha_factura;
    }

    public void setFecha_factura(String fecha_factura) {
        this.fecha_factura = fecha_factura;
    }

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
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
            String query = "select a.id_venta , a.no_factura , a.serie , a.fecha_factura, a.estado, s.id_cliente , CONCAT(s.nombres, ' ', s.apellidos) AS cliente , d.id_empleados , "
                    + "CONCAT(d.nombres , ' ', d.apellidos ) AS empleado ,a.fecha_ingreso , x.id_producto , c.producto , x.cantidad , x.precio_unitario from ventas a "
                    + " inner join clientes s on s.id_cliente = a.id_cliente inner join empleados d on d.id_empleados = a.id_empleado "
                    + "inner join ventas_detalle x on x.id_venta = a.id_venta inner join productos c on c.id_producto = x.id_producto where a.estado = 1 order by a.id_venta asc;";
            ResultSet consulta = cn.conexionDB.createStatement().executeQuery(query);
            String encabezado[] = {"id_venta", "no_factura", "serie", "fecha_factura", "estado" , "id_cliente", "cliente", "id_empleados", "empleado", "fecha_ingreso", "id_producto", "producto", "cantidad", "precio_unitario"};
            tabla.setColumnIdentifiers(encabezado);
            String datos[] = new String[14];
            while (consulta.next()) {
                datos[0] = consulta.getString("id_venta");
                datos[1] = consulta.getString("no_factura");
                datos[2] = consulta.getString("serie");
                datos[3] = consulta.getString("fecha_factura");
                datos[4] = consulta.getString("estado");
                datos[5] = consulta.getString("id_cliente");
                datos[6] = consulta.getString("cliente");
                datos[7] = consulta.getString("id_empleados");
                datos[8] = consulta.getString("empleado");
                datos[9] = consulta.getString("fecha_ingreso");
                datos[10] = consulta.getString("id_producto");
                datos[11] = consulta.getString("producto");
                datos[12] = consulta.getString("cantidad");
                datos[13] = consulta.getString("precio_unitario");
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
            String query = "INSERT INTO ventas (no_factura, serie, fecha_factura, estado, id_cliente, id_empleado, fecha_ingreso) VALUES (?, ?, ?, ?, ?, ?, ?);";
            cn.abrir_conexion();

            parametro = cn.conexionDB.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            parametro.setInt(1, getNo_factura());
            parametro.setInt(2, getSerie());
            parametro.setString(3, getFecha_factura());
            parametro.setInt(4, getEstado());
            parametro.setInt(5, getId_cliente());
            parametro.setInt(6, getId_empleado());
            parametro.setTimestamp(7, getFecha_ingreso());
            retorno = parametro.executeUpdate();

            // Obtener el id generado para la venta
            ResultSet generatedKeys = parametro.getGeneratedKeys();
            if (generatedKeys.next()) {
                this.id_venta = generatedKeys.getInt(1);
            }

            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println("Error al insertar la venta: " + ex.getMessage());
            retorno = 0;
        }
        return retorno;
    }

    // Método para agregar detalles de venta
    public int agregarDetalle(int idProducto, int cantidad, double precioUnitario) {
        int retorno = 0;
        try {
            PreparedStatement parametro;
            cn = new Conexion();
            String query = "INSERT INTO ventas_detalle (id_venta, id_producto, cantidad, precio_unitario) VALUES (?, ?, ?, ?);";
            cn.abrir_conexion();

            parametro = cn.conexionDB.prepareStatement(query);
            parametro.setInt(1, this.id_venta);
            parametro.setInt(2, idProducto);
            parametro.setInt(3, cantidad);
            parametro.setDouble(4, precioUnitario);
            retorno = parametro.executeUpdate();

            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println("Error al insertar el detalle de la venta: " + ex.getMessage());
            retorno = 0;
        }
        return retorno;
    }

    // Metodo anular venta
    public int anular() {
        int retorno = 0;
        try {
            PreparedStatement parametro;
            cn = new Conexion();
            String query = "UPDATE ventas SET estado = 0 WHERE id_venta = ?;";
            cn.abrir_conexion();
            parametro = cn.conexionDB.prepareStatement(query);
            parametro.setInt(1, getId_venta());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println("Error al anular la venta: " + ex.getMessage());
            retorno = 0;
        }
        return retorno;
    }
}
