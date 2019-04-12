package fr.cg44.plugin.socle.indexation.datacontroller;

import java.util.Map;
import java.util.TreeSet;

import com.jalios.jcms.BasicDataController;
import com.jalios.jcms.Data;
import com.jalios.jcms.DataController;
import com.jalios.jcms.JcmsUtil;
import com.jalios.jcms.Member;
import com.jalios.jcms.Publication;
import com.jalios.util.Util;

import generated.Canton;
import generated.City;

/**
 * Si une commune ou un canton est modifiés alors réindexe les contenus liés
 */
public class IndexationDataController extends BasicDataController {
			
	public void afterWrite(Data data, int op, Member mbr, Map context) {
		if(op != OP_CREATE) {
			// Si une commune ou un canton est modifié alors réindexe toutes les publications associées
			if(data instanceof City) {	
				// Réindexe les contenus liées à la commune si son code commune ou canton a été modifié
				indexPubCity(data, context);
			}else if(data instanceof Canton) {
				// Réindexe les contenus liées au canton si son code canton ou la commune a été modifié
				indexPubCanton(data, context);
			}	
		}
	}
	
		
	/**
	 * Réindexe les contenu liées à la commune si son code commune ou canton a été modifié
	 * @param data
	 * @param context
	 */
	private void indexPubCity(Data data, Map context) {
		City city = (City) data;		
		City previousCity = (City) context.get(DataController.CTXT_PREVIOUS_DATA);

		// Récupère le code commune avant et après modification
		int previousCityCode = previousCity.getCityCode();
		int cityCode = city.getCityCode();

		// Récupère le canton déclaré dans la commune avant et après modification 
		Canton previsousCityCanton = previousCity.getCanton();
		Canton cityCanton = city.getCanton();

		// Si le code commune ou le canton de la commune à été changé alors réindexe les contenus liés
		if(cityCode != previousCityCode || !JcmsUtil.isSameId(previsousCityCanton, cityCanton)) {

			// Récuprère les publications qui référencent directement la commune (champ mono)
			TreeSet<Publication> pubRefSet = new TreeSet<>(city.getLinkIndexedDataSet(Publication.class, "city"));
			
			// Récuprère les publications qui référencent directement la commune (champ multiple)
			pubRefSet.addAll(new TreeSet<>(city.getLinkIndexedDataSet(Publication.class, "cities")));
			
			// Récupère le ou les cantons associés à cette commune
			TreeSet<Canton> cantonSet = new TreeSet<>(city.getLinkIndexedDataSet(Canton.class, "city"));					
			if(Util.notEmpty(cityCanton)) {
				cantonSet.add(cityCanton);
			}

			// Récupère le canton qui était associé à cette commune si celui-ci a été changé.
			if(previsousCityCanton != null && !JcmsUtil.isSameId(previsousCityCanton, cityCanton)) {
				cantonSet.add(previsousCityCanton);
			}

			// Récupère les publications qui référencent la commune au travers d'un canton ou plusieurs cantons
			// Récupère aussi les publications qui était référencées avant que le canton ne soit changé dans la commune
			for(Canton itCanton : cantonSet) {
				TreeSet<Publication> pubRefCantonSet = new TreeSet<>(itCanton.getLinkIndexedDataSet(Publication.class, "canton"));
				pubRefSet.addAll(pubRefCantonSet);
			}

			// Réindexe les publications associées à la commune ou au canton associées à cette commune.
			for(Publication itPub : pubRefSet) {
				// Ne pas réindexer les autres communes du cantons
				if(!(itPub instanceof City)) {
					channel.getQueryManager().getPublicationSearchEngine().update(itPub);
				}
			}
		}
	}
	
	
	/**
	 * Réindexe les contenus liées au canton si son code canton ou la commune a été modifié
	 * @param data
	 * @param context
	 */
	private void indexPubCanton(Data data, Map context) {
		Canton canton = (Canton) data;		
		Canton previousCanton = (Canton) context.get(DataController.CTXT_PREVIOUS_DATA);
		
		// Récupère le code canton avant et après modification
		int previousCantonCode = previousCanton.getCantonCode();
		int cantonCode = canton.getCantonCode();
		
		// Récupère le canton déclaré dans la commune avant et après modification 
		City previsousCantonCity = previousCanton.getCity();
		City cantonCity = canton.getCity();
		
		// Si le code canton ou la commune du canton à été changé alors réindexe les contenus liés
		if(cantonCode != previousCantonCode || !JcmsUtil.isSameId(previsousCantonCity, cantonCity)) {
			
			// Récuprère les publications qui référencent directement le canton
			TreeSet<Publication> pubRefSet = new TreeSet<>(canton.getLinkIndexedDataSet(Publication.class, "canton"));
			if(Util.notEmpty(cantonCity)) {
				pubRefSet.add(cantonCity);
			}
						
			// Récupère la commune qui était associé à ce canton si celle-ci a été changée.
			if(previsousCantonCity != null && !JcmsUtil.isSameId(previsousCantonCity, cantonCity)) {
				pubRefSet.add(previsousCantonCity);
			}					
			
			// Réindexe les publications associées au canton.
			for(Publication itPub : pubRefSet) {				
				channel.getQueryManager().getPublicationSearchEngine().update(itPub);				
			}			
		}
	}


}