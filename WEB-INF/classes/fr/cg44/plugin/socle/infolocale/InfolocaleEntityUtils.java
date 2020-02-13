package fr.cg44.plugin.socle.infolocale;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.jalios.jcms.Channel;
import com.jalios.util.Util;

import fr.cg44.plugin.socle.infolocale.entities.Commune;
import fr.cg44.plugin.socle.infolocale.entities.Contact;
import fr.cg44.plugin.socle.infolocale.entities.Date;
import fr.cg44.plugin.socle.infolocale.entities.Genre;
import fr.cg44.plugin.socle.infolocale.entities.Langue;
import fr.cg44.plugin.socle.infolocale.entities.Lieu;
import fr.cg44.plugin.socle.infolocale.entities.Photo;
import generated.EvenementInfolocale;


/**
 * Ensemble de méthodes utilisées pour la gestion de données Infolocales
 * @author lchoquet
 *
 */
public class InfolocaleEntityUtils {
    
    /**
     * Créé un tableau d'évenements infolocale à partir de JSON
     */
    public static EvenementInfolocale[] createEvenementInfolocaleArrayFromJsonArray(JSONArray jsonArray) {
        EvenementInfolocale[] itEvents = new EvenementInfolocale[jsonArray.length()];
        for (int counter = 0; counter < jsonArray.length(); counter++) {
            try {
                itEvents[counter] = createEvenementInfolocaleFromJsonItem(jsonArray.getJSONObject(counter));
            } catch (JSONException e) {
                e.printStackTrace();
            }
        }
        return itEvents;
    }
    
    /**
     * Créé un événement infolocale depuis du JSON
     */
    public static EvenementInfolocale createEvenementInfolocaleFromJsonItem(JSONObject json) {
        if (Util.isEmpty(json)) return null;
        
        EvenementInfolocale itEvent = new EvenementInfolocale();
        
        try {
            itEvent.setId("INFOLOC-"+json.getInt("id"));
            itEvent.setEvenementId(json.getInt("id"));
            itEvent.setOrganismeId(json.getInt("organismeId"));
            itEvent.setTitre(json.getString("titre"));
            itEvent.setTitreSlug(json.getString("titreSlug"));
            itEvent.setDescription(json.getString("descriptif"));
            itEvent.setDateCreation(json.getString("dateCreation"));
            itEvent.setDateModification(json.getString("dateModification"));
            if (Util.notEmpty(json.get("lieu"))) {
                itEvent.setLieu(createLieuFromJsonItem(json.getJSONObject("lieu")));
            }
            itEvent.setTarif(json.getString("tarif"));
            if (Util.notEmpty(json.get("dates"))) {
                itEvent.setDates(createDateArrayFromJsonArray(json.getJSONArray("dates")));
            }
            itEvent.setDateString(json.getString("dateString"));
            if (Util.notEmpty(json.get("contacts"))) {
                itEvent.setContacts(createContactArrayFromJsonArray(json.getJSONArray("contacts")));
            }
            itEvent.setReservation(json.getString("reservation"));
            itEvent.setProvider(json.getString("provider"));
            if (Util.notEmpty(json.get("genre"))) {
                itEvent.setGenre(createGenreFromJsonItem(json.getJSONObject("genre")));
            }
            if (Util.notEmpty(json.get("photos"))) {
                itEvent.setPhotos(createPhotosArrayFromJsonArray(json.getJSONArray("photos")));
            }
            itEvent.setAgeMinimum(json.getInt("ageMinimum"));
            itEvent.setAgeMaximum(json.getInt("ageMaximum"));
            itEvent.setDuree(json.getInt("duree"));
            itEvent.setMentionEvenementComplet(json.getBoolean("mentionEvenementComplet"));
            itEvent.setMentionAccessibleHandicapAuditif(json.getBoolean("mentionAccessibleHandicapAuditif"));
            itEvent.setMentionAccessibleHandicapVisuel(json.getBoolean("mentionAccessibleHandicapVisuel"));
            itEvent.setMentionAccessibleHandicapMental(json.getBoolean("mentionAccessibleHandicapMental"));
            itEvent.setMentionAccessibleHandicapMoteur(json.getBoolean("mentionAccessibleHandicapMoteur"));
            if (Util.notEmpty(json.get("langues"))) {
                itEvent.setLangues(createLanguesArrayFromJsonArray(json.getJSONArray("langues")));
            }
            itEvent.setUrlAnnonce(json.getString("urlAnnonce"));
            itEvent.setUrlOrganisme(json.getString("urlOrganisme"));
        } catch (JSONException e) {
            e.printStackTrace();
            itEvent = new EvenementInfolocale();
        }
        
        return itEvent;
    }

    /**
     * Créé un tableau d'objets Langue depuis du JSON
     */
    public static Langue[] createLanguesArrayFromJsonArray(JSONArray jsonArray) {
        Langue[] itLangues = new Langue[jsonArray.length()];
        for (int counter = 0; counter < jsonArray.length(); counter++) {
            try {
                itLangues[counter] = createLangueFromJsonItem(jsonArray.getJSONObject(counter));
            } catch (JSONException e) {
                e.printStackTrace();
            }
        }
        return itLangues;
    }

    /**
     * Créé un objet Langue depuis du JSON
     */
    public static Langue createLangueFromJsonItem(JSONObject json) {
        if (Util.isEmpty(json)) return null;
        Langue langue = new Langue();
        try {
            langue.setLangueId(json.getString("langueId"));
            langue.setLangueLibelle(json.getString("langueLibelle"));
        } catch (JSONException e) {
            e.printStackTrace();
            langue = new Langue();
        }
        return langue;
    }

    /**
     * Créé un tableau d'objets Photo depuis du JSON
     */
    public static Photo[] createPhotosArrayFromJsonArray(JSONArray jsonArray) {
        Photo[] itPhotos = new Photo[jsonArray.length()];
        for (int counter = 0; counter < jsonArray.length(); counter++) {
            try {
                itPhotos[counter] = createPhotoFromJsonItem(jsonArray.getJSONObject(counter));
            } catch (JSONException e) {
                e.printStackTrace();
            }
        }
        return itPhotos;
    }

    /**
     * Créé un objet Photo depuis du JSON
     */
    public static Photo createPhotoFromJsonItem(JSONObject json) {
        if (Util.isEmpty(json)) return null;
        Photo photo = new Photo();
        try {
            photo.setPath(json.getString("path"));
            photo.setLegend(json.getString("legend"));
            photo.setCredit(json.getString("credit"));
        } catch (JSONException e) {
            e.printStackTrace();
            photo = new Photo();
        }
        return photo;
    }

    /**
     * Créé un objet Genre depuis du JSON
     */
    public static Genre createGenreFromJsonItem(JSONObject json) {
        if (Util.isEmpty(json)) return null;
        Genre genre = new Genre();
        try {
            genre.setGenreId(json.getInt("id"));
            genre.setCategorie(json.getString("categorie"));
            genre.setLibelle(json.getString("libelle"));
        } catch (JSONException e) {
            e.printStackTrace();
            genre = new Genre();
        }
        return genre;
    }

    /**
     * Créé un tableau d'objets Contact depuis du JSON
     */
    public static Contact[] createContactArrayFromJsonArray(JSONArray jsonArray) {
        Contact[] itContacts = new Contact[jsonArray.length()];
        for (int counter = 0; counter < jsonArray.length(); counter++) {
            try {
                itContacts[counter] = createContactFromJsonItem(jsonArray.getJSONObject(counter));
            } catch (JSONException e) {
                e.printStackTrace();
            }
        }
        return itContacts;
    }

    /**
     * Créé un object Contact depuis du JSON
     */
    public static Contact createContactFromJsonItem(JSONObject json) {
        if (Util.isEmpty(json)) return null;
        Contact contact = new Contact();
        try {
            contact.setType(json.getString("type"));
            contact.setTelephone1(json.getString("telephone1"));
            contact.setTelephone2(json.getString("telephone2"));
            contact.setUrl(json.getString("url"));
            contact.setEmail(json.getString("email"));
        } catch (JSONException e) {
            e.printStackTrace();
            contact = new Contact();
        }
        return contact;
    }

    /**
     * Créé un tableau d'objets Date (infolocale) depuis du JSON
     */
    public static Date[] createDateArrayFromJsonArray(JSONArray jsonArray) {
        Date[] itDates = new Date[jsonArray.length()];
        for (int counter = 0; counter < jsonArray.length(); counter++) {
            try {
                itDates[counter] = createDateFromJsonItem(jsonArray.getJSONObject(counter));
            } catch (JSONException e) {
                e.printStackTrace();
            }
        }
        return itDates;
    }

    /**
     * Créé un objet Date (infolocale) depuis du JSON
     */
    public static Date createDateFromJsonItem(JSONObject json) {
        if (Util.isEmpty(json)) return null;
        Date date = new Date();
        try {
            date.setDebut(json.getString("debut"));
            date.setFin(json.getString("fin"));
            date.setHoraire(json.getString("horaire"));
        } catch (JSONException e) {
            e.printStackTrace();
            date = new Date();
        }
        return date;
    }

    /**
     * Créé un objet Lieu depuis du JSON
     */
    public static Lieu createLieuFromJsonItem(JSONObject json) {
        if (Util.isEmpty(json)) return null;
        Lieu lieu = new Lieu();
        try {
            lieu.setNom(json.getString("nom"));
            lieu.setAdresse(json.getString("adresse"));
            lieu.setLongitude(json.getString("longitude"));
            lieu.setLatitude(json.getString("latitude"));
            if (Util.notEmpty(json.get("commune"))) {
                lieu.setCommune(createCommuneFromJsonItem(json.getJSONObject("commune")));
            }
        } catch (JSONException e) {
            e.printStackTrace();
            lieu = new Lieu();
        }
        return lieu;
    }

    /**
     * Créé un objet Commune depuis du JSON
     */
    public static Commune createCommuneFromJsonItem(JSONObject json) {
        if (Util.isEmpty(json)) return null;
        Commune commune = new Commune();
        try {
            commune.setInsee(json.getString("insee"));
            commune.setNom(json.getString("nom"));
            commune.setSlug(json.getString("slug"));
            commune.setDepartement(json.getString("departement"));
            commune.setLatitude(json.getString("latitude"));
            commune.setLongitude(json.getString("longitude"));
            commune.setCodePostal(json.getString("codePostal"));
        } catch (JSONException e) {
            e.printStackTrace();
            commune = new Commune();
        }
        return commune;
    }
    
    /**
     * Effectue un tri sur un tableau d'objets EvenementInfolocale à partir de paramètres
     */
    public static EvenementInfolocale[] sortEvenementInfolocaleArray(EvenementInfolocale[] arrayEvents, Map<String, Object> sortParameters) {
        
        if (Util.isEmpty(arrayEvents)) return new EvenementInfolocale[0];
        
        if (Util.isEmpty(sortParameters)) return arrayEvents;
        
        Integer resultatsMax;
        String exclusion;
        boolean accessibiliteMental;
        boolean accessibiliteMoteur;
        boolean accessibiliteVisuel;

        resultatsMax = Util.toInteger(sortParameters.get("resultatsMax"), Channel.getChannel().getIntegerProperty("jcmsplugin.socle.infolocale.limit", 20));
        exclusion = Util.getString(sortParameters.get("exclusion"), null);
        accessibiliteMental = Util.toBoolean(sortParameters.get("accessibiliteMental"), false);
        accessibiliteMoteur = Util.toBoolean(sortParameters.get("accessibiliteMoteur"), false);
        accessibiliteVisuel = Util.toBoolean(sortParameters.get("accessibiliteVisuel"), false);
        
        ArrayList<EvenementInfolocale> listEvents = new ArrayList<EvenementInfolocale>(Arrays.asList(arrayEvents));
        
        for (Iterator<EvenementInfolocale> iter = listEvents.iterator(); iter.hasNext();) {
            EvenementInfolocale itEvent = iter.next();
            
            // Tri sur la mention d'accessibilité : handicap mental
            if (accessibiliteMental ? !itEvent.getMentionAccessibleHandicapMental() : false) {
                iter.remove();
                continue;
            }
            // Tri sur la mention d'accessibilité : handicap moteur
            if (accessibiliteMoteur ? !itEvent.getMentionAccessibleHandicapMoteur() : false) {
                iter.remove();
                continue;
            }
            // Tri sur la mention d'accessibilité : handicap visuel
            if (accessibiliteVisuel ? !itEvent.getMentionAccessibleHandicapVisuel() : false) {
                iter.remove();
                continue;
            }
            // Tri sur l'exclusion de certains IDs d'événements
            if (Util.notEmpty(exclusion) ? exclusion.contains(Integer.toString(itEvent.getEvenementId())) : false) {
                iter.remove();
                continue;
            }
        }
        // Tronquer la liste de résultats en fonction du nombre maximum de résultats
        if (resultatsMax < listEvents.size()) {
            listEvents = new ArrayList<EvenementInfolocale>(listEvents.subList(0, resultatsMax));
        }
        
        return listEvents.toArray(new EvenementInfolocale[listEvents.size()]);
    }
    
}