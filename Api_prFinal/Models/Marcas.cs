using System.ComponentModel.DataAnnotations;

namespace Api_prFinal.Models;

public class Marcas{
    [Key]
    public Int16? id_marca {get; set;}
    public string? marca {get; set;}
}