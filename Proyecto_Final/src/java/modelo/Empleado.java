/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.util.HashMap;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author Bomiki
 */
public class Empleado extends Persona {
    private String  dpi, fecha_inicio_labores,fecha_ingreso;
    private int id_puesto, genero ;
    private Conexion cn;

    public Empleado() {
    }

    public Empleado( int id,int id_puesto, String nombres, String apellidos, String direccion, String telefono, int genero, String dpi, String fecha_nacimiento, String fecha_inicio_labores, String fecha_ingreso ) {
        super(id, nombres, apellidos, direccion, telefono, fecha_nacimiento);
        this.dpi = dpi;
        this.id_puesto = id_puesto;
        this.fecha_ingreso = fecha_ingreso;
        this.fecha_inicio_labores = fecha_inicio_labores;
        this.genero = genero;
    }

     public String getDpi() {
        return dpi;
    }

    public void setDpi(String dpi) {
        this.dpi = dpi;
    }

    public String getFecha_inicio_labores() {
        return fecha_inicio_labores;
    }

    public void setFecha_inicio_labores(String fecha_inicio_labores) {
        this.fecha_inicio_labores = fecha_inicio_labores;
    }

    public String getFecha_ingreso() {
        return fecha_ingreso;
    }

    public void setFecha_ingreso(String fecha_ingreso) {
        this.fecha_ingreso = fecha_ingreso;
    }

    public int getId_puesto() {
        return id_puesto;
    }

    public void setId_puesto(int id_puesto) {
        this.id_puesto = id_puesto;
    }
    
    public int getGenero() {
        return genero;
    }

    public void setGenero(int genero) {
        this.genero = genero;
    }
    
    
    public HashMap drop_empleados(){
    HashMap<String,String> drop = new HashMap();
    try{
        cn= new Conexion ();
        String query="select id_empleados, concat(nombres,' ', apellidos) as empleado from empleados order by id_empleados asc;";
        cn.abrir_conexion();
        ResultSet consulta = cn.conexionDB.createStatement().executeQuery(query);
        while(consulta.next()){
        drop.put(consulta.getString("id_empleados"), consulta.getString("empleado"));
        }
       cn.cerrar_conexion();
    }catch(SQLException ex){
    System.out.println(ex.getMessage());
    }
    return drop;
    }
    
    // METODO LEER DATOS DEL EMPLEADO
    public DefaultTableModel leer(){
        DefaultTableModel tabla = new DefaultTableModel();
        try{
            cn = new Conexion();
            cn.abrir_conexion();
            String query = "SELECT e.id_empleados, e.nombres, e.apellidos, e.direccion, e.telefono, e.dpi, v.genero, e.fecha_nacimiento, a.puesto, e.id_puesto, e.fecha_inicio_labores, e.fecha_ingreso FROM empleados e inner join puestos a on a.id_puesto = e.id_puesto inner join genero v on v.id_genero = e.genero order by id_empleados asc;";
            ResultSet consulta = cn.conexionDB.createStatement().executeQuery(query);
            String encabezado [] = {"id_empleados", "nombres", "apellidos", "direccion", "telefono", "Dpi", "genero", "fecha_nacimiento", "puesto" , "id_puesto","fecha_inicio_labores", "fecha_ingreso"};
            tabla.setColumnIdentifiers(encabezado);
            String datos[] = new String[12];
            while (consulta.next()){
                datos[0] = consulta.getString("id_empleados");
                datos[1] = consulta.getString("nombres");
                datos[2] = consulta.getString("apellidos");
                datos[3] = consulta.getString("direccion");
                datos[4] = consulta.getString("telefono");
                datos[5] = consulta.getString("dpi");
                datos[6] = consulta.getString("genero");
                datos[7] = consulta.getString("fecha_nacimiento");
                datos[8] = consulta.getString("puesto");
                datos[9] = consulta.getString("id_puesto");
                datos[10] = consulta.getString("fecha_inicio_labores");
                datos[11] = consulta.getString("fecha_ingreso");
                tabla.addRow(datos);
                
            }
            
            cn.cerrar_conexion();
        }catch(SQLException ex){
                System.out.println(ex.getMessage());
            
        }
        
        return tabla;
    }
    
     // METODO INSERTAR EMPLEADO
            @Override
        public int agregar() {
            int retorno = 0;
            try {
                PreparedStatement parametro;
                cn = new Conexion();
                String query = "INSERT INTO empleados ( nombres , apellidos , direccion , telefono , dpi , genero , fecha_nacimiento , id_puesto , fecha_inicio_labores , fecha_ingreso ) VALUES ( ? , ? , ? , ? , ? , ? , ? , ? , ? , ? );";
                cn.abrir_conexion(); 
                parametro = (PreparedStatement) cn.conexionDB.prepareStatement(query);
                parametro.setString(1, getNombres()); 
                parametro.setString(2, getApellidos()); 
                parametro.setString(3, getDireccion()); 
                parametro.setString(4, getTelefono()); 
                parametro.setString(5, getDpi());
                parametro.setInt(6, getGenero()); 
                parametro.setString(7, getFecha_nacimiento()); 
                parametro.setInt(8, getId_puesto()); 
                parametro.setString(9, getFecha_inicio_labores()); 
                parametro.setString(10, getFecha_ingreso()); 
                retorno = parametro.executeUpdate();
                cn.cerrar_conexion();
            }catch(SQLException ex){
            System.out.println(ex.getMessage());
            ex.printStackTrace();
            retorno = 0;
            }
           return retorno;
           }
        
            
         // METODO ACTUALIZAR EMPLEADO
                @Override
            public int modificar() {
            int retorno = 0;
            try {
                PreparedStatement parametro;
                cn = new Conexion();
                String query = "UPDATE empleados SET nombres=?, apellidos=?, direccion=?, telefono=?, fecha_nacimiento=?, id_puesto=?, dpi=?, genero=?, fecha_inicio_labores=?, fecha_ingreso=? WHERE id_empleados = ?;";
                cn.abrir_conexion();
                parametro = cn.conexionDB.prepareStatement(query);
                parametro.setString(1, getNombres());
                parametro.setString(2, getApellidos());
                parametro.setString(3, getDireccion());
                parametro.setString(4, getTelefono());
                parametro.setString(5, getFecha_nacimiento());
                parametro.setInt(6, getId_puesto());
                parametro.setString(7, getDpi());
                parametro.setInt(8, getGenero());
                parametro.setString(9, getFecha_inicio_labores()); 
                parametro.setString(10, getFecha_ingreso());       
                parametro.setInt(11, getId_empleados());           
                retorno = parametro.executeUpdate();
                cn.cerrar_conexion();
            } catch (SQLException ex) {
                System.out.println("Error al modificar: " + ex.getMessage());
                retorno = 0;
            }
            return retorno;
        }

                //METODO ELIMINAR EMPLEADO
            @Override
            public int eliminar(){
               int retorno = 0;
           try{
            PreparedStatement parametro;
            cn = new Conexion();
            String query = "delete from empleados where id_empleados = ? ;";
            cn.abrir_conexion();
            parametro = (PreparedStatement) cn.conexionDB.prepareStatement(query);
            parametro.setInt(1, getId_empleados());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();

            } catch (SQLException ex) {
             System.out.println("Error al eliminar el empleado: " + ex.getMessage());
              retorno = 0;
             }
             return retorno;
         }
}