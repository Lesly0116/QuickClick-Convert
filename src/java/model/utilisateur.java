package model;

import java.sql.Timestamp;

public class utilisateur {
    
    private int id;
    private String email;
    private String password;
    private Timestamp dateCreation;
    private String role;

    public utilisateur() {
    }

    public utilisateur(int id, String email, String password, Timestamp dateCreation,String role) {
        this.id = id;
        this.email = email;
        this.password = password;
        this.dateCreation = dateCreation;
        this.role = role;
    }

    public utilisateur(String email, String password,String role) {
        this.email = email;
        this.password = password;
        this.role = role;
       
    }

    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Timestamp getDateCreation() {
        return dateCreation;
    }

    public void setDateCreation(Timestamp dateCreation) {
        this.dateCreation = dateCreation;
    }
    
    public String getRole() {
        return role;
    }
    
    public void setRole(String role) {
        this.role = role;
    }
}
