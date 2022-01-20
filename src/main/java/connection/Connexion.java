package connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Connexion {

    private static String login = "root";
    private static String password = "";
    private static String url = "jdbc:mysql://localhost/javaweb";
    private Connection connection = null;
    private static Connexion instane;

   public Connexion() {
        try {
            //Class.forName("com.mysql.jdbc.Driver");
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(url, login, password);
        } catch (ClassNotFoundException e) {
            System.out.println("Driver introvable");
        } catch (SQLException e) {
            System.out.println("Connexion errror");
            System.out.println(e.getMessage());
        }
    }

    public Connection getConnection() {
        return connection;
    }

    public static Connexion getInstane() {
        if (instane == null) {
            instane = new Connexion();
        }
        return instane;
    }

}