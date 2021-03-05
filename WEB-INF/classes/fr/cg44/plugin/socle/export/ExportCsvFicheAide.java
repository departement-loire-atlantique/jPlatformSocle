package fr.cg44.plugin.socle.export;

import java.io.PrintWriter;
import java.io.Writer;
import java.util.Iterator;
import java.util.SortedSet;

import com.jalios.jcms.Member;
import com.jalios.jcms.Publication;
import com.jalios.util.Util;

import fr.cg44.plugin.socle.SocleUtils;
import generated.FicheAide;
import generated.FicheArticle;

public class ExportCsvFicheAide {
  
  private static final String SEPARATOR = ";";
  private static final char DOUBLE_QUOTE = '"';
  
  
  /**
   * Ajoute les headers CSV pour le type FicheAide
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
    header.append(DOUBLE_QUOTE + "Chapo" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Pour qui ?" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Intro" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Eligibilité" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "C'est quoi ?" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Comment faire une demande ?" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Quels documents fournir ?" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Titre encart \"Bon à savoir\"" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Bon à savoir" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Titre vidéo" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Vidéo" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Portlet encadrés" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Instruction délégation" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Type de lieu" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Type de lieu secondaire" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Contact service par email" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Qui contacter ?" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Intro contact" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Complément contact" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Besoin d'aide ?" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "FAQ" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Contact FAQ" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Instruction délégation (demande)" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Type de lieu (demande)" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Type de lieu secondaire (demande)" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Contact service par email (demande)" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Lieu instruction des demandes ?" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Documents utiles" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "E-démarche" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Url e-démarche" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Url suivi e-démarches" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Durée e-démarches" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Intro suivre une demande" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Intro faire une demande" + DOUBLE_QUOTE + SEPARATOR);
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
    
    header.append(ExportCsvUtils.getMetadataCsvHeader());
    
    printWriter.println(header);
  }
  
  /**
   * Ajoute les données CSV pour le type FicheAide
   * @param itMember
   * @param paramString
   * @param paramWriter
   */
  public static void generateCsv(Member itMember, String paramString, Writer paramWriter) {
    PrintWriter localPrintWriter = new PrintWriter(paramWriter);
    
    printHeader(localPrintWriter);
    
    SortedSet<Publication> sortedPubs = ExportCsvUtils.getPublicationsOfType("FicheAide", itMember);
    
    for (Iterator<Publication> iter = sortedPubs.iterator(); iter.hasNext();) {
      Publication itPub = iter.next();
      if (Util.isEmpty(itPub) || !(itPub instanceof FicheArticle)) {
        continue;
      }
      
      FicheAide itFicheAide = (FicheAide) itPub;
      
      // Remplir les champs CSV
      StringBuilder chaine = new StringBuilder();
      
      // ID
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itPub.getId(), true));
      
      // Titre
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itPub.getTitle(), true));
      
      // Images
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheAide.getImagePrincipale(), true));
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheAide.getImageBandeau(), true));
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheAide.getImageCarree(), true));
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheAide.getImageMobile(), true));
      
      // Copyright
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheAide.getCopyright(), true));
      
      // Légende
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheAide.getLegende(), true));
      
      // Texte alternatif
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheAide.getTexteAlternatif(), true));
      
      // Chapo
      chaine.append(ExportCsvUtils.getFormattedCsvValueWysiwyg(itFicheAide.getChapo(), true));
      
      // Pour qui
      chaine.append(ExportCsvUtils.getFormattedCsvValueWysiwyg(itFicheAide.getPourQui(), true));
      
      // Intro
      chaine.append(ExportCsvUtils.getFormattedCsvValueWysiwyg(itFicheAide.getIntro(), true));
      
      // Eligibilité
      chaine.append(ExportCsvUtils.getFormattedCsvValueWysiwyg(itFicheAide.getEligibilite(), true));
      
      // C'est quoi ?
      chaine.append(ExportCsvUtils.getFormattedCsvValueWysiwyg(itFicheAide.getCestQuoi(), true));
      
      // Comment faire une demande ?
      chaine.append(ExportCsvUtils.getFormattedCsvValueWysiwyg(itFicheAide.getCommentFaireUneDemande(), true));
      
      // Quels documents fournir ?
      chaine.append(ExportCsvUtils.getFormattedCsvValueWysiwyg(itFicheAide.getQuelsDocumentsFournir(), true));
      
      // Titre encart 'bon à savoir'
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheAide.getTitreEncartBonASavoir(), true));
      
      // Bon à savoir
      chaine.append(ExportCsvUtils.getFormattedCsvValueWysiwyg(itFicheAide.getBonASavoir(), true));
      
      // Titre vidéo
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheAide.getTitreVideo(), true));
      
      // Vidéo
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.listNameOfContent(itFicheAide.getVideo()), true));
      
      // Portlets encadrés
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.listNameOfPortalElements(itFicheAide.getPortletEncadres()), true));

      // Instruction délégation
      chaine.append(ExportCsvUtils.getFormattedCsvValue(Boolean.toString(itFicheAide.getInstructionDelegation()), true));

      // Type de lieu
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheAide.getTypeDeLieu(), true));
      
      // Type de lieu secondaire
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheAide.getTypeDeLieuSecondaire(), true));

      // Contact service par email
      chaine.append(ExportCsvUtils.getFormattedCsvValue(Boolean.toString(itFicheAide.getContactServiceParEmail()), true));

      // Qui contacter ?
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.listNameOfContent(itFicheAide.getQuiContacter()), true));

      // Intro contact
      chaine.append(ExportCsvUtils.getFormattedCsvValueWysiwyg(itFicheAide.getIntroContact(), true));

      // Complément contact
      chaine.append(ExportCsvUtils.getFormattedCsvValueWysiwyg(itFicheAide.getComplementContact(), true));

      // Besoin d'aide ?
      chaine.append(ExportCsvUtils.getFormattedCsvValueWysiwyg(itFicheAide.getBesoinDaide(), true));

      // Faq
      chaine.append(ExportCsvUtils.getFormattedCsvValue(Util.notEmpty(itFicheAide.getFaq()) ? itFicheAide.getFaq().getTitle() : "", true));
      
      // Contact faq
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheAide.getContactFAQ(), true));

      // Instruction délégation demande
      chaine.append(ExportCsvUtils.getFormattedCsvValue(Boolean.toString(itFicheAide.getInstructionDelegationDemande()), true));

      // Type de lieu demande
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheAide.getTypeDeLieuDemande(), true));

      // Type de lieu secondaire demande
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheAide.getTypeDeLieuSecondaireDemande(), true));

      // Contact service par email demande
      chaine.append(ExportCsvUtils.getFormattedCsvValue(Boolean.toString(itFicheAide.getContactServiceParEmailDemande()), true));

      // Lieu instruction des demandes
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.listNameOfContent(itFicheAide.getLieuInstructionDemande()), true));
      
      // Documents utiles
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.listNameOfContent(itFicheAide.getDocumentsUtiles()), true));

      // E-démarche
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.formatCategories(itFicheAide.getEdemarche(itMember)), true));
          
      // Url e-démarche
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheAide.getUrlEdemarche(), true));

      // Url suivi e-démarche
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheAide.getUrlSuiviEdemarche(), true));

      // Durée e-démarches
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheAide.getDureeEdemarche(), true));

      // Intro suivre une demande
      chaine.append(ExportCsvUtils.getFormattedCsvValueWysiwyg(itFicheAide.getIntroSuivreUneDemande(), true));

      // Intro faire une demande
      chaine.append(ExportCsvUtils.getFormattedCsvValueWysiwyg(itFicheAide.getIntroFaireUneDemande(), true));

      // Catégorie de navigation
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.formatCategories(itFicheAide.getCategorieDeNavigation(itMember)), true));

      // Mise en avant
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.formatCategories(itFicheAide.getMiseEnAvant(itMember)), true));

      // Besoins
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.formatCategories(itFicheAide.getBesoins(itMember)), true));

      // Publics
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.formatCategories(itFicheAide.getPublics(itMember)), true));

      // Annuaires
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.formatCategories(itFicheAide.getAnnuaires(itMember)), true));

      // Communes concernées
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.listNameOfContent(itFicheAide.getCommunes()), true));

      // Toutes les communes du département
      chaine.append(ExportCsvUtils.getFormattedCsvValue(Boolean.toString(itFicheAide.getToutesLesCommunesDuDepartement()), true));
          
      // Délégations concernées
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.listNameOfContent(itFicheAide.getDelegations()), true));

      // EPCI concernées
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.formatCategories(itFicheAide.getEpci(itMember)), true));

      // Cantons concernés
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.listNameOfContent(itFicheAide.getCantons()), true));

      chaine.append(ExportCsvUtils.getMetadataCsvPublication(itPub, "FicheAide"));
    
      localPrintWriter.println(chaine);
    }
}
  
}