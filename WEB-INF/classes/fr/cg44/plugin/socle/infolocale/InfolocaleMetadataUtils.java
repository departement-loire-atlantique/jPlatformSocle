package fr.cg44.plugin.socle.infolocale;

import java.util.ArrayList;
import java.util.Iterator;

import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.jalios.jcms.Channel;
import com.jalios.jcms.JcmsUtil;
import com.jalios.util.Util;

import fr.cg44.plugin.socle.infolocale.util.InfolocaleUtil;
import generated.EvenementInfolocale;

/**
 * Classe gérant la récupération de métadonnées d'événements infolocale
 * @author LChoquet
 *
 */
public class InfolocaleMetadataUtils {
  
    private static String[] accessibiliteNamesArray = new String[] {"auditif", "mental", "visuel", "moteur"};
    
    private InfolocaleMetadataUtils() {}
    
    private static final Logger LOGGER = Logger.getLogger(InfolocaleMetadataUtils.class);
    
    private static String propertyMetadataLibelle = "jcmsplugin.socle.infolocale.metadata.libelle";
    
    static String separator = ", ";
    static String baliseItalicStart = "<i class=\"icon ";
    static String baliseItalicEnd = "\"></i>";
    static String baliseSpanStart = "<span class=\"visibility-hidden\"> ";
    static String baliseSpanEnd = "</span>";
    static String cssVisuel = ".visuel";
    
    /**
     * Retourne le code HTML correspondant à une metadata
     * @param metadata
     * @param jsonEvent
     * @return
     */
    public static String getMetadataHtml(String metadata, EvenementInfolocale event, JSONArray resultJsonArray) {
      JSONObject jsonEvent = InfolocaleEntityUtils.getJsonObjectOfEvent(event, resultJsonArray);
      
      return getMetadataHtml(metadata, jsonEvent, event);
    }
    
    /**
     * Retourne le code HTML correspondant à une metadata
     * @param metadata
     * @param jsonEvent
     * @return
     */
    public static String getMetadataHtml(String metadata, JSONObject jsonEvent, EvenementInfolocale event) {
      
      if (Util.isEmpty(jsonEvent)) {
        return "";
      }
      
      Channel channel = Channel.getChannel();
      
      // Cas particuliers... Parce qu'on les aime ceux-là :)
      String metaAccessibilite = channel.getProperty("jcmsplugin.socle.infolocale.metadata.front.accessibilite");
      
      if (metadata.contentEquals(metaAccessibilite)) {
        return getMetadata(metadata, jsonEvent, event);
      }
      
      // Cas réguliers
      
      String metadataIcon = getMetadataIcon(metadata);
      String metadataValue = getMetadata(metadata, jsonEvent, event);
      
      if (Util.isEmpty(metadataValue) || metadataValue.equals("{}")) {
        return "";
      }
      
      StringBuilder htmlMetadata = new StringBuilder();
      htmlMetadata.append(baliseItalicStart);
      htmlMetadata.append(metadataIcon);
      htmlMetadata.append(baliseItalicEnd + baliseSpanStart);
      htmlMetadata.append(metadataValue);
      htmlMetadata.append(baliseSpanEnd);
      
      return htmlMetadata.toString();
      
    }
    
    /**
     * Récupère la ou les données Metadata demandées
     * @param metadata
     * @param jsonEvent
     * @return
     */
    public static String getMetadata(String metadata, JSONObject jsonEvent, EvenementInfolocale event) {
        
        Channel channel = Channel.getChannel();
        
        String metaCommune = channel.getProperty("jcmsplugin.socle.infolocale.metadata.front.commune");
        String metaGenre = channel.getProperty("jcmsplugin.socle.infolocale.metadata.front.genre");
        String metaOrganismes = channel.getProperty("jcmsplugin.socle.infolocale.metadata.front.organisme");
        String metaHoraires = channel.getProperty("jcmsplugin.socle.infolocale.metadata.front.horaires");
        String metaDuree = channel.getProperty("jcmsplugin.socle.infolocale.metadata.front.duree");
        String metaTarif = channel.getProperty("jcmsplugin.socle.infolocale.metadata.front.tarif");
        String metaPublic = channel.getProperty("jcmsplugin.socle.infolocale.metadata.front.public");
        String metaAccessibilite = channel.getProperty("jcmsplugin.socle.infolocale.metadata.front.accessibilite");
        String metaGroupeThemePrefix = channel.getProperty("jcmsplugin.socle.infolocale.metadata.front.prefix.groupeTheme");
        String metaThemePrefix = channel.getProperty("jcmsplugin.socle.infolocale.metadata.front.prefix.theme");
        
        if (metadata.equals(metaCommune)) {
            return getMetaCommune(event);
        }
        if (metadata.equals(metaGenre)) {
            return getMetaGenre(event);
        }
        if (metadata.equals(metaOrganismes)) {
            return getMetaOrganismes(event);
        }
        if (metadata.equals(metaHoraires)) {
            return getMetaHoraires(event);
        }
        if (metadata.equals(metaDuree)) {
            return getMetaDuree(event);
        }
        if (metadata.equals(metaTarif)) {
            return getMetaTarif(event);
        }
        if (metadata.equals(metaPublic)) {
            return getMetaPublic(jsonEvent);
        }
        if (metadata.equals(metaAccessibilite)) {
            return getMetaAccessibilite(jsonEvent);
        }
        if (metadata.indexOf(metaGroupeThemePrefix) == 0) {
            return getMetaGroupeTheme(jsonEvent, metadata.replace(metaGroupeThemePrefix, ""));
        }
        if (metadata.indexOf(metaThemePrefix) == 0) {
            return getMetaTheme(jsonEvent, metadata.replace(metaThemePrefix, ""));
        }
        
        return "";
    }
    
    /**
     * Récupère la métadonnée Commune
     * @param jsonEvent
     * @return
     */
    private static String getMetaCommune(EvenementInfolocale event) {
        try {
            return event.getLieu().getCommune().getNom();
        } catch (Exception e) {
            return "";
        }
    }
    
    /**
     * Récupère la métadonnée Genre
     * @param jsonEvent
     * @return
     */
    private static String getMetaGenre(EvenementInfolocale event) {        
        try {
            return event.getGenre().getLibelle();
        } catch (Exception e) {
            return "";
        }
    }
    
    /**
     * Récupère la métadonnée Organismes
     * @param jsonEvent
     * @return
     */
    private static String getMetaOrganismes(EvenementInfolocale event) {
        return Util.isEmpty(event.getOrganismeNom()) ? "" : event.getOrganismeNom();
    }
    
    /**
     * Récupère les métadonnées Horaires
     * @param jsonEvent
     * @return
     */
    private static String getMetaHoraires(EvenementInfolocale event) {
        // Mettre la valeur "horaire" pour récupérer l'horaire associé à la date affichée d'un événement
        return InfolocaleUtil.getHoraireDisplay(event, InfolocaleUtil.getClosestDate(event));
      }
    
    /**
     * Récupère la métadonnée Durée
     * @param jsonEvent
     * @return
     */
    private static String getMetaDuree(EvenementInfolocale event) {
        if (Util.isEmpty(event.getDuree()) || event.getDuree() <= 0) {
          return "";
        }
        return event.getDuree() + " " + JcmsUtil.glp(Channel.getChannel().getCurrentJcmsContext().getUserLang(), "jcmsplugin.socle.infolocale.label.duree");
    }
    
    /**
     * Récupère la métadonnée Tarif
     * @param jsonEvent
     * @return
     */
    private static String getMetaTarif(EvenementInfolocale event) {
        String tarifMeta = Util.isEmpty(event.getTarifs()) || Util.isEmpty(event.getTarifs()[0]) ? "" : InfolocaleUtil.getPriceOfTarif(event.getTarifs()[0]);
        return tarifMeta;
    }
    
    /**
     * Récupère les métadonnées Public
     * @param jsonEvent
     * @return
     */
    private static String getMetaPublic(JSONObject jsonEvent) {
        Channel channel = Channel.getChannel();
        StringBuilder publicString = new StringBuilder();
        try {
            JSONArray categoriesAge = jsonEvent.getJSONArray(channel.getProperty("jcmsplugin.socle.infolocale.metadata.categoriesAge"));
            for (int count = 0; count < categoriesAge.length(); count++) {
                publicString = concatenatePublicLibelle(publicString, categoriesAge.getJSONObject(count));
            }
            return publicString.toString();
        } catch (Exception e) {
            return "";
        }
    }
    
    private static StringBuilder concatenatePublicLibelle(StringBuilder publicString, JSONObject publicJson) {
        String separator = ", ";
        Channel channel = Channel.getChannel();
        
        try {
            String toAdd = publicJson.getString(channel.getProperty(propertyMetadataLibelle));
            if (Util.notEmpty(publicString.toString())) toAdd = separator + toAdd;
            publicString.append(toAdd);
        } catch (Exception e) {
            LOGGER.warn("Erreur dans concatenatePublicLibelle : libellé non trouvé pour le json " + publicJson.toString());
        }
        
        return publicString;
    }
    
    /**
     * Récupère les métadonnées Accessibilité sous la forme d'un bloc HTML
     * @param jsonEvent
     * @return
     */
    private static String getMetaAccessibilite(JSONObject jsonEvent) {
        StringBuilder accessibilite = buildAccessibiliteHtmlBlock(jsonEvent);
        if (Util.isEmpty(accessibilite)) {
            return ""; 
        } else {
            return accessibilite.toString();
        }
    }
    
    private static StringBuilder buildAccessibiliteHtmlBlock(JSONObject jsonEvent) {
        StringBuilder value = new StringBuilder();
        ArrayList<Integer> idsAccessibilitesEvent = new ArrayList<>();
        try {
          JSONArray itAccessibiliteArray = jsonEvent.getJSONArray(Channel.getChannel().getProperty("jcmsplugin.socle.infolocale.metadata.accessibilite.field"));          
          if (itAccessibiliteArray.length() <= 0) return value;
          for (int counterAccessibiliteArray = 0; counterAccessibiliteArray < itAccessibiliteArray.length(); counterAccessibiliteArray ++) {
            idsAccessibilitesEvent.add(itAccessibiliteArray.getJSONObject(counterAccessibiliteArray).getInt("hanId"));
          }
        } catch (JSONException e) {
          LOGGER.warn("Anomalie in buildAccessibiliteHtmlBlock : " + e.getMessage());
          return value;
        }
        for (Iterator<Integer> iter = idsAccessibilitesEvent.iterator(); iter.hasNext();) {
            int itId = iter.next();
            value.append(getHtmlForAccessibilite(jsonEvent, itId, iter.hasNext()));
        }
        return value;
    }

    private static String getHtmlForAccessibilite(JSONObject jsonEvent, int idAccessibilite, boolean addSeparator) {
        StringBuilder value = new StringBuilder();
        Channel channel = Channel.getChannel();
        
        value.append(baliseItalicStart + channel.getProperty("jcmsplugin.socle.infolocale.metadata.icon.accessibilite." + accessibiliteNamesArray[idAccessibilite]) + baliseItalicEnd);
        value.append(baliseSpanStart);
        value.append(JcmsUtil.glp(channel.getCurrentUserLang(), "jcmsplugin.socle.infolocale.label.accessibilite.handicap" + accessibiliteNamesArray[idAccessibilite]));
        value.append(baliseSpanEnd);
        if (addSeparator) value.append("<br/>");
        
        return value.toString();
    }

    /**
     * Récupère les métadonnées des thèmes ayant un groupe parent précis
     * @param jsonEvent
     * @param id
     * @return
     */
    private static String getMetaGroupeTheme(JSONObject jsonEvent, String id) {
        Channel channel = Channel.getChannel();
        StringBuilder groupString = new StringBuilder();
        try {
            JSONArray thematiques = jsonEvent.getJSONArray(channel.getProperty("jcmsplugin.socle.infolocale.metadata.thematiques"));
            for (int count = 0; count < thematiques.length(); count++) {
                concatenateGroupLibelle(groupString, thematiques.getJSONObject(count), id);
            }
            return groupString.toString();
        } catch (Exception e) {
            return "";
        }
    }
    
    private static StringBuilder concatenateGroupLibelle(StringBuilder groupString, JSONObject groupJson, String id) {
        String separator = ", ";
        Channel channel = Channel.getChannel();
        
        try {
            if (! groupJson.getString(channel.getProperty("jcmsplugin.socle.infolocale.metadata.parentId")).equals(id)) return groupString;
            String toAdd = groupJson.getString(channel.getProperty(propertyMetadataLibelle));
            if (Util.notEmpty(groupString.toString())) toAdd = separator + toAdd;
            groupString.append(toAdd);
        } catch (Exception e) {
            LOGGER.debug("Erreur dans getMetaGroupeTheme : le groupe thématique n'a pas été trouvé");
        }
        
        return groupString;
    }
    
    /**
     * Récupère la métadonnée d'une thématique correspondant à l'ID indiquée
     * @param jsonEvent
     * @param id
     * @return
     */
    private static String getMetaTheme(JSONObject jsonEvent, String id) {
        Channel channel = Channel.getChannel();
        try {
            JSONArray thematiquesArrays = jsonEvent.getJSONArray(channel.getProperty("jcmsplugin.socle.infolocale.metadata.thematiques"));
            for (int count = 0; count < thematiquesArrays.length(); count++) {
                if (thematiquesArrays.getJSONObject(count).getString(channel.getProperty("jcmsplugin.socle.infolocale.metadata.thematiqueId")).equals(id)) {
                    return thematiquesArrays.getJSONObject(count).getString(channel.getProperty(propertyMetadataLibelle));
                }
            }
        } catch (JSONException e) {
            return "";
        }
        
        return "";
    }
    
    /**
     * Récupère l'icône visuelle pour une métadonnée
     * @param metadata
     * @return
     */
    public static String getMetadataIcon(String metadata) {
        return Channel.getChannel().getProperty("jcmsplugin.socle.infolocale.metadata.icon." + metadata.replace(":", ""));
    }
    
    /**
     * Récupère le label d'une métadonnée
     * @param metadata
     * @return
     */
    public static String getLabelMetadata(String metadata) {
        return JcmsUtil.glp("jcmsplugin.socle.infolocale.metadata.label." + metadata.replace(":", ""), Channel.getChannel().getCurrentJcmsContext().getUserLang());
    }

}