using System.ComponentModel.DataAnnotations;
namespace Api_prFinal.Models;

public class Ventas_detalle{
    [Key]
    public Int64 id_venta_detalle {get; set;}
    public Int32 id_venta {get; set;}
    public Int32 id_producto {get; set;}
    public Int32? cantidad {get; set;}
    public double? precio_unitario {get; set;}
}