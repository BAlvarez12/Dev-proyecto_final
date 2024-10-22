using System.ComponentModel.DataAnnotations;

namespace Api_prFinal.Models;

public class Usuarios{
    [Key]
    public Int32 id_usuarios {get; set;}
    public string? usuario {get; set;}
    public string? nombres {get; set;}
    public string? apellidos {get; set;}
    public string? correo_electronico {get; set;}
    public string? contrasena {get; set;}
    public Int32 id_rol {get; set;}

    //public virtual ICollection<Roles> Roles {get; set;} 
} 