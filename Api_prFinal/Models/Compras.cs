using System.ComponentModel.DataAnnotations;

namespace Api_prFinal.Models;

public class Compras{
    [Key]
    public Int32 id_compra {get; set;}
    public Int32? no_orden_compra {get; set;}
    public Int32? id_proveedor {get; set;}
    public DateTime? fecha_orden {get; set;}
    public DateTime? fecha_ingreso {get; set;}

}