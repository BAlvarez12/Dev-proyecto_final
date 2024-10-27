package modelo; // Cambia el paquete según tu proyecto

// Definición de la clase Menu
public class Menu {
    
    
    private int id;
    private String nombre;
    private String url;
    private Integer idPadre;
    private int nivel;

    // Constructor vacío
    public Menu() {
    }

    // Constructor con todos los parámetros
    public Menu(int id, String nombre, String url, Integer idPadre, int nivel) {
        this.id = id;
        this.nombre = nombre;
        this.url = url;
        this.idPadre = idPadre;
        this.nivel = nivel;
    }

    // Getters y Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Integer getIdPadre() {
        return idPadre;
    }

    public void setIdPadre(Integer idPadre) {
        this.idPadre = idPadre;
    }

    public int getNivel() {
        return nivel;
    }

    public void setNivel(int nivel) {
        this.nivel = nivel;
    }


    // Método para representar el objeto Menu como una cadena
    @Override
    public String toString() {
        return "Menu{" +
                "id=" + id +
                ", nombre='" + nombre + '\'' +
                ", url='" + url + '\'' +
                ", idPadre=" + idPadre +
                ", nivel=" + nivel +
                '}';
    }
}
