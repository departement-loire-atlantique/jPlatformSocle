package fr.cg44.plugin.socle.datacontroller;

import java.util.Calendar;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;
import java.util.stream.Collector;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Restrictions;
import org.json.JSONException;
import org.json.JSONObject;

import com.jalios.jcms.BasicDataController;
import com.jalios.jcms.Category;
import com.jalios.jcms.Channel;
import com.jalios.jcms.Data;
import com.jalios.jcms.JcmsUtil;
import com.jalios.jcms.Member;
import com.jalios.jcms.db.HibernateUtil;
import com.jalios.jcms.handler.QueryHandler;
import com.jalios.jcms.plugin.PluginComponent;
import com.jalios.util.StringEncrypter.EncryptionException;
import com.jalios.util.URLUtils;
import com.jalios.util.Util;
import com.mailjet.client.errors.MailjetException;

import fr.cg44.plugin.socle.SocleUtils;
import fr.cg44.plugin.socle.mailjet.MailjetManager;
import generated.AlerteOffresDemploi;
import generated.EditFicheEmploiStageHandler;
import generated.FicheEmploiStage;
import generated.FicheEmploiStage_HANDLER;

public class FicheEmploiStageDataController extends BasicDataController implements PluginComponent {
  
  private static Logger LOGGER = Logger.getLogger(FicheEmploiStageDataController.class);

	private static Channel channel = Channel.getChannel();

	private static final Category navigationEmploiCat = channel.getCategory(channel.getProperty("$jcmsplugin.socle.emploiStage.nav.emploi"));
	private static final Category classementEmploiCat = channel.getCategory(channel.getProperty("$jcmsplugin.socle.emploiStage.typeEmploi.root"));
	
	private static final Category navigationApprentissageCat = channel.getCategory(channel.getProperty("$jcmsplugin.socle.emploiStage.nav.apprentissage"));
	private static final Category classementApprentissageCat = channel.getCategory(channel.getProperty("$jcmsplugin.socle.emploiStage.typeOffre.apprentissage"));
	
	private static final Category navigationStageCat = channel.getCategory(channel.getProperty("$jcmsplugin.socle.emploiStage.nav.stage"));
	private static final Category classementStageCat = channel.getCategory(channel.getProperty("$jcmsplugin.socle.emploiStage.typeOffre.stage"));
	
	private static final Category navigationServiceCiviqueCat = channel.getCategory(channel.getProperty("$jcmsplugin.socle.emploiStage.nav.serviceCivique"));
	private static final Category classementServiceCiviqueCat = channel.getCategory(channel.getProperty("$jcmsplugin.socle.emploiStage.typeOffre.serviceCivique"));
	
	private static final Category navigationSaisonnierCat = channel.getCategory(channel.getProperty("$jcmsplugin.socle.emploiStage.nav.saisonnier"));
	private static final Category classementSaisonnierCat = channel.getCategory(channel.getProperty("$jcmsplugin.socle.emploiStage.typeOffre.saisonnier"));


	@Override
	/* Le choix du type d'offre se fait par bouton radio relié à des catégories de classement
	 * En fonction du choix précédent on va automatiquement rajouter la catégorie de navigation correspondante.
	 * 
	 * Valorisation automatique de la date d'expiration en fonction de la date
	 * limite de réponse à une offre (lendemain à 00h02)
	 * */
	public void beforeWrite(Data data, int op, Member mbr, Map context) {
		FicheEmploiStage itFiche = (FicheEmploiStage) data;

		if(		Util.isEmpty(navigationEmploiCat) || Util.isEmpty(classementEmploiCat) || 
				Util.isEmpty(navigationApprentissageCat) || Util.isEmpty(classementApprentissageCat) ||
				Util.isEmpty(navigationStageCat) || Util.isEmpty(classementStageCat) ||
				Util.isEmpty(navigationServiceCiviqueCat) || Util.isEmpty(classementServiceCiviqueCat) ||
				Util.isEmpty(navigationSaisonnierCat) || Util.isEmpty(classementSaisonnierCat)) {
					
				return;
		}

		if(op == OP_CREATE || op == OP_UPDATE){
			// On enlève les anciennes catégories de nav avant d'ajouter la bonne
			TreeSet<Category> AllCategoriesFicheEmploi = itFiche.getCategorySet();
			AllCategoriesFicheEmploi.remove(navigationEmploiCat);
			AllCategoriesFicheEmploi.remove(navigationApprentissageCat);
			AllCategoriesFicheEmploi.remove(navigationStageCat);
			AllCategoriesFicheEmploi.remove(navigationServiceCiviqueCat);
			AllCategoriesFicheEmploi.remove(navigationSaisonnierCat);
			
			Category typeOffreCat = itFiche.getTypeDoffre(mbr).first();

			if(typeOffreCat.equals(classementEmploiCat) || typeOffreCat.hasAncestor(classementEmploiCat)){
				AllCategoriesFicheEmploi.add(navigationEmploiCat);
			}else if(typeOffreCat.equals(classementApprentissageCat) || typeOffreCat.hasAncestor(classementApprentissageCat)){
				AllCategoriesFicheEmploi.add(navigationApprentissageCat);
			}else if(typeOffreCat.equals(classementStageCat) || typeOffreCat.hasAncestor(classementStageCat)){
				AllCategoriesFicheEmploi.add(navigationStageCat);
			} else if(typeOffreCat.equals(classementServiceCiviqueCat) || typeOffreCat.hasAncestor(classementServiceCiviqueCat)){
				AllCategoriesFicheEmploi.add(navigationServiceCiviqueCat);
			} else if(typeOffreCat.equals(classementSaisonnierCat) || typeOffreCat.hasAncestor(classementSaisonnierCat)){
				AllCategoriesFicheEmploi.add(navigationSaisonnierCat);
			}

			itFiche.setCategorySet(AllCategoriesFicheEmploi);

			// si la date limite de réponse à l'offre est passée, on ne change pas la
			// date d'expiration de la publication, ceci permet de changer le status de publications
			// expirées normalement
			Calendar cal = Calendar.getInstance();
			
			if (itFiche.getDateLimiteDeDepot().after(cal.getTime())) {
				cal.setTime(itFiche.getDateLimiteDeDepot());
				cal.add(Calendar.DATE, 1);
				cal.set(Calendar.HOUR_OF_DAY,00);
				cal.set(Calendar.MINUTE,02);
				cal.set(Calendar.SECOND,0);
				cal.set(Calendar.MILLISECOND,0);
				itFiche.setEdate(cal.getTime());
			}
		}
		
	
	}
	
	
	public void afterWrite(Data data, int op, Member mbr, Map context) {
	  
	  FicheEmploiStage ficheEmploi = (FicheEmploiStage) data;
	  
	  HttpServletRequest request = (HttpServletRequest) context.get("request");	  
	  Boolean isCopy = context.get(CTXT_CREATE_COPY) != null ? (Boolean) context.get(CTXT_CREATE_COPY) : false;  
	  Boolean isMajorUpdate = false;
	  if(request != null && Util.notEmpty(request.getParameter("opUpdateMajor"))) {
	    isMajorUpdate =  Boolean.parseBoolean(request.getParameter("opUpdateMajor"));
	  }
	  
	  if( ficheEmploi.isInVisibleState() && ( (op == OP_CREATE && !isCopy)  || (op == OP_UPDATE && isMajorUpdate)) ) {

	    // Envoyer un email par rapport au abonnement alerte emploi
	    EditFicheEmploiStageHandler handler = new EditFicheEmploiStageHandler();

	    // Récupère les catégories de l'offre d'emploi
	    Set<Category> delegationCatSet = ficheEmploi.getDirectiondelegation(channel.getDefaultAdmin());
	    Set<Category> typeCatSet = ficheEmploi.getTypeDoffre(channel.getDefaultAdmin());
	    Set<Category> metierCatSet = ficheEmploi.getDomainesMetiers(channel.getDefaultAdmin());
	    Set<Category> categorieCatSet = ficheEmploi.getCategorieDemploi(channel.getDefaultAdmin());	
	    Set<Category> filiereCatSet = ficheEmploi.getFiliere(channel.getDefaultAdmin());  	  

	    // Récupére mes alerte offre d'emploi correspondant a la délégation
	    Set<String> delegationCatIdSet = delegationCatSet.stream().map(Category::getId).collect(Collectors.toSet());
	    String requeteDeleg = "from generated.AlerteOffresDemploi a left join a.catIdSet c where c in ( :delegCat ) or a.touteLaLoireAtlantique = true" ;
	    Query queryDeleg = HibernateUtil.getSession().createQuery(requeteDeleg);
	    queryDeleg.setParameterList("delegCat", delegationCatIdSet);	
	    Set<AlerteOffresDemploi> listDeleg = new HashSet<AlerteOffresDemploi>();
	    listDeleg.addAll(queryDeleg.list());

	    // Type d'offre
	    listDeleg.retainAll(getAlertEmploiCat(typeCatSet, handler.getTypeDoffreRoot()));		  
	    // Domaine metier
	    listDeleg.retainAll(getAlertEmploiCat(metierCatSet, handler.getDomainesMetiersRoot())); 	  
	    // Catégorie A B C autre
	    listDeleg.retainAll(getAlertEmploiCat(categorieCatSet, handler.getCategorieDemploiRoot()));	    
	    // Filiere
	    listDeleg.retainAll(getAlertEmploiCat(filiereCatSet, handler.getFiliereRoot()));

	    Set<String> maiToSet = listDeleg.stream().filter(AlerteOffresDemploi::isInVisibleState).map(AlerteOffresDemploi::getMail).collect(Collectors.toSet());
	    int templateId = channel.getIntegerProperty("jcmsplugin.socle.alert-emploi.template.id", 3877945);
	    String desinscriptionBaseUrl = channel.getUrl() + "plugins/SoclePlugin/jsp/portal/deinscriptionAlerteOffresDemploi.jsp";

	    try {	    
	      JSONObject variables = new JSONObject()
	          .put("EMPLOI", new JSONObject()
	              .put("LIEN", channel.getUrl() + ficheEmploi.getDisplayUrl(null))
	              .put("TITRE", ficheEmploi.getTitle())
	              .put("OFFRE", getCatNiv1(ficheEmploi.getFirstTypeDoffre(null), handler.getTypeDoffreRoot()).getName() )
	              .put("ENVIRONNEMENT", ficheEmploi.getTexteentete())
	              .put("MISSION", ficheEmploi.getMissions())
	              .put("COMMUNE", ficheEmploi.getCommune().getTitle())
	              .put("DATE_LIMITE", SocleUtils.formatDate("dd/MM/yy", ficheEmploi.getDateLimiteDeDepot()))
	              );

	      MailjetManager.sendMailTemplate(maiToSet, templateId, variables, desinscriptionBaseUrl);
	    } catch (JSONException | MailjetException | EncryptionException e) {
	      LOGGER.warn("Erreur lors de l'envoi des alertes emploi", e);
	    } 
	  }

	}

	
	/**
	 * Retourne les alertes emploi catégorisé sur au moins une catégorie de filterCat ou aucune des catégorie du parent filterCat
	 * @param filterCat les catégories doivent avoir le même parent
	 * @return
	 */
	public Set<AlerteOffresDemploi> getAlertEmploiCat(Set<Category> filterCat, Category parentCat) {	  	  
	  //Retourne les id de catégories juste en dessous du parent (ex : CDD -> Emploi)
	  Set<String> filterCatIdSet = filterCat.stream().map(cat -> getCatNiv1(cat, parentCat)).map(Category::getId).collect(Collectors.toSet());
  
	  String requeteCategorie = "from generated.AlerteOffresDemploi alerte where alerte not in ( from generated.AlerteOffresDemploi a left join a.catIdSet c where c in ( :categorieRootChildCat ))";    
	  if(Util.notEmpty(filterCat)) {
	    requeteCategorie += " OR alerte in (from generated.AlerteOffresDemploi a left join a.catIdSet c where c in ( :categorieFilterCat )) " ;
	  }

	  Set<Category> categorieChildCatSet = parentCat.getChildrenSet();
	  Set<String> categorieChildCatIdSet = categorieChildCatSet.stream().map(Category::getId).collect(Collectors.toSet());

	  Query queryCategorie = HibernateUtil.getSession().createQuery(requeteCategorie);   
	  queryCategorie.setParameterList("categorieRootChildCat", categorieChildCatIdSet);  
	  if(Util.notEmpty(filterCat)) {
	    queryCategorie.setParameterList("categorieFilterCat", filterCatIdSet);  
	  }
	  Set<AlerteOffresDemploi> listAlerteEmploi = new HashSet<AlerteOffresDemploi>();
	  listAlerteEmploi.addAll(queryCategorie.list());
	  	  
	  return listAlerteEmploi;
	}
	
	
	/**
	 * Retourne la catégorie juste en dessous du parent
	 * @param currentCat
	 * @param parentCat
	 * @return
	 */
	public Category getCatNiv1(Category currentCat, Category parentCat) {	  
	  if( currentCat.getParent() == null || JcmsUtil.isSameId(currentCat.getParent(), parentCat)) {
      return currentCat;
    }
    else {
      return getCatNiv1(currentCat.getParent(), parentCat);
    } 
	}

}