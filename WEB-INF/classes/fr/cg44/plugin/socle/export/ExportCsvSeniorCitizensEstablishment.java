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
import generated.SeniorCitizensEstablishment;

public class ExportCsvSeniorCitizensEstablishment {
  
  private static final String SEPARATOR = ";";
  private static final char DOUBLE_QUOTE = '"';
  
  
  /**
   * Ajoute les headers CSV pour le type SeniorCitizensEstablishment
   * @param printWriter
   */
  private static void printHeader(PrintWriter printWriter){    
    StringBuilder header = new StringBuilder();
    
    header.append(DOUBLE_QUOTE + "ID" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Titre" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Type de structure" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Adresse" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Boîte postale" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Commune (ancienne valeur)" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Commune" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Téléphones" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Courriels" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Sites Internet" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Texte de présentation" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Texte cadre de vie" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Texte sécurité sociale" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Texte vie sociale" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Texte animations" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Texte contractualisation" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Texte tarifs conventions" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Résidents dépendants" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Texte remarques" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Gérance" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Titre responsable" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Civilité responsable" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Nom responsable" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "CLICs" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Catégorie de navitation" + DOUBLE_QUOTE + SEPARATOR);
    
    header.append(ExportCsvUtils.getMetadataCsvHeader());
    
    printWriter.println(header);
  }
  
  /**
   * Ajoute les données CSV pour le type SeniorCitizensEstablishment
   * @param itMember
   * @param paramString
   * @param paramWriter
   */
  public static void generateCsv(Member itMember, String paramString, Writer paramWriter) {
    PrintWriter localPrintWriter = new PrintWriter(paramWriter);
    
    Channel channel = Channel.getChannel();
    String userLang = channel.getCurrentUserLang();
    
    printHeader(localPrintWriter);
    
    SortedSet<Publication> sortedPubs = ExportCsvUtils.getPublicationsOfType("SeniorCitizensEstablishment", itMember);
    
    for (Iterator<Publication> iter = sortedPubs.iterator(); iter.hasNext();) {
      Publication itPub = iter.next();
      if (Util.isEmpty(itPub) || !(itPub instanceof FicheArticle)) {
        continue;
      }
      
      SeniorCitizensEstablishment itEstablishment = (SeniorCitizensEstablishment) itPub;
      
      // Remplir les champs CSV
      StringBuilder chaine = new StringBuilder();
      
      // ID
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itPub.getId(), true));
      
      // Titre
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itPub.getTitle(userLang), true));
      
      // Type de structure
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.formatCategories(itEstablishment.getStructureType(itMember)), true));
      
      // Adresse
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itEstablishment.getAddress(), true));
      
      // Boîte postale
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itEstablishment.getPostalBox(), true));
      
      // Commune (ancienne valeur)
      chaine.append(ExportCsvUtils.getFormattedCsvValue(Util.notEmpty(itEstablishment.getCity()) ? itEstablishment.getCity().getTitle() : "", true));
      
      // Commune
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itEstablishment.getCommune().getTitle(), true));

      // Téléphones
      chaine.append(ExportCsvUtils.getFormattedCsvValueStringArray(itEstablishment.getPhones(), true));
      
      // Courriels
      chaine.append(ExportCsvUtils.getFormattedCsvValueStringArray(itEstablishment.getMails(), true));
      
      // Sites Internet
      chaine.append(ExportCsvUtils.getFormattedCsvValueStringArray(itEstablishment.getWebsites(), true));
      
      // Texte de présentation
      chaine.append(ExportCsvUtils.getFormattedCsvValueWysiwyg(itEstablishment.getDescription(), true));

      // Texte cadre de vie
      chaine.append(ExportCsvUtils.getFormattedCsvValueWysiwyg(itEstablishment.getLifeEnvironmentText(), true));
      
      // Texte sécurité sociale
      chaine.append(ExportCsvUtils.getFormattedCsvValueWysiwyg(itEstablishment.getSafeServiceText(), true));

      // Texte vie sociale
      chaine.append(ExportCsvUtils.getFormattedCsvValueWysiwyg(itEstablishment.getSocialLifeText(), true));

      // Texte animations
      chaine.append(ExportCsvUtils.getFormattedCsvValueWysiwyg(itEstablishment.getAnimationsText(), true));

      // Texte contractualisation
      chaine.append(ExportCsvUtils.getFormattedCsvValueWysiwyg(itEstablishment.getContractText(), true));

      // Texte tarifs conventions
      chaine.append(ExportCsvUtils.getFormattedCsvValueWysiwyg(itEstablishment.getConventionsCostText(), true));

      // Résidents dépendants
      chaine.append(ExportCsvUtils.getFormattedCsvValue(Boolean.toString(itEstablishment.getDependantResident()), true));
      
      // Texte remarques
      chaine.append(ExportCsvUtils.getFormattedCsvValueWysiwyg(itEstablishment.getRemarkText(), true));

      // Gérance
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itEstablishment.getManagement(), true));

      // Titre responsable
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itEstablishment.getManagerTitle(), true));

      // Civilité responsable
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itEstablishment.getManagerCivility(), true));

      // Nom responsable
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itEstablishment.getManagerName(), true));

      // CLICs
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.listNameOfContent(itEstablishment.getClics()), true));
      
      // Catégorie de navigation
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.formatCategories(itEstablishment.getCategorieDeNavigation(itMember)), true));

      chaine.append(ExportCsvUtils.getMetadataCsvPublication(itPub, "SeniorCitizensEstablishment"));
    
      localPrintWriter.println(chaine);
    }
}
  
}