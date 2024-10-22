using System.ComponentModel.DataAnnotations;
using NuGet.Common;
using NuGet.Protocol.Plugins;
namespace Api_prFinal.Models;

public class Ventas{
    [Key]
    public Int32 id_venta {get; set;}
    public Int32? no_factura {get; set;}
    public char? serie {get; set;}
    public DateTime? fecha_factura {get; set;}
    public Int32 id_cliente {get; set;}
    public Int32 id_empleados {get; set;}
    public DateTime? fecha_ingreso {get; set;}
}