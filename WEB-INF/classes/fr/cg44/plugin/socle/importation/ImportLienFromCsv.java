package fr.cg44.plugin.socle.importation;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.apache.commons.fileupload.FileItem;
import org.apache.log4j.Logger;

import com.csvreader.CsvReader;
import com.jalios.jcms.Category;
import com.jalios.jcms.Channel;
import com.jalios.jcms.Content;
import com.jalios.jcms.ControllerStatus;
import com.jalios.jcms.Publication;
import com.jalios.jcms.context.JcmsMessage;
import com.jalios.util.Util;

import fr.cg44.plugin.socle.SocleUtils;
import generated.Canton;
import generated.City;
import generated.Delegation;
import generated.FicheLieu;
import generated.Lien;

public class ImportLienFromCsv {
    
    private static CsvReader csvReader;
    private static final char SEPARATOR = ';';
    private static final String doubleHashtag = "##";
    private static final Logger LOGGER = Logger.getLogger(ImportLienFromCsv.class);
    private static String encoding = "UTF-8";
    private static final String WORKSPACE = "$id.jcmsplugin.socle.lien.importWS";
    protected static final Channel channel = Channel.getChannel();
    
    /*
     * Liste des valeurs attendues dans le CSV
     * 0 Titre - String
     * 1 Navigation et classement - Multiples IDs de catégories
     * 2 Lieu affiché - String 
     * 3 Lien externe - String
     */
    
    /**
     * Va renvoyer différents logs informatifs pour informer l'utilisateur
     * de l'état du CSV et des lignes en erreur
     * sans effectuer d'import de données
     */
    public static Map<String, String> checkCsvImport(FileItem fileItem) {
        Map<String, String> returnedLog = new TreeMap<>();
        
        if (!fileIsNotCorrectCsv(fileItem)) {
            try {
                csvReader = new CsvReader(new InputStreamReader(fileItem.getInputStream(),encoding), SEPARATOR);
                String[] values;
                int cpt = 2;
                StringBuilder lineLog;
                boolean skippedFirst = false;
                while (csvReader.readRecord()){
                    /*
                     * Champs à surveiller :
                     * 
                     * Les 4 champs sont obligatoires
                     * Navigation et classement -> si non vide déterminer existence catégorie + si dans branche
                     * 
                     */
                    lineLog = new StringBuilder();
                    values = csvReader.getValues();
                    if (values.length != 4) {
                        channel.getCurrentJcmsContext().addMsgSession(new JcmsMessage(JcmsMessage.Level.ERROR, "Le fichier CSV doit avoir 4 colonnes, et il n'en a que " + values.length));
                        break;
                    }
                    if (!skippedFirst) { // ne pas lire la ligne des headers
                        skippedFirst = true;
                        continue;
                    }
                    if (Util.isEmpty(values[0])) { // titre
                        lineLog.append("Le titre (champ obligatoire) est vide. # ");
                    }
                    if (Util.isEmpty(values[1])) { // navigation et classement
                        lineLog.append("Le champ Navigation et classement (obligatoire) est vide. # ");
                    } else if (!categoryCheck(values[1], channel.getCategory("$jcmsplugin.socle.category.navigationDesEspaces.root"))) { // check branche navigation et existence de catégories
                        lineLog.append("Le champ Navigation et classement (obligatoire) présente des catégories incorrectes (mauvaise branche ou IDs n'existant pas) # ");
                    }
                    if (Util.isEmpty(values[2])) { // lieu affiché
                      lineLog.append("Le lieu (champ obligatoire) est vide. # ");
                    }
                    if (Util.isEmpty(values[3])) { // lien externe
                      lineLog.append("Le lien (champ obligatoire) est vide. # ");
                    }
                    
                    Lien itFiche = generateLienFromCsvValues(values);
                    
                    ControllerStatus status = itFiche.checkCreate(channel.getCurrentLoggedMember());
                    if (!status.isOK()) {
                        lineLog.append(status.getMessage(channel.getCurrentUserLang()));   
                    }
                    
                    if (Util.notEmpty(lineLog.toString())) {
                        returnedLog.put("Ligne " + (cpt), lineLog.toString());
                    }
                    
                    cpt++;
                }
            } catch (IOException e) {
                channel.getCurrentJcmsContext().addMsgSession(new JcmsMessage(JcmsMessage.Level.ERROR, "Erreur lors de la lecture du CSV : " + e.getMessage()));
                return null;
            }
            
            return returnedLog;
        }
        
        channel.getCurrentJcmsContext().addMsgSession(new JcmsMessage(JcmsMessage.Level.SUCCESS, "Le fichier CSV est correct !"));
        
        return null;
    }


    /**
     * Vérifie si une liste d'IDs de catégorie représente une liste correcte de catégories
     * Incorrect si une catégorie n'existe pas
     * @param string
     * @return
     */
    private static boolean categoryCheck(String cidsStr, Category ancestorCat) {
        if (Util.isEmpty(cidsStr)) return false;
        
        String[] cids = cidsStr.split(doubleHashtag);
        for (int counter = 0; counter < cids.length; counter++) {
            Category itCat = channel.getCategory(cids[counter]);
            if (Util.isEmpty(itCat)) return false;
        }
        return true;
    }

    private static boolean fileIsNotCorrectCsv(FileItem fileItem) {
        boolean result = false;
        String message = "";
        String trace = "";

        try {
            csvReader = new CsvReader(new InputStreamReader(fileItem.getInputStream(),encoding), SEPARATOR);
            String[] values;
            int cpt = 1;
            // On vérifie le nombre de colonnes
            while (csvReader.readRecord()){
                values = csvReader.getValues();
                if(values.length != 4){
                    trace += "Le fichier contient une ligne incorrecte [ligne " + cpt + "], nombre de colonnes différent de 4 \r\n" + csvReader.getRawRecord() + "\r\n";
                    result = true;
                }
                cpt++;
            }
            csvReader.close();
            if(result){
                message = "Le fichier contient des lignes en erreur.";
                channel.getCurrentJcmsContext().addMsgSession(new JcmsMessage(JcmsMessage.Level.ERROR, message));
            }
            else{
                result = false;
                message = "La syntaxe du fichier est correcte.";
                channel.getCurrentJcmsContext().addMsgSession(new JcmsMessage(JcmsMessage.Level.INFO, message));
            }
            
            channel.getCurrentJcmsContext().getRequest().setAttribute("traceImport", trace);
            
        } catch (FileNotFoundException e) {
            result = true;
            message = "Impossible de trouver le fichier";
            channel.getCurrentJcmsContext().addMsgSession(new JcmsMessage(JcmsMessage.Level.ERROR, message));
        } catch (IOException e) {
            result = true;
            message = "Erreur lors de la lecture du fichier";
            channel.getCurrentJcmsContext().addMsgSession(new JcmsMessage(JcmsMessage.Level.ERROR, message));
            channel.getCurrentJcmsContext().getRequest().setAttribute("traceImport", e);
        } 
        return result;
    }
    
    /**
     * Générer une fiche lieu à partir des valeurs d'une ligne CSV
     * @param values
     */
    private static Lien generateLienFromCsvValues(String[] values) {
        
        Lien itLien = new Lien();
        
        // Titre
        itLien.setTitle(values[0]);
        // Navigation et classement
        if (Util.notEmpty(values[1])) {
            for (String itCid : values[1].split(doubleHashtag)) {
                itLien.addCategory(channel.getCategory(itCid));
            }
        }
        // Lieu
        itLien.setLieu(values[2]);
        // Lien
        itLien.setLienExterne(values[3]);
        itLien.setAuthor(channel.getCurrentLoggedMember());
        itLien.setWorkspaceId(WORKSPACE);
        
        return itLien;
    }
    
    /**
     * Procéder à l'import de Liens via CSV
     * Assume que le fichier a été vérifié au préalable
     * @param fileItem
     */
    public static void importLiensCsv(FileItem fileItem) {
        
        List<Lien> publicationsToCreate = new ArrayList<Lien>();
        
        try {
            csvReader = new CsvReader(new InputStreamReader(fileItem.getInputStream(),encoding), SEPARATOR);
            String[] values;
            boolean skippedFirst = false;
            while (csvReader.readRecord()){
                if (!skippedFirst) { // ne pas lire la ligne des headers
                    skippedFirst = true;
                    continue;
                }

                values = csvReader.getValues();
                
                publicationsToCreate.add(generateLienFromCsvValues(values));
            }
            
        } catch (Exception e) {
            channel.getCurrentJcmsContext().addMsgSession(new JcmsMessage(JcmsMessage.Level.ERROR, "Erreur lors de la lecture du CSV : " + e.getMessage()));
            LOGGER.error("Erreur sur importLiensCsv : " + e.getMessage());
        }
        
        int counterImported = 0;
        
        for (Lien itLien : publicationsToCreate) {
            ControllerStatus importStatus = itLien.checkAndPerformCreate(channel.getCurrentLoggedMember());
            if (!importStatus.isOK()) {
                LOGGER.warn("Anomalie lors de l'import du lien " + itLien.getTitle() + " : " + importStatus.getMessage(channel.getCurrentUserLang()));
            } else {
                counterImported++;
            }
        }
        
        if (counterImported == publicationsToCreate.size()) {        
            channel.getCurrentJcmsContext().addMsgSession(new JcmsMessage(JcmsMessage.Level.SUCCESS, "Un total de " + publicationsToCreate.size() + " liens ont été créées."));
        } else {
            channel.getCurrentJcmsContext().addMsgSession(new JcmsMessage(JcmsMessage.Level.WARN, "Un total de " + counterImported
                + " liens ont été créées sur les " + publicationsToCreate.size() + " possibles. Veuillez inspecter les logs.")); 
        }
    }
}