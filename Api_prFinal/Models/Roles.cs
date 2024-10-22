using System.ComponentModel.DataAnnotations;

namespace Api_prFinal.Models;

public class Roles{
    [Key]
    public Int32 id_rol {get; set;}
    public string? roles {get; set;}
   // public virtual ICollection<Usuarios> Usuarios {get; set;}
}