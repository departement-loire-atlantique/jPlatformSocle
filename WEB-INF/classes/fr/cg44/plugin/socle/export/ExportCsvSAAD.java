package fr.cg44.plugin.socle.export;

import java.io.PrintWriter;
import java.io.Writer;
import java.util.Iterator;
import java.util.SortedSet;

import com.jalios.jcms.Channel;
import com.jalios.jcms.Member;
import com.jalios.jcms.Publication;
import com.jalios.util.Util;

import fr.cg44.plugin.socle.SocleUtils;
import generated.FicheArticle;
import generated.SAAD;

public class ExportCsvSAAD {
  
  private static final String SEPARATOR = ";";
  private static final char DOUBLE_QUOTE = '"';
  
  
  /**
   * Ajoute les headers CSV pour le type SAAD
   * @param printWriter
   */
  private static void printHeader(PrintWriter printWriter){    
    StringBuilder header = new StringBuilder();
    
    header.append(DOUBLE_QUOTE + "ID" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Titre" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Adresse" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Téléphone" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Adresse mail" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Site internet" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Commune (ancienne valeur)" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Communes" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Sur tout le département" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Statut juridique" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Modes d'intervention" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Type d'aide" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Prestations" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Modalités de paiement" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Plages d'intervention" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Types de service" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Mode de tarification" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Descriptif" + DOUBLE_QUOTE + SEPARATOR);
    
    header.append(ExportCsvUtils.getMetadataCsvHeader());
    
    printWriter.println(header);
  }
  
  /**
   * Ajoute les données CSV pour le type SAAD
   * @param itMember
   * @param paramString
   * @param paramWriter
   */
  public static void generateCsv(Member itMember, String paramString, Writer paramWriter) {
    PrintWriter localPrintWriter = new PrintWriter(paramWriter);
    
    Channel channel = Channel.getChannel();
    String userLang = channel.getCurrentUserLang();
    
    printHeader(localPrintWriter);
    
    SortedSet<Publication> sortedPubs = ExportCsvUtils.getPublicationsOfType("SAAD", itMember);
    
    for (Iterator<Publication> iter = sortedPubs.iterator(); iter.hasNext();) {
      Publication itPub = iter.next();
      if (Util.isEmpty(itPub) || !(itPub instanceof FicheArticle)) {
        continue;
      }
      
      SAAD itSaad = (SAAD) itPub;
      
      // Remplir les champs CSV
      StringBuilder chaine = new StringBuilder();
      
      // ID
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itPub.getId(), true));
      
      // Titre
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itPub.getTitle(userLang), true));
      
      // Adresse
      chaine.append(ExportCsvUtils.getFormattedCsvValueWysiwyg(itSaad.getAdresse(), true));
      
      // Téléphone
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itSaad.getTelephone(), true));

      // Adresse mail
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itSaad.getAdresseMail(), true));

      // Site internet
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itSaad.getSiteInternet(), true));
      
      // Commune (ancienne valeur)
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.listNameOfContent(itSaad.getCities()), true));
      
      // Communes
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.listNameOfContent(itSaad.getCommunes()), true));

      // Sur tout le département
      chaine.append(ExportCsvUtils.getFormattedCsvValue(Boolean.toString(itSaad.getSurToutLeDepartement()), true));
      
      // Statut juridique
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.formatCategories(itSaad.getStatutJuridique(itMember)), true));
      
      // Modes d'intervention
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.formatCategories(itSaad.getModesDintervention(itMember)), true));
      
      // Type d'aide
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.formatCategories(itSaad.getTypeDaide(itMember)), true));

      // Prestations
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.formatCategories(itSaad.getPrestations(itMember)), true));
      
      // Modalités de paiement
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.formatCategories(itSaad.getModalitesDePaiement(itMember)), true));

      // Plages d'intervention
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.formatCategories(itSaad.getPlagesDintervention(itMember)), true));

      // Types de service
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.formatCategories(itSaad.getTypesDeService(itMember)), true));

      // Mode de tarification
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.formatCategories(itSaad.getModeDeTarification(itMember)), true));

      // Descriptif
      chaine.append(ExportCsvUtils.getFormattedCsvValueWysiwyg(itSaad.getDescriptif(), true));

      chaine.append(ExportCsvUtils.getMetadataCsvPublication(itPub, "SAAD"));
    
      localPrintWriter.println(chaine);
    }
}
  
}