package fr.cg44.plugin.socle.policyfilter;

import org.apache.lucene.document.Document;

import com.jalios.jcms.Publication;
import com.jalios.jcms.policy.BasicLuceneSearchEnginePolicyFilter;



/**
 * Indexe le code canton dans les publication qui référence des cantons directement
 */
public class PublicationFacetedSearchCantonEnginePolicyFilter extends BasicLuceneSearchEnginePolicyFilter {
		
	public static final String CODE_CANTON = "cantonCode";
	public static final String INDEX_FIELD_CANTON = "facet_canton";
	
	
	@Override
	public void filterPublicationDocument(Document doc, Publication publication, String lang) {				
		// Récupère le champ "canton" du type de contenu pour l'indéxer si celui-ci est présent
		indexCanton(doc, publication);			
		// Récupère le champ "cantons" du type de contenu pour indéxer les cantons déclarées si celui-ci est présent
		indexCantons(doc, publication);		
	}
	
	
	/**
	 * Indexe le code canton sur la publication
	 * @param doc
	 * @param city
	 */
	private void indexCanton(Document doc, Publication publication){
		UtilEnginePolicyFilter.indexField(doc, INDEX_FIELD_CANTON, CODE_CANTON, publication, "canton");
	}
	
	/**
	 * Indexe le code canton sur la publication
	 * @param doc
	 * @param city
	 */
	private void indexCantons(Document doc, Publication publication){
		UtilEnginePolicyFilter.indexField(doc, INDEX_FIELD_CANTON, CODE_CANTON, publication, "cantons");
	}
	
	

}