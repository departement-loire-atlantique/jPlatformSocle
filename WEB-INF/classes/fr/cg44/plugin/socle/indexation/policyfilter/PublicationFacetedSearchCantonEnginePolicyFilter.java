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
 * Indexe le code canton dans les publication qui référence des cantons
 */
public class PublicationFacetedSearchCantonEnginePolicyFilter extends BasicLuceneSearchEnginePolicyFilter {

	private static final Logger LOGGER = Logger.getLogger(PublicationFacetedSearchCantonEnginePolicyFilter.class);
		
	public static final String INDEX_FIELD_CANTON = "facet_canton";
	
	@Override
	public void filterPublicationDocument(Document doc, Publication publication, String lang) {   							
		// Récupère le champ "canton" du type de contenu pour l'indexer si celui-ci est présent
		try {
			Canton cantonPub = (Canton) publication.getFieldValue("canton");
			indexCantonCode(doc, cantonPub);			
		} catch (NoSuchFieldException e) {
			LOGGER.debug("Le contenu n'a pas de référence à un canton à indexer", e);
		}				
		// Si la commune est référencée dans un canton alors indexe le code canton dans cette commune.
		if(publication instanceof City) {
			City commune = (City) publication;
			TreeSet<Canton> cantonRefSet = new TreeSet<>(commune.getLinkIndexedDataSet(Canton.class, "city"));
			if(Util.notEmpty(cantonRefSet)) {
				for(Canton itCanton : cantonRefSet) {
					indexCantonCode(doc, itCanton);
				}
			}
		}		
	}

	
	/**
	 * Indexe le code canton sur la publication
	 * @param doc
	 * @param city
	 */
	private void indexCantonCode(Document doc, Canton canton){
		if(Util.notEmpty(canton)) {
			Integer cantonCode = canton.getCantonCode();
			// TODO INDEX_FIELD_CANTON
			Field cityField = new StringField(LucenePublicationSearchEngine.ALLFIELDS_FIELD, Integer.toString(cantonCode), Field.Store.NO);
			doc.add(cityField);	
		}
	}
	
}