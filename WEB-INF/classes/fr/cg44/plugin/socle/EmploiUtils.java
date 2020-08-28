package fr.cg44.plugin.socle;

import java.util.ArrayList;
import java.util.List;
import java.util.TreeSet;

import org.apache.log4j.Logger;

import com.jalios.jcms.Category;
import com.jalios.jcms.Channel;
import com.jalios.jcms.Member;
import com.jalios.util.Util;

import generated.City;
import generated.Delegation;
import generated.FicheEmploiStage;
import generated.PortletFaq;

public final class EmploiUtils {
	private static Channel channel = Channel.getChannel();
	
	private static final Logger LOGGER = Logger.getLogger(EmploiUtils.class);
	
	private static final String TYPE_OFFRE_CAT_PROP = "$jcmsplugin.socle.emploiStage.typeOffre.root";
	private static final String EMPLOI_CAT_PROP = "$jcmsplugin.socle.emploiStage.typeOffre.emploi";
	private static final String STAGE_CAT_PROP = "$jcmsplugin.socle.emploiStage.typeOffre.stage";
	private static final String APPRENTISSAGE_CAT_PROP = "$jcmsplugin.socle.emploiStage.typeOffre.apprentissage";
	private static final String SERVICE_CIVIQUE_CAT_PROP = "$jcmsplugin.socle.emploiStage.typeOffre.serviceCivique";

	private static final Category TYPE_OFFRE_CAT = channel.getCategory(TYPE_OFFRE_CAT_PROP);
	private static final Category EMPLOI_CAT = channel.getCategory(EMPLOI_CAT_PROP);
	private static final Category STAGE_CAT = channel.getCategory(STAGE_CAT_PROP);
	private static final Category APPRENTISSAGE_CAT = channel.getCategory(APPRENTISSAGE_CAT_PROP);
	private static final Category SERVICE_CIVIQUE_CAT = channel.getCategory(SERVICE_CIVIQUE_CAT_PROP);

	private EmploiUtils() {
		throw new IllegalStateException("Utility class");
	}
	

  /**
   * Renvoie la FicheEmploiStage correspondant à une référence d'offre
   * @param reference	La référence du poste/stage
   * @return Le contenu de type FicheEmploiStage correspondant, ou null
   */
  public static FicheEmploiStage getJobByReference(String reference) {

 		if (Util.isEmpty(reference)) {
 			return null;
 		}

 		Channel channel = Channel.getChannel();
 		TreeSet<FicheEmploiStage> jobs = channel.getPublicationSet(FicheEmploiStage.class, channel.getCurrentLoggedMember());

 		for (FicheEmploiStage job : jobs) {
 			if (job.getNumeroDePoste().equals(reference)) {
 				return job;
 			}
 		}

 		return null;
 	}
  
  /**
   * Renvoie le code postal de la Délégation associée à la commune 
   * saisie dans la FicheEmploiStage
   * @param reference Le contenu de type FicheEmploiStage
   * @return Le code postal de la Délégation correspondante
   */
  public static String getCodePostalDelegationFromJob(FicheEmploiStage job) {
    String codePostal = "?";
    
    if(Util.isEmpty(job)) return "?";

    if (Util.notEmpty(job.getCommune())) {
      City communeOffre = job.getCommune();
      if (Util.notEmpty(communeOffre.getDelegation())) {
        Delegation delegation = communeOffre.getDelegation();
        codePostal = delegation.getCodePostal();
      }
    }
    return codePostal;
  }  
  
  /**
   * Recherche le type d'offre de la fiche emploi/stage
   * @param reference Le contenu de type FicheEmploiStage
   * @return le type d'offre
   */
  public static String getTypeOffre(FicheEmploiStage job) {
    Member loggedMember = channel.getCurrentLoggedMember();
    String typeOffre = "";
    Category typeOffreCat = job.getTypeDoffre(loggedMember).first() ;
    List<Category> ancestors  = new ArrayList<Category>();
    ancestors.add(typeOffreCat);
    ancestors.addAll(typeOffreCat.getAncestorList(TYPE_OFFRE_CAT, false));
    
    if(ancestors.contains(EMPLOI_CAT)) {
      return "emploi";
    }else if(ancestors.contains(APPRENTISSAGE_CAT)) {
      return "apprentissage";
    }else if(ancestors.contains(STAGE_CAT)) {
      return "stage";
    }else if(ancestors.contains(SERVICE_CIVIQUE_CAT)) {
      return "servicecivique";
    }
    return typeOffre;

  }  
  
  /**
   * Regarde si la fiche emploi/stage est de type "Emploi"
   * @param reference Le contenu de type FicheEmploiStage
   * @return true si le contenu est de type "Emploi"
   */
  public static boolean isEmploi(FicheEmploiStage job) {
    if(getTypeOffre(job).equals("emploi")) {
      return true;
    } else {
      return false;
    }
  }   
  
  
	
}
