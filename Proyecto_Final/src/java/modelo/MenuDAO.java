import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import modelo.Menu;

public class MenuDAO {
    public List<Menu> getMenuItems() {
        List<Menu> menuList = new ArrayList<>();
        try {
            String url = "jdbc:mysql://localhost:3306/tu_base_de_datos";
            String usuario = "usuario";
            String password = "password";
            Connection con = DriverManager.getConnection(url, usuario, password);
            Statement stmt = con.createStatement();
            String query = "SELECT * FROM menu ORDER BY nivel, id_padre";
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                Menu item = new Menu();
                item.setId(rs.getInt("id"));
                item.setNombre(rs.getString("nombre"));
                item.setUrl(rs.getString("url"));
                item.setIdPadre(rs.getInt("id_padre"));
                item.setNivel(rs.getInt("nivel"));
                menuList.add(item);
            }
            rs.close();
            stmt.close();
            con.close();
        } catch (SQLException e) {
        }
        return menuList;
    }
}
