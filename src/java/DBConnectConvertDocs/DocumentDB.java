package DBConnectConvertDocs;

import model.documents;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import dto.DocumentDTO;

public class DocumentDB {

    
    public void ajouterDocument(documents doc) throws SQLException {
    
    if (doc.getUserId() <= 0) {
        throw new SQLException("Impossible d'ajouter un document : user_id est invalide (doit être > 0)");
    }
    
    String sql = "INSERT INTO documents (user_id, nom_fichier, type_avant, type_apres, nom_fichier_converti) VALUES (?, ?, ?, ?, ?)";

    try (Connection conn = DBConnection.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

        stmt.setInt(1, doc.getUserId());
        
        stmt.setString(2, doc.getNomFichier());
        stmt.setString(3, doc.getTypeAvant());
        stmt.setString(4, doc.getTypeApres());
        stmt.setString(5, doc.getNomFichierConverti());

        stmt.executeUpdate();

        try (ResultSet rs = stmt.getGeneratedKeys()) {
            if(rs.next()) doc.setId(rs.getInt(1));
        }
    }
}

    
    public List<documents> getDocumentsParUtilisateur(int userId) throws SQLException {
        List<documents> documentsList = new ArrayList<>();
        String sql = "SELECT * FROM documents WHERE user_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while(rs.next()) {
                    documentsList.add(new documents(
                        rs.getInt("id"),
                        rs.getInt("user_id"),
                        rs.getString("nom_fichier"),
                        rs.getString("type_avant"),
                        rs.getString("type_apres"),
                        rs.getTimestamp("date_conversion"),
                        rs.getString("nom_fichier_converti")
                    ));
                }
            }
        }
        return documentsList;
    }
    
    public List<DocumentDTO> getTousLesDocumentsAvecInfosUtilisateur() throws SQLException {
    List<DocumentDTO> documents = new ArrayList<>();
    
    String sql = "SELECT d.*, u.email " +
                 "FROM documents d " +
                 "LEFT JOIN utilisateur u ON d.user_id = u.id " +
                 "ORDER BY d.date_conversion DESC";
    
    try (Connection con = DBConnection.getConnection();
         PreparedStatement stmt = con.prepareStatement(sql);
         ResultSet rs = stmt.executeQuery()) {
        
        while (rs.next()) {
            DocumentDTO doc = new DocumentDTO(
                rs.getInt("id"),
                rs.getInt("user_id"),
                rs.getString("email"),
                rs.getString("nom_fichier"),
                rs.getString("type_avant"),
                rs.getString("type_apres"),
                rs.getTimestamp("date_conversion"),
                rs.getString("nom_fichier_converti")
            );
            documents.add(doc);
        }
    }
    
    return documents;
}
    
}
