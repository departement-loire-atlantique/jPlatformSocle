package fr.cg44.plugin.socle.policyfilter;

import java.util.Arrays;
import java.util.HashMap;
import java.util.stream.Collectors;

import org.apache.log4j.Logger;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.LatLonPoint;

import com.jalios.jcms.Publication;
import com.jalios.jcms.policy.BasicLuceneSearchEnginePolicyFilter;
import com.jalios.jcms.search.queryparser.ParseOptions;
import com.jalios.util.Util;


/**
 * Indexe la géolocalisation des publications
 */
public class PublicationFacetedSearchGeolocEnginePolicyFilter extends BasicLuceneSearchEnginePolicyFilter {

  private static final Logger LOGGER = Logger.getLogger(PublicationFacetedSearchGeolocEnginePolicyFilter.class);

  @Override
  public void filterPublicationDocument(Document doc, Publication publication, String lang) {   						
    String className = publication.getClass().getSimpleName();
    String pubLat = publication.getExtraData("extra."+ className +".plugin.tools.geolocation.latitude");
    String PubLng = publication.getExtraData("extra."+ className +".plugin.tools.geolocation.longitude");
    if(Util.notEmpty(pubLat) && Util.notEmpty(PubLng)) {
      try { 
        LatLonPoint latLong = new LatLonPoint("localisation", Float.parseFloat(pubLat), Float.parseFloat(PubLng));
        doc.add(latLong);
      }
      catch (Exception e) { 
        LOGGER.warn("Impossible d'indéxer la localisation sur le contenu : " + publication.getId() + " de type " + publication.getClass().getSimpleName() + " latitude : " + pubLat + " longitude : " +  PubLng, e);
      } 
    }			
  }


  @Override
  public org.apache.lucene.search.Query parseQuery(String searchString, ParseOptions options, org.apache.lucene.analysis.Analyzer analyzer, org.apache.lucene.search.Query query) {
    if(searchString.contains("localisationInJCMS:1")) {
      HashMap<String, Float> map = (HashMap<String, Float>) Arrays.asList(searchString.split(",")).stream().map(s -> s.split(":")).collect(Collectors.toMap(e -> e[0], e -> Float.parseFloat(e[1])));
      query = LatLonPoint.newBoxQuery("localisation", map.get("southEastLat"), map.get("northWestLat"), map.get("northWestLng"), map.get("southEastLng"));
    }
    return query;
  }


}