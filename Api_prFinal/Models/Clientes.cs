using System.ComponentModel.DataAnnotations;
namespace Api_prFinal.Models;

public class Clientes{
    [Key]
    public Int32? id_cliente {get; set;}
    public string? nombres {get; set;}
    public string? apellidos {get; set;}
    public string? nit {get; set;}
    public bool? genero {get; set;}
    public string? telefono {get; set;}
    public string? correo_electronico {get; set;}
    public DateTime? fecha_ingreso  {get; set;}
    
}