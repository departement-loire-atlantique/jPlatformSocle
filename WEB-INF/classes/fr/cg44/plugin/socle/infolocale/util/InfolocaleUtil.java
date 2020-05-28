package fr.cg44.plugin.socle.infolocale.util;

import java.text.DateFormatSymbols;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import org.apache.log4j.Logger;

import com.jalios.jcms.Channel;
import com.jalios.jcms.JcmsUtil;
import com.jalios.util.Util;

import fr.cg44.plugin.socle.infolocale.entities.DateInfolocale;
import generated.EvenementInfolocale;

public class InfolocaleUtil {
    
    private static final Logger LOGGER = Logger.getLogger(InfolocaleUtil.class);
    
    public static String dateInfolocalePattern = "yyyy-MM-dd";
    
    private InfolocaleUtil() {}
    
    /**
     * Trie une liste d'événements infolocale selon un ordre précis pour les carrousels en front-office
     * @param arrayEvents
     * @return
     */
    public static List<EvenementInfolocale> sortEvenementsCarrousel(EvenementInfolocale[] arrayEvents) {
        return sortEvenementsCarrousel(new ArrayList<EvenementInfolocale>(Arrays.asList(arrayEvents)));
    }
    
    /**
     * Trie une liste d'événements infolocale selon un ordre précis pour les carrousels en front-office
     * @param listEvents
     * @return
     */
    public static List<EvenementInfolocale> sortEvenementsCarrousel(List<EvenementInfolocale> listEvents) {
        List<EvenementInfolocale> sortedEvents = new ArrayList<>();
        List<EvenementInfolocale> listClone = new ArrayList<>(listEvents);
        
        // Récupérer tous les événements dont la date actuelle est égale à leur date de fin
        for (Iterator<EvenementInfolocale> iter = listClone.iterator(); iter.hasNext();) {
            EvenementInfolocale itEvent = iter.next();
            if (eventEndsToday(itEvent)) {
                sortedEvents.add(itEvent);
                iter.remove();
            }
        }
        
        // Récupérer tous les événements dont la date actuelle est égale à leur date de début
        for (Iterator<EvenementInfolocale> iter = listClone.iterator(); iter.hasNext();) {
            EvenementInfolocale itEvent = iter.next();
            if (eventStartsToday(itEvent)) {
                sortedEvents.add(itEvent);
                iter.remove();
            }
        }
        
        // Ajouter le reste de la liste normalement déjà triée
        sortedEvents.addAll(listClone);
        
        return sortedEvents;
    }

    /**
     * Détermine si un événement Infolocale commence aujourd'hui
     * @param itEvent
     * @return
     */
    public static boolean eventStartsToday(EvenementInfolocale itEvent) {
        DateInfolocale[] eventDates = itEvent.getDates();
        if (Util.isEmpty(eventDates)) return false;
        
        // récupérer toutes les dates de fin
        List<String> datesFin = new ArrayList<>();
        for (DateInfolocale itDate : eventDates) {
            datesFin.add(itDate.getFin());
        }
        
        return eventDateListContainsToday(datesFin);
    }

    /**
     * Détermine si un événement infolocale se termine aujourd'hui
     * @param itEvent
     * @return
     */
    public static boolean eventEndsToday(EvenementInfolocale itEvent) {
        DateInfolocale[] eventDates = itEvent.getDates();
        if (Util.isEmpty(eventDates)) return false;
        
        // récupérer toutes les dates de début
        List<String> datesFin = new ArrayList<>();
        for (DateInfolocale itDate : eventDates) {
            datesFin.add(itDate.getDebut());
        }
        
        return eventDateListContainsToday(datesFin);
    }

    private static boolean eventDateListContainsToday(List<String> datesString) {
        Calendar cal = Calendar.getInstance();
        
        // Utilisation de la classe Instant ajoutée dans Java 8
        Instant instantNow = cal.getTime().toInstant().truncatedTo(ChronoUnit.DAYS);
        
        SimpleDateFormat sdf = new SimpleDateFormat(dateInfolocalePattern);
        
        for (String itDateString : datesString) {
            try {
                Date itDate = sdf.parse(itDateString);
                Instant instantDate = itDate.toInstant().truncatedTo(ChronoUnit.DAYS);
                
                // Les deux dates sont au même jour, on renvoie true
                if (instantDate.equals(instantNow)) return true;
                
                // autrement, on continue normalement dans la boucle
            } catch (ParseException e) {
                LOGGER.warn("eventDateListContainsToday -> error parsing date " + itDateString + " into a usable Date item.");
            }
        }
        
        return false; // pas de date trouvée correspondant à aujourd'hui
    }
    
    /**
     * Renvoie la date infolocale la plus proche dans le futur du jour actuel en se basant sur le début de chaque date.
     * Si aucun résultat n'est trouvé, renvoie null
     * @param event
     * @return
     */
    public static DateInfolocale getClosestDate(EvenementInfolocale event) {
        
        if (Util.isEmpty(event) || Util.isEmpty(event.getDates())) return null;
        
        DateInfolocale[] allDates = event.getDates();
        
        DateInfolocale value = null;
        
        Calendar cal = Calendar.getInstance();
        Instant instantNow = cal.getTime().toInstant().truncatedTo(ChronoUnit.DAYS);
        
        SimpleDateFormat sdf = new SimpleDateFormat(dateInfolocalePattern);
        
        for (DateInfolocale itDate : allDates) {
            try {
                Date itJavaDate = sdf.parse(itDate.getDebut());
                Instant itInstant = itJavaDate.toInstant();
                
                if (instantNow.isAfter(itInstant)) {
                    if (Util.isEmpty(value)) { 
                      value = itDate; 
                    }
                    continue;
                }
                
                // pas de valeur déterminée, on vérifie si la date trouvée est égale ou supérieure à aujourd'hui
                if (Util.isEmpty(value) && (instantNow.equals(itInstant) || instantNow.isBefore(itInstant))) {
                    value = itDate;
                    continue;
                }
                
                if (value != null && Util.notEmpty(value) && Util.notEmpty(value.getDebut())) {
                  // une valeur a été déterminée : il faut que la nouvelle date soit entre la date enregistrée et la date du jour
                  Date currentFoundJavaDate = sdf.parse(value.getDebut());
                  Instant currentFoundInstant = currentFoundJavaDate.toInstant();
                  if (instantNow.equals(itInstant) || currentFoundInstant.isAfter(itInstant)) {
                      value = itDate;
                  }
                }
               
            } catch (ParseException e) {
               LOGGER.warn("Error in getClosestDate parsing date " + itDate.getDebut());
            } catch (NullPointerException e) {
              LOGGER.warn("NPE in getClosestDate : " + e.getMessage());
            }
        }
        
        return value;
    }
    
    /**
     * Détermine si une date infolocale n'indique qu'une journée unique
     * @param date
     * @return
     */
    public static boolean infolocaleDateIsSingleDay(DateInfolocale date) {
        if (Util.isEmpty(date)) return true;
        return date.getDebut().equals(date.getFin());
    }
    
    /**
     * Renvoie la valeur numérique "jour du mois" depuis un string de date infolocale
     * @param dateStr
     * @return
     */
    public static String getDayOfMonthLabel(String dateStr) {
        if (Util.isEmpty(dateStr)) return "";
        SimpleDateFormat sdf = new SimpleDateFormat(dateInfolocalePattern);
        try {
            Calendar cal = Calendar.getInstance();
            cal.setTime(sdf.parse(dateStr));
            return Integer.toString(cal.get(Calendar.DAY_OF_MONTH));
        } catch (ParseException e) {
            LOGGER.warn("Error in getDayLabel parsing date " + dateStr);
            return "";
        }
    }
    
    /**
     * Renvoie le label d'un mois à partir d'un string de date infolocale
     * @param dateStr
     * @param abbreviated
     * @return
     */
    public static String getMonthLabel(String dateStr, boolean abbreviated) {
        if (Util.isEmpty(dateStr)) return "";
        SimpleDateFormat sdf = new SimpleDateFormat(dateInfolocalePattern);
        try {
            Calendar cal = Calendar.getInstance();
            cal.setTime(sdf.parse(dateStr));
            DateFormatSymbols dfs = DateFormatSymbols.getInstance(Channel.getChannel().getCurrentUserLocale());
            String returnedValue = dfs.getMonths()[cal.get(Calendar.MONTH)];
            if (abbreviated) {
                returnedValue = returnedValue.substring(0, 3) + ".";
            }
            return returnedValue;
        } catch (ParseException e) {
            LOGGER.warn("Error in getMonthLabel parsing date " + dateStr);
            return "";
        }
    }
    
    /**
     * Renvoie la valeur numérique de l'année d'un string de date infolocale
     * @param dateStr
     * @return
     */
    public static String getYearLabel(String dateStr) {
      if (Util.isEmpty(dateStr)) return "";
      SimpleDateFormat sdf = new SimpleDateFormat(dateInfolocalePattern);
      try {
          Calendar cal = Calendar.getInstance();
          cal.setTime(sdf.parse(dateStr));
          return Integer.toString(cal.get(Calendar.YEAR));
      } catch (ParseException e) {
          LOGGER.warn("Error in getDayLabel parsing date " + dateStr);
          return "";
      }
    }
    
    /**
     * Retourne un string du format "du 8 avril 2019 au 5 septembre 2019" ou "le 8 avril 2019" selon une date d'événement
     * @param dateEvent
     * @return
     */
    public static String getFullStringFromEventDate(DateInfolocale dateEvent) {
      if (Util.isEmpty(dateEvent)) return "";
      if (infolocaleDateIsSingleDay(dateEvent)) {
        return JcmsUtil.glp("jcmsplugin.socle.infolocale.label.carrousel.tuile.date", Channel.getChannel().getCurrentUserLang(), 
            getDayOfMonthLabel(dateEvent.getDebut()), getMonthLabel(dateEvent.getDebut() ,false), getYearLabel(dateEvent.getDebut()));
      } else {
        return JcmsUtil.glp("jcmsplugin.socle.infolocale.label.carrousel.tuile.periode", Channel.getChannel().getCurrentUserLang(), 
            getDayOfMonthLabel(dateEvent.getDebut()), getMonthLabel(dateEvent.getDebut() ,false), getYearLabel(dateEvent.getDebut()),
            getDayOfMonthLabel(dateEvent.getFin()), getMonthLabel(dateEvent.getFin() ,false), getYearLabel(dateEvent.getFin()));
      }
    }
    
    /**
     * Génère une liste d'événements infolocale à partir d'un tableau original, en générant des événements supplémentaires
     * selon leur champ "Dates"
     * @param startingArray
     * @return
     */
    public static List<EvenementInfolocale> splitEventListFromDateFields(EvenementInfolocale[] startingArray) {
      return splitEventListFromDateFields(new ArrayList<EvenementInfolocale>(Arrays.asList(startingArray)));
    }
    
    /**
     * Génère une liste d'événements infolocale à partir d'une liste originale, en générant des événements supplémentaires
     * selon leur champ "Dates"
     * @param startingList
     * @return
     */
    public static List<EvenementInfolocale> splitEventListFromDateFields(List<EvenementInfolocale> startingList) {
      List<EvenementInfolocale> finalList = new ArrayList<>();
      for (Iterator<EvenementInfolocale> iter = startingList.iterator(); iter.hasNext();) {
        EvenementInfolocale itEvent = iter.next();
        if (Util.notEmpty(itEvent.getDates()) && itEvent.getDates().length > 1) {
          finalList.addAll(splitEventIntoEventListFromDates(itEvent));
        } else {
          finalList.add(itEvent);
        }
      }
      return finalList;
    }

    private static List<EvenementInfolocale> splitEventIntoEventListFromDates(EvenementInfolocale event) {
      List<EvenementInfolocale> splittedList = new ArrayList<>();
      for (DateInfolocale itDate : event.getDates()) {
        EvenementInfolocale eventClone = (EvenementInfolocale) event.clone();
        eventClone.setDates(new DateInfolocale[]{itDate});
        splittedList.add(eventClone);
      }
      return splittedList;
    }
    
    /**
     * Retourne le format de date lisible par infolocale yyyy-MM-dd
     * @param date
     * @return
     */
    public static String convertDateToInfolocaleFormat(Date date) {
      SimpleDateFormat sdfInfolocale = new SimpleDateFormat(dateInfolocalePattern);
      return sdfInfolocale.format(date);
    }
    
    /**
     * Retourne la date d'aujourd'hui dans un format lisible par infolocale yyyy-MM-dd
     * @return
     */
    public static String getDateTodayInfolocale() {
      Calendar cal = Calendar.getInstance();
      SimpleDateFormat sdfInfolocale = new SimpleDateFormat(dateInfolocalePattern);
      return sdfInfolocale.format(cal.getTime());
    }
    
    /**
     * Retourne la date de demain dans un format lisible par infolocale yyyy-MM-dd
     * @return
     */
    public static String getDateTomorrowInfolocale() {
      Calendar cal = Calendar.getInstance();
      SimpleDateFormat sdfInfolocale = new SimpleDateFormat(dateInfolocalePattern);
      cal.set(Calendar.DAY_OF_YEAR, cal.get(Calendar.DAY_OF_YEAR) + 1);
      return sdfInfolocale.format(cal.getTime());
    }
    
    /**
     * Retourne un duo date début / date fin des sept prochains jours dans un format lisible par infolocale yyyy-MM-dd
     * @return
     */
    public static String[] getDateNextSevenDaysInfolocale() {
      Calendar cal = Calendar.getInstance();
      SimpleDateFormat sdfInfolocale = new SimpleDateFormat(dateInfolocalePattern);
      String[] nextSevenDays = new String[2];
      nextSevenDays[0] = sdfInfolocale.format(cal.getTime());
      cal.set(Calendar.DAY_OF_YEAR, cal.get(Calendar.DAY_OF_YEAR) + 7);
      nextSevenDays[1] = sdfInfolocale.format(cal.getTime());
      
      return nextSevenDays;
    }
    
    /**
     * Retourne la date du weekend dans un format lisible par infolocale yyyy-MM-dd
     * Dans le cas où le jour actuel serait samedi ou dimanche, prendre ce weekend actuel
     * @return
     */
    public static String[] getDateWeekendInfolocale() {
      Calendar cal = Calendar.getInstance();
      SimpleDateFormat sdfInfolocale = new SimpleDateFormat(dateInfolocalePattern);
      
      do {
        cal.set(Calendar.DAY_OF_YEAR, cal.get(Calendar.DAY_OF_YEAR) + 1); // atteindre le prochain samedi
      } while (cal.get(Calendar.DAY_OF_WEEK) != Calendar.SATURDAY);
      
      String[] weekendDays = new String[2];
      weekendDays[0] = sdfInfolocale.format(cal.getTime());
      cal.set(Calendar.DAY_OF_YEAR, cal.get(Calendar.DAY_OF_YEAR) + 1); // dimanche
      weekendDays[1] = sdfInfolocale.format(cal.getTime());

      return weekendDays;
    }
}