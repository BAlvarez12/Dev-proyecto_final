using System.ComponentModel.DataAnnotations;
namespace Api_prFinal.Models;

 public class Productos{
    [Key]
    public Int32 id_producto {get; set;}
    public String? producto {get; set;}
    public Int16 id_marca {get; set;}
    public String? descripcion {get; set;}
    public String? imagen {get; set;}
    public double? precio_costo {get; set;}
    public double? precio_venta {get; set;}
    public Int32? existencia {get; set;}
    public DateTime? fecha_ingreso {get; set;}

 }