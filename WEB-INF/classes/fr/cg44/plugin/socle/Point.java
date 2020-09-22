package fr.cg44.plugin.socle;

/**
 * Point localisé dans un espace à 2 dimensions avec une notion d'ordre.
 */
public class Point {
  private float latitude;
  private float longitude;
  private int order;

  public Point(float latitude, float longitude) {
    this.latitude = latitude;
    this.longitude = longitude;
    order = 0;
  }
  
  public Point(float latitude, float longitude, int order) {
    this.latitude = latitude;
    this.longitude = longitude;
    this.order = order;
  }
  
  public Point(String latitude, String longitude) {
    this.latitude = Float.parseFloat(latitude);
    this.longitude = Float.parseFloat(longitude);
  }
  
  public Point(String latitude, String longitude, int order) {
    this.latitude = Float.parseFloat(latitude);
    this.longitude = Float.parseFloat(longitude);
    this.order = order;
  }

  public float getLatitude() {
    return latitude;
  }

  public void setLatitude(float latitude) {
    this.latitude = latitude;
  }

  public float getLongitude() {
    return longitude;
  }

  public void setLongitude(float longitude) {
    this.longitude = longitude;
  }
  
  public int getOrder() {
    return order;
  }

  public void setOrder(int order) {
    this.order = order;
  }

  @Override
  public String toString() {
    return "latitude: " + latitude + ", longitude: " + longitude +", order: "+order;
  }
}