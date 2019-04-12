package fr.cg44.plugin.socle.indexation.policyfilter;

import java.util.TreeSet;

import org.apache.log4j.Logger;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.document.StringField;

import com.jalios.jcms.Publication;
import com.jalios.jcms.policy.BasicLuceneSearchEnginePolicyFilter;
import com.jalios.jcms.search.LucenePublicationSearchEngine;
import com.jalios.util.Util;

import generated.Canton;
import generated.City;


/**
 * Indexe le code commune dans les publication qui référence des communes (directement ou au travers de cantons)
 */
public class PublicationFacetedSearchCityEnginePolicyFilter extends BasicLuceneSearchEnginePolicyFilter {

	private static final Logger LOGGER = Logger.getLogger(PublicationFacetedSearchCityEnginePolicyFilter.class);
		
	public static final String INDEX_FIELD_CITY = "facet_city";
	public static final String INDEX_FIELD_CITIES = "facet_cities";
	
	@Override
	public void filterPublicationDocument(Document doc, Publication publication, String lang) {   			
		// Indexe les publications avec le code commune a la quelle elles sont ratachées
		if(!(publication instanceof City)) {
			// Récupère le champ "city" du type de contenu pour l'indéxer si celui-ci est présent
			indexCity(doc, publication);
			// Récupère le champ "cities" du type de contenu pour indéxer les communes déclarées si celui-ci est présent
			indexCities(doc, publication);
			// Récupère le champ "canton" du type de contenu si celui-ci est présent pour indexer les communes référencées par ce canton
			indexCantonCity(doc, publication);		
		}		
	}
	
	
	/**
	 * Récupère le champ "city" du type de contenu pour l'indéxer si celui-ci est présent
	 * @param doc
	 * @param publication
	 */
	private void indexCity(Document doc, Publication publication) {
		try {
			// Récupère le champ "city" du type de contenu pour l'indéxer si celui-ci est présent
			City cityPub = (City) publication.getFieldValue("city");
			indexCityCode(doc, cityPub);			
		} catch (NoSuchFieldException e) {
			LOGGER.debug("Le contenu n'a pas de référence à une commune à indexer", e);
		}	
	}
	
	
	/**
	 * Récupère le champ "cities" du type de contenu pour l'indéxer si celui-ci est présent
	 * @param doc
	 * @param publication
	 */
	private void indexCities(Document doc, Publication publication) {
		try {
			// Récupère le champ "cities" du type de contenu pour l'indéxer si celui-ci est présent
			City[] cityPubTab = (City[]) publication.getFieldValue("cities");
			for(City itCommune : cityPubTab) {
				indexCityCode(doc, itCommune);
			}
		} catch (NoSuchFieldException e) {
			LOGGER.debug("Le contenu n'a pas de référence à plusieurs communes à indexer", e);
		}	
	}
	
	
	/**
	 * Récupère le champ "canton" du type de contenu si celui-ci est présent pour indexer les communes référencées par ce canton
	 * @param doc
	 * @param publication
	 */
	private void indexCantonCity(Document doc, Publication publication) {
		try {
			// Récupère le champ "canton" du type de contenu si celui-ci est présent
			Canton cantonPub = (Canton) publication.getFieldValue("canton");
			// Si pas de canton de renseigné alors stop l'indexation des communes à partir du canton
			if (Util.isEmpty(cantonPub)) {
				return;
			}
			// Récupère les communes associés au canton (commune qui ont un lien vers le canton)
			TreeSet<City> citiesLinkCanton = new TreeSet<>(cantonPub.getLinkIndexedDataSet(City.class, "canton"));
			// Récupère la commune référencée par le canton
			City cityDuCanton = cantonPub.getCity();
			if(Util.notEmpty(cityDuCanton)) {
				citiesLinkCanton.add(cityDuCanton);
			}
			// Index les communes du canton
			for(City city: citiesLinkCanton) {
				indexCityCode(doc, city);
			}			
		} catch (NoSuchFieldException e) {
			LOGGER.debug("Le contenu n'a pas de référence à un canton à indexer", e);
		}
	}
	
		
	/**
	 * Indexe le code commune sur la publication
	 * @param doc
	 * @param city
	 */
	private void indexCityCode(Document doc, City city){
		if(Util.notEmpty(city)) {
			Integer cityCode = city.getCityCode();
			// TODO INDEX_FIELD_CITY
			Field cityField = new StringField(LucenePublicationSearchEngine.ALLFIELDS_FIELD, Integer.toString(cityCode), Field.Store.NO);
			doc.add(cityField);	
		}
	}
	
	
}