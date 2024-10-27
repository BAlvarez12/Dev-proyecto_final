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
public class Cliente {
    private String nombres, apellidos, correo_electronico ;
    private int id_cliente, nit, genero, telefono;
    private java.sql.Timestamp fecha_ingreso;
    private Conexion cn;

    
    
    public Cliente (){
        
    }
    
    public Cliente( int id_cliente, String nombres, String apellidos, int nit, int genero, int telefono, String correo_electronico, Timestamp fecha_ingreso) {
        this.nombres = nombres;
        this.apellidos = apellidos;
        this.correo_electronico = correo_electronico;
        this.fecha_ingreso = fecha_ingreso;
        this.id_cliente = id_cliente;
        this.nit = nit;
        this.genero = genero;
        this.telefono = telefono;
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

    public Timestamp getFecha_ingreso() {
        return fecha_ingreso;
    }

    public void setFecha_ingreso(java.sql.Timestamp fecha_ingreso) {
        this.fecha_ingreso = fecha_ingreso;
    }

    public int getId_cliente() {
        return id_cliente;
    }

    public void setId_cliente(int id_cliente) {
        this.id_cliente = id_cliente;
    }

    public int getNit() {
        return nit;
    }

    public void setNit(int nit) {
        this.nit = nit;
    }

    public int getGenero() {
        return genero;
    }

    public void setGenero(int genero) {
        this.genero = genero;
    }

    public int getTelefono() {
        return telefono;
    }

    public void setTelefono(int telefono) {
        this.telefono = telefono;
    }
    
    public HashMap drop_clientes(){
    HashMap<String,String> drop = new HashMap();
    try{
        cn= new Conexion ();
        String query="select id_cliente, concat(nombres,' ', apellidos) as cliente from clientes order by id_cliente asc;";
        cn.abrir_conexion();
        ResultSet consulta = cn.conexionDB.createStatement().executeQuery(query);
        while(consulta.next()){
        drop.put(consulta.getString("id_cliente"), consulta.getString("cliente"));
        }
       cn.cerrar_conexion();
    }catch(SQLException ex){
    System.out.println(ex.getMessage());
    }
    return drop;
    }
    
    
    // Metodo leer datos del cliente
    public DefaultTableModel leer(){
        DefaultTableModel tabla = new DefaultTableModel();
        try{
            cn = new Conexion();
            cn.abrir_conexion();
            String query = "select a.id_cliente, a.nombres, a.apellidos, a.nit, s.id_genero, s.genero, a.telefono, a.correo_electronico from clientes a inner join genero s on s.id_genero = a.genero order by id_cliente asc;";
            ResultSet consulta = cn.conexionDB.createStatement().executeQuery(query);
            String encabezado [] = {"id_cliente", "nombres", "apellidos", "nit", "id_genero", "genero", "telefono", "correo_electronico"};
            tabla.setColumnIdentifiers(encabezado);
            String datos[] = new String[9];
            while (consulta.next()){
                datos[0] = consulta.getString("id_cliente");
                datos[1] = consulta.getString("nombres");
                datos[2] = consulta.getString("apellidos");
                datos[3] = consulta.getString("nit");
                datos[4] = consulta.getString("genero");
                datos[5] = consulta.getString("genero");
                datos[6] = consulta.getString("telefono");
                datos[7] = consulta.getString("correo_electronico");
                tabla.addRow(datos);
                
            }
            
            cn.cerrar_conexion();
        }catch(SQLException ex){
                System.out.println(ex.getMessage());
            
        }
        
        return tabla;
    }

     // Metodo insertar cliente
        public int agregar() {
            int retorno = 0;
            try {
                PreparedStatement parametro;
                cn = new Conexion();
                String query = "INSERT INTO clientes ( nombres , apellidos , nit , genero , telefono , correo_electronico ,fecha_ingreso ) VALUES ( ? , ? , ? , ? , ? , ? , ? );";
                cn.abrir_conexion(); 
                parametro = cn.conexionDB.prepareStatement(query);
                parametro.setString(1, getNombres()); 
                parametro.setString(2, getApellidos()); 
                parametro.setInt(3, getNit()); 
                parametro.setInt(4, getGenero()); 
                parametro.setInt(5, getTelefono()); 
                parametro.setString(6, getCorreo_electronico()); 
                parametro.setTimestamp(7, getFecha_ingreso()); 
                retorno = parametro.executeUpdate();
                cn.cerrar_conexion();
            } catch (SQLException ex) {
                System.out.println("Error al insertar el empleado: " + ex.getMessage()); 
                retorno = 0;
            }
            return retorno;
        }
            
         // Metodo modificar clientes
            public int modificar() {
            int retorno = 0;
            try {
                PreparedStatement parametro;
                cn = new Conexion();
                String query = "UPDATE clientes SET nombres=?, apellidos=?, nit=?, genero=?, telefono=?, correo_electronico=?, fecha_ingreso=? WHERE id_cliente = ?;";
                cn.abrir_conexion();
                parametro = cn.conexionDB.prepareStatement(query);
                parametro.setString(1, getNombres()); 
                parametro.setString(2, getApellidos()); 
                parametro.setInt(3, getNit()); 
                parametro.setInt(4, getGenero()); 
                parametro.setInt(5, getTelefono()); 
                parametro.setString(6, getCorreo_electronico()); 
                parametro.setTimestamp(7, getFecha_ingreso());     
                parametro.setInt(8, getId_cliente()); 
                retorno = parametro.executeUpdate();
                cn.cerrar_conexion();
            } catch (SQLException ex) {
                System.out.println("Error al modificar: " + ex.getMessage());
                retorno = 0;
            }
            return retorno;
        }

                //Metodo eliminar cliente
            public int eliminar(){
               int retorno = 0;
           try{
            PreparedStatement parametro;
            cn = new Conexion();
            String query = "delete from clientes where id_cliente = ? ;";
            cn.abrir_conexion();
            parametro = (PreparedStatement) cn.conexionDB.prepareStatement(query);
            parametro.setInt(1, getId_cliente());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();

            } catch (SQLException ex) {
             System.out.println("Error al eliminar el empleado: " + ex.getMessage());
              retorno = 0;
             }
             return retorno;
         }
}
   

 