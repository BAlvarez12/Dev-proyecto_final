using System.ComponentModel.DataAnnotations;
namespace Api_prFinal.Models;

public class Proveedores{
    [Key]
    public Int32? id_proveedores {get; set;}
    public string? proveedor {get; set;}
    public string? nit {get; set;}
    public string? direccion {get; set;}
    public string? telefono {get; set;}
}