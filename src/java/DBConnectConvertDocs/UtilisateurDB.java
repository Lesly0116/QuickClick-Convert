/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DBConnectConvertDocs;

/**
 *
 * @author SOS PC MULTISERVICES
 */

import model.utilisateur;
import java.sql.*;

public class UtilisateurDB {

    public void ajouterUtilisateur(utilisateur u) throws SQLException {
        String sql = "INSERT INTO utilisateur (email, password, role) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, u.getEmail());
            stmt.setString(2, u.getPassword());
            stmt.setString(3, u.getRole());
            stmt.executeUpdate();

            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) u.setId(rs.getInt(1));
            }
        }
    }

    public utilisateur login(String email, String password) throws SQLException {
        String sql = "SELECT * FROM utilisateur WHERE email=? AND password=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            stmt.setString(2, password);
            try (ResultSet rs = stmt.executeQuery()) {
                if(rs.next()) {
                    return new utilisateur(
                        rs.getInt("id"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getTimestamp("date_creation"),
                        rs.getString("role")
                    );
                }
            }
        }
        return null;
    }

    public boolean emailExiste(String email) throws SQLException {
        String sql = "SELECT id FROM utilisateur WHERE email=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        }
    }
    
    public boolean verifAdmin(String email) throws Exception {
    
    System.out.println("--- Dans verifAdmin ---");
    System.out.println("Email reçu: '" + email + "'");
    
    String sql = "SELECT role FROM utilisateur WHERE email = ? AND role = 'administrateur'";
    System.out.println("SQL: " + sql);
    
    try(Connection conAd = DBConnection.getConnection();
        PreparedStatement stmt = conAd.prepareStatement(sql)) {
    
        stmt.setString(1, email);
        System.out.println("Paramètre email set: '" + email + "'");
        
        try (ResultSet rs = stmt.executeQuery()) {
            boolean result = rs.next();
            System.out.println("Résultat de rs.next(): " + result);
            
            if(result) {
                String role = rs.getString("role");
                System.out.println("Rôle trouvé: " + role);
            } else {
                System.out.println("AUCUN RÉSULTAT trouvé pour cet email");
                
                // Vérifions si l'email existe dans la table
                String checkSql = "SELECT email, role FROM utilisateur WHERE email = ?";
                try (PreparedStatement checkStmt = conAd.prepareStatement(checkSql)) {
                    checkStmt.setString(1, email);
                    ResultSet checkRs = checkStmt.executeQuery();
                    if(checkRs.next()) {
                        System.out.println("L'email EXISTE dans la table !");
                        System.out.println("Email trouvé: '" + checkRs.getString("email") + "'");
                        System.out.println("Rôle trouvé: '" + checkRs.getString("role") + "'");
                    } else {
                        System.out.println("L'email N'EXISTE PAS dans la table !");
                    }
                }
            }
            
            return result;
        }
    }
}
    
}

