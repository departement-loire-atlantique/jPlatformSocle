package fr.cg44.plugin.socle.infolocale;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.jalios.jcms.Channel;
import com.jalios.jcms.Member;
import com.jalios.util.Util;

import fr.cg44.plugin.socle.SocleUtils;
import fr.cg44.plugin.socle.infolocale.entities.Commune;
import fr.cg44.plugin.socle.infolocale.entities.Contact;
import fr.cg44.plugin.socle.infolocale.entities.DateInfolocale;
import fr.cg44.plugin.socle.infolocale.entities.DossierPresse;
import fr.cg44.plugin.socle.infolocale.entities.Genre;
import fr.cg44.plugin.socle.infolocale.entities.Langue;
import fr.cg44.plugin.socle.infolocale.entities.Lieu;
import fr.cg44.plugin.socle.infolocale.entities.Photo;
import fr.cg44.plugin.socle.infolocale.util.InfolocaleUtil;
import generated.EvenementInfolocale;
import generated.PortletAgendaInfolocale;


/**
 * Ensemble de méthodes utilisées pour la gestion de données Infolocales
 * @author lchoquet
 *
 */
public class InfolocaleEntityUtils {
    
    private InfolocaleEntityUtils() {}
    
    private static final Logger LOGGER = Logger.getLogger(InfolocaleEntityUtils.class);
    
    private static final String listMetadataLbl = "listMetadata";
    
    /**
     * Créé un tableau d'évenements infolocale à partir de JSON
     * @param jsonArray
     * @return
     */
    public static EvenementInfolocale[] createEvenementInfolocaleArrayFromJsonArray(JSONArray jsonArray) {
      return createEvenementInfolocaleArrayFromJsonArray(jsonArray, null, null, null, null, null);
    }
    
    /**
     * Créé un tableau d'évenements infolocale à partir de JSON
     * @param jsonArray
     * @param metadata1
     * @param metadata2
     * @return
     */
    public static EvenementInfolocale[] createEvenementInfolocaleArrayFromJsonArray(JSONArray jsonArray, String metadata1, String metadata2, String metadataDefaut, List<String> idsToExclude, List<String> idGroupes) {
        List<EvenementInfolocale> arrayEvents = new ArrayList<>();
        for (int counter = 0; counter < jsonArray.length(); counter++) {
            try {
                EvenementInfolocale itEvent = createEvenementInfolocaleFromJsonItem(jsonArray.getJSONObject(counter), metadata1, metadata2, metadataDefaut, idsToExclude, idGroupes);
                if (Util.notEmpty(itEvent)) {
                  arrayEvents.add(itEvent);
                }
            } catch (JSONException e) {
                LOGGER.error("Erreur in createEvenementInfolocaleArrayFromJsonArray: " + e.getMessage());
            }
        }
        return arrayEvents.toArray(new EvenementInfolocale[arrayEvents.size()]);
    }
    
    /**
     * Créé un événement infolocale depuis du JSON
     * @param json
     * @return
     */
    public static EvenementInfolocale createEvenementInfolocaleFromJsonItem(JSONObject json) {
      return createEvenementInfolocaleFromJsonItem(json, null, null, null, null, null);
    }
    
    /**
     * Créé un événement infolocale depuis du JSON
     * @param json
     * @param metadata1
     * @param metadata2
     * @param idsToExclude 
     * @return
     */
    public static EvenementInfolocale createEvenementInfolocaleFromJsonItem(JSONObject json, String metadata1, String metadata2, String metadataDefault, List<String> idsToExclude, List<String> idGroupes) {
        if (Util.isEmpty(json)) return null;
        
        EvenementInfolocale itEvent = new EvenementInfolocale();
        
        try {
            // ID d'événement à exclure
            if (Util.notEmpty(idsToExclude) && idsToExclude.contains(Integer.toString(json.getInt("id")))) {
              return null;
            }
            // Vérification sur des IDs de groupes d'événements
            if (Util.notEmpty(idGroupes) && !json.isNull("groupes")) {
              JSONArray arrayGroups = json.getJSONArray("groupes");
              boolean hasGroup = false;
              for (int counterGroups = 0; counterGroups < arrayGroups.length(); counterGroups++) {
                if (idGroupes.contains(Integer.toString(arrayGroups.getJSONObject(counterGroups).getInt("id")))) {
                  hasGroup = true;
                  break;
                }
              }
              if (!hasGroup) {
                return null;
              }
            }
            itEvent.setId("INFOLOC-"+json.getInt("id"));
            itEvent.setEvenementId(json.getInt("id"));
            if (Util.notEmpty(json.get("organismeId")) && !(json.get("organismeId").toString().equals("null"))) {
              itEvent.setOrganismeId(json.getInt("organismeId"));
            }
            if (Util.notEmpty(json.get("organismeNom")) && !(json.get("organismeNom").toString().equals("null"))) {
              itEvent.setOrganismeNom(json.getString("organismeNom"));
            }
            itEvent.setTitre(json.getString("titre"));
            itEvent.setTitreSlug(json.getString("titreSlug"));
            itEvent.setDescription(json.getString("descriptif"));
            itEvent.setDateCreation(json.getString("dateCreation"));
            itEvent.setDateModification(json.getString("dateModification"));
            if (Util.notEmpty(json.get("lieu"))) {
                itEvent.setLieu(createLieuFromJsonItem(json.getJSONObject("lieu")));
                // Ajout de la longitude / latitute en extradata pour s'afficher sur les cartes comme les autres publications JCMS
                itEvent.setExtraData("extra.EvenementInfolocale.plugin.tools.geolocation.longitude", itEvent.getLieu().getLongitude());
                itEvent.setExtraData("extra.EvenementInfolocale.plugin.tools.geolocation.latitude", itEvent.getLieu().getLatitude());
            }
            JSONArray tarifs = json.getJSONArray("tarifs");
            if (tarifs.length() > 0) {
              JSONObject tmpTarif = tarifs.getJSONObject(0);
              itEvent.setGratuit(tmpTarif.getBoolean("gratuit"));
              itEvent.setTarifNormal(tmpTarif.getString("tarif"));
              itEvent.setTarifReduit(tmpTarif.getString("tarifReduit"));
              itEvent.setTarifAutre(tmpTarif.getString("tarifAutre"));
            }
            JSONArray billetteries = json.getJSONArray("billetteries");
            if (billetteries.length() > 0) {
              JSONObject billetterie = billetteries.getJSONObject(0);
              itEvent.setUrlBilletterie(billetterie.getString("url"));
            }
            JSONArray donneesComplementaires = json.getJSONArray("donneesComplementaires");
            if (donneesComplementaires.length() > 0) {
              JSONObject tmpDonnees = donneesComplementaires.getJSONObject(0);
              if (!tmpDonnees.isNull("titreLibre")) itEvent.setTitreLibre(tmpDonnees.getString("titreLibre"));
              if (!tmpDonnees.isNull("texteCourt")) itEvent.setTexteCourt(tmpDonnees.getString("texteCourt"));
              if (!tmpDonnees.isNull("texteLong")) itEvent.setTexteLong(tmpDonnees.getString("texteLong"));
            }
            JSONArray ressources = json.getJSONArray("ressources");
            if (ressources.length() > 0) {
              List<String> urlVideos = new ArrayList<>();
              List<DossierPresse> listDossiers = new ArrayList<>();
              for (int ressourceCounter = 0; ressourceCounter < ressources.length(); ressourceCounter++) {
                JSONObject itRessource = ressources.getJSONObject(ressourceCounter);
                switch (itRessource.getString("type")) {
                  case "video" :
                    urlVideos.add(itRessource.getString("url"));
                    break;
                  case "dossier_presse" :
                    DossierPresse itDossier = new DossierPresse();
                    itDossier.setUrl(itRessource.getString("url"));
                    itDossier.setFilename(SocleUtils.getFilenameFromUrl(itRessource.getString("url")));
                    itDossier.setFormat(SocleUtils.getFileExpensionFromUrl(itRessource.getString("url")));
                    listDossiers.add(itDossier);
                    break;
                }
              }
              itEvent.setUrlVideos(urlVideos);
              itEvent.setDossiersDePresse(listDossiers);
            }
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
            if (json.getJSONArray("categoriesAge").length() > 0) {
              JSONArray jsonAgeArray = json.getJSONArray("categoriesAge");
              String[] tmpCatAge = new String[jsonAgeArray.length()];
              for (int countArrayAge = 0; countArrayAge < jsonAgeArray.length(); countArrayAge++) {
                tmpCatAge[countArrayAge] = jsonAgeArray.getJSONObject(countArrayAge).getString("libelle");
              }
              itEvent.setCategorieDage(tmpCatAge);
            }
            itEvent.setNombreDeParticipants(json.getInt("nombreParticipants"))  ;
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
            metadataDefault = Util.isEmpty(metadataDefault) ? Channel.getChannel().getProperty("jcmsplugin.socle.infolocale.metadata.default") : metadataDefault;
            if (Util.notEmpty(metadata1) && !metadata1.equals(metadataDefault)) {
              itEvent.setMetadata1(InfolocaleMetadataUtils.getMetadataHtml(metadata1, json, itEvent));
            }
            if (Util.notEmpty(metadata2) && !metadata2.equals(metadataDefault)) {
              itEvent.setMetadata2(InfolocaleMetadataUtils.getMetadataHtml(metadata2, json, itEvent));
            }
            if (Util.notEmpty(metadataDefault)) {
              itEvent.setMetadataDefaultIcon(InfolocaleMetadataUtils.getMetadataIcon(metadataDefault));
              itEvent.setMetadataDefaultContent(InfolocaleMetadataUtils.getMetadata(metadataDefault, json, itEvent));
              itEvent.setMetadataHiddenLabel(metadataDefault);
            }
        } catch (JSONException e) {
            LOGGER.error("Erreur in createEvenementInfolocaleFromJsonItem: " + e.getMessage());
            itEvent = null;
        }
        
        return itEvent;
    }

    /**
     * Créé un tableau d'objets Langue depuis du JSON
     */
    public static Langue[] createLanguesArrayFromJsonArray(JSONArray jsonArray) {
        Langue[] langues = new Langue[jsonArray.length()];
        for (int counter = 0; counter < jsonArray.length(); counter++) {
            try {
                langues[counter] = createLangueFromJsonItem(jsonArray.getJSONObject(counter));
            } catch (JSONException e) {
                LOGGER.error("Erreur in createLanguesArrayFromJsonArray: " + e.getMessage());
            }
        }
        return langues;
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
            LOGGER.error("Erreur in createLangueFromJsonItem: " + e.getMessage());
            langue = new Langue();
        }
        return langue;
    }

    /**
     * Créé un tableau d'objets Photo depuis du JSON
     */
    public static Photo[] createPhotosArrayFromJsonArray(JSONArray jsonArray) {
        Photo[] photos = new Photo[jsonArray.length()];
        for (int counter = 0; counter < jsonArray.length(); counter++) {
            try {
                photos[counter] = createPhotoFromJsonItem(jsonArray.getJSONObject(counter));
            } catch (JSONException e) {
                LOGGER.error("Erreur in createPhotosArrayFromJsonArray: " + e.getMessage());
            }
        }
        return photos;
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
            LOGGER.error("Erreur in createPhotoFromJsonItem: " + e.getMessage());
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
            genre.setGenreId(json.getString("id"));
            genre.setCategorie(json.getString("categorie"));
            genre.setLibelle(json.getString("libelle"));
        } catch (JSONException e) {
            LOGGER.error("Erreur in createGenreFromJsonItem: " + e.getMessage());
            genre = new Genre();
        }
        return genre;
    }

    /**
     * Créé un tableau d'objets Contact depuis du JSON
     */
    public static Contact[] createContactArrayFromJsonArray(JSONArray jsonArray) {
        Contact[] contacts = new Contact[jsonArray.length()];
        for (int counter = 0; counter < jsonArray.length(); counter++) {
            try {
                contacts[counter] = createContactFromJsonItem(jsonArray.getJSONObject(counter));
            } catch (JSONException e) {
                LOGGER.error("Erreur in createContactArrayFromJsonArray: " + e.getMessage());
            }
        }
        return contacts;
    }

    /**
     * Créé un object Contact depuis du JSON
     */
    public static Contact createContactFromJsonItem(JSONObject json) {
        if (Util.isEmpty(json)) return null;
        Contact contact = new Contact();
        try {
            contact.setTypeId(json.getInt("typeId"));
            contact.setType(json.getString("type"));
            contact.setTelephone1(json.getString("telephone1"));
            contact.setTelephone2(json.getString("telephone2"));
            contact.setUrl(json.getString("url"));
            contact.setEmail(json.getString("email"));
        } catch (JSONException e) {
            LOGGER.error("Erreur in createContactFromJsonItem: " + e.getMessage());
            contact = new Contact();
        }
        return contact;
    }

    /**
     * Créé un tableau d'objets Date (infolocale) depuis du JSON
     */
    public static DateInfolocale[] createDateArrayFromJsonArray(JSONArray jsonArray) {
        DateInfolocale[] dates = new DateInfolocale[jsonArray.length()];
        for (int counter = 0; counter < jsonArray.length(); counter++) {
            try {
                dates[counter] = createDateFromJsonItem(jsonArray.getJSONObject(counter));
            } catch (JSONException e) {
                LOGGER.error("Erreur in createDateArrayFromJsonArray: " + e.getMessage());
            }
        }
        return dates;
    }

    /**
     * Créé un objet Date (infolocale) depuis du JSON
     */
    public static DateInfolocale createDateFromJsonItem(JSONObject json) {
        if (Util.isEmpty(json)) return null;
        DateInfolocale date = new DateInfolocale();
        try {
            date.setDebut(json.getString("debut"));
            date.setFin(json.getString("fin"));
            String tmpHoraireString = json.getString("horaire");
            StringBuilder horaireBuilder = new StringBuilder();
            boolean isReadingHoraire = false;
            if (Util.notEmpty(tmpHoraireString)) {
              for (Character itChar : tmpHoraireString.toCharArray()) {
                if (itChar.equals('{')) { // début d'un horaire
                  isReadingHoraire = true;
                  continue;
                }
                if (itChar.equals('}')) { // fin d'un horaire
                  isReadingHoraire = false;
                  continue;
                }
                if (itChar.equals(',') && isReadingHoraire) { // virgule au sein d'un horaire formatté autrement
                  horaireBuilder.append(" - ");
                  continue;
                }
                if (itChar.equals(',') && !isReadingHoraire) { // virgule séparant deux horaires formatté autrement
                  horaireBuilder.append(", ");
                  continue;
                }
                // Dans tous les autres cas, on concatène normalement
                horaireBuilder.append(itChar);
              }
            }
            date.setHoraire(horaireBuilder.toString().replace(":", "h"));
        } catch (JSONException e) {
            LOGGER.error("Erreur in createDateFromJsonItem: " + e.getMessage());
            date = new DateInfolocale();
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
            LOGGER.error("Erreur in createLieuFromJsonItem: " + e.getMessage());
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
            LOGGER.error("Erreur in createCommuneFromJsonItem: " + e.getMessage());
            commune = new Commune();
        }
        return commune;
    }
    
    /**
     * Effectue un filtre sur un tableau d'objets EvenementInfolocale à partir de paramètres
     */
    public static EvenementInfolocale[] filterEvenementInfolocaleArray(EvenementInfolocale[] arrayEvents, Map<String, Object> sortParameters) {
        
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
        
        ArrayList<EvenementInfolocale> listEvents = new ArrayList<>(Arrays.asList(arrayEvents));
        
        for (Iterator<EvenementInfolocale> iter = listEvents.iterator(); iter.hasNext();) {
            EvenementInfolocale itEvent = iter.next();
            
            if (isEventFilteredOnAccessibilityAndId(itEvent, accessibiliteMental, accessibiliteMoteur, accessibiliteVisuel, exclusion)) {
                iter.remove();
            }
        }
        // Tronquer la liste de résultats en fonction du nombre maximum de résultats
        if (resultatsMax < listEvents.size()) {
            listEvents = new ArrayList<>(listEvents.subList(0, resultatsMax));
        }
        
        return listEvents.toArray(new EvenementInfolocale[listEvents.size()]);
    }
    
    private static boolean isEventFilteredOnAccessibilityAndId(EvenementInfolocale event, boolean accessibiliteMental, boolean accessibiliteMoteur, 
            boolean accessibiliteVisuel, String exclusion) {
        
        // filtre sur la mention d'accessibilité : handicap mental
        if (accessibiliteMental && !event.getMentionAccessibleHandicapMental()) {
            return true;
        }
        // filtre sur la mention d'accessibilité : handicap moteur
        if (accessibiliteMoteur && !event.getMentionAccessibleHandicapMoteur()) {
            return true;
        }
        // filtre sur la mention d'accessibilité : handicap visuel
        if (accessibiliteVisuel && !event.getMentionAccessibleHandicapVisuel()) {
            return true;
        }
        // filtre sur l'exclusion de certains IDs d'événements
        if (Util.notEmpty(exclusion) && exclusion.contains(Integer.toString(event.getEvenementId()))) {
            return true;
        }
        
        return false;
    }
    
    /**
     * Retourne l'objet JSON associé à un événement depuis un JSONArray
     * @param event
     * @return
     */
    public static JSONObject getJsonObjectOfEvent(EvenementInfolocale event, JSONArray jsonArray) {
      if (Util.isEmpty(event) || Util.isEmpty(jsonArray) || Util.isEmpty(event.getId())) {
        return null;
      }
      
      Integer jsonEventId = Util.toInteger(event.getId().replace("INFOLOC-", ""), -1);
      
      for (int jsonArrayCounter = 0; jsonArrayCounter <= jsonArray.length(); jsonArrayCounter++) {
        JSONObject itJsonObject;
        try {
          itJsonObject = jsonArray.getJSONObject(jsonArrayCounter);
          if (jsonEventId == itJsonObject.getInt("id")) {
            return itJsonObject;
          }
        } catch (JSONException e) {
          LOGGER.warn("Exception in getJsonObjectOfEvent : " + e.getMessage());
        }
        
      }
      
      return null;
    }
    
    
    /**
     * Retourne le résulat des evenements en fonction de la requete
     * @param request
     * @return
     */
    public static List<EvenementInfolocale> getQueryEvent(HttpServletRequest request) {
      
      Channel channel = Channel.getChannel();  
      PortletAgendaInfolocale box = (PortletAgendaInfolocale) channel.getPublication(request.getParameter("boxId"));
      
      if(Util.isEmpty(request) || Util.isEmpty(box)) {
        return Collections.emptyList();
      }
      
      Member adminMbr = Channel.getChannel().getDefaultAdmin();
                
      List<EvenementInfolocale> allEvents = Collections.emptyList();      
      Map<String, Object> parameters = new HashMap<String, Object>();
      
      // Forcer l'ordre des résultats
      parameters.put("order", "dateDebut asc");
      
      // Ajouter un filtre sur les organismes
      if (Util.notEmpty(box.getOrganismesInfolocale())) {
        parameters.put("organisme", box.getOrganismesInfolocale());
      }
           
      // Recherche sur une commune
      String commune = request.getParameter("commune");
      String codesInseeBox = SocleUtils.getCodesInseeFromPortletAgenda(box, adminMbr);
      String codeInseeLbl = channel.getProperty("jcmsplugin.socle.infolocale.search.field.codeInsee");
      if(Util.notEmpty(commune)) {
        parameters.put(codeInseeLbl, commune);
      } else if (Util.notEmpty(codesInseeBox)) {
        parameters.put(codeInseeLbl, codesInseeBox);
      }
      
      String rayonField = channel.getProperty("jcmsplugin.socle.infolocale.search.field.rayon");
      
      // Recherche sur un rayon
      String rayon = request.getParameter(rayonField);
      if(Util.notEmpty(rayon)) {
        parameters.put(rayonField, rayon.replaceAll("[km ]", ""));
      }
      
      // Recherche sur un genre
      String prefixeGrp = "groupe_";
      String[] genres = request.getParameterValues("cids");
      String strGenres = "";
      String strThematiques = "";
      String boxGenres = InfolocaleUtil.getAllGenresFromPortletAgendaConfig(box);
      String boxThematiques = box.getGroupesDevenementsInfolocale();
      String rubriqueField = channel.getProperty("jcmsplugin.socle.infolocale.search.field.rubrique");
      String thematiqueField = channel.getProperty("jcmsplugin.socle.infolocale.search.field.thematiquePerso");
      if(Util.notEmpty(genres)) {
        strGenres = genres[0].contains(prefixeGrp) ? "" : genres[0];
        strThematiques = Util.isEmpty(strGenres) ? genres[0] : "";
      	for(int i = 1 ; i < genres.length; i++) {
      	  if (genres[i].contains(prefixeGrp)) {
      	    strThematiques += "," + genres[i];
      	  } else {
      	    strGenres += "," + genres[i]; 
      	  }
      	}
    	  
        if (Util.notEmpty(strGenres)) { 
          parameters.put(rubriqueField, strGenres);
        }
        if (Util.notEmpty(strThematiques)) { 
          parameters.put(thematiqueField, strThematiques);
        } 
      }
      
      if (Util.isEmpty(strGenres) && Util.notEmpty(boxGenres)) {
        parameters.put(rubriqueField, boxGenres);
      }
      if (Util.isEmpty(strThematiques) && Util.notEmpty(boxThematiques)) {
        parameters.put(thematiqueField, boxThematiques);
      }
      
      String dateDebutField = channel.getProperty("jcmsplugin.socle.infolocale.search.field.dateDebut");
      String dateFinField =  channel.getProperty("jcmsplugin.socle.infolocale.search.field.dateFin");
      String dateFormatForm = "yyyy-MM-dd";
      String dateFormatInfolocale = "dd-MM-yyyy";

      // Recherche sur une date
      String[] arrayDebutFin = InfolocaleUtil.getDatesDebutFinFromRequestParam(request.getParameterValues("agenda-date"));
      if (Util.notEmpty(arrayDebutFin)) {
        
        String dateDebut = arrayDebutFin[0];
        String dateFin = arrayDebutFin[1];
        
        // Vérifier si les dates de début et de fin respectent les limites infolocale
        dateDebut = InfolocaleUtil.putDateInInfolocaleLimits(dateDebut);
        dateFin = InfolocaleUtil.putDateInInfolocaleLimits(dateFin);
        
        parameters.put(dateDebutField, InfolocaleUtil.convertStringDateToOtherFormat(dateDebut, dateFormatForm, dateFormatInfolocale));
        parameters.put(dateFinField, InfolocaleUtil.convertStringDateToOtherFormat(dateFin, dateFormatForm, dateFormatInfolocale));
        
      }
      
      // Recherche sur l'accessibilité
      String mentionAccessibiliteAuditif = channel.getProperty("jcmsplugin.socle.infolocale.metadata.accessibilite.auditif");
      String mentionAccessibiliteMental = channel.getProperty("jcmsplugin.socle.infolocale.metadata.accessibilite.mental");
      String mentionAccessibiliteVisuel = channel.getProperty("jcmsplugin.socle.infolocale.metadata.accessibilite.visuel");
      String mentionAccessibiliteMoteur = channel.getProperty("jcmsplugin.socle.infolocale.metadata.accessibilite.moteur");
      
      String searchAccessibilite = request.getParameter("accessibilite");
      
      if (Util.notEmpty(searchAccessibilite)) {
        if (searchAccessibilite.contains(mentionAccessibiliteAuditif)) {
          parameters.put(mentionAccessibiliteAuditif, true);
        }
        if (searchAccessibilite.contains(mentionAccessibiliteMental)) {
          parameters.put(mentionAccessibiliteMental, true);
        }
        if (searchAccessibilite.contains(mentionAccessibiliteVisuel)) {
          parameters.put(mentionAccessibiliteVisuel, true);
        }
        if (searchAccessibilite.contains(mentionAccessibiliteMoteur)) {
          parameters.put(mentionAccessibiliteMoteur, true);
        }
      }
      
      parameters.put("limit", channel.getIntegerProperty("jcmsplugin.socle.infolocale.max.limit", 100)); 
      // 200 est le maximum autorisé par Infolocale. Posé à 100 en défaut par sécurité...
      
      String[] arrayIdsAExclure = null;
      if (Util.notEmpty(box.getIdsAExclure())) {
        arrayIdsAExclure = box.getIdsAExclure().split(",");
      }
      
      String[] arrayIdsGroupes = null;
      if (Util.notEmpty(box.getGroupeDevenements())) {
        arrayIdsGroupes = box.getGroupeDevenements().split(",");
      }
      
      // Récupère le flux infolocale et transformation en liste de publication JCMS
      String flux = Util.isEmpty(box.getIdDeFlux()) ? channel.getProperty("jcmsplugin.socle.infolocale.flux.default") : box.getIdDeFlux();
      JSONObject extractedFlux = RequestManager.filterFluxData(flux, parameters);
      try {
        EvenementInfolocale[] evenements = InfolocaleEntityUtils.createEvenementInfolocaleArrayFromJsonArray(extractedFlux.getJSONArray("result"), 
            box.getMetadonneesTuileResultat_1(), box.getMetadonneesTuileResultat_2(), box.getMetadonneeParDefaut(), 
            Util.notEmpty(arrayIdsAExclure) ? Arrays.asList(arrayIdsAExclure) : null, 
            Util.notEmpty(arrayIdsGroupes) ? Arrays.asList(arrayIdsGroupes) : null);
        allEvents = InfolocaleUtil.splitEventListFromDateFields(evenements);
      } catch (JSONException e) {
        LOGGER.warn("Erreur lors de la requete sur les évènements infolocale", e);
      }           
      return allEvents;
    }
    
    /**
     * <p>Méthode recursive qui navigue dans l'arborescence des thématiques infolocales</p>
     * @param thematique la thématique sur laquelle on navigue : on va récupérer ses thématiques enfants s'il y a ou ses genres rattachés s'il y a
     * @param hasToSave est-ce qu'on retourne les valeurs rattachés à cette thématique par défaut
     * @param idDeThematiquesPersonnalisees liste des thématiques dont on veut les genres reliés, si vide on considère qu'on veut tout récupérer
     * @param listeGenre la liste qui contient tous les genres déjà récupérés
     * @param prefixLibelle le prefix du libellés des genres qui permet de rendre compte de sa place dans l'arborescence et éviter les doublons
     * @return listeGenre avec les genres rattachés à la thématique en entrée en plus
     */
  private static Set<Genre> getAllGenreOfAThematique(JSONObject thematique, Boolean hasToSave, String[] idDeThematiquesPersonnalisees, Set<Genre> listeGenre, String prefixLibelle) {
    Boolean originalHasToSave = hasToSave;

    // on vérifie s'il faut récupérer le contenu de la thématique courante
    if (!hasToSave && Util.notEmpty(idDeThematiquesPersonnalisees)) {
      try {
        int i = 0;
        String themId = thematique.getString("code");
        while(i < idDeThematiquesPersonnalisees.length && !hasToSave) {
          hasToSave = idDeThematiquesPersonnalisees[i].equalsIgnoreCase(themId);
          i++;
        }
      } catch (JSONException e) {
        LOGGER.warn("Exception sur themId dans getAllGenreOfAThematique"+ e.getMessage());
      }
    }
    // on met à jour le prefix du libelle en fonction de si on récupére le contenu de la thématique courante
    String newPrefixLibelle = prefixLibelle;
    try {
      if((originalHasToSave && idDeThematiquesPersonnalisees.length < 2) || (hasToSave && idDeThematiquesPersonnalisees.length > 1)) {
        newPrefixLibelle = prefixLibelle+thematique.getString("libelle")+" - ";
      }
    } catch (JSONException e1) {
      LOGGER.warn("Exception sur newPrefixLibelle dans getAllGenreOfAThematique"+ e1.getMessage());
    }

    // on regarde si la thématique courante a des thématiques enfants
    JSONArray listeSubThem = null;
    try {
      listeSubThem = thematique.getJSONArray("categories");
    } catch (JSONException e) {
      if( ! e.getMessage().equalsIgnoreCase("JSONObject[\"categories\"] not found.")) {
        LOGGER.warn("Exception sur listeSubThem dans getAllGenreOfAThematique : "+ e.getMessage());
      }
    }
    // si la thématique a des thématiques enfants, alors on navigue dans ses catégories enfants récursivement
    if(Util.notEmpty(listeSubThem)) {
      for(int i = 0; i < listeSubThem.length(); i++) {
        try {
          JSONObject subThem = listeSubThem.getJSONObject(i);
          listeGenre = getAllGenreOfAThematique(subThem, hasToSave, idDeThematiquesPersonnalisees, listeGenre, newPrefixLibelle);
        } catch (JSONException e) {
          LOGGER.warn("Exception sur subThem dans getAllGenreOfAThematique : "+ e.getMessage());
        }
      }
    } else { // sinon, cela signifie qu'elle devrait avoir des genres rattachés
      JSONArray listeSubGenres = null;
      try {
        listeSubGenres = thematique.getJSONArray("genres");
      } catch (JSONException e) {
        LOGGER.warn("Exception sur listeSubGenres dans getAllGenreOfAThematique : "+ e.getMessage());
      }
      if(Util.notEmpty(listeSubGenres)) {
        for(int i = 0; i < listeSubGenres.length(); i++) {
          try {
            JSONObject subGenre = listeSubGenres.getJSONObject(i);
            Genre genre = new Genre();
            genre.setGenreId(subGenre.getString("code"));
            genre.setLibelle(newPrefixLibelle+subGenre.getString("libelle"));

            Boolean hasToSaveThisGenre = false;
            // si on ne sauvegarde pas par défaut tous les genres rattachés, on vérifie qu'il fasse partie de la liste idDeThematiquesPersonnalisees
            if (!hasToSave && Util.notEmpty(idDeThematiquesPersonnalisees)) {
              int j = 0;
              while(j < idDeThematiquesPersonnalisees.length && !hasToSaveThisGenre) {
                hasToSaveThisGenre = idDeThematiquesPersonnalisees[j].equalsIgnoreCase(genre.getGenreId()+"");
                j++;
              }
            }

            if(hasToSave || hasToSaveThisGenre) {
              listeGenre.add(genre);
            }

          } catch (JSONException e) {
            LOGGER.warn("Exception sur subGenre dans getAllGenreOfAThematique : "+ e.getMessage());
          }
        }
      }
    }

    return listeGenre;
  }
	
	/**
	 * Renvoie une map de libellés et de thématiques perso sous la forme d'objets Genres
	 * @param fluxId
	 * @param lblGenres
	 * @param idGenres
	 * @return
	 */
	private static Map<String, Set<Genre>> getAllThematiquesWithLibelles(String fluxId, String[] lblThematiques, String[] idThematiques) {
	  Map<String, Set<Genre>> genresWithLabels = new HashMap<>();

	  JSONObject objThematiques = RequestManager.getFluxMetadata(fluxId, "thematique_perso");
    String idLbl = "id";
    
    try {
      JSONObject objListeThematiques = objThematiques.getJSONObject("listMetadata");
      
      for(int i = 0 ; i < objListeThematiques.length() ; i++) {
        JSONArray listeThematiques = objListeThematiques.getJSONArray(objListeThematiques.names().getString(i));
        
        for (int counterThematiques = 0; counterThematiques < idThematiques.length; counterThematiques++) {
          if (Util.isEmpty(lblThematiques[counterThematiques])) continue;
          
          String listIdGenres = idThematiques[counterThematiques];
          Set<Genre> foundGenres = new TreeSet<>();
          for (int counterJson = 0; counterJson < listeThematiques.length(); counterJson++) {
            if (listIdGenres.contains(listeThematiques.getJSONObject(counterJson).getString(idLbl))) {
              foundGenres.add(generateGenreThematiqueFromJson(listeThematiques.getJSONObject(counterJson)));
            }
          }
          if (Util.notEmpty(foundGenres)) {
            foundGenres = InfolocaleUtil.orderSetGenresToMatchIdList(foundGenres, listIdGenres);
            genresWithLabels.put(lblThematiques[counterThematiques], foundGenres);
          }
        }
      }
    } catch (JSONException e) {
      LOGGER.warn("Exception sur getAllGenreOfThematiques : "+ e.getMessage());
    }

    return genresWithLabels;
	}
	
	 /**
   * Retourne la liste des genres depuis une liste d'IDs, ainsi que les genres des catégories indiquées, regroupés par labels
   * @param fluxId
   * @param groupeDeThematiquesPersonnalisee
	 * @param idGenres 
   * @param listeGenre
   * @return un set des genres reliés aux thématiques personnalisées, triés par ordre alphabétique des libellés
   */
  private static Map<String, Set<Genre>> getAllGenresWithLibelle(String fluxId, String[] lblGenres, String[] idGenres) {
    
    Map<String, Set<Genre>> genresWithLabels = new HashMap<>();

    JSONObject fluxMetadataGenres = RequestManager.getFluxMetadata(fluxId, "thematique");

    JSONArray allStyles;

    try {
      if (Util.isEmpty(fluxMetadataGenres) || !fluxMetadataGenres.getBoolean("success")
          || fluxMetadataGenres.isNull(listMetadataLbl)) {
        LOGGER.warn("getAllGenreOfThematiquesPerso -> aucune thématique perso trouvée (flux " + fluxId + ")");
      }

      allStyles = fluxMetadataGenres.getJSONObject(listMetadataLbl).getJSONArray("styles");
      
      for (int counterGenres = 0; counterGenres < idGenres.length; counterGenres++) {
        if (Util.isEmpty(lblGenres[counterGenres])) continue;
        
        String listIdGenres = idGenres[counterGenres];
        Set<Genre> foundGenres = findGenresFromIdList(allStyles, new ArrayList<String>(Arrays.asList(listIdGenres.split(","))));
        if (Util.notEmpty(foundGenres)) {
          foundGenres = InfolocaleUtil.orderSetGenresToMatchIdList(foundGenres, listIdGenres);
          genresWithLabels.put(lblGenres[counterGenres], foundGenres);
        }
      }
    } catch (JSONException e) {
      LOGGER.warn("Exception sur getAllGenreOfThematiquesPerso : "+ e.getMessage());
      return null;
    }

    
    
    return genresWithLabels;
  }
    
  /**
   * Méthode récursive qui retourne la liste des genres trouvés dans le flux
   * @param allStyles
   * @param arrayList
   * @return
   */
	private static Set<Genre> findGenresFromIdList(JSONArray genreArray, ArrayList<String> listIds) {
	  Set<Genre> listeGenre = new TreeSet<Genre>(new Comparator<Genre>() {
      @Override
      public int compare(final Genre obj1, final Genre obj2) {
        return obj1.getLibelle().compareToIgnoreCase(obj2.getLibelle());
      }
    });
	  
	  for (int jsonCounter = 0; jsonCounter < genreArray.length(); jsonCounter++) {
	    JSONObject jsonGenre;
      try {
        jsonGenre = genreArray.getJSONObject(jsonCounter);
        // style. On recherche immédiatement dans les catégories
        if (!jsonGenre.isNull("categories")) {
          listeGenre.addAll(findGenresFromIdList(jsonGenre.getJSONArray("categories"), listIds));
        }
        // catégorie
        else if (!jsonGenre.isNull("genres")) {
          // l'id de la catégorie appartient à la liste
          if (listIds.contains(jsonGenre.getString("code"))) {
            JSONArray genresCategorie = jsonGenre.getJSONArray("genres");
            for (int genreCounter = 0; genreCounter < genresCategorie.length(); genreCounter++) {
              JSONObject itJsonGenre = genresCategorie.getJSONObject(genreCounter);
              Genre genreObj = generateGenreFromJson(itJsonGenre);
              if (Util.notEmpty(genreObj)) listeGenre.add(genreObj);
            }
          } else {
            // on recherche dans les genres de la catégorie
            listeGenre.addAll(findGenresFromIdList(jsonGenre.getJSONArray("genres"), listIds));
          }
        }
        // genre
        else if (listIds.contains(jsonGenre.getString("code"))) {
          Genre genreObj = generateGenreFromJson(jsonGenre);
          if (Util.notEmpty(genreObj)) listeGenre.add(genreObj);
        }
      } catch (JSONException e) {
        // TODO Auto-generated catch block
        e.printStackTrace();
      }
	  }
	  
    return listeGenre;
  }
	
	/**
   * Génère un objet Genre depuis du JSON
   * @param jsonGenre
   * @return
   */
  private static Genre generateGenreFromJson(JSONObject jsonGenre) {
    Genre genreObj = new Genre();
    
    try {
      genreObj.setLibelle(jsonGenre.getString("libelle"));
      genreObj.setId(jsonGenre.getString("code"));
    } catch (JSONException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }
    
    return genreObj;
  }
  
  /**
   * Génère un objet Genre (thématique) depuis du JSON
   * @param jsonGenre
   * @return
   */
  private static Genre generateGenreThematiqueFromJson(JSONObject jsonGenre) {
    Genre genreObj = new Genre();
    
    try {
      genreObj.setLibelle(jsonGenre.getString("libelle"));
      genreObj.setId(jsonGenre.getString("id"));
    } catch (JSONException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }
    
    return genreObj;
  }

  /**
	 * Retourne une liste de thématiques personnalisées selon une liste d'IDs
	 * @param idDeThematiquesPersonnalisees la liste d'IDs de thématiques persos
	 * @param fluxId l'ID du flux à utiliser
	 * @return la liste de thématiques personnalisées (sous la classe 'Genre' qui partage les mêmes paramètres)
	 */
  public static Map<String, Set<Genre>> getThematiquesPersoOfMetadata(String[] lblThematiques, String[] idThematiques, String fluxId) {
    if (Util.isEmpty(lblThematiques) || Util.isEmpty(idThematiques)) {
      return null;
    }
    
    Map<String, Set<Genre>> mapGenre;
  	
    // S'assurer que le tableau des labels aie la même taille que le tableau des IDs
    if (lblThematiques.length < idThematiques.length) {
      String[] lblClone = new String[idThematiques.length];
      if (Util.notEmpty(lblThematiques)) {
        for (int i = 0; i < lblThematiques.length; i++) {
          lblClone[i] = lblThematiques[i];
        }
      }
      mapGenre = getAllThematiquesWithLibelles(fluxId, lblClone, idThematiques);
    } else {
      mapGenre = getAllThematiquesWithLibelles(fluxId, idThematiques, idThematiques);
    }
    
    return mapGenre;
  }
  
  /**
   * Retourne une map de genres associées à leur libellé, en fonction des IDs de genres / catégories indiqués
   * @param lblGenres
   * @param idGenres
   * @param fluxId
   * @return
   */
  public static Map<String, Set<Genre>> getAllGenreOfMetadata(String[] lblGenres, String[] idGenres, String fluxId) {
    if (Util.isEmpty(idGenres)) {
      return null;
    }
    
    Map<String, Set<Genre>> mapGenre;
    
    // S'assurer que le tableau des labels aie la même taille que le tableau des IDs
    if (Util.isEmpty(lblGenres) || lblGenres.length < idGenres.length) {
      String[] lblClone = new String[idGenres.length];
      if (Util.notEmpty(lblGenres)) {
        for (int i = 0; i < lblGenres.length; i++) {
          lblClone[i] = lblGenres[i];
        }
      }
      mapGenre = getAllGenresWithLibelle(fluxId, lblClone, idGenres);
    } else {
      mapGenre = getAllGenresWithLibelle(fluxId, lblGenres, idGenres);
    }
    
    return mapGenre;
  }
}