package fr.cg44.plugin.socle.api.google;

import org.apache.log4j.Logger;

import java.time.DayOfWeek;
import java.time.format.TextStyle;
import java.util.Calendar;
import java.util.List;

import org.json.JSONObject;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.jalios.jcms.Channel;
import com.jalios.jcms.JcmsUtil;
import com.jalios.util.Util;

import fr.cg44.plugin.socle.ApiUtil;
import fr.cg44.plugin.socle.api.google.bean.GooglePlaceBean;
import fr.cg44.plugin.socle.api.google.bean.Period;

public class GoogleApiManager {
  
  private static final Logger LOGGER = Logger.getLogger(GoogleApiManager.class);
  
  public static JSONObject getJsonFromGooglePlace(String placeId) {
    StringBuilder urlRequest = new StringBuilder();
    urlRequest.append(Channel.getChannel().getProperty("jcmsplugin.socle.api.places.google.url"));
    urlRequest.append("?key=" + Channel.getChannel().getProperty("jcmsplugin.socle.api.places.google.key"));
    urlRequest.append("&");
    urlRequest.append("place_id=" + (Util.isEmpty(placeId) ? Channel.getChannel().getProperty("jcmsplugin.socle.api.places.google.id") : placeId));
    urlRequest.append("&language=" + Channel.getChannel().getCurrentUserLang());

    
    return ApiUtil.getJsonObjectFromApi(urlRequest.toString());
  }
  
  public static GooglePlaceBean getGooglePlaceBeanFromId(String placeId) {
    JSONObject jsonGoogleBean = getJsonFromGooglePlace(placeId);

    ObjectMapper objectMapper = new ObjectMapper();
    try {
      return objectMapper.readValue(jsonGoogleBean.toString(), GooglePlaceBean.class);
    }  catch (Exception e) {
      LOGGER.warn("Error in getJsonFromGooglePlace : " + e.getMessage());
    }
    
    return new GooglePlaceBean();
  }
  
  
  /**
   * Retourne l'état et la prochaine heure de fermeture ou d'ouverture du lieu
   * @param place
   * @return
   */
  public static String getOpening(GooglePlaceBean place) {
       
    StringBuilder horaire = new StringBuilder();
    String userLang = Channel.getChannel().getCurrentUserLang();
    
    // Récupère la donnée si le lieu est ouvert ou fermé actuellement
    boolean isOpen = place.getResult().getOpeningHours().getOpenNow();    
    if(isOpen) {
      horaire.append(JcmsUtil.glp(userLang, "jcmsplugin.socle.api.horaire.ouvert"));
    }else {
      horaire.append(JcmsUtil.glp(userLang, "jcmsplugin.socle.api.horaire.ferme"));
    }
    
    Calendar cal = Calendar.getInstance();
    int currentDay = cal.get(Calendar.DAY_OF_WEEK) - 1;
    String ouvertureHeure = "";
    String fermetureHeure = "";
    String ouvertureJour = "";
    
    // Heure et minute courantes
    String heure = cal.get(Calendar.HOUR_OF_DAY) + "";
    String minute = cal.get(Calendar.MINUTE) < 10 ?  "0" + cal.get(Calendar.MINUTE) : cal.get(Calendar.MINUTE) + "";
    int heureMinute = Integer.parseInt(heure + minute);
       
    // Détermine l'horaire d'ouverture et de fermeture pour le jour courant
    int openingDay = currentDay;
    int cpt = 1;
    while(Util.isEmpty(ouvertureHeure) && cpt < 7) {
      for(Period itPeriod : place.getResult().getOpeningHours().getPeriods()) {
        if(itPeriod.getOpen().getDay() == openingDay) {        
          String itOuvertureHeure = itPeriod.getOpen().getTime();       
          String itFermetureHeure = itPeriod.getClose().getTime();        
          // Détermine l'heure d'ouverture (doit être après l'heure courante ou un autre jour)
          if(Util.isEmpty(ouvertureHeure) && (Integer.parseInt(itOuvertureHeure) > heureMinute) || currentDay != openingDay) {
            ouvertureHeure = itOuvertureHeure;
          }        
          // Détermine l'heure de fermeture (doit être après l'heure courante ou un autre jour)
          if(Util.isEmpty(fermetureHeure) && (Integer.parseInt(itFermetureHeure) > heureMinute) || currentDay != openingDay) {
            fermetureHeure = itFermetureHeure;
          }       
          
          // Dimanche est le jour 7 et non 0 pour la méthode
          int day = openingDay != 0 ? openingDay : 7;
          ouvertureJour =  DayOfWeek.of(day).getDisplayName(TextStyle.FULL, Channel.getChannel().getCurrentUserLocale());
        }        
      }
      openingDay = openingDay < 6 ? openingDay+1 : 0;
      cpt++;
    }
    
    // horaire d'ouverture ou de fermeture à afficher
    if(!isOpen && Util.notEmpty(ouvertureJour)) {
      horaire.append(" - " + JcmsUtil.glp(userLang, "jcmsplugin.socle.api.horaire.jour.ouvert", new String[]{ouvertureJour, ouvertureHeure.substring(0, 2) + ":" + ouvertureHeure.substring(2)}));      
    } else if(Util.notEmpty(fermetureHeure)) {
      String fermetureJour = DayOfWeek.of(currentDay).getDisplayName(TextStyle.FULL, Channel.getChannel().getCurrentUserLocale());      
      horaire.append(" - " + JcmsUtil.glp(userLang, "jcmsplugin.socle.api.horaire.jour.ferme", new String[]{fermetureJour, fermetureHeure.substring(0, 2) + ":" + fermetureHeure.substring(2)}));
    }
    
    return horaire.toString();
  }
  
  
  /**
   * Retourne les horaires du lieu pour le jour courant
   * @param place
   * @return
   */
  public static String getDayOpening(GooglePlaceBean place) {
    Calendar cal = Calendar.getInstance();
    int currentDay = cal.get(Calendar.DAY_OF_WEEK) - 1;
    // Corespondance jour API google et Calendar java
    int[] day = {6,0,1,2,3,4,5};    
    List<String> openingWeekDay = place.getResult().getOpeningHours().getWeekdayText();    
    return openingWeekDay.get(day[currentDay]);
  }
  
}