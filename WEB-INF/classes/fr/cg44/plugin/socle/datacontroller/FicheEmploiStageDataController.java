package fr.cg44.plugin.socle.datacontroller;

import java.util.Calendar;
import java.util.Map;
import java.util.TreeSet;

import com.jalios.jcms.BasicDataController;
import com.jalios.jcms.Category;
import com.jalios.jcms.Channel;
import com.jalios.jcms.Data;
import com.jalios.jcms.Member;
import com.jalios.jcms.plugin.PluginComponent;
import com.jalios.util.Util;

import generated.FicheEmploiStage;

public class FicheEmploiStageDataController extends BasicDataController implements PluginComponent {

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


}