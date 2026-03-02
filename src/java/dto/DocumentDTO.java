/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

import java.sql.Timestamp;

/**
 *
 * @author jeanl
 */
public class DocumentDTO {
    
    private int id;
    private int userId;
    private String userEmail;
    private String nomFichier;
    private String typeAvant;
    private String typeApres;
    private Timestamp dateConversion;
    private String nomFichierConverti;
    
    public DocumentDTO(int id, int userId, String userEmail,
                      String nomFichier, String typeAvant, String typeApres,
                      Timestamp dateConversion, String nomFichierConverti){
    
                  this.id = id;
                  this.userId = userId;
                  this.userEmail = userEmail;
                  this.nomFichier = nomFichier;
                  this.typeAvant = typeAvant;
                  this.typeApres = typeApres;
                  this.dateConversion = dateConversion;
                  this.nomFichierConverti = nomFichierConverti;     
    
    }
    
    public int getId() { return id; }
    public int getUserId() { return userId; }
    public String getUserEmail() { return userEmail; }
    public String getNomFichier() { return nomFichier; }
    public String getTypeAvant() { return typeAvant; }
    public String getTypeApres() { return typeApres; }
    public Timestamp getDateConversion() { return dateConversion; }
    public String getNomFichierConverti() { return nomFichierConverti; }
    
}
