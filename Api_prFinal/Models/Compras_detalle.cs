using System.ComponentModel.DataAnnotations;
namespace Api_prFinal.Models;

public class Compras_detalle{
    [Key]
    public Int64 id_compra_detalle {get; set;}
    public Int32 id_compra {get; set;}
    public Int32 id_producto {get; set;}
    public Int32? cantidad {get; set;}
    public double? precio_costo_unitario {get; set;}
}