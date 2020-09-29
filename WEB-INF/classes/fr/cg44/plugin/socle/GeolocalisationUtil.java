package fr.cg44.plugin.socle;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Set;

import com.jalios.jcms.Channel;
import com.jalios.jcms.Publication;
import com.jalios.util.Util;

import fr.cg44.plugin.socle.comparator.DistanceComparator;

public class GeolocalisationUtil {


  /**
   * Renvoi la publications à plus proche d'une publication de
   * référence à partir d'un itérateur de liste triée par comparateur de
   * distance.
   * 
   * @param publication
   *          Publication de référence.
   * @param itPublications
   *          Iterateur de liste triée par comparateur de proximité.
   * @return Liste des publications à proximité de la publication de référence.
   */
  public static Publication getClosenessDistancePublications(Publication publication, Set<Publication> itPublications) {
    List<Publication> listPublications = new ArrayList<Publication>(itPublications);
    if (isGeolocated(publication)) {
      DistanceComparator distanceComparator = new DistanceComparator(publication);     
      Collections.sort(listPublications, distanceComparator);
    }
    if(itPublications.size()>0){
      return listPublications.get(0);
    }
    return null ;
  }


  /**
   * Détermine si la publication passée en paramètre est géolocalisée.
   * @param publication
   *          Publication à vérifier.
   * @return True si la publication est géolocalisée, false sinon.
   */
  public static boolean isGeolocated(Publication publication){
    if(publication != null){
      String[] geolocatedTypes = Channel.getChannel().getStringArrayProperty("plugin.geoloc.geolocation.types", new String[]{});
      String className = publication.getClass().getSimpleName();
      boolean geolocatedType = false;
      for(int i=0; i<geolocatedTypes.length; i++){
        if((geolocatedTypes[i]).equals(className)){
          geolocatedType = true;
        }
      }
      return geolocatedType
          && Util.notEmpty(getPublicationLatitude(publication))
          && Util.notEmpty(getPublicationLongitude(publication));
    } else {
      return false;
    }
  }


  /**
   * Retourne le champ latitude d'une publication
   * @param publication
   *          Publication géolocalisée.
   * @return Latitude d'une publication.
   */
  public static String getPublicationLatitude(Publication publication){
    return publication.getExtraData("extra."+ publication.getClass().getSimpleName() +".plugin.tools.geolocation.latitude");
  }

  /**
   * Retourne le champ longitude d'une publication
   * @param publication
   *          Publication géolocalisée.
   * @return Longitude d'une publication.
   */
  public static String getPublicationLongitude(Publication publication){
    return publication.getExtraData("extra."+ publication.getClass().getSimpleName() + ".plugin.tools.geolocation.longitude");
  }


  /**
   * Retourne les coordonnées géographiques d'une publication.
   * @param publication
   *          Publication géolocalisée.
   * @return Tableau des points (latitude, longitude) d'une publication.
   */
  public static Point getPoints(Publication publication){
    if(isGeolocated(publication)){
      String latitudes = getPublicationLatitude(publication);
      String longitudes = getPublicationLongitude(publication);
      return new Point(latitudes, longitudes);
    }
    return null;
  }



}
