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

public class ExportCsvFicheArticle {
  
  private static final String SEPARATOR = ";";
  private static final char DOUBLE_QUOTE = '"';
  
  
  /**
   * Ajoute les headers CSV pour le type FicheArticle
   * @param printWriter
   */
  private static void printHeader(PrintWriter printWriter){    
    StringBuilder header = new StringBuilder();
    
    header.append(DOUBLE_QUOTE + "ID" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Titre" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Image principale" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Image bandeau" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Image carrée" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Image mobile" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Copyright" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Légende" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Texte alternatif" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Vidéo principale" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Chapo" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Portlets haut" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Infobulle annuaire" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Type simple" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Encadrés communs" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Page utile" + DOUBLE_QUOTE + SEPARATOR);
    // TODO : couples titres / paragraphes
    header.append(DOUBLE_QUOTE + "Titre onglet 1" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Portlets encadré 1" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Titre onglet 2" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Portlets encadré 2" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Titre onglet 3" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Portlets encadré 3" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Titre onglet 4" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Portlets encadré 4" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Titre témoignage" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Sous-titre témoignage" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Catégorie de navigation" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Mise en avant" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Besoins" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Publics" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Annuaires" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Communes concernées" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Toutes les communes du département" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Délégations concernées" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "EPCI concernées" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Cantons concernés" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "FAQ" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Portlets bas" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Portlets encadrés" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "ID ancien contenu" + DOUBLE_QUOTE + SEPARATOR);
    
    header.append(ExportCsvUtils.getMetadataCsvHeader());
    
    printWriter.println(header);
  }
  
  /**
   * Ajoute les données CSV pour le type FicheArticle
   * @param itMember
   * @param paramString
   * @param paramWriter
   */
  public static void generateCsv(Member itMember, String paramString, Writer paramWriter) {
    PrintWriter localPrintWriter = new PrintWriter(paramWriter);
    
    Channel channel = Channel.getChannel();
    String userLang = channel.getCurrentUserLang();
    
    printHeader(localPrintWriter);
    
    SortedSet<Publication> sortedPubs = ExportCsvUtils.getPublicationsOfType("FicheArticle", itMember);
    
    for (Iterator<Publication> iter = sortedPubs.iterator(); iter.hasNext();) {
      Publication itPub = iter.next();
      if (Util.isEmpty(itPub) || !(itPub instanceof FicheArticle)) {
        continue;
      }
      
      FicheArticle itFicheArticle = (FicheArticle) itPub;
      
      // Remplir les champs CSV
      StringBuilder chaine = new StringBuilder();
      
      // ID
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itPub.getId(), true));
      
      // Titre
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itPub.getTitle(userLang), true));
      
      // Images
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheArticle.getImagePrincipale(userLang), true));
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheArticle.getImageBandeau(userLang), true));
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheArticle.getImageCarree(userLang), true));
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheArticle.getImageMobile(userLang), true));
      
      // Copyright
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheArticle.getCopyright(userLang), true));
      
      // Légende
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheArticle.getLegende(userLang), true));
      
      // Texte alternatif
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheArticle.getTexteAlternatif(userLang), true));
      
      // Vidéo principale
      chaine.append(ExportCsvUtils.getFormattedCsvValue(Util.notEmpty(itFicheArticle.getVideoPrincipale()) ? itFicheArticle.getVideoPrincipale().getTitle(userLang) : "", true));
      
      // Chapo
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheArticle.getChapo(userLang), true));
      
      // Portlets haut
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.listNameOfPortalElements(itFicheArticle.getPortletHaut()), true));
      
      // Infobulle
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheArticle.getInfobulleAnnuaire(userLang), true));
      
      // Type simple
      chaine.append(ExportCsvUtils.getFormattedCsvValue(Boolean.toString(itFicheArticle.getTypeSimple()), true));
      
      // ENcadrés communs
      chaine.append(ExportCsvUtils.getFormattedCsvValue(Boolean.toString(itFicheArticle.getEncadresCommuns()), true));
      
      // Page utile
      chaine.append(ExportCsvUtils.getFormattedCsvValue(Boolean.toString(itFicheArticle.getPageUtile()), true));
      
      
      
      chaine.append(ExportCsvUtils.getMetadataCsvPublication(itPub));
    
      localPrintWriter.println(chaine);}
  }
  
}