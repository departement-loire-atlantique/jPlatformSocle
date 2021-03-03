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
import generated.FicheLieu;

public class ExportCsvFicheLieu {
  
  private static final String SEPARATOR = ";";
  private static final char DOUBLE_QUOTE = '"';
  
  
  /**
   * Ajoute les headers CSV pour le type FicheLieu
   * @param printWriter
   */
  private static void printHeader(PrintWriter printWriter){    
    StringBuilder header = new StringBuilder();
    
    header.append(DOUBLE_QUOTE + "ID" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Titre" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "ID référentiel" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Sous-titre" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Image principale" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Image carrée" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Image mobile" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Copyright" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Légende" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Texte alternatif" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Chapo" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "ID ancien contenu" + DOUBLE_QUOTE + SEPARATOR);
    
    header.append(DOUBLE_QUOTE + "Etage / couloir / escalier" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Entrée bâtiment / immeuble" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Numéro de voie" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Libellé de voie" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Lieu-dit" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Code postal" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Commune" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Plan d'accès" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Libellé autre adresse" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Etage / couloir / escalier" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Entrée bâtiment / immeuble" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Numéro de voie" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Libellé de voie" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Lieu-dit" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Code postal" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "CS" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Cedex" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Commune" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Téléphone" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Email" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Site internet" + DOUBLE_QUOTE + SEPARATOR);
    
    header.append(DOUBLE_QUOTE + "Plus de détail (interne)" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Plus de détail (externe)" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Texte alternatif lien" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Type d'accès" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Complément type d'accès" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Pour qui ?" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Modalités d'accueil" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Horaires et accès" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Transports en commun" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Parkings" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Description" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Titre vidéo" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Intro vidéo" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Vidéo" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Autres lieux associés" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Autres lieux associés (Accueil annuaire)" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Lien de la page Facebook" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Lien de la page Instagram" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Portlet bas" + DOUBLE_QUOTE + SEPARATOR);
    
    header.append(DOUBLE_QUOTE + "Catégorie de navigation" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Mise en avant" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Service du Département" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Statut" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Type de lieu" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Besoins" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Publics" + DOUBLE_QUOTE + SEPARATOR);
    
    header.append(DOUBLE_QUOTE + "Communes concernées" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Toutes les communes du Département" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Délégations concernées" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "EPCI concernées" + DOUBLE_QUOTE + SEPARATOR);
    header.append(DOUBLE_QUOTE + "Cantons concernés" + DOUBLE_QUOTE + SEPARATOR);
    
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
    
    SortedSet<Publication> sortedPubs = ExportCsvUtils.getPublicationsOfType("FicheLieu", itMember);
    
    for (Iterator<Publication> iter = sortedPubs.iterator(); iter.hasNext();) {
      Publication itPub = iter.next();
      if (Util.isEmpty(itPub) || !(itPub instanceof FicheLieu)) {
        continue;
      }
      
      FicheLieu itFicheLieu = (FicheLieu) itPub;
      
      // Remplir les champs CSV
      StringBuilder chaine = new StringBuilder();
      
      // ID
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itPub.getId(), true));
      
      // Titre
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itPub.getTitle(userLang), true));
      
      // ID référentiel
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheLieu.getIdReferentiel(), true));
      
      // Sous-titre
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheLieu.getSoustitre(), true));
      
      // Images
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheLieu.getImagePrincipale(userLang), true));
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheLieu.getImageCarree(userLang), true));
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheLieu.getImageMobile(userLang), true));
      
      // Copyright
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheLieu.getCopyright(userLang), true));
      
      // Légende
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheLieu.getLegende(userLang), true));
      
      // Texte alternatif
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheLieu.getTexteAlternatif(userLang), true));
      
      // Chapo
      chaine.append(ExportCsvUtils.getFormattedCsvValueWysiwyg(itFicheLieu.getChapo(userLang), true));
      
      // ID ancien contenu
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheLieu.getIdAncienContenu(), true));
      
      // Etage, couloir, escalier
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheLieu.getEtageCouloirEscalier(), true));
      
      // Entrée bâtiment / immeuble
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheLieu.getEntreeBatimentImmeuble(), true));
      
      // Numéro de voie
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheLieu.getNdeVoie(), true));
      
      // Libellé de voie
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheLieu.getLibelleDeVoie(), true));
      
      // Lieu-dit
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheLieu.getLieudit(), true));
      
      // Code postal
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheLieu.getCodePostal(), true));
      
      // Commune
      chaine.append(ExportCsvUtils.getFormattedCsvValue(Util.notEmpty(itFicheLieu.getCommune()) ? itFicheLieu.getCommune().getTitle() : "", true));

      // Plan d'accès
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.listNameOfContent(itFicheLieu.getPlanDacces()), true));

      // Libellé autre adresse
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheLieu.getLibelleAutreAdresse(), true));

      // Etage / couloir / escalier 2
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheLieu.getEtageCouloirEscalier2(), true));

      // Entrée bâtiment / immeuble 2
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheLieu.getEntreeBatimentImmeuble2(), true));

      // Numéro de voie 2
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheLieu.getNdeVoie2(), true));

      // Libellé de voie 2
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheLieu.getLibelleDeVoie2(), true));

      // Lieu-dit 2
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheLieu.getLieudit2(), true));

      // Code postal 2
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheLieu.getCodePostal2(), true));

      // CS 2
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheLieu.getCs2(), true));
      
      // Cedex 2
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheLieu.getCedex2(), true));

      // Commune 2
      chaine.append(ExportCsvUtils.getFormattedCsvValue(Util.notEmpty(itFicheLieu.getCommune2()) ? itFicheLieu.getCommune2().getTitle() : "", true));

      // Téléphone
      chaine.append(ExportCsvUtils.getFormattedCsvValueStringArray(itFicheLieu.getTelephone(), true));

      // Email
      chaine.append(ExportCsvUtils.getFormattedCsvValueStringArray(itFicheLieu.getEmail(), true));

      // Site internet
      chaine.append(ExportCsvUtils.getFormattedCsvValueStringArray(itFicheLieu.getSiteInternet(), true));

      // Plus de détails (interne)
      chaine.append(ExportCsvUtils.getFormattedCsvValue(Util.notEmpty(itFicheLieu.getPlusDeDetailInterne()) ? itFicheLieu.getPlusDeDetailInterne().getTitle() : "", true));
      
      // Plus de détails (externe)
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheLieu.getPlusDeDetailExterne(), true));

      // Texte alternatif lien
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheLieu.getTexteAlternatifLien(), true));
      
      // Type d'accès
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.formatCategories(itFicheLieu.getTypeDacces(itMember)), true));

      // Complément type d'accès
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheLieu.getComplementTypeDacces(), true));

      // Pour qui
      chaine.append(ExportCsvUtils.getFormattedCsvValueWysiwyg(itFicheLieu.getPourQui(), true));

      // Modalités d'accueil
      chaine.append(ExportCsvUtils.getFormattedCsvValueWysiwyg(itFicheLieu.getModalitesDaccueil(), true));

      // Horaires et accès
      chaine.append(ExportCsvUtils.getFormattedCsvValueWysiwyg(itFicheLieu.getHorairesEtAcces(), true));

      // Transports en commun
      chaine.append(ExportCsvUtils.getFormattedCsvValueWysiwyg(itFicheLieu.getTransportsEnCommun(), true));

      // Parkings
      chaine.append(ExportCsvUtils.getFormattedCsvValueWysiwyg(itFicheLieu.getParkings(), true));

      // Description
      chaine.append(ExportCsvUtils.getFormattedCsvValueWysiwyg(itFicheLieu.getDescription(), true));

      // Titre vidéo
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheLieu.getTitreVideo(), true));

      // Intro vidéo
      chaine.append(ExportCsvUtils.getFormattedCsvValueWysiwyg(itFicheLieu.getIntroVideo(), true));

      // Vidéo
      chaine.append(ExportCsvUtils.getFormattedCsvValue(Util.notEmpty(itFicheLieu.getVideo()) ? itFicheLieu.getVideo().getTitle() : "", true));

      // Autres lieux associés
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.listNameOfContent(itFicheLieu.getAutresLieuxAssocies()), true));
      
      // Autres lieux associés (accueil annuaire)
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.listNameOfContent(itFicheLieu.getAutresLieuxAssociesAccueilAnnuai()), true));

      // Lien page FB
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheLieu.getLienDeLaPageFacebook(), true));

      // Lien page Instagram
      chaine.append(ExportCsvUtils.getFormattedCsvValue(itFicheLieu.getLienDeLaPageInstagram(), true));

      // Portlet bas
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.listNameOfPortalElements(itFicheLieu.getPortletBas()), true));

      // Catégorie de navigation
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.formatCategories(itFicheLieu.getCategorieDeNavigation(itMember)), true));
      
      // Mise en avant
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.formatCategories(itFicheLieu.getMiseEnAvant(itMember)), true));

      // Service du département
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.formatCategories(itFicheLieu.getServiceDuDepartement(itMember)), true));

      // Statut
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.formatCategories(itFicheLieu.getStatut(itMember)), true));

      // Type de lieu
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.formatCategories(itFicheLieu.getTypeDeLieu(itMember)), true));

      // Besoins
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.formatCategories(itFicheLieu.getBesoins(itMember)), true));

      // Publics
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.formatCategories(itFicheLieu.getPublics(itMember)), true));

      // Communes concernées
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.listNameOfContent(itFicheLieu.getCommunes()), true));

      // Toutes les communes du département
      chaine.append(ExportCsvUtils.getFormattedCsvValue(Boolean.toString(itFicheLieu.getToutesLesCommunesDuDepartement()), true));
          
      // Délégations concernées
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.listNameOfContent(itFicheLieu.getDelegations()), true));
      
      // EPCI concernées
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.formatCategories(itFicheLieu.getEpci(itMember)), true));

      // Cantons concernés
      chaine.append(ExportCsvUtils.getFormattedCsvValue(SocleUtils.listNameOfContent(itFicheLieu.getCantons()), true));
      
      chaine.append(ExportCsvUtils.getMetadataCsvPublication(itPub, "FicheLieu"));
    
      localPrintWriter.println(chaine);
    }
}
  
}