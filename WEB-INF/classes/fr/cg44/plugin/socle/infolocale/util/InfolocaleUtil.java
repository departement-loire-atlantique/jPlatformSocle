package fr.cg44.plugin.socle.infolocale.util;

import java.text.DateFormatSymbols;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collection;
import java.util.Comparator;
import java.util.Date;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import org.apache.log4j.Logger;

import com.jalios.jcms.Channel;
import com.jalios.jcms.JcmsUtil;
import com.jalios.util.Util;

import fr.cg44.plugin.socle.infolocale.InfolocaleEntityUtils;
import fr.cg44.plugin.socle.infolocale.entities.DateInfolocale;
import fr.cg44.plugin.socle.infolocale.entities.Genre;
import fr.cg44.plugin.socle.infolocale.entities.Photo;
import fr.cg44.plugin.socle.infolocale.entities.Tarif;
import generated.EvenementInfolocale;
import generated.PortletAgendaInfolocale;

public class InfolocaleUtil {
    
    private static final Logger LOGGER = Logger.getLogger(InfolocaleUtil.class);
    
    public static final String dateInfolocalePattern = "yyyy-MM-dd";
    
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
            // En profiter pour retirer les événements vides
            if (Util.isEmpty(itEvent.getId())) {
                iter.remove();
            }
            else if (eventEndsToday(itEvent)) {
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
        
        // Ajouter le reste de la liste, à re-trier faute à la duplication d'événements dans les résultats
        // ce qui va fausser l'ordre
        sortedEvents.addAll(forceOrderEventsByDateDebut(listClone));
        
        return sortedEvents;
    }

    /**
     * Trie une liste d'événement selon leur dates de début respectives
     * @param listClone
     * @return
     */
    private static Collection<? extends EvenementInfolocale> forceOrderEventsByDateDebut(List<EvenementInfolocale> eventList) {
      List<EvenementInfolocale> listClone = new ArrayList<>(eventList);
      listClone.sort(new Comparator<EvenementInfolocale>() {

        @Override
        public int compare(EvenementInfolocale o1, EvenementInfolocale o2) {
          if (Util.isEmpty(o1.getDates()) || Util.isEmpty(o2.getDates())
              || Util.isEmpty(o1.getDates()[0].getDebut()) || Util.isEmpty(o2.getDates()[0].getDebut())) {
            return 0;
          }
          
          SimpleDateFormat sdf = new SimpleDateFormat(dateInfolocalePattern);
          try {
            Date date1 = sdf.parse(o1.getDates()[0].getDebut());
            Date date2 = sdf.parse(o2.getDates()[0].getDebut());
            if (date1.after(date2)) return 1;
            if (date2.after(date1)) return -1;
          } catch (ParseException e) {
            LOGGER.warn("Exception while comparing events : " + e.getMessage());
          }
          
          return 0;
        }
        
      });
      return listClone;
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
        if (Util.isEmpty(datesString)) {
          return false;
        }
        
        SimpleDateFormat sdf = new SimpleDateFormat(dateInfolocalePattern);
        
        String dateStringToday = sdf.format(Calendar.getInstance().getTime());
        
        for (String itDateString : datesString) {
            try {
                Date itDate = sdf.parse(itDateString);
                String dateStringEvent = sdf.format(itDate);
                // Les deux dates sont au même jour, on renvoie true
                if (dateStringEvent.equals(dateStringToday)) return true;
                
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
                Instant itInstant = itJavaDate.toInstant().truncatedTo(ChronoUnit.DAYS);
                Date itJavaDateEnd = sdf.parse(itDate.getFin());
                Instant itInstantEnd = itJavaDateEnd.toInstant().truncatedTo(ChronoUnit.DAYS);
                
                // Fix sur un bug natif Java où si une date a pour valeur XX/XX/XXXX 00:00:00
                // alors l'instant généré sera à J-1
                while (Date.from(itInstant).before(itJavaDate)) {
                  itInstant = itInstant.plus(Duration.ofHours(24));
                }
                while (Date.from(itInstantEnd).before(itJavaDateEnd)) {
                  itInstantEnd = itInstantEnd.plus(Duration.ofHours(24));
                }
                
                // Date de début et de fin sont avant la date actuelle / la date la plus proche actuelle
                if (itInstant.isBefore(instantNow) && itInstantEnd.isBefore(instantNow)) {
                  continue;
                }
                
                // La date actuelle est après la date testée : on remplace la date actuelle par la nouvelle
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
                // Cas spécifiques pour certains mois
                // Janvier
                if (cal.get(Calendar.MONTH) == 0) {
                  returnedValue = returnedValue.substring(0, 4) + ".";
                }
                // Juillet
                else if (cal.get(Calendar.MONTH) == 6) {
                  returnedValue = returnedValue.substring(0, 4) + ".";
                }
                // septembre
                else if (cal.get(Calendar.MONTH) == 8) {
                  returnedValue = returnedValue.substring(0, 4) + ".";
                }
                // N'est aucun des mois suivants : Mars, Mai, Juin, Août
                else if (cal.get(Calendar.MONTH) != 2 && cal.get(Calendar.MONTH) != 4 && cal.get(Calendar.MONTH) != 5 && cal.get(Calendar.MONTH) != 7) {
                  returnedValue = returnedValue.substring(0, 3) + ".";
                }
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
        return JcmsUtil.glp(Channel.getChannel().getCurrentUserLang() ,"jcmsplugin.socle.infolocale.label.carrousel.tuile.date",
            getDayOfMonthLabel(dateEvent.getDebut()), getMonthLabel(dateEvent.getDebut() ,false), getYearLabel(dateEvent.getDebut()));
      } else {
        return JcmsUtil.glp(Channel.getChannel().getCurrentUserLang(), "jcmsplugin.socle.infolocale.label.carrousel.tuile.periode",
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
      int counter = 0;
      for (DateInfolocale itDate : event.getDates()) {
        EvenementInfolocale eventClone = (EvenementInfolocale) event.clone();
        eventClone.setDates(new DateInfolocale[]{itDate});
        eventClone.setIndexDate(counter);
        splittedList.add(eventClone);
        counter++;
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
     * Convertit un String de date de format défini en un String de date infolocale
     * @param dateString
     * @param format
     * @return
     */
    public static String convertStringDateToOtherFormat(String dateString, String formatOld, String formatNew) {
      SimpleDateFormat sdfNew = new SimpleDateFormat(formatNew);
      SimpleDateFormat sdfPrevious = new SimpleDateFormat(formatOld);
      try {
        Date tmpDate = sdfPrevious.parse(dateString);
        return sdfNew.format(tmpDate);
      } catch (ParseException e) {
        LOGGER.warn("Error in convertDateToInfolocaleFormat : incorrect source date " + dateString + " or incorrect format " + formatOld + " / " + formatNew + ".");
        return "";
      }
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
    
    /**
     * Renvoie une durée (en minutes) dans un format heures / minutes
     * @param duree
     * @return
     */
    public static String getLabelDuree(int duree) {
      if (Util.isEmpty(duree) || duree <= 0) return "";
      int hours = duree/60;
      int minutes = duree%60;
      if (hours > 0) {
        return Integer.toString(hours) + "h" + (minutes > 0 ? Integer.toString(minutes) : "");
      }
      if (minutes > 0) {
        return Integer.toString(minutes) + "m";
      }
      return "";
    }
    
    /**
     * Retourne un tableau de taille 2 contenant une date de début et une date de fin infolocale pour les requêtes et autres vérifications de dates
     * @param dateParam
     * @return
     */
    public static String[] getDatesDebutFinFromRequestParam(String[] dateArray) {
      if (Util.notEmpty(dateArray)) {
        String dateDebut;
        String dateFin;
         // période pré-définie
        if (dateArray.length == 1) {
          String dateValue = dateArray[0];
          if (!dateValue.contains(",")) {
            dateDebut = dateValue;
            dateFin = dateValue;
          } else {
            dateDebut = dateValue.split(",")[0];
            dateFin = dateValue.split(",")[1];
          }
        } else {
          // période manuelle
          dateDebut = dateArray[0];
          dateFin = dateArray[1];
        }
        
        return new String[]{dateDebut, dateFin};
      }
      
      return null;
    }
    
    /**
     * Supprime les événements qui ne rentrent pas dans les limites de dates indiquées, les doublons, et événements annulés
     * @param eventList
     * @param arrayDebutFin
     * @return
     */
    public static List<EvenementInfolocale> purgeEventListFromDuplicates(List<EvenementInfolocale> eventList, String[] arrayDebutFin) {
      return purgeEventListFromDuplicates(eventList, arrayDebutFin, true);
    }
    
    /**
     * Supprime les événements qui ne rentrent pas dans les limites de dates indiquées et potentiellement les doublons, également ceux annulés
     * S'il n'y a pas de limite de date, celle-ci est initialisée de J à J+2 ans
     * S'il n'y a pas de limite, et que l'option de duplication est à "FALSE", aucun tri ne sera au final fait
     * @param source
     * @return
     */
    public static List<EvenementInfolocale> purgeEventListFromDuplicates(List<EvenementInfolocale> eventList, String[] arrayDebutFin, boolean deleteDuplicates) {
      if (Util.isEmpty(eventList)) {
        return new ArrayList<EvenementInfolocale>();
      }
      
      List<String> usedIds = new ArrayList<>();
      
      // Initialiser les dates début / fin à des valeurs par défaut au besoin
      if (Util.isEmpty(arrayDebutFin)) {
        Calendar calFuture = Calendar.getInstance();
        calFuture.add(Calendar.YEAR, 2);
        SimpleDateFormat sdf = new SimpleDateFormat(dateInfolocalePattern);
        
        arrayDebutFin = new String[] {sdf.format(Calendar.getInstance().getTime()), sdf.format(calFuture.getTime())};
        
      }
      
      // Possibilité d'une double date, par ex. 2020-08-12,2020-08-14
      if (arrayDebutFin[0].contains(",")) {
        arrayDebutFin = arrayDebutFin[0].split(",");
      }
      
      String dateDebut = arrayDebutFin[0];
      String dateFin = arrayDebutFin.length > 1 ? arrayDebutFin[1] : arrayDebutFin[0];
      for (Iterator<EvenementInfolocale> iter = eventList.iterator(); iter.hasNext();) {
        EvenementInfolocale itEvent = iter.next();
        // si l'événement est annulé, on ne l'ajoute simplement pas
        if (itEvent.getMentionAnnule()) {
            iter.remove();
        }
        
        // si un événement est déjà listé, ou si la date de l'événement dépasse les limites de dates, on ne le récupère pas
        if ((deleteDuplicates && usedIds.contains(itEvent.getId())) || !eventIsInDateRange(itEvent, dateDebut, dateFin)) {
          iter.remove();
        // autrement, on le récupère, et on indique qu'on a ajouté cet événement
        } else {
          usedIds.add(itEvent.getId());
        }
      }
      
      
      
      return eventList;
    }

    /**
     * Détermine si un événement est dans la portée de deux dates
     * @param itEvent
     * @param dateDebut
     * @param dateFin
     * @return
     */
    private static boolean eventIsInDateRange(EvenementInfolocale itEvent, String dateDebut, String dateFin) {
      
      if (Util.isEmpty(itEvent) || Util.isEmpty(dateDebut) || Util.isEmpty(dateFin)
          || Util.isEmpty(itEvent.getDates()) || itEvent.getDates().length == 0) {
        return false;
      }
      
      SimpleDateFormat sdf  = new SimpleDateFormat(dateInfolocalePattern);
      
      try {
        Date limitStart = sdf.parse(dateDebut);
        Date limitEnd = sdf.parse(dateFin);
        Date debutEvent = sdf.parse(itEvent.getDates()[0].getDebut());
        Date finEvent = sdf.parse(itEvent.getDates()[0].getFin());
        
        boolean beginsInLimits = (limitStart.before(debutEvent) || limitStart.equals(debutEvent)) && (limitEnd.after(debutEvent) || limitEnd.equals(debutEvent));
        boolean endsInLimits = (limitStart.before(finEvent) || limitStart.equals(finEvent)) && (limitEnd.after(finEvent) || limitEnd.equals(finEvent));
        boolean eventContainsLimit = (limitStart.after(debutEvent) || limitStart.equals(debutEvent)) && (limitEnd.before(finEvent) || limitEnd.equals(finEvent));
        
        return beginsInLimits || endsInLimits || eventContainsLimit;
        
      } catch (ParseException e) {
        LOGGER.warn("Error in convertDateToInfolocaleFormat : incorrect source date for SimpleDateFormat : " + e.getMessage());
        return false;
      }
    }

    /**
     * S'assure qu'une date entre dans les limites infolocale (entre aujourd'hui et + 2 ans)
     * Si cette date dépasse les bornes, elle sera modifiée en conséquence
     * Dépasser cette limite provoque une erreur 400 sur l'API Infolocale
     * @param dateDebut
     * @return
     */
    public static String putDateInInfolocaleLimits(String dateStr) {
      if (Util.isEmpty(dateStr)) return "";
      
      SimpleDateFormat sdfInfolocale = new SimpleDateFormat(dateInfolocalePattern);
      try {
        Date testedDate = sdfInfolocale.parse(dateStr);
        Date dateToday = Calendar.getInstance().getTime();
        Calendar calFuture = Calendar.getInstance();
        calFuture.add(Calendar.YEAR, 2);
        Date dateTwoYears = calFuture.getTime();
        
        // Si la date est inférieure à aujourd'hui, on la force à aujourd'hui
        if (testedDate.before(dateToday)) {
          return sdfInfolocale.format(dateToday);
        }
        
        // Si la date est supérieure à celle dans deux ans, on la force à cette dernière
        if (testedDate.after(dateTwoYears)) {
          return sdfInfolocale.format(dateTwoYears);
        }
      } catch (ParseException e) {
        LOGGER.warn("Error in putDateInInfolocaleLimits : incorrect source date " + dateStr + ".");
        return "";
      }
      
      // Renvoyer la valeur d'origine : aucune modification
      return dateStr;
    }
    
    /**
     * Renvoie un horaire de date infolocale dans un format propre
     * @param dateInfoloc
     * @return
     */
    public static String getHoraireDisplay(DateInfolocale dateInfoloc) {
      if (Util.isEmpty(dateInfoloc) || Util.isEmpty(dateInfoloc.getHoraire())) return "";
      
      String separatorHoraire = " - ";
      String suffixeHoraire = ", ";
      
      // séparation par les virgules
      String[] splittedHoraires = dateInfoloc.getHoraire().split(suffixeHoraire);
      StringBuilder finalHoraire = new StringBuilder();
      
      for (Iterator<String> iter = Arrays.asList(splittedHoraires).iterator(); iter.hasNext();) {
        
        String itHoraire = iter.next();
        StringBuilder horaireToAdd = new StringBuilder();
        
        if (!itHoraire.contains(separatorHoraire)) {
          
          horaireToAdd.append(itHoraire);
          
        } else {
          
          String[] splittedTimes = itHoraire.split(separatorHoraire);
          
          int counterSplit = 0;
          
          while (counterSplit < splittedTimes.length) {
            String horaire_1 = splittedTimes[counterSplit];
            counterSplit++;
            String horaire_2 = splittedTimes[counterSplit];
            
            if (horaire_1.equals(horaire_2) || Util.isEmpty(horaire_2)) {
              horaireToAdd.append(horaire_1);
            } else {
              horaireToAdd.append(JcmsUtil.glp(Channel.getChannel().getCurrentJcmsContext().getUserLang(),"jcmsplugin.socle.infolocale.label.horaire.periode", horaire_1, horaire_2));
            }
            
            counterSplit++;
            
          }
          
          if (splittedTimes.length < 2 || splittedTimes[0].equals(splittedTimes[1]) && Util.isEmpty(horaireToAdd)) horaireToAdd.append(splittedTimes[0]);
          
        }
        
        if (Util.notEmpty(horaireToAdd)) {
          finalHoraire.append(horaireToAdd.toString());
        }
        
        if (iter.hasNext() && Util.notEmpty(horaireToAdd)) {
          finalHoraire.append(suffixeHoraire);
        }
        
      }
      
      return deleteDoublonsFromString(finalHoraire.toString(), suffixeHoraire);
    }
    
    /**
     * Détermine si un horaire a déjà l'horaire qu'on souhaite ajouter
     * @param horaireToTest
     * @param currentHorairesStr
     * @return
     */
    private static boolean horaireStringAlreadyContains(String horaireToTest, String currentHorairesStr) {
      return currentHorairesStr.contains(horaireToTest);
    }
    
    /**
     * Depuis un string représentant une liste, supprime les doublons
     * ex: "14h00, 14h00, 15h00" -> "14h00, 15h00"
     * @param original
     * @param splitter
     * @return
     */
    private static String deleteDoublonsFromString(String original, String splitter) {
      String[] splittedString = original.split(splitter);
      
      StringBuilder result = new StringBuilder();
      
      for (Iterator<String> iter = Arrays.asList(splittedString).iterator(); iter.hasNext();) {
        String itSsElem = iter.next();
        
        if (result.toString().contains(itSsElem)) continue;
        
        result.append(itSsElem + splitter);
      }
      
      // obligation de retirer le dernier suffixe -> ajouter un suffixe suite à un hasNext() pourrait ajouter
      // un suffixe même si aucun élément suivant n'est unique
      // on évite de rajouter un IF dans la boucle avec cette action
      result.delete(result.lastIndexOf(splitter), result.length()+1);
      
      return result.toString().replaceAll("h00", "h");
    }
    
    /**
     * Retourne une liste de genres générée de la concaténation des champs "genres infolocale" et "catégories infolocale" d'une portlet agenda
     * Utilisée notamment pour les requêtes par défaut
     * @param box
     * @return
     */
    public static String getAllGenresFromPortletAgendaConfig(PortletAgendaInfolocale box) {
      StringBuilder allGenres = new StringBuilder();
      Set<String> setBoxGenres = new LinkedHashSet<>();
      
      if (Util.notEmpty(box.getGenresInfolocale())) {
        // Liste d'IDs de genres
        setBoxGenres.addAll(Arrays.asList(box.getGenresInfolocale().split(",")));
      }
      
      if (Util.notEmpty(box.getCategoriesInfolocale())) {
        // Liste de catégories. On doit récupérer tous les genres associés à chaque catégorie
        String fluxId = Util.notEmpty(box.getIdDeFlux()) ? box.getIdDeFlux() : Channel.getChannel().getProperty("jcmsplugin.socle.infolocale.flux.default");
        Map<String, Set<Genre>> foundGenresFromCats = InfolocaleEntityUtils.getAllGenreOfMetadata(new String[] {"tmplbl"}, new String[] {box.getCategoriesInfolocale()}, fluxId);
        // Il faut récupérer l'ID de chaque genre trouvé pour l'ajouter dans une liste à part
        if (Util.notEmpty(foundGenresFromCats)) {
         List<String> listGenresFromCats = new ArrayList<>();
         
         for (String itKey : foundGenresFromCats.keySet()) {
           foundGenresFromCats.get(itKey).forEach( (itGenre) -> listGenresFromCats.add(itGenre.getId()));
         }
         
         // Tout ajouter au set de genres. La nature du linkedhashset va empêcher les doublons
         setBoxGenres.addAll(listGenresFromCats);
        }
      }
      
      // Remplir le string builder
      for (Iterator<String> iter = setBoxGenres.iterator(); iter.hasNext();) {
        String itGenreId = iter.next();
        allGenres.append(itGenreId);
        if (iter.hasNext()) {
          allGenres.append(",");
        }
      }
      
      return allGenres.toString();
    }
    
    /**
     * Ordonne les éléments d'une liste d'objets Genres selon une liste d'IDs
     * @param listGenres
     * @param idList
     * @return
     */
    public static Set<Genre> orderSetGenresToMatchIdList(Set<Genre> listGenres, String idList) {
      if (Util.isEmpty(listGenres) || Util.isEmpty(idList)) {
        return listGenres;
      }
      
      Set<Genre> sortedList = new TreeSet<>();
      
      String[] arrayIds = idList.split(",");
      
      for (int counterId = 0; counterId < arrayIds.length; counterId++) {
        String itId = arrayIds[counterId];
        for (Iterator<Genre> iter = listGenres.iterator(); iter.hasNext();) {
          Genre itGenre = iter.next();
          if (itGenre.getId().equals(itId)) {
            sortedList.add(itGenre);
            iter.remove();
            break;
          }
        }
      }
      
      sortedList.addAll(listGenres);
      
      return sortedList;
    }
    
    /**
     * Retourne l'URL de l'image la plus grande, et dont le ratio est le plus proche de 1
     * @param itEvent
     * @return
     */
    public static String getUrlOfLargestPicture(EvenementInfolocale itEvent) {
      /**
       * Explication du principe
       * 
       * - On récupère la première photo trouvée, en conservant ses dimensions et son ratio
       * - On inspecte la photo suivante. 
       *      -> Si celle-ci a une largeur OU une hauteur moins élevées que l'image précédente, on l'ignore
       *      -> Si son ratio est plus éloignée de 1 que la précédente par une marge, on l'ignore
       *      -> Autrement, on la conserve
       */
      
      if (Util.isEmpty(itEvent) || Util.isEmpty(itEvent.getPhotos())) {
        return "";
      }
      
      String urlImg = "";
      int width = 0;
      int height = 0;
      double ratio = 0.0;
      
      double diffAllowed = 0.2; // Configuration ratio
      
      for (int counterPhotos = 0; counterPhotos < itEvent.getPhotos().length; counterPhotos++) {
        Photo itPhoto = itEvent.getPhotos()[counterPhotos];
        
        if (Util.isEmpty(itPhoto) || 
            Util.isEmpty(itPhoto.getPath()) ||
            Util.isEmpty(itPhoto.getFormat()) ||
            "inconnu".equals(itPhoto.getFormat()) ||
            Util.isEmpty(itPhoto.getWidth()) ||
            Util.isEmpty(itPhoto.getHeight()) ||
            Util.isEmpty(itPhoto.getRatio())) {
          continue;
        }
        
        // Initialisation
        if (Util.isEmpty(urlImg)) {
          urlImg = itPhoto.getPath();
          width = itPhoto.getWidth();
          height = itPhoto.getHeight();
          ratio = itPhoto.getRatio();
          continue;
        }
        
        // si les dimensions sont plus petites, on passe
        if (itPhoto.getWidth() < width || itPhoto.getHeight() < height) {
          continue;
        }
        
        // si le ratio est plus petit, avec une marge, on passe
        // ex avec 0.2 : Le ratio actuel est de 1.2 -> si le ratio de la photo dépasse 1.4 ou 0.6, on ignore
        double ratioTmpOne = ratio;
        double ratioTmpTwo = ratioTmpOne;
        boolean oneIsLarger = false;
        
        if (ratioTmpOne > 1.0) {
          ratioTmpOne += diffAllowed;
          ratioTmpTwo = 1.0 - (ratioTmpOne - 1.0);
          oneIsLarger = true;
        } else if (ratioTmpOne < 1.0) {
          ratioTmpOne -= diffAllowed;
          ratioTmpTwo = 2.0 - ratioTmpOne;
        }
        
        if (oneIsLarger && (itPhoto.getRatio() <= ratioTmpTwo || itPhoto.getRatio() >= ratioTmpTwo)) {
          continue;
        } else if (itPhoto.getRatio() >= ratioTmpTwo || itPhoto.getRatio() <= ratioTmpTwo) {
          continue;
        }
        
        urlImg = itPhoto.getPath();
        width = itPhoto.getWidth();
        height = itPhoto.getHeight();
        ratio = itPhoto.getRatio();
      }
      
      return urlImg;
    }
    
    /**
     * Retourne l'objet Photo dont les dimensions sont les plus grandes, et dont le ratio est également proche de 1 au possible
     * @param itEvent
     * @return
     */
    public static Photo getLargestPicture(EvenementInfolocale itEvent) {
      
      if (Util.isEmpty(itEvent)) {
        return null;
      }
      
      if (Util.isEmpty(itEvent.getPhotos())) {
        if (Util.notEmpty(itEvent.getGenre()) && Util.notEmpty(itEvent.getGenre().getUrlPhotoLarge())) {
          // l'événement n'a pas de photo, MAIS a une photo sur son genre
          Photo genrePhoto = new Photo();
          genrePhoto.setPath(itEvent.getGenre().getUrlPhotoLarge());
          return genrePhoto;
        } else {
          return null;
        }
      }
      
      String urlLargest = getUrlOfLargestPicture(itEvent);
      
      for (int counterPhotos = 0; counterPhotos < itEvent.getPhotos().length; counterPhotos++) {
        Photo itPhoto = itEvent.getPhotos()[counterPhotos];
        if (Util.isEmpty(itPhoto.getPath())) {
          continue;
        }
        if (itPhoto.getPath().equals(urlLargest)) {
          return itPhoto;
        }
      }
      
      return null;
    }

    /**
     * Retourne la valeur du prix d'entrée d'un événement, ou un libellé décrivant le tarif
     * @param tarif
     * @return
     */
    public static String getPriceOfTarif(Tarif tarif) {
      if (Util.isEmpty(tarif)) return "";
      
      // Cas 1 : gratuit
      
      if (tarif.isGratuit()) {
        return JcmsUtil.glp(Channel.getChannel().getCurrentJcmsContext().getUserLang(), "jcmsplugin.socle.gratuit");
      }
      
      // Cas 2 : libre
      
      if (tarif.isLibre()) {
        return JcmsUtil.glp(Channel.getChannel().getCurrentJcmsContext().getUserLang(), "jcmsplugin.socle.libre");
      }
      
      // Cas 3 : payant non précisé
      
      if (tarif.isPayantNonPrecise() || Util.isEmpty(tarif.getPayantLibelle())) {
        return JcmsUtil.glp(Channel.getChannel().getCurrentJcmsContext().getUserLang(), "jcmsplugin.socle.payant");
      }
      
      // Cas 4 : payant, avec montant
      if (tarif.isPayant()) {
        StringBuilder txtTarif = new StringBuilder();
        if (Util.notEmpty(tarif.getPayantLibelle())) {
          txtTarif.append(tarif.getPayantLibelle());
          txtTarif.append(" : ");
        }
        if (tarif.getPayantMontant().equals("0")) {
          txtTarif.append(JcmsUtil.glp(Channel.getChannel().getCurrentJcmsContext().getUserLang(), "jcmsplugin.socle.gratuit"));
          txtTarif.append(" ");
        } else {
          txtTarif.append(tarif.getPayantMontant());
          txtTarif.append(" ");
          txtTarif.append(JcmsUtil.glp(Channel.getChannel().getCurrentJcmsContext().getUserLang(), "jcmsplugin.socle.symbol.euro"));
        }
        
        return txtTarif.toString();
      }
      
      return "";
    }
    
    /**
     * Détermine si un ID d'organisme appartient à la propriété jcmsplugin.socle.infolocale.organisme.dep.id.list
     * @param idOrganisme
     * @return
     */
    public static boolean organisationIdIsInPropList(int idOrganisme) {
      if (Util.isEmpty(idOrganisme) || idOrganisme <= 0) {
        return false;
      }
      
      String idOrgaTxt = Integer.toString(idOrganisme);
      
      String[] allOrganismes = Channel.getChannel().getProperty("jcmsplugin.socle.infolocale.organisme.dep.id.list").split(",");
      
      if (Util.notEmpty(allOrganismes)) {
        for (String itIdList : allOrganismes) {
          if (itIdList.contentEquals(idOrgaTxt)) return true;
        }
      }
      
      return false;
    }
}