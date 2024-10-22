using System.ComponentModel.DataAnnotations;

namespace Api_prFinal.Models;

public class Empleados{
    [Key]
    public Int32 id_empleados {get; set;}
    public String? nombres {get; set;}
    public String? apellidos {get; set;}
    public String? direccion {get; set;}
    public String? telefono {get; set;}
    public String? dpi {get; set;}
    public bool? genero {get; set;}
    public DateTime? fecha_nacimiento {get; set;}
    public Int16 id_puesto {get; set;}
    public DateTime? fecha_inicio_labores {get; set;}
    public DateTime? fecha_ingreso {get; set;}

}