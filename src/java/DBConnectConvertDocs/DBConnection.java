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
 * @author SOS PC MULTISERVICES
 */
public class DBConnection {
    
    private static String URL;
    private static String USER;
    private static String PASSWORD;
    private static Connection connection = null;

    static {
        try {
            // Charger le driver MySQL
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // Essayer d'abord les variables d'environnement système (Render)
            String envUrl = System.getenv("DB_URL");
            String envUser = System.getenv("DB_USER");
            String envPassword = System.getenv("DB_PASSWORD");
            
            if (envUrl != null && !envUrl.isEmpty()) {
                // Mode Render : utiliser les variables d'environnement
                URL = envUrl;
                USER = envUser;
                PASSWORD = envPassword;
                System.out.println("Connexion via variables d'environnement système");
            } else {
                // Mode local : utiliser Dotenv
                Dotenv dotenv = Dotenv.configure()
                    .ignoreIfMissing() // Ne pas planter si .env n'existe pas
                    .load();
                
                URL = dotenv.get("DB_URL");
                USER = dotenv.get("DB_USER");
                PASSWORD = dotenv.get("DB_PASSWORD");
                System.out.println("Connexion via fichier .env local");
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
        if (connection == null || connection.isClosed()) {
            connection = DriverManager.getConnection(URL, USER, PASSWORD);
        }
        return connection;
    }

    public static void closeConnection() {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}