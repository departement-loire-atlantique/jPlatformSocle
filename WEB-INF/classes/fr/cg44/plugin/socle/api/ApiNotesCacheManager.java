package fr.cg44.plugin.socle.api;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Iterator;

import com.jalios.jcms.Channel;
import com.jalios.util.Util;

import fr.cg44.plugin.socle.api.facebook.FacebookApiManager;
import fr.cg44.plugin.socle.api.facebook.bean.Datum;
import fr.cg44.plugin.socle.api.facebook.bean.FacebookReviewBean;
import fr.cg44.plugin.socle.api.google.GoogleApiManager;
import fr.cg44.plugin.socle.api.google.bean.GooglePlaceBean;
import fr.cg44.plugin.socle.api.tripadvisor.TripadvisorApiManager;
import fr.cg44.plugin.socle.api.tripadvisor.bean.TripadvisorPlaceBean;

public enum ApiNotesCacheManager {
  
  INSTANCE;
  
  double googleNote;
  int googleNbReviews;
  double tripadvisorNote;
  int tripadvisorNbReviews;
  double facebookNote;
  int facebookNbReviews;

  public double getGoogleNote() {
    return googleNote;
  }

  public void setGoogleNote(double googleNote) {
    this.googleNote = googleNote;
  }

  public int getGoogleNbReviews() {
    return googleNbReviews;
  }

  public void setGoogleNbReviews(int googleNbReviews) {
    this.googleNbReviews = googleNbReviews;
  }

  public double getTripadvisorNote() {
    return tripadvisorNote;
  }

  public void setTripadvisorNote(double tripadvisorNote) {
    this.tripadvisorNote = tripadvisorNote;
  }

  public int getTripadvisorNbReviews() {
    return tripadvisorNbReviews;
  }

  public void setTripadvisorNbReviews(int tripadvisorNbReviews) {
    this.tripadvisorNbReviews = tripadvisorNbReviews;
  }

  public double getFacebookNote() {
    return facebookNote;
  }

  public void setFacebookNote(double facebookNote) {
    this.facebookNote = facebookNote;
  }

  public int getFacebookNbReviews() {
    return facebookNbReviews;
  }

  public void setFacebookNbReviews(int facebookNbReviews) {
    this.facebookNbReviews = facebookNbReviews;
  }

  public void refreshBeanData() {
    String placeIdGoogle = Channel.getChannel().getProperty("jcmsplugin.socle.api.places.google.id");
    String placeIdTripadvisor = Channel.getChannel().getProperty("jcmsplugin.socle.api.places.tripadvisor.id");
    String placeIdFacebook = Channel.getChannel().getProperty("jcmsplugin.socle.api.places.facebook.id");
    
    // Google
    GooglePlaceBean googleBean = GoogleApiManager.getGooglePlaceBeanFromId(placeIdGoogle);
    if (Util.notEmpty(googleBean) && Util.notEmpty(googleBean.getResult()) && Util.notEmpty(googleBean.getResult().getReviews()) && Util.notEmpty(googleBean.getResult().getRating())) {
      setGoogleNbReviews(googleBean.getResult().getReviews().size());
      setGoogleNote(googleBean.getResult().getRating());
    }
    
    // Tripadvisor
    TripadvisorPlaceBean tripadvisorBean = TripadvisorApiManager.getTripAdvisorPlaceBeanFromId(placeIdTripadvisor);
    if (Util.notEmpty(tripadvisorBean) && Util.notEmpty(tripadvisorBean.getRating()) && Util.notEmpty(tripadvisorBean.getNumReviews())) {
      setTripadvisorNote(Double.parseDouble(tripadvisorBean.getRating()));
      setTripadvisorNbReviews(Integer.parseInt(tripadvisorBean.getNumReviews()));
      // format note : "4.5". Format nbReviews : "1450"
    }
    
    // Facebook
    FacebookReviewBean facebookBean = FacebookApiManager.getFacebookReviewBeanFromId(placeIdFacebook);
    if (Util.notEmpty(facebookBean) && Util.notEmpty(facebookBean.getData())) {
      // La note FB n'est pas donnée par défaut -> il faut la calculer soi-même
      int totalValue = 0;
      int totalReviewsWithRating = 0;
      for (Iterator<Datum> iter = facebookBean.getData().iterator(); iter.hasNext();) {
        Datum itReview = iter.next();
        if (itReview.getHasRating()) { // un commentaire n'a pas nécessairement de note
          totalReviewsWithRating ++;
          totalValue += itReview.getRating();
        }
      }
      
      BigDecimal bigDecimal = new BigDecimal(totalValue / totalReviewsWithRating); // moyenne des notes sur le total des commentaires avec une note
      bigDecimal = bigDecimal.setScale(1, RoundingMode.HALF_UP); // on arrondi à la première décimale, au supérieur si nécessaire et pas uniquement à l'inférieur
      setFacebookNote(bigDecimal.doubleValue());
      setFacebookNbReviews(totalReviewsWithRating);
    }
    
  }
  
}