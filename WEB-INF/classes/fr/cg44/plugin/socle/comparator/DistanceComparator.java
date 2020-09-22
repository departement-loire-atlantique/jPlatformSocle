package fr.cg44.plugin.socle.comparator;

import java.util.Comparator;

import com.jalios.jcms.Publication;

import fr.cg44.plugin.socle.GeolocalisationUtil;
import fr.cg44.plugin.socle.Point;



public class DistanceComparator implements Comparator<Publication> {
  
  private final Publication reference;
  
  public DistanceComparator(Publication reference) {
    this.reference=reference;
  }
  
  @Override
  public int compare(Publication p1, Publication p2) {
    if(!GeolocalisationUtil.isGeolocated(reference)){
      return 0;
    }
    // si on ne peu pas géolocaliser l'un des points
    if(!GeolocalisationUtil.isGeolocated(p1)){ 
      if(!GeolocalisationUtil.isGeolocated(p2)){
        return 0;
      }
      return 1;
    }
    if(!GeolocalisationUtil.isGeolocated(p2)){
      return -1;
    }
    
    //Calcule des distances
    Point referencePoint = GeolocalisationUtil.getPoints(reference);
    Point p1Point = GeolocalisationUtil.getPoints(p1);
    Point p2Point = GeolocalisationUtil.getPoints(p2);
    
    Float latitude1Reference = referencePoint.getLatitude();
    Float longitude1Reference = referencePoint.getLongitude();
    
    Float latitude1 = p1Point.getLatitude();
    Float longitude1 = p1Point.getLongitude();
    Float latitude2 = p2Point.getLatitude();
    Float longitude2 = p2Point.getLongitude();
    
    double d1=getDistance(latitude1Reference,longitude1Reference,latitude1, longitude1);
    double d2=getDistance(latitude1Reference,longitude1Reference,latitude2, longitude2);
    if(d1>d2){
      return 1; 
    }else if(d1<d2){
        return -1;
    }else{
      return 0;
    }
  }
  
  // recalculer les distances avec la courbure de terre (si besoin autre que le tri)
  public double getDistance(Float latitude1,Float longitude1,Float latitude2,Float longitude2){
    Float dlat=latitude1 - latitude2;
    Float dlon=longitude1 - longitude2;
    return Math.sqrt((dlat*dlat)+(dlon*dlon));
  }
}
