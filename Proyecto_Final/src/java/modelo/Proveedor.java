/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author Bomiki
 */
public class Proveedor {
    private String proveedor, direccion, telefono;
    private int id_proveedor, nit;
    private Conexion cn;

    
    
    public Proveedor (){
        
    }
    
    public Proveedor( int id_proveedor, String proveedor, int nit,  String direccion, String telefono) {
        this.id_proveedor = id_proveedor;
        this.proveedor = proveedor;
        this.nit = nit;
        this.direccion = direccion;
        this.telefono = telefono;
    }
    
     public String getProveedor() {
        return proveedor;
    }

    public void setProveedor(String proveedor) {
        this.proveedor = proveedor;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public int getId_proveedor() {
        return id_proveedor;
    }

    public void setId_proveedor(int id_proveedor) {
        this.id_proveedor = id_proveedor;
    }

    public int getNit() {
        return nit;
    }

    public void setNit(int nit) {
        this.nit = nit;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    
    
    // Metodo leer proveedor
    public DefaultTableModel leer(){
        DefaultTableModel tabla = new DefaultTableModel();
        try{
            cn = new Conexion();
            cn.abrir_conexion();
            String query = "select * from proveedores order by id_proveedores asc;";
            ResultSet consulta = cn.conexionDB.createStatement().executeQuery(query);
            String encabezado [] = {"id_proveedores", "proveedor", "nit", "direccion", "telefono"};
            tabla.setColumnIdentifiers(encabezado);
            String datos[] = new String[5];
            while (consulta.next()){
                datos[0] = consulta.getString("id_proveedores");
                datos[1] = consulta.getString("proveedor");
                datos[2] = consulta.getString("nit");
                datos[3] = consulta.getString("direccion");
                datos[4] = consulta.getString("telefono");
                tabla.addRow(datos);
                
            }
            
            cn.cerrar_conexion();
        }catch(SQLException ex){
                System.out.println(ex.getMessage());
            
        }
        
        return tabla;
    }
    
     //Metodo insertar proveedor
        public int agregar() {
            int retorno = 0;
            try {
                PreparedStatement parametro;
                cn = new Conexion();
                String query = "INSERT INTO proveedores ( proveedor , nit , direccion , telefono ) VALUES ( ? , ? , ? , ? );";
                cn.abrir_conexion(); 
                parametro = cn.conexionDB.prepareStatement(query);
                parametro.setString(1, getProveedor()); 
                parametro.setInt(2, getNit()); 
                parametro.setString(3, getDireccion()); 
                parametro.setString(4, getTelefono()); 
                retorno = parametro.executeUpdate();
                cn.cerrar_conexion();
            } catch (SQLException ex) {
                System.out.println("Error al insertar el proveedor: " + ex.getMessage()); 
                retorno = 0;
            }
            return retorno;
        }
            
         // Metodo actualizar proveedor
            public int modificar() {
            int retorno = 0;
            try {
                PreparedStatement parametro;
                cn = new Conexion();
                String query = "UPDATE proveedores SET proveedor=?, nit=?, direccion=?, telefono=? WHERE id_proveedores = ?;";
                cn.abrir_conexion();
                parametro = cn.conexionDB.prepareStatement(query);
                parametro.setString(1, getProveedor()); 
                parametro.setInt(2, getNit()); 
                parametro.setString(3, getDireccion()); 
                parametro.setString(4, getTelefono()); 
                parametro.setInt(5, getId_proveedor());        
                retorno = parametro.executeUpdate();
                cn.cerrar_conexion();
            } catch (SQLException ex) {
                System.out.println("Error al modificar: " + ex.getMessage());
                retorno = 0;
            }
            return retorno;
        }

                //Metodo eliminar proveedor
            public int eliminar(){
               int retorno = 0;
           try{
            PreparedStatement parametro;
            cn = new Conexion();
            String query = "delete from proveedores where id_proveedores = ? ;";
            cn.abrir_conexion();
            parametro = (PreparedStatement) cn.conexionDB.prepareStatement(query);
            parametro.setInt(1, getId_proveedor());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();

            } catch (SQLException ex) {
             System.out.println("Error al eliminar el empleado: " + ex.getMessage());
              retorno = 0;
             }
             return retorno;

            }
        }

 