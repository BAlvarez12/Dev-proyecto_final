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
public class Puesto {
    private int id_puesto;
    private String puesto;
    private Conexion cn;

    public Puesto(){}
    
    public Puesto( int id_puesto , String puesto) {
        this.puesto = puesto;
        this.id_puesto = id_puesto;
    }

    public int getId_puesto() {
        return id_puesto;
    }

    public void setId_puesto(int id_puesto) {
        this.id_puesto = id_puesto;
    }

    public String getPuesto() {
        return puesto;
    }

    public void setPuesto(String puesto) {
        this.puesto = puesto;
    }
    
    // metodo cargar puesto
    public HashMap drop_puesto(){
    HashMap<String,String> drop = new HashMap();
    try{
        cn= new Conexion ();
        String query="select id_puesto, puesto from puestos;";
        cn.abrir_conexion();
        ResultSet consulta = cn.conexionDB.createStatement().executeQuery(query);
        while(consulta.next()){
        drop.put(consulta.getString("id_puesto"), consulta.getString("puesto"));
        }
       cn.cerrar_conexion();
    }catch(SQLException ex){
    System.out.println(ex.getMessage());
    }
    return drop;
    }
    
      // Metodo leer puesto
        public DefaultTableModel leer(){
            DefaultTableModel tabla = new DefaultTableModel();
            try{
                cn = new Conexion();
                cn.abrir_conexion();
                String query = "select * from puestos order by id_puesto asc;";
                ResultSet consulta = cn.conexionDB.createStatement().executeQuery(query);
                String encabezado [] = {"id_puesto", "puesto"};
                tabla.setColumnIdentifiers(encabezado);
                String datos[] = new String[2];
                while (consulta.next()){
                    datos[0] = consulta.getString("id_puesto");
                    datos[1] = consulta.getString("puesto");
                    tabla.addRow(datos);
                }

                cn.cerrar_conexion();
            }catch(SQLException ex){
                    System.out.println(ex.getMessage());

            }

            return tabla;
        }
    
            //Metodo insertar puesto
            public int agregar(){
                int retorno = 0;
            try{
             PreparedStatement parametro;
             cn = new Conexion();
             String query = "INSERT INTO puestos ( puesto ) VALUES ( ? );";
             cn.abrir_conexion();
             parametro = (PreparedStatement) cn.conexionDB.prepareStatement(query);
             parametro.setString(1, getPuesto());
             retorno = parametro.executeUpdate();
             cn.cerrar_conexion();

             }catch(SQLException ex){
             System.out.println(ex.getMessage());
             retorno = 0;
             }
            return retorno;
            }
   
            // Metodo modificar puesto
        public int modificar() {
         int retorno = 0;
         try {
             PreparedStatement parametro;
             cn = new Conexion();
             String query = " UPDATE puestos SET puesto = ? WHERE id_puesto = ? ; ";
             cn.abrir_conexion();
             parametro = (PreparedStatement) cn.conexionDB.prepareStatement(query);
             parametro.setString(1, getPuesto());
             parametro.setInt(2, getId_puesto());
             retorno = parametro.executeUpdate();
             cn.cerrar_conexion();
         } catch (SQLException ex) {
             System.out.println("Error al modificar puesto: " + ex.getMessage());
             retorno = 0;
         }
         return retorno;
     }
        
        //Metodo eliminar puesto
            public int eliminar() {
        int retorno = 0;
        try {
            PreparedStatement parametro;
            cn = new Conexion();
            String query = "DELETE FROM puestos WHERE id_puesto = ?;";
            cn.abrir_conexion();
            parametro = (PreparedStatement) cn.conexionDB.prepareStatement(query);
            parametro.setInt(1, getId_puesto());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println("Error al eliminar puesto: " + ex.getMessage());
            retorno = 0;
        }
        return retorno;
    }


    
}
