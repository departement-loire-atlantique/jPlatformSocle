package fr.cg44.plugin.socle.export;

import java.io.PrintWriter;
import java.io.Writer;
import java.util.Arrays;
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
    header.append(DOUBLE_QUOTE + "Titres paragraphes" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Contenu paragraphes" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Titre onglet 1" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Titres paragraphes 1" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Contenu paragraphes 1" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Titres encadrés 1" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Contenu encadrés 1" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Portlets encadré 1" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Titre onglet 2" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Titres paragraphes 2" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Contenu paragraphes 2" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Titres encadrés 2" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Contenu encadrés 2" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Portlets encadré 2" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Titre onglet 3" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Titres paragraphes 3" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Contenu paragraphes 3" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Titres encadrés 3" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Contenu encadrés 3" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Portlets encadré 3" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Titre onglet 4" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Titres paragraphes 4" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Contenu paragraphes 4" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Titres encadrés 4" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Contenu encadrés 4" + DOUBLE_QUOTE + SEPARATOR);
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
    header.append(DOUBLE_QUOTE + "Portlets encadrés 1" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Portlets encadrés 2" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Portlets encadrés 3" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Portlets encadrés 4" + DOUBLE_QUOTE + SEPARATOR);
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
      chaine.append(ExportCsvUtils.getFormattedCsvValueWysiwyg(itFicheArticle.getChapo(userLang), true));
      
      // Portlets haut
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.listNameOfPortalElements(itFicheArticle.getPortletHaut()), true));
      
      // Infobulle
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheArticle.getInfobulleAnnuaire(userLang), true));
      
      // Type simple
      chaine.append(ExportCsvUtils.getFormattedCsvValue(Boolean.toString(itFicheArticle.getTypeSimple()), true));
      
      // Encadrés communs
      chaine.append(ExportCsvUtils.getFormattedCsvValue(Boolean.toString(itFicheArticle.getEncadresCommuns()), true));
      
      // Page utile
      chaine.append(ExportCsvUtils.getFormattedCsvValue(Boolean.toString(itFicheArticle.getPageUtile()), true));
      
      // Titres paragraphes
      chaine.append(ExportCsvUtils.getFormattedCsvValueStringArray(itFicheArticle.getTitreParagraphe(), true));
      
      // Contenu paragraphes
      chaine.append(ExportCsvUtils.getFormattedCsvValueStringArray(itFicheArticle.getContenuParagraphe(), true));
      
      // Titre onglet 1
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheArticle.getTitreOnglet_1(), true));
      
      // Titres paragraphes 1
      chaine.append(ExportCsvUtils.getFormattedCsvValueStringArray(itFicheArticle.getTitreParagraphe_1(), true));
      
      // Contenu paragraphes 1
      chaine.append(ExportCsvUtils.getFormattedCsvValueStringArray(itFicheArticle.getContenuParagraphe_1(), true));
      
      // Titres encadrés 1
      chaine.append(ExportCsvUtils.getFormattedCsvValueStringArray(itFicheArticle.getTitreEncadre_1(), true));
      
      // Contenu encadrés 1
      chaine.append(ExportCsvUtils.getFormattedCsvValueStringArray(itFicheArticle.getContenuEncadre_1(), true));
      
      // Portlets encadrés 1
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.listNameOfPortalElements(itFicheArticle.getPortletsEncadres_1()), true));
      
      // Titre onglet 2
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheArticle.getTitreOnglet_2(), true));
      
      // Titres paragraphes 2
      chaine.append(ExportCsvUtils.getFormattedCsvValueStringArray(itFicheArticle.getTitreParagraphe_2(), true));
      
      // Contenu paragraphes 2
      chaine.append(ExportCsvUtils.getFormattedCsvValueStringArray(itFicheArticle.getContenuParagraphe_2(), true));
      
      // Titres encadrés 2
      chaine.append(ExportCsvUtils.getFormattedCsvValueStringArray(itFicheArticle.getTitreEncadre_2(), true));
      
      // Contenu encadrés 2
      chaine.append(ExportCsvUtils.getFormattedCsvValueStringArray(itFicheArticle.getContenuEncadre_2(), true));
      
      // Portlets encadrés 2
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.listNameOfPortalElements(itFicheArticle.getPortletsEncadres_2()), true));
      
      // Titre onglet 3
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheArticle.getTitreOnglet_3(), true));
      
      // Titres paragraphes 3
      chaine.append(ExportCsvUtils.getFormattedCsvValueStringArray(itFicheArticle.getTitreParagraphe_3(), true));
      
      // Contenu paragraphes 3
      chaine.append(ExportCsvUtils.getFormattedCsvValueStringArray(itFicheArticle.getContenuParagraphe_3(), true));
      
      // Titres encadrés 3
      chaine.append(ExportCsvUtils.getFormattedCsvValueStringArray(itFicheArticle.getTitreEncadre_3(), true));
      
      // Contenu encadrés 3
      chaine.append(ExportCsvUtils.getFormattedCsvValueStringArray(itFicheArticle.getContenuEncadre_3(), true));
      
      // Portlets encadrés 3
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.listNameOfPortalElements(itFicheArticle.getPortletsEncadres_3()), true));
      
      // Titre onglet 4
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheArticle.getTitreOnglet_4(), true));
      
      // Titres paragraphes 4
      chaine.append(ExportCsvUtils.getFormattedCsvValueStringArray(itFicheArticle.getTitreParagraphe_4(), true));
      
      // Contenu paragraphes 4
      chaine.append(ExportCsvUtils.getFormattedCsvValueStringArray(itFicheArticle.getContenuParagraphe_4(), true));
      
      // Titres encadrés 4
      chaine.append(ExportCsvUtils.getFormattedCsvValueStringArray(itFicheArticle.getTitreEncadre_4(), true));
      
      // Contenu encadrés 4
      chaine.append(ExportCsvUtils.getFormattedCsvValueStringArray(itFicheArticle.getContenuEncadre_4(), true));
      
      // Portlets encadrés 4
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.listNameOfPortalElements(itFicheArticle.getPortletsEncadres_4()), true));
      
      // Titre témoignage
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheArticle.getTitreTemoignage(), true));
      
      // Sous-titre témoignage
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheArticle.getSoustitreTemoignage(), true));
      
      // Catégorie de navigation
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.formatCategories(itFicheArticle.getCategorieDeNavigation(itMember), " ** "), true));
      
      // Mise en avant
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.formatCategories(itFicheArticle.getMiseEnAvant(itMember)), true));
      
      // Besoins
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.formatCategories(itFicheArticle.getBesoins(itMember)), true));
      
      // Publics
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.formatCategories(itFicheArticle.getPublics(itMember)), true));
      
      // Annuaires
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.formatCategories(itFicheArticle.getAnnuaires(itMember)), true));
      
      // Communes concernées
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.listNameOfContent(itFicheArticle.getCommunes()), true));
      
      // Toutes les communes du département
      chaine.append(ExportCsvUtils.getFormattedCsvValue(Boolean.toString(itFicheArticle.getToutesLesCommunesDuDepartement()), true));
      
      // Délégations concernées
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.listNameOfContent(itFicheArticle.getDelegations()), true));
      
      // EPCI concernées
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.formatCategories(itFicheArticle.getEpci(itMember)), true));
      
      // Cantons concernés
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.listNameOfContent(itFicheArticle.getCantons()), true));
      
      // FAQ
      chaine.append(ExportCsvUtils.getFormattedCsvValue(Util.isEmpty(itFicheArticle.getFaq()) ? "" : itFicheArticle.getFaq().getTitle(), true));
      
      // Portlets encadrés 1
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.listNameOfPortalElements(itFicheArticle.getPortletsEncadres_1()), true));
      
      // Portlets encadrés 2
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.listNameOfPortalElements(itFicheArticle.getPortletsEncadres_2()), true));
      
      // Portlets encadrés 3
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.listNameOfPortalElements(itFicheArticle.getPortletsEncadres_3()), true));
      
      // Portlets encadrés 4
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.listNameOfPortalElements(itFicheArticle.getPortletsEncadres_4()), true));
      
      // ID ancien contenu
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheArticle.getIdAncienContenu(), true));
      
      chaine.append(ExportCsvUtils.getMetadataCsvPublication(itPub, "FicheArticle"));
    
      localPrintWriter.println(chaine);
    }
}
  
}