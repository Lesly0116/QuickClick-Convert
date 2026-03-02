/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DBConnectConvertDocs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import io.github.cdimascio.dotenv.Dotenv;

/**
 *
 * @author SOS PC MULTISERVICES
 */
public class DBConnection {
    
    private static final Dotenv dotenv = Dotenv.load();
    
    private static final String URL = dotenv.get("DB_URL");
   private static final String Lesly = dotenv.get("DB_USER");
   private static final String Password = dotenv.get("DB_PASSWORD");
   private static Connection connection = null;
   
   public static Connection getConnection() throws SQLException {
   
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.err.println("Erreur de chargement du driver: " + e.getMessage());
        }
        
        return DriverManager.getConnection(URL, Lesly, Password);
    }

   
    
    public static void testConnection() {
        try {
            Connection conn = getConnection();
            if (conn != null && !conn.isClosed()) {
                System.out.println("Test connexion : RÉUSSIE");
                System.out.println("Base de données : " + conn.getCatalog());
            } else {
                System.out.println("Test connexion : ÉCHEC");
            }
        } catch (SQLException e) {
            System.err.println("Erreur test connexion: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
}
