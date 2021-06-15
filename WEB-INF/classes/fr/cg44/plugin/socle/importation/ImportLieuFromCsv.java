package fr.cg44.plugin.socle.importation;

import java.util.Map;

import javax.servlet.http.Part;

import org.apache.log4j.Logger;

public class ImportLieuFromCsv {
    
    private static final String SEPARATOR = ";";
    private static final char DOUBLE_QUOTE = '"';
    private static final String doubleHashtag = " ## ";
    private static final Logger LOGGER = Logger.getLogger(ImportLieuFromCsv.class);
    
    /**
     * Va renvoyer différents logs informatifs pour informer l'utilisateur
     * de l'état du CSV et des lignes en erreur
     * sans effectuer d'import de données
     */
    public static Map<String, String> checkCsvImport(Part filePart) {
        if (Util.)
    }
}