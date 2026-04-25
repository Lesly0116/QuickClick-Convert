package service;

import DBConnectConvertDocs.DocumentDB;
import model.documents;
import model.utilisateur;

import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.List;

import com.convertapi.client.ConvertApi;
import com.convertapi.client.Param;
import com.convertapi.client.ConversionResult;
import com.convertapi.client.Config;

import java.util.concurrent.CompletableFuture;

public class ServiceDocument {

    private DocumentDB docDB = new DocumentDB();
    private final String uploadDir = "C:/ConvertDocs/uploads/";

    private final Config convertApiConfig;

    public ServiceDocument() {
        this.convertApiConfig =
            Config.defaults("n7mE4fKvG5bd9TdVayqqwNL62GQcNZm5");
    }

    public File convertPdfToWord(File fichierPdf) throws Exception {
        CompletableFuture<ConversionResult> future =
            ConvertApi.convert(
                "pdf",
                "docx",
                new Param[] { new Param("file", fichierPdf.toPath()) },
                convertApiConfig
            );

        ConversionResult result = future.get();
        result.saveFilesSync(fichierPdf.getParentFile().toPath());

        return new File(
            fichierPdf.getParent(),
            fichierPdf.getName().replace(".pdf", ".docx")
        );
    }

    public File convertPdfToExcel(File fichierPdf) throws Exception {
        CompletableFuture<ConversionResult> future =
            ConvertApi.convert(
                "pdf",
                "xlsx",
                new Param[] { new Param("file", fichierPdf.toPath()) },
                convertApiConfig
            );

        ConversionResult result = future.get();
        result.saveFilesSync(fichierPdf.getParentFile().toPath());

        return new File(
            fichierPdf.getParent(),
            fichierPdf.getName().replace(".pdf", ".xlsx")
        );
    }

    public File convertWordToPdf(File fichierWord) throws Exception {
        CompletableFuture<ConversionResult> future =
            ConvertApi.convert(
                "docx",
                "pdf",
                new Param[] { new Param("file", fichierWord.toPath()) },
                convertApiConfig
            );

        ConversionResult result = future.get();
        result.saveFilesSync(fichierWord.getParentFile().toPath());

        return new File(
            fichierWord.getParent(),
            fichierWord.getName().replace(".docx", ".pdf")
        );
    }

    
    public void convertir(HttpSession session, Part fichier, String typeApres, utilisateur user) throws Exception {


        if (fichier == null || fichier.getSize() == 0) {
            throw new Exception("Aucun fichier sélectionné.");
        }

        String nomOriginal = fichier.getSubmittedFileName();
        String typeAvant = getExtension(nomOriginal);

        if (!isConversionAutorisee(typeAvant, typeApres)) {
            throw new Exception("Conversion non autorisée.");
        }

        File dossier = new File(uploadDir);
        if (!dossier.exists()) dossier.mkdirs();

        String nomStockage = System.currentTimeMillis() + "_" + nomOriginal;
        File fichierStocke = new File(dossier, nomStockage);

        try (InputStream in = fichier.getInputStream();
             FileOutputStream out = new FileOutputStream(fichierStocke)) {

            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = in.read(buffer)) != -1) {
                out.write(buffer, 0, bytesRead);
            }
        }

        String nomConverti =
            nomStockage.substring(0, nomStockage.lastIndexOf(".")) + "." + typeApres;

        File fichierConverti = new File(dossier, nomConverti);

        if (typeAvant.equals("pdf") && typeApres.equals("docx")) {
            fichierConverti = convertPdfToWord(fichierStocke);

        } else if (typeAvant.equals("pdf") && typeApres.equals("xlsx")) {
            fichierConverti = convertPdfToExcel(fichierStocke);

        } else if (typeAvant.equals("docx") && typeApres.equals("pdf")) {
            fichierConverti = convertWordToPdf(fichierStocke);
        }

       
        session.setAttribute("fichierConverti", fichierConverti.getName());

       if (user != null) {
       
        documents doc = new documents(user.getId(), nomOriginal, typeAvant, typeApres, fichierConverti.getName());
        docDB.ajouterDocument(doc);
        System.out.println("Document sauvegardé pour l'utilisateur ID: " + user.getId());
        
    } else {
        
        System.out.println("Conversion par invité - pas de sauvegarde en BD");
        
    }
    }

    public List<documents> getDocumentsUtilisateur(int userId) throws Exception {
        return docDB.getDocumentsParUtilisateur(userId);
    }

    private String getExtension(String nomFichier) {
        int i = nomFichier.lastIndexOf('.');
        if (i > 0) return nomFichier.substring(i + 1).toLowerCase();
        return "";
    }

    private boolean isConversionAutorisee(String avant, String apres) {
        if (avant.equals("docx") && apres.equals("pdf")) return true;
        if (avant.equals("pdf") && apres.equals("docx")) return true;
        if (avant.equals("pdf") && apres.equals("xlsx")) return true;
        return false;
    }
}
