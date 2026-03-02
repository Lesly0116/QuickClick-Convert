/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import DBConnectConvertDocs.UtilisateurDB;
import model.*;
import DBConnectConvertDocs.DocumentDB;
import java.util.List;
import dto.DocumentDTO;

/**
 *
 * @author SOS PC MULTISERVICES
 */
public class ServiceUtilisateur {
    
    private UtilisateurDB utilDB = new UtilisateurDB();
    private DocumentDB docutDB = new DocumentDB();
    
    public void inscrire(String email, String password) throws Exception {
    
        if(utilDB.emailExiste(email)){
        
            throw new Exception("Cet email a deja ete utilise !!!");
        
        }
        
        utilisateur util = new utilisateur(email,password, "utilisateur");
        utilDB.ajouterUtilisateur(util);
    
    }
    
    public utilisateur authentifier(String email, String password) throws Exception {
    
        utilisateur util = utilDB.login(email, password);
        
        if(util == null){
        
            throw new Exception("Email ou mot de passe incorrecte !!!");
        
        }
        
        return util;
    
    }
    
    public List<DocumentDTO> consulterTousDocuments(String email) throws Exception {
    
    System.out.println("=== ServiceUtilisateur.consulterTousDocuments ===");
    System.out.println("Email reçu: " + email);
    
    // Vérifier si l'utilisateur est admin
    if(!utilDB.verifAdmin(email)) {
        System.out.println("ACCÈS REFUSÉ: " + email + " n'est pas admin");
        throw new Exception("Accès refusé : Vous n'êtes pas administrateur !");
    }
    
    System.out.println("Accès autorisé - Récupération des documents...");
    
    // Récupérer les documents
    List<DocumentDTO> docs = docutDB.getTousLesDocumentsAvecInfosUtilisateur();
    
    System.out.println("Documents trouvés: " + (docs != null ? docs.size() : 0));
    
    return docs;
}
    
}
