package fr.cg44.plugin.socle.policyfilter;

import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

import org.apache.log4j.Logger;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.document.StringField;

import com.jalios.jcms.Publication;
import com.jalios.util.Util;


/**
 * Indexe le code du contenu T dans les publication qui référence des communes (directement ou au travers de cantons)
 */
public class UtilEnginePolicyFilter  {

	private static final Logger LOGGER = Logger.getLogger(UtilEnginePolicyFilter.class);
		
	
	/**
	 * Récupère le champ "publication" du type de contenu pour l'indéxer si celui-ci est présent
	 * @param doc
	 * @param publication
	 */
	static public void indexField(Document doc, String fieldIndex, String fieldCodePublication, Publication publication, String field) {
		try {			
			// Récupère le champ du type de contenu pour l'indéxer si celui-ci est présent			
			if(publication.getFieldValue(field) instanceof Publication[]) {
				Publication[] tPubIndex = (Publication[]) publication.getFieldValue(field);
				indexFieldCode(doc, fieldIndex, fieldCodePublication, tPubIndex);
			}else {
				Publication tPubIndex = (Publication) publication.getFieldValue(field);
				indexFieldCode(doc, fieldIndex, fieldCodePublication, tPubIndex);
			}			
			
		} catch (NoSuchFieldException e) {
			LOGGER.trace("Le contenu n'a pas de référence à une canton à indexer", e);
		}	
	}
	
	
	/**
	 * Indexe le code du contenu sur la publication
	 * @param doc
	 * @param city
	 */
	static public void indexFieldCode(Document doc, String fieldIndex, String fieldCodePublication, Publication... tPubIndex){
		if(Util.notEmpty(tPubIndex)) {
			indexFieldCode(doc, fieldIndex, fieldCodePublication, new HashSet<Publication>(Arrays.asList(tPubIndex)));
		}
	}
	
	
	/**
	 * Indexe le code du contenu  sur la publication
	 * @param doc
	 * @param city
	 * @throws NoSuchFieldException 
	 */
	static public void indexFieldCode(Document doc, String fieldIndex, String fieldCodePublication, Set<? extends Publication> tPubIndex) {
		Set<? extends Publication> tPubIndexSet =  Util.collectionToCleanSet(tPubIndex);
		if(Util.notEmpty(tPubIndexSet)) {
			for(Publication itPub : tPubIndexSet) {
				try {
					Integer pubCode = itPub.getIntFieldValue(fieldCodePublication);
					Field tPubField = new StringField(fieldIndex, Integer.toString(pubCode), Field.Store.NO);
					doc.add(tPubField);	
				} catch (NoSuchFieldException e) {
					LOGGER.warn("Impossible d'indexer : " + itPub, e);
					e.printStackTrace();
				}									
			}
		}
	}
	
		
}