/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.Lesly.ConvertirFichier.controller;

import com.Lesly.ConvertirFichier.model.Utilisateur;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpSession;
import com.Lesly.ConvertirFichier.service.ServiceUtilisateur;

/**
 *
 * @author SOS PC MULTISERVICES
 */

@Controller
public class LoginController {
    
    private final ServiceUtilisateur service;
    
     public LoginController(ServiceUtilisateur service) {
        this.service = service;
    }
    
    @PostMapping("/login")
    public String login(
            @RequestParam("email") String email,
            @RequestParam("password") String password,
            HttpSession session,
            Model model
    ) {
        try {
            Utilisateur u = service.authentifier(email, password);
            session.setAttribute("utilisateurConnecte", u);
            session.setAttribute("conversionInviteEffectuee", false);
            return "redirect:/convert";  
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            return "login"; 
        }
    }
    
}
