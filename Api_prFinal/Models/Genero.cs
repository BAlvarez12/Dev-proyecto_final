using System.ComponentModel.DataAnnotations;

namespace Api_prFinal.Models;

public class Genero{
    [Key]
    public Int32? id_genero {get; set;}
    public string? genero {get; set;}
}