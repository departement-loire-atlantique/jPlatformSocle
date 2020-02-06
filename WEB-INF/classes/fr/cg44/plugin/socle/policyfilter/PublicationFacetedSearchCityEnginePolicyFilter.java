package fr.cg44.plugin.socle.policyfilter;

import java.util.Set;
import java.util.TreeSet;

import org.apache.log4j.Logger;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.document.StringField;

import com.jalios.jcms.Publication;
import com.jalios.jcms.policy.BasicLuceneSearchEnginePolicyFilter;
import com.jalios.util.Util;

import generated.Canton;
import generated.City;


/**
 * Indexe le code commune dans les publication qui référence des communes (directement ou au travers de cantons)
 */
public class PublicationFacetedSearchCityEnginePolicyFilter extends BasicLuceneSearchEnginePolicyFilter {

	private static final Logger LOGGER = Logger.getLogger(PublicationFacetedSearchCityEnginePolicyFilter.class);
		
	public static final String INDEX_FIELD_CITY = "facet_city";
	
	@Override
	public void filterPublicationDocument(Document doc, Publication publication, String lang) {   				
		// Indexe dans INDEX_FIELD_CITIES les publications avec le code commune a laquelle elles sont ratachées
		if(!(publication instanceof City)) {
			// Récupère le champ "commune" du type de contenu pour l'indéxer si celui-ci est présent
			indexCommune(doc, publication);	
			// Récupère le champ "communes" du type de contenu pour indéxer les communes déclarées si celui-ci est présent
			indexCommunes(doc, publication);
			// Récupère le champ "canton" du type de contenu si celui-ci est présent pour indexer les communes référencées par ce canton
			indexCommunesDuCanton(doc, publication);
			// Récupère le champ "cantons" du type de contenu si celui-ci est présent pour indexer les communes référencées par ces cantons
			indexCommunesDesCantons(doc, publication);
		}		
	}
	
	
	/**
	 * Récupère le champ "commune" du type de contenu pour l'indéxer si celui-ci est présent
	 * @param doc
	 * @param publication
	 */
	private void indexCommune(Document doc, Publication publication) {
		try {			
			// Récupère le champ "commune" du type de contenu pour l'indéxer si celui-ci est présent
			City cityPub = (City) publication.getFieldValue("commune");
			indexCityCode(doc, cityPub);			
		} catch (NoSuchFieldException e) {
			LOGGER.trace("Le contenu n'a pas de référence à une commune à indexer", e);
		}	
	}
	
	
	/**
	 * Récupère le champ "communes" du type de contenu pour l'indéxer si celui-ci est présent
	 * @param doc
	 * @param publication
	 */
	private void indexCommunes(Document doc, Publication publication) {
		try {
			// Récupère le champ "communes" du type de contenu pour l'indéxer si celui-ci est présent
			City[] cityPubTab = (City[]) publication.getFieldValue("communes");
			indexCityCode(doc, cityPubTab);
		} catch (NoSuchFieldException e) {
			LOGGER.trace("Le contenu n'a pas de référence à plusieurs communes à indexer", e);
		}	
	}
	
	
	/**
	 * Récupère le champ "canton" du type de contenu si celui-ci est présent pour indexer les communes référencées par ce canton
	 * @param doc
	 * @param publication
	 */
	private void indexCommunesDuCanton(Document doc, Publication publication) {
		try {
			// Récupère le champ "canton" du type de contenu si celui-ci est présent
			Canton cantonPub = (Canton) publication.getFieldValue("canton");
			// Pour le canton récupère la/les communes associées et les indexe
			indexCityCodeCanton(doc, cantonPub);					
		} catch (NoSuchFieldException e) {
			LOGGER.trace("Le contenu n'a pas de référence à un canton à indexer", e);
		}
	}
	
		
	/**
	 * Récupère le champ "cantons" du type de contenu si celui-ci est présent pour indexer les communes référencées par ces cantons
	 * @param doc
	 * @param publication
	 */
	private void indexCommunesDesCantons(Document doc, Publication publication) {
		try {
			// Récupère le champ "canton" du type de contenu si celui-ci est présent
			Canton[] cantonsPubTab = (Canton[])  publication.getFieldValue("cantons");			
			// Pour chaque canton récupère la/les communes associées et les indexe
			indexCityCodeCanton(doc, cantonsPubTab);						
		} catch (NoSuchFieldException e) {
			LOGGER.trace("Le contenu n'a pas de référence à un canton à indexer", e);
		}
	}
	
	
	/**
	 * Indexe les codes commune sur la publication à partir du canton
	 * @param doc
	 * @param communes
	 */
	private void indexCityCodeCanton(Document doc, Canton... cantons){
		if (Util.isEmpty(cantons)) {
			return;
		}
		for(Canton itCanton : cantons) {
			// Récupère les communes associés aux cantons (commune qui ont un lien vers le canton)
			indexCityCode(doc, itCanton.getLinkIndexedDataSet(City.class, "canton"));
			// Récupère la commune référencée par le canton
			indexCityCode(doc, itCanton.getCity());			
		}			
	}
	
	/**
	 * Indexe le code commune sur la publication
	 * @param doc
	 * @param city
	 */
	private void indexCityCode(Document doc, City... communes){
		if(Util.notEmpty(communes)) {
			for(City itCommune : communes) {
				Integer cityCode = itCommune.getCityCode();
				Field cityField = new StringField(INDEX_FIELD_CITY, Integer.toString(cityCode), Field.Store.NO);
				doc.add(cityField);	
			}
		}
	}
	
	
	/**
	 * Indexe le code commune sur la publication
	 * @param doc
	 * @param city
	 */
	private void indexCityCode(Document doc, Set<City> communes){
		if(Util.notEmpty(communes)) {
			indexCityCode(doc, communes.toArray(new City[] {}));
		}
	}

	
}