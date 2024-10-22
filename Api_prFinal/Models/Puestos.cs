using System.ComponentModel.DataAnnotations;

namespace Api_prFinal.Models;

public class Puestos{
    [Key]
    public Int16 id_puesto {get; set;}
    public string? puesto {get; set;}
}