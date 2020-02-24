package fr.cg44.plugin.socle.policyfilter;

import java.util.Set;

import org.apache.log4j.Logger;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.document.StringField;

import com.jalios.jcms.Category;
import com.jalios.jcms.Channel;
import com.jalios.jcms.Publication;
import com.jalios.jcms.policy.BasicLuceneSearchEnginePolicyFilter;
import com.jalios.util.Util;

import generated.Canton;
import generated.City;
import generated.Delegation;


/**
 * Indexe le code commune dans les publications qui référencent des communes (directement ou au travers de cantons)
 */
public class PublicationFacetedSearchCityEnginePolicyFilter extends BasicLuceneSearchEnginePolicyFilter {

	private static final Logger LOGGER = Logger.getLogger(PublicationFacetedSearchCityEnginePolicyFilter.class);
	
	public static final String CODE_CITY = "cityCode";
	public static final String INDEX_FIELD_CITY = "facet_city";
	public static final String INDEX_FIELD_ALL_CITY = "toutesLesCommunesDuDepartement";
	
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
			// Récupère le champ "delegation" du type de contenu si celui-ci est présent pour indexer les communes référencées par cette délégation
			indexCommunesDeDelegation(doc, publication);
			// Récupère le champ "delegations" du type de contenu si celui-ci est présent pour indexer les communes référencées par ces délégations
			indexCommunesDesDelegations(doc, publication);
			// Récupère le champ "EPCI" du type de contenu si celui-ci est présent pour indexer les communes référencées par ces cantons
			indexCommunesDesEPCI(doc, publication);
			// Indexation de toutes les communes
			indexAllCommunes(doc, publication);
		}else {
			// Indexation du code commune sur la commune
			indexCityCode(doc, (City) publication);
		}
			
	}
	
	
	/**
	 * Indexe le code commune à partir de la commune récupérée sur le champ "commune" de la publication.
	 * @param doc
	 * @param publication
	 */
	private void indexCommune(Document doc, Publication publication){
		UtilEnginePolicyFilter.indexField(doc, INDEX_FIELD_CITY, CODE_CITY, publication, "commune");
	}
	
	
	/**
	 * Indexe les codes commune à partir des communes récupérées sur le champ "communes" de la publication.
	 * @param doc
	 * @param publication
	 */
	private void indexCommunes(Document doc, Publication publication){
		UtilEnginePolicyFilter.indexField(doc, INDEX_FIELD_CITY, CODE_CITY, publication, "communes");
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
	 * Récupère le champ "delegation" du type de contenu si celui-ci est présent pour indexer les communes référencées par cette délégation
	 * @param doc
	 * @param publication
	 */
	private void indexCommunesDeDelegation(Document doc, Publication publication) {
		try {
			// Récupère le champ "delegation" du type de contenu si celui-ci est présent
			Delegation delegationPub = (Delegation) publication.getFieldValue("delegation");
			// Pour la delégation récupère la/les communes associées et les indexe
			indexCityCodeDelegation(doc, delegationPub);					
		} catch (NoSuchFieldException e) {
			LOGGER.trace("Le contenu n'a pas de référence à une délégation à indexer", e);
		}
	}
	
	
	/**
	 * Récupère le champ "delegations" du type de contenu si celui-ci est présent pour indexer les communes référencées par ces délégations
	 * @param doc
	 * @param publication
	 */
	private void indexCommunesDesDelegations(Document doc, Publication publication) {
		try {
			// Récupère le champ "delegation" du type de contenu si celui-ci est présent
			Delegation[] delegationPubTab = (Delegation[]) publication.getFieldValue("delegations");
			// Pour la delégation récupère la/les communes associées et les indexe
			indexCityCodeDelegation(doc, delegationPubTab);					
		} catch (NoSuchFieldException e) {
			LOGGER.trace("Le contenu n'a pas de référence à une délégation à indexer", e);
		}
	}
	
	
	/**
	 * Récupère le champ "indexer toutes les commune" du type de contenu pour l'indéxer toutes les communes si celui-ci est présent
	 * @param doc
	 * @param publication
	 */
	private void indexAllCommunes(Document doc, Publication publication) {
		try {
			// Récupère le champ "toutesLesCommunesDuDepartement" du type de contenu pour l'indéxer si celui-ci est présent
			Boolean  isAllCity = publication.getBooleanFieldValue(INDEX_FIELD_ALL_CITY);			
			// Indexe toutes les communes dans la publication
			if(isAllCity) {
				indexCityCode(doc, Channel.getChannel().getAllPublicationSet(City.class, null, true));
				// Indexe le champ boolean qui indique que le contenu est sur toutes les communes
				Field cityField = new StringField(INDEX_FIELD_ALL_CITY, "true", Field.Store.NO);
				doc.add(cityField);	
			}
		} catch (NoSuchFieldException e) {
			LOGGER.trace("Le contenu n'a pas de référence à plusieurs communes à indexer", e);
		}	
	}
	
	
	/**
	 * Récupère le champ "EPCI" du type de contenu si celui-ci est présent pour indexer les communes catégorisées dans ces catégories
	 * @param doc
	 * @param publication
	 */
	private void indexCommunesDesEPCI(Document doc, Publication publication) {
		try {
			// Récupère le champ "epci" du type de contenu pour l'indéxer si celui-ci est présent
			Set<Category> epciCatSet = publication.getCategoryFieldValue("epci", null);
			if(Util.notEmpty((epciCatSet))) {				
				for(Category itEpciCat : epciCatSet) {					
					indexCityCode(doc, itEpciCat.getPublicationSet(City.class, null));
				}
			}
		} catch (NoSuchFieldException e) {
			LOGGER.trace("Le contenu n'a pas de référence à plusieurs communes à indexer à partir des EPCI", e);
		}
	}
		
	
	/**
	 * Indexe les codes commune sur la publication à partir d'un ou plusieurs cantons
	 * @param doc
	 * @param cantons
	 */
	private void indexCityCodeCanton(Document doc, Canton... cantons){
		if (Util.isEmpty(cantons)) {
			return;
		}
		for(Canton itCanton : cantons) {
			// Récupère les communes associés aux cantons (commune qui ont un lien vers le canton)
			if(Util.notEmpty(itCanton)) {
				indexCityCode(doc, itCanton.getLinkIndexedDataSet(City.class, "canton"));
			}
		}			
	}
	
	
	/**
	 * Indexe les codes commune sur la publication à partir de la délégation
	 * @param doc
	 * @param delegations
	 */
	private void indexCityCodeDelegation(Document doc, Delegation... delegations){
		if (Util.isEmpty(delegations)) {
			return;
		}
		for(Delegation itDelegation : delegations) {
			// Récupère les communes associés aux cantons (commune qui ont un lien vers le canton)
			if(Util.notEmpty(itDelegation)) {
				indexCityCode(doc, itDelegation.getLinkIndexedDataSet(City.class, "delegation"));
			}
		}			
	}
	
	
	/**
	 * Indexe le code commune sur la publication
	 * @param doc
	 * @param communes
	 */
	private void indexCityCode(Document doc, City... communes){
		UtilEnginePolicyFilter.indexFieldCode(doc, INDEX_FIELD_CITY, CODE_CITY, communes);
	}
	
		 
	/**
	 * Indexe le code commune sur la publication
	 * @param doc
	 * @param communes
	 */
	private void indexCityCode(Document doc, Set<City> communes){
		UtilEnginePolicyFilter.indexFieldCode(doc, INDEX_FIELD_CITY, CODE_CITY, communes);
	}
	
	
}