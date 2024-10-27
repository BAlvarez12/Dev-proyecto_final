/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author Bomiki
 */
public class Marcas{
    private int id_marca;
    private String marca;
    private Conexion cn;

    public Marcas(){}
    
    public Marcas( int id_marca , String marca) {
        this.id_marca = id_marca;
        this.marca = marca;
    }

     public int getId_marca() {
        return id_marca;
    }

    public void setId_marca(int id_marca) {
        this.id_marca = id_marca;
    }

    public String getMarca() {
        return marca;
    }

    public void setMarca(String marca) {
        this.marca = marca;
   
    }
    
    
    // metodo cargar puesto
    public HashMap drop_marcas(){
    HashMap<String,String> drop = new HashMap();
    try{
        cn= new Conexion ();
        String query="select id_marca, marca from marcas;";
        cn.abrir_conexion();
        ResultSet consulta = cn.conexionDB.createStatement().executeQuery(query);
        while(consulta.next()){
        drop.put(consulta.getString("id_marca"), consulta.getString("marca"));
        }
       cn.cerrar_conexion();
    }catch(SQLException ex){
    System.out.println(ex.getMessage());
    }
    return drop;
    }
    
     //Metodo leer Marca
        public DefaultTableModel leer(){
            DefaultTableModel tabla = new DefaultTableModel();
            try{
                cn = new Conexion();
                cn.abrir_conexion();
                String query = "select * from marcas order by id_marca asc;";
                ResultSet consulta = cn.conexionDB.createStatement().executeQuery(query);
                String encabezado [] = {"id_marca", "marca"};
                tabla.setColumnIdentifiers(encabezado);
                String datos[] = new String[2];
                while (consulta.next()){
                    datos[0] = consulta.getString("id_marca");
                    datos[1] = consulta.getString("marca");
                    tabla.addRow(datos);
                }

                cn.cerrar_conexion();
            }catch(SQLException ex){
                    System.out.println(ex.getMessage());

            }

            return tabla;
        }
        
            //Metodo insert Marca
            public int agregar(){
                int retorno = 0;
            try{
             PreparedStatement parametro;
             cn = new Conexion();
             String query = "INSERT INTO marcas ( marca ) VALUES ( ? );";
             cn.abrir_conexion();
             parametro = (PreparedStatement) cn.conexionDB.prepareStatement(query);
             parametro.setString(1, getMarca());
             retorno = parametro.executeUpdate();
             cn.cerrar_conexion();

             }catch(SQLException ex){
             System.out.println(ex.getMessage());
             retorno = 0;
             }
            return retorno;
            }
   
            //Metodo modificar Marca
        public int modificar() {
         int retorno = 0;
         try {
             PreparedStatement parametro;
             cn = new Conexion();
             String query = " UPDATE marcas SET marca = ? WHERE id_marca = ? ; ";
             cn.abrir_conexion();
             parametro = (PreparedStatement) cn.conexionDB.prepareStatement(query);
             parametro.setString(1, getMarca());
             parametro.setInt(2, getId_marca());
             retorno = parametro.executeUpdate();
             cn.cerrar_conexion();
         } catch (SQLException ex) {
             System.out.println("Error al modificar la Marca: " + ex.getMessage());
             retorno = 0;
         }
         return retorno;
     }
        
        
            public int eliminar() {
        int retorno = 0;
        try {
            PreparedStatement parametro;
            cn = new Conexion();
            String query = "DELETE FROM marcas WHERE id_marca = ?;";
            cn.abrir_conexion();
            parametro = (PreparedStatement) cn.conexionDB.prepareStatement(query);
            parametro.setInt(1, getId_marca());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println("Error al eliminar la Marca: " + ex.getMessage());
            retorno = 0;
        }
        return retorno;
    }

   


    
}
