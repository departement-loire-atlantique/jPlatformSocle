package fr.cg44.plugin.socle.infolocale.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import org.apache.log4j.Logger;

import com.jalios.util.Util;

import generated.EvenementInfolocale;

public class InfolocaleUtil {
    
    private static final Logger LOGGER = Logger.getLogger(InfolocaleUtil.class);
    
    private InfolocaleUtil() {}
    
    /**
     * Trie une liste d'événements infolocale selon un ordre précis pour les carrousels en front-office
     * @param listEvents
     * @return
     */
    public static List<EvenementInfolocale> sortEvenementsCarrousel(List<EvenementInfolocale> listEvents) {
        List<EvenementInfolocale> sortedEvents = new ArrayList<EvenementInfolocale>();
        List<EvenementInfolocale> listClone = new ArrayList<EvenementInfolocale>(listEvents);
        
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
        fr.cg44.plugin.socle.infolocale.entities.Date[] eventDates = itEvent.getDates();
        if (Util.isEmpty(eventDates)) return false;
        
        // récupérer toutes les dates de fin
        List<String> datesFin = new ArrayList<String>();
        for (fr.cg44.plugin.socle.infolocale.entities.Date itDate : eventDates) {
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
        fr.cg44.plugin.socle.infolocale.entities.Date[] eventDates = itEvent.getDates();
        if (Util.isEmpty(eventDates)) return false;
        
        // récupérer toutes les dates de début
        List<String> datesFin = new ArrayList<String>();
        for (fr.cg44.plugin.socle.infolocale.entities.Date itDate : eventDates) {
            datesFin.add(itDate.getDebut());
        }
        
        return eventDateListContainsToday(datesFin);
    }

    private static boolean eventDateListContainsToday(List<String> datesString) {
        Calendar cal = Calendar.getInstance();
        
        // Utilisation de la classe Instant ajoutée dans Java 8
        Instant instantNow = cal.getTime().toInstant().truncatedTo(ChronoUnit.DAYS);
        
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        
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
    
}