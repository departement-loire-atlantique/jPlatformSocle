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
 * Indexe le code du contenu (canton, commune, etc.) dans les publications qui le référence
 */
public class UtilEnginePolicyFilter  {

	private static final Logger LOGGER = Logger.getLogger(UtilEnginePolicyFilter.class);
		
	/**
	 * Constructeur privé
	 */
	private UtilEnginePolicyFilter() {}
	
	/**
	 * Récupère le champ "field" de la "publication" indéxer le code de la/les publications retournées dans "doc" si ceux-ci sont présents
	 * @param doc
	 * @param fieldIndex
	 * @param fieldCodePublication
	 * @param publication
	 * @param field
	 */
	public static void indexField(Document doc, String fieldIndex, String fieldCodePublication, Publication publication, String field) {
		try {			
			// Récupère le champ du type de contenu pour l'indéxer si celui-ci est présent			
			if(publication.getFieldValue(field) instanceof Publication[]) {
				Publication[] pubIndex = (Publication[]) publication.getFieldValue(field);
				indexFieldCode(doc, fieldIndex, fieldCodePublication, pubIndex);
			}else if(publication.getFieldValue(field) instanceof Publication) {
				Publication pubIndex = (Publication) publication.getFieldValue(field);
				indexFieldCode(doc, fieldIndex, fieldCodePublication, pubIndex);
			}					
		} catch (NoSuchFieldException e) {
			LOGGER.trace("Le contenu : " + publication + " n'a pas de référence à " + field + " à indexer", e);
		}	
	}
	
	
	/**
	 * Indexe le champ "fieldCodePublication" de "pubIndex" sur la publication
	 * @param doc
	 * @param fieldIndex
	 * @param fieldCodePublication
	 * @param pubIndex
	 */
	public static void indexFieldCode(Document doc, String fieldIndex, String fieldCodePublication, Publication... pubIndex){
		if(Util.notEmpty(pubIndex)) {
			indexFieldCode(doc, fieldIndex, fieldCodePublication, new HashSet<Publication>(Arrays.asList(pubIndex)));
		}
	}
	
	
	/**
	 * Indexe le champ "fieldCodePublication" de "pubIndex" sur la publication
	 * @param doc
	 * @param fieldIndex
	 * @param fieldCodePublication
	 * @param pubIndex
	 */
	public static void indexFieldCode(Document doc, String fieldIndex, String fieldCodePublication, Set<? extends Publication> pubIndex) {
		Set<? extends Publication> pubIndexSet =  Util.collectionToCleanSet(pubIndex);
		if(Util.notEmpty(pubIndexSet)) {
			for(Publication itPub : pubIndexSet) {
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