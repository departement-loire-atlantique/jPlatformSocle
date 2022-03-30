package fr.cg44.plugin.socle.importation;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.lang.math.NumberUtils;
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

public class ImportLieuFromCsv {
    
    private static CsvReader csvReader;
    private static final char SEPARATOR = ';';
    private static final String doubleHashtag = "##";
    private static final Logger LOGGER = Logger.getLogger(ImportLieuFromCsv.class);
    private static String encoding = "UTF-8";
    protected static final Channel channel = Channel.getChannel();
    
    /*
     * Liste des valeurs attendues dans le CSV
     * 0 Titre - String
     * 1 Sous-titre - String
     * 2 Etage, couloir, escalier - String
     * 3 Entrée, bâtiment, immeuble - String
     * 4 N° de voie - String
     * 5 Libellé de voie - String
     * 6 Lieu-dit - String
     * 7 Code postal - String
     * 8 CS - String
     * 9 Cedex - String
     * 10 Code Insee - Commune (à récupérer via le dit INSEE)
     * 11 Telephone - String[]
     * 12 Email - String[]
     * 13 Site internet - String[]
     * 14 Lien page facebook - String
     * 15 Lien page instagram - String
     * 16 Latitude - String
     * 17 Longitude - String
     * 18 Plus de détails interne - ID jalios sur contenu
     * 19 Type d'accès - ID catégorie de la branche "type d'accès"
     * 20 Navigation et classement - Multiples IDs de catégories
     * 21 Territoire communes concernées - String (code insee)
     * 22 Toutes les communues du département - oui / non
     * 23 Délégations - IDs jcms multiples
     * 24 EPCI - IDs catégories multiples
     * 25 Cantons - IDs fiche canton multiples
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
                     * Titre (obligatoire)
                     * Code INSEE -> déterminer l'existence du contenu Commune
                     * Communes concernées -> ditto, mais un array
                     * Navigation et classement -> si non vide déterminer existence catégorie + si dans branche
                     * EPCI -> ditto
                     * Délégations -> si non vide déterminer l'existence de chaque ID (et bon type)
                     * Cantons -> ditto
                     */
                    lineLog = new StringBuilder();
                    values = csvReader.getValues();
                    if (values.length != 26) {
                        channel.getCurrentJcmsContext().addMsgSession(new JcmsMessage(JcmsMessage.Level.ERROR, "Le fichier CSV doit avoir 26 colonnes, et il n'en a que " + values.length));
                        break;
                    }
                    if (!skippedFirst) { // ne pas lire la ligne des headers
                        skippedFirst = true;
                        continue;
                    }
                    if (Util.isEmpty(values[0])) { // titre
                        lineLog.append("Le titre (champ obligatoire) est vide. # ");
                    }
                    if (Util.notEmpty(values[10]) ? !communeInseeCheck(values[10]) : false) { // check code INSEE commune
                        lineLog.append("Le champ Code INSEE présente un code INSEE incorrect. Aucune commune 44 n'est associée à la valeur donnée. # ");
                    }
                    if (Util.isEmpty(values[20])) { // navigation et classement
                        lineLog.append("Le champ Navigation et classement (obligatoire) est vide. # ");
                    } else if (!categoryCheck(values[20], channel.getCategory("$jcmsplugin.socle.category.navigationDesEspaces.root"))) { // check branche navigation et existence de catégories
                        lineLog.append("Le champ Navigation et classement (obligatoire) présente des catégories incorrectes (mauvaise branche ou IDs n'existant pas) # ");
                    }
                    if (Util.notEmpty(values[21]) ? !inseeArrayCheck(values[21]) : false) { // Territoire communes concernées
                        lineLog.append("Le champ Territoire communes concernées présente des codes INSEE incorrects (INSEE non 44 ou pas de commune associée à un code INSEE) # ");
                    }
                    if (Util.notEmpty(values[24]) ? !categoryCheck(values[24], channel.getCategory("$jcmsplugin.socle.category.toutesLesCommunesEPCI.root")) : false) { // check branche EPCI
                        lineLog.append("Le champ EPCI présente des catégories incorrectes (mauvaise branche ou IDs n'existant pas) # ");
                    }
                    
                    if (Util.notEmpty(values[23]) ? !contentCheck(values[23],Delegation.class) : false) { // délégations
                        lineLog.append("Le champ Délégations présente des contenus incorrects (un ou plusieurs contenus n'existent pas / ne sont pas des délégations) # ");
                    }
                    
                    if (Util.notEmpty(values[25]) ? !contentCheck(values[25], Canton.class) : false) { // cantons
                        lineLog.append("Le champ Cantons présente des contenus incorrects (un ou plusieurs contenus n'existent pas / ne sont pas des cantons) # ");
                    }
                    
                    FicheLieu itFiche = generateFicheLieuFromCsvValues(values);
                    
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
     * Détermine si une liste de codes INSEE est correcte
     * @param string
     * @return
     */
    private static boolean inseeArrayCheck(String codesInsee) {
        String[] arrayInsee = codesInsee.split(doubleHashtag);
        for (int counter = 0; counter < arrayInsee.length; counter++) {
            if (Util.isEmpty(communeInseeCheck(arrayInsee[counter]))) {
                return false;
            }
        }
        return true;
    }

    /**
     * Détermine si un code INSEE correspond au code INSEE d'une commune 44
     * @param string
     * @return
     */
    private static boolean communeInseeCheck(String inseeStr) {
        City itCommune = null;
        // Cas 1 -> que des nombres dans le string
        if (NumberUtils.isNumber(inseeStr)) {
            itCommune = SocleUtils.getCommuneFromInsee(inseeStr);
        } else {
            // cas 2 -> nom de ville, on récupère depuis celui-ci
            itCommune = SocleUtils.getCommuneFromName(inseeStr);
        }
        return Util.notEmpty(itCommune);
    }

    /**
     * Vérifie si une liste d'IDs de contenus représente une liste correcte de contenus
     * Incorrect si un contenu n'existe pas ou n'est pas du type indiqué
     * @param string
     * @param type
     * @return
     */
    private static boolean contentCheck(String idsStr, Class<?> itClass) {
        if (Util.isEmpty(idsStr)) return false;
        
        String[] ids = idsStr.split(doubleHashtag);
        for (int counter = 0; counter < ids.length; counter++) {
            Publication itPub = channel.getPublication(ids[counter]);
            if (Util.isEmpty(itPub) || !itClass.isInstance(itPub)) return false;
        }
        return true;
    }

    /**
     * Vérifie si une liste d'IDs de catégorie représente une liste correcte de catégories
     * Incorrect si une catégorie n'existe pas ou si la branche d'une catégorie est incorrecte
     * @param string
     * @return
     */
    private static boolean categoryCheck(String cidsStr, Category ancestorCat) {
        if (Util.isEmpty(cidsStr)) return false;
        
        String[] cids = cidsStr.split(doubleHashtag);
        for (int counter = 0; counter < cids.length; counter++) {
            Category itCat = channel.getCategory(cids[counter]);
            if (Util.isEmpty(itCat) || !SocleUtils.catHasAncestor(itCat, ancestorCat)) return false;
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
                if(values.length != 26){
                    trace += "Le fichier contient une ligne incorrecte [ligne " + cpt + "], nombre de colonnes différent de 26 \r\n" + csvReader.getRawRecord() + "\r\n";
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
        channel.getCurrentJcmsContext().getRequest().setAttribute("traceImport", trace);
        return result;
    }
    
    /**
     * Générer une fiche lieu à partir des valeurs d'une ligne CSV
     * @param values
     */
    private static FicheLieu generateFicheLieuFromCsvValues(String[] values) {
        
        FicheLieu itLieu = new FicheLieu();
        // Titre
        itLieu.setTitle(values[0]);
        // Sous-titre
        itLieu.setSoustitre(values[1]);
        // Etage, couloir, escalier
        itLieu.setEtageCouloirEscalier(values[2]);
        // Entrée, bâtiment, immeuble
        itLieu.setEntreeBatimentImmeuble(values[3]);
        // N° de voie
        itLieu.setNdeVoie(values[4]);
        // Libellé de voie
        itLieu.setLibelleDeVoie(values[5]);
        // Lieu-dit
        itLieu.setLieudit(values[6]);
        // Code postal
        itLieu.setCodePostal(values[7]);
        // CS
        itLieu.setCs2(values[8]);
        // Cedex
        itLieu.setCedex2(values[9]);
        // Commune
        if (NumberUtils.isNumber(values[10])) {
            itLieu.setCommune(SocleUtils.getCommuneFromCode(values[10]));
        } else {
            itLieu.setCommune(SocleUtils.getCommuneFromName(values[10]));
        }        
        // Telephone
        itLieu.setTelephone(values[11].split(doubleHashtag));
        // Email
        itLieu.setEmail(values[12].split(doubleHashtag));
        // Site internet
        itLieu.setSiteInternet(values[13].split(doubleHashtag));
        // Lien page facebook
        itLieu.setLienDeLaPageFacebook(values[14]);
        // Lien page instagram
        itLieu.setLienDeLaPageInstagram(values[15]);
        // Latitude
        if (Util.notEmpty(values[16])) {
            itLieu.setExtraData("extra.EvenementInfolocale.plugin.tools.geolocation.latitude", values[16]);
        }
        // Longitude
        if (Util.notEmpty(values[17])) {
            itLieu.setExtraData("extra.EvenementInfolocale.plugin.tools.geolocation.longitude", values[17]);
        }
        // Plus de détails interne
        if (Util.notEmpty(values[18])) {
            itLieu.setPlusDeDetailInterne(channel.getData(Content.class, values[18]));
        }
        // Type d'accès
        if (Util.notEmpty(values[19])) {
            itLieu.addCategory(channel.getCategory(values[19]));
        }
        // Navigation et classement
        if (Util.notEmpty(values[20])) {
            for (String itCid : values[20].split(doubleHashtag)) {
                itLieu.addCategory(channel.getCategory(itCid));
            }
        }
        // Communes concernées
        if (Util.notEmpty(values[21])) {
            List<City> communes = new ArrayList<>();
            for (String itInsee : values[21].split(doubleHashtag)) {
                communes.add(SocleUtils.getCommuneFromCode(itInsee));
            }
            itLieu.setCommunes(communes.toArray(new City[communes.size()]));
        }
        // Toutes les communes du département
        itLieu.setToutesLesCommunesDuDepartement("oui".equalsIgnoreCase(values[22]));
        // Délégations
        if (Util.notEmpty(values[23])) {
            List<Delegation> delegations = new ArrayList<>();
            for (String itId : values[23].split(doubleHashtag)) {
                delegations.add(channel.getData(Delegation.class, itId));
            }
            itLieu.setDelegations(delegations.toArray(new Delegation[delegations.size()]));
        }
        // EPCI
        if (Util.notEmpty(values[24])) {
            for (String itCid : values[24].split(doubleHashtag)) {
                itLieu.addCategory(channel.getCategory(itCid));
            }
        }
        // Cantons
        if (Util.notEmpty(values[25])) {
            List<Canton> cantons = new ArrayList<>();
            for (String itId : values[25].split(doubleHashtag)) {
                cantons.add(channel.getData(Canton.class, itId));
            }
            itLieu.setCantons(cantons.toArray(new Canton[cantons.size()]));
        }
        
        itLieu.setAuthor(channel.getCurrentLoggedMember());
        
        return itLieu;
    }
    
    /**
     * Procéder à l'import de fiches lieu via CSV
     * Assume que le fichier a été vérifié au préalable
     * @param fileItem
     */
    public static void importFichesLieuCsv(FileItem fileItem) {
        
        List<FicheLieu> lieuxToCreate = new ArrayList<FicheLieu>();
        
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
                
                lieuxToCreate.add(generateFicheLieuFromCsvValues(values));
            }
            
        } catch (Exception e) {
            channel.getCurrentJcmsContext().addMsgSession(new JcmsMessage(JcmsMessage.Level.ERROR, "Erreur lors de la lecture du CSV : " + e.getMessage()));
            LOGGER.error("Erreur sur importFichesLieuCsv : " + e.getMessage());
        }
        
        int counterImported = 0;
        
        for (FicheLieu itLieu : lieuxToCreate) {
            ControllerStatus importStatus = itLieu.checkAndPerformCreate(channel.getCurrentLoggedMember());
            if (!importStatus.isOK()) {
                LOGGER.warn("Anomalie lors de l'import du lieu " + itLieu.getTitle() + " : " + importStatus.getMessage(channel.getCurrentUserLang()));
            } else {
                counterImported++;
            }
        }
        
        if (counterImported == lieuxToCreate.size()) {        
            channel.getCurrentJcmsContext().addMsgSession(new JcmsMessage(JcmsMessage.Level.SUCCESS, "Un total de " + lieuxToCreate.size() + " fiches lieux ont été créées."));
        } else {
            channel.getCurrentJcmsContext().addMsgSession(new JcmsMessage(JcmsMessage.Level.WARN, "Un total de " + counterImported
                + " fiches lieux ont été créées sur les " + lieuxToCreate.size() + " possibles. Veuillez inspecter les logs.")); 
        }
    }
}