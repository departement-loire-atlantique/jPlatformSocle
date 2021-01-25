package fr.cg44.plugin.socle.api;

import com.jalios.jcms.Channel;

import fr.cg44.plugin.socle.api.google.GoogleApiManager;
import fr.cg44.plugin.socle.api.google.bean.GooglePlaceBean;
import fr.cg44.plugin.socle.api.tripadvisor.TripadvisorApiManager;
import fr.cg44.plugin.socle.api.tripadvisor.bean.TripadvisorPlaceBean;

public enum ApiNotesCacheManager {
  
  INSTANCE;
  
  GooglePlaceBean googlePlace;
  TripadvisorPlaceBean tripadvisorPlace;
  // TODO bean FB
  
  public GooglePlaceBean getGooglePlace() {
    return googlePlace;
  }
  public void setGooglePlace(GooglePlaceBean googlePlace) {
    this.googlePlace = googlePlace;
  }
  public TripadvisorPlaceBean getTripadvisorPlace() {
    return tripadvisorPlace;
  }
  public void setTripadvisorPlace(TripadvisorPlaceBean tripadvisorPlace) {
    this.tripadvisorPlace = tripadvisorPlace;
  }
  
  public void refreshBeanData() {
    String placeIdGoogle = Channel.getChannel().getProperty("jcmsplugin.socle.api.places.google.key");
    String placeIdTripadvisor = Channel.getChannel().getProperty("jcmsplugin.socle.api.places.tripadvisor.key");
    String placeIdFacebook = Channel.getChannel().getProperty("jcmsplugin.socle.api.places.facebook.key");
    setGooglePlace(GoogleApiManager.getGooglePlaceBeanFromId(placeIdGoogle));
    setTripadvisorPlace(TripadvisorApiManager.getTripAdvisorPlaceBeanFromId(placeIdTripadvisor));
    // TODO bean FB
  }
  
}