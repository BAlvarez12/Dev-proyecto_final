/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.Timestamp;
import java.util.HashMap;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author Bomiki
 */
public class Productos {
    private String producto, descripcion, imagen, existencia;
    private int id_producto, id_marca;
    private double precio_costo, precio_venta;
    private java.sql.Timestamp fecha_ingreso;
    private Conexion cn;

    
    
    public Productos (){
        
    }
    
    public Productos( int id_producto, String producto, int id_marca, String descripcion, String imagen, double precio_costo, double precio_venta, String existencia ,Timestamp fecha_ingreso) {
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
    
     public HashMap drop_productos(){
    HashMap<String,String> drop = new HashMap();
    try{
        cn= new Conexion ();
        String query="select id_producto, producto from productos order by id_producto asc;";
        cn.abrir_conexion();
        ResultSet consulta = cn.conexionDB.createStatement().executeQuery(query);
        while(consulta.next()){
        drop.put(consulta.getString("id_producto"), consulta.getString("producto"));
        }
       cn.cerrar_conexion();
    }catch(SQLException ex){
    System.out.println(ex.getMessage());
    }
    return drop;
    }
    
    
    // Metodo leer productos
    public DefaultTableModel leer(){
        DefaultTableModel tabla = new DefaultTableModel();
        try{
            cn = new Conexion();
            cn.abrir_conexion();
            String query = "select a.id_producto, a.producto, a.id_marca, s.marca, a.descripcion, a.imagen, a.precio_costo, a.precio_venta, a.existencia, a.fecha_ingreso from productos a inner join marcas s on s.id_marca = a.id_marca order by id_producto asc;";
            ResultSet consulta = cn.conexionDB.createStatement().executeQuery(query);
            String encabezado [] = {"id_producto", "producto", "id_marca", "marca", "descripcion", "imagen", "precio_costo", "precio_venta", "existencia","fecha_ingreso"};
            tabla.setColumnIdentifiers(encabezado);
            String datos[] = new String[10];
            while (consulta.next()){
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
            
            cn.cerrar_conexion();
        }catch(SQLException ex){
                System.out.println(ex.getMessage());
            
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
          }

    
 