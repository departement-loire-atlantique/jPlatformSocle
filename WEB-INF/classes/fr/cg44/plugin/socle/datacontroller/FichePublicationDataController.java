package fr.cg44.plugin.socle.datacontroller;

import java.util.Map;
import java.util.TreeSet;

import com.jalios.jcms.BasicDataController;
import com.jalios.jcms.Category;
import com.jalios.jcms.Channel;
import com.jalios.jcms.Data;
import com.jalios.jcms.Member;
import com.jalios.jcms.plugin.PluginComponent;
import com.jalios.util.Util;

import generated.FichePublication;

public class FichePublicationDataController extends BasicDataController implements PluginComponent {

	private static Channel channel = Channel.getChannel();

	private static final Category navigationMagazineCat = channel.getCategory(channel.getProperty("$jcmsplugin.socle.fichepublication.navigationMagazine.cat"));
	private static final Category classementMagazineCat = channel.getCategory(channel.getProperty("$jcmsplugin.socle.fichepublication.classementMagazine.cat"));
	private static final Category navigationSiooxCat = channel.getCategory(channel.getProperty("$jcmsplugin.socle.fichepublication.navigationSioox.cat"));
	private static final Category classementSiooxCat = channel.getCategory(channel.getProperty("$jcmsplugin.socle.fichepublication.classementSioox.cat"));

	@Override
	/* Le choix du type de magazine se fait par bouton radio relié à des catégories de classement
	 * En fonction du choix précédent on va automatiquement rajouter la catégorie de navigation correspondante.
	 * Ceci concerne uniquement les catégories du Magazine et de Sioox
	 * 
	 * */
	public void beforeWrite(Data data, int op, Member mbr, Map context) {
		FichePublication itFiche = (FichePublication) data;
		if(Util.isEmpty(navigationMagazineCat) || Util.isEmpty(classementMagazineCat) || Util.isEmpty(navigationSiooxCat) || Util.isEmpty(classementSiooxCat)) {
			return;
		}

		if(op == OP_CREATE || op == OP_UPDATE){
			// On enlève les anciennes catégories de nav avant d'ajouter la bonne
			TreeSet<Category> AllCategoriesFichePub = itFiche.getCategorySet();
			AllCategoriesFichePub.remove(navigationMagazineCat);
			AllCategoriesFichePub.remove(navigationSiooxCat);
			
			if(itFiche.getTypeMagazine(mbr).first().equals(classementMagazineCat)){
				AllCategoriesFichePub.add(navigationMagazineCat);
			}else if(itFiche.getTypeMagazine(mbr).first().equals(classementSiooxCat)){
				AllCategoriesFichePub.add(navigationSiooxCat);
			}
			
			itFiche.setCategorySet(AllCategoriesFichePub);
		}		
		
	}


}