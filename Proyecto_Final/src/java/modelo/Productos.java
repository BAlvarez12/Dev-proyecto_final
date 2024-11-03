package modelo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.HashMap;
import javax.swing.table.DefaultTableModel;

public class Productos {
    private String producto, descripcion, imagen, existencia;
    private int id_producto, id_marca;
    private double precio_costo, precio_venta;
    private java.sql.Timestamp fecha_ingreso;
    private Conexion cn;

    // Constructores
    public Productos() {}

    public Productos(int id_producto, String producto, int id_marca, String descripcion, String imagen, double precio_costo, double precio_venta, String existencia, Timestamp fecha_ingreso) {
        this.id_producto = id_producto;
        this.producto = producto;
        this.id_marca = id_marca;
        this.descripcion = descripcion;
        this.imagen = imagen;
        this.precio_costo = precio_costo;
        this.precio_venta = precio_venta;
        this.existencia = existencia;
        this.fecha_ingreso = fecha_ingreso;
    }

    // Getters y Setters
    public String getProducto() {
        return producto;
    }

    public void setProducto(String producto) {
        this.producto = producto;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getImagen() {
        return imagen;
    }

    public void setImagen(String imagen) {
        this.imagen = imagen;
    }

    public String getExistencia() {
        return existencia;
    }

    public void setExistencia(String existencia) {
        this.existencia = existencia;
    }

    public int getId_producto() {
        return id_producto;
    }

    public void setId_producto(int id_producto) {
        this.id_producto = id_producto;
    }

    public int getId_marca() {
        return id_marca;
    }

    public void setId_marca(int id_marca) {
        this.id_marca = id_marca;
    }

    public double getPrecio_costo() {
        return precio_costo;
    }

    public void setPrecio_costo(double precio_costo) {
        this.precio_costo = precio_costo;
    }

    public double getPrecio_venta() {
        return precio_venta;
    }

    public void setPrecio_venta(double precio_venta) {
        this.precio_venta = precio_venta;
    }

    public java.sql.Timestamp getFecha_ingreso() {
        return fecha_ingreso;
    }

    public void setFecha_ingreso(java.sql.Timestamp fecha_ingreso) {
        this.fecha_ingreso = fecha_ingreso;
    }

    // Método para descontar el stock de un producto en la base de datos
    public boolean descontarStock(int id_producto, int cantidad) {
    PreparedStatement stmt = null;
    try {
        // Inicializar la conexión y abrirla
        cn = new Conexion();
        cn.abrir_conexion();
        Connection conn = cn.conexionDB;

        // Consulta SQL para actualizar el stock del producto
        String sql = "UPDATE productos SET existencia = existencia - ? WHERE id_producto = ? AND existencia >= ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, cantidad);
        stmt.setInt(2, id_producto);
        stmt.setInt(3, cantidad);

        int filasActualizadas = stmt.executeUpdate();

        // Si al menos una fila fue actualizada, significa que la operación fue exitosa
        return filasActualizadas > 0;
    } catch (SQLException e) {
        System.out.println("Error al descontar stock: " + e.getMessage());
        return false;
    } finally {
        // Cerrar los recursos utilizados
        try {
            if (stmt != null) stmt.close();
            if (cn != null) cn.cerrar_conexion();
        } catch (SQLException e) {
            System.out.println("Error al cerrar recursos: " + e.getMessage());
        }
    }
}


    // Método para obtener la existencia de un producto en la base de datos
    public int Existencia(int id_producto) {
        int existencia = 0;
        PreparedStatement stmt = null;
        ResultSet consulta = null;
        try {
            // Inicializar la conexión y abrirla
            cn = new Conexion();
            cn.abrir_conexion();
            Connection conn = cn.conexionDB;

            String query = "SELECT existencia FROM productos WHERE id_producto = ?;";
            stmt = conn.prepareStatement(query);
            stmt.setInt(1, id_producto);
            consulta = stmt.executeQuery();
            if (consulta.next()) {
                existencia = consulta.getInt("existencia");
            }
        } catch (SQLException ex) {
            System.out.println("Error al obtener la existencia del producto: " + ex.getMessage());
        } finally {
            // Cerrar los recursos utilizados
            try {
                if (consulta != null) consulta.close();
                if (stmt != null) stmt.close();
                if (cn != null) cn.cerrar_conexion();
            } catch (SQLException e) {
                System.out.println("Error al cerrar recursos: " + e.getMessage());
            }
        }
        return existencia;
    }

    // Método para actualizar la existencia del producto después de una venta
    public int actualizarExistencia(int id_producto, int cantidadVendida) {
        int retorno = 0;
        PreparedStatement stmt = null;
        try {
            // Inicializar la conexión y abrirla
            cn = new Conexion();
            cn.abrir_conexion();
            Connection conn = cn.conexionDB;

            String query = "UPDATE productos SET existencia = existencia - ? WHERE id_producto = ? AND existencia >= ?;";
            stmt = conn.prepareStatement(query);
            stmt.setInt(1, cantidadVendida);
            stmt.setInt(2, id_producto);
            stmt.setInt(3, cantidadVendida);
            retorno = stmt.executeUpdate();
        } catch (SQLException ex) {
            System.out.println("Error al actualizar la existencia del producto: " + ex.getMessage());
            retorno = 0;
        } finally {
            // Cerrar los recursos utilizados
            try {
                if (stmt != null) stmt.close();
                if (cn != null) cn.cerrar_conexion();
            } catch (SQLException e) {
                System.out.println("Error al cerrar recursos: " + e.getMessage());
            }
        }
        return retorno;
    }

    // Método para llenar un HashMap con productos
    public HashMap<String, String> drop_productos() {
        HashMap<String, String> drop = new HashMap<>();
        ResultSet consulta = null;
        try {
            cn = new Conexion();
            cn.abrir_conexion();
            String query = "select id_producto, producto from productos order by id_producto asc;";
            consulta = cn.conexionDB.createStatement().executeQuery(query);
            while (consulta.next()) {
                drop.put(consulta.getString("id_producto"), consulta.getString("producto"));
            }
        } catch (SQLException ex) {
            System.out.println("Error al obtener productos: " + ex.getMessage());
        } finally {
            try {
                if (consulta != null) consulta.close();
                if (cn != null) cn.cerrar_conexion();
            } catch (SQLException e) {
                System.out.println("Error al cerrar recursos: " + e.getMessage());
            }
        }
        return drop;
    }

    // Método para leer los productos en un DefaultTableModel
    public DefaultTableModel leer() {
        DefaultTableModel tabla = new DefaultTableModel();
        ResultSet consulta = null;
        try {
            cn = new Conexion();
            cn.abrir_conexion();
            String query = "select a.id_producto, a.producto, a.id_marca, s.marca, a.descripcion, a.imagen, a.precio_costo, a.precio_venta, a.existencia, a.fecha_ingreso from productos a inner join marcas s on s.id_marca = a.id_marca order by id_producto asc;";
            consulta = cn.conexionDB.createStatement().executeQuery(query);
            String encabezado[] = {"id_producto", "producto", "id_marca", "marca", "descripcion", "imagen", "precio_costo", "precio_venta", "existencia", "fecha_ingreso"};
            tabla.setColumnIdentifiers(encabezado);
            String datos[] = new String[10];
            while (consulta.next()) {
                datos[0] = consulta.getString("id_producto");
                datos[1] = consulta.getString("producto");
                datos[2] = consulta.getString("id_marca");
                datos[3] = consulta.getString("marca");
                datos[4] = consulta.getString("descripcion");
                datos[5] = consulta.getString("imagen");
                datos[6] = consulta.getString("precio_costo");
                datos[7] = consulta.getString("precio_venta");
                datos[8] = consulta.getString("existencia");
                datos[9] = consulta.getString("fecha_ingreso");
                tabla.addRow(datos);
            }
        } catch (SQLException ex) {
            System.out.println("Error al leer productos: " + ex.getMessage());
        } finally {
            try {
                if (consulta != null) consulta.close();
                if (cn != null) cn.cerrar_conexion();
            } catch (SQLException e) {
                System.out.println("Error al cerrar recursos: " + e.getMessage());
            }
        }
        return tabla;
    }

     // Metodo insertar productos
        public int agregar() {
            int retorno = 0;
            try {
                PreparedStatement parametro;
                cn = new Conexion();
                String query = "INSERT INTO productos ( producto , id_marca , descripcion , imagen , precio_costo , precio_venta , existencia , fecha_ingreso  ) VALUES ( ? , ? , ? , ? , ? , ? , ? , ? );";
                cn.abrir_conexion(); 
                parametro = cn.conexionDB.prepareStatement(query);
                parametro.setString(1, getProducto()); 
                parametro.setInt(2, getId_marca()); 
                parametro.setString(3, getDescripcion()); 
                parametro.setString(4, getImagen()); 
                parametro.setDouble(5, getPrecio_costo()); 
                parametro.setDouble(6, getPrecio_venta()); 
                parametro.setString(7, getExistencia()); 
                parametro.setTimestamp(8, getFecha_ingreso()); 
                retorno = parametro.executeUpdate();
                cn.cerrar_conexion();
            } catch (SQLException ex) {
                System.out.println("Error al insertar el producto: " + ex.getMessage()); 
                retorno = 0;
            }
            return retorno;
        }
            //Metodo modificar producto
                public int modificar() {
           int retorno = 0;
           try {
               PreparedStatement parametro;
               cn = new Conexion();
               String query = "UPDATE productos SET producto=?, id_marca=?, descripcion=?, imagen=?, precio_costo=?, precio_venta=?, existencia=?, fecha_ingreso=? WHERE id_producto = ?;";
               cn.abrir_conexion();
               parametro = cn.conexionDB.prepareStatement(query);
               parametro.setString(1, getProducto());
               parametro.setInt(2, getId_marca());
               parametro.setString(3, getDescripcion());
               parametro.setString(4, getImagen());
               parametro.setDouble(5, getPrecio_costo());
               parametro.setDouble(6, getPrecio_venta());
               parametro.setString(7, getExistencia());
               parametro.setTimestamp(8, getFecha_ingreso());
               parametro.setInt(9, getId_producto());
               retorno = parametro.executeUpdate();
               cn.cerrar_conexion();
           } catch (SQLException ex) {
               System.out.println("Error al modificar el producto: " + ex.getMessage());
               retorno = 0;
           }
           return retorno;
       }


                        public int eliminar() {
              int retorno = 0;
              try {
                  PreparedStatement parametro;
                  cn = new Conexion();
                  String query = "DELETE FROM productos WHERE id_producto = ?;";
                  cn.abrir_conexion();
                  parametro = cn.conexionDB.prepareStatement(query);
                  parametro.setInt(1, getId_producto());
                  retorno = parametro.executeUpdate();
                  cn.cerrar_conexion();
              } catch (SQLException ex) {
                  System.out.println("Error al eliminar el producto: " + ex.getMessage());
                  retorno = 0;
              }
              return retorno;
                        }
               public boolean aumentarStock(int id_producto, int cantidad) {
        PreparedStatement stmt = null;
        try {
            // Inicializar la conexión y abrirla
            cn = new Conexion();
            cn.abrir_conexion();
            Connection conn = cn.conexionDB;

            // Consulta SQL para actualizar el stock del producto
            String sql = "UPDATE productos SET existencia = existencia + ? WHERE id_producto = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, cantidad);
            stmt.setInt(2, id_producto);

            int filasActualizadas = stmt.executeUpdate();

            // Si al menos una fila fue actualizada, significa que la operación fue exitosa
            return filasActualizadas > 0;
        } catch (SQLException e) {
            System.out.println("Error al aumentar stock: " + e.getMessage());
            return false;
        } finally {
            // Cerrar los recursos utilizados
            try {
                if (stmt != null) stmt.close();
                if (cn != null) cn.cerrar_conexion();
            } catch (SQLException e) {
                System.out.println("Error al cerrar recursos: " + e.getMessage());
            }
        }
    }
          }

    
 