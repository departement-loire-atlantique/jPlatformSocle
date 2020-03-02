package fr.cg44.plugin.socle.infolocale;

import java.util.Arrays;
import java.util.Iterator;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.jalios.jcms.Channel;
import com.jalios.jcms.JcmsUtil;
import com.jalios.util.Util;

import fr.cg44.plugin.socle.infolocale.entities.Date;
import generated.EvenementInfolocale;

public class InfolocaleMetadataUtils {
    
    public static String getMetadata(String metadata, JSONObject jsonEvent) {
        
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
            return getMetaCommune(jsonEvent);
        }
        if (metadata.equals(metaGenre)) {
            return getMetaGenre(jsonEvent);
        }
        if (metadata.equals(metaOrganismes)) {
            return getMetaOrganismes(jsonEvent);
        }
        if (metadata.equals(metaHoraires)) {
            return getMetaHoraires(jsonEvent);
        }
        if (metadata.equals(metaDuree)) {
            return getMetaDuree(jsonEvent);
        }
        if (metadata.equals(metaTarif)) {
            return getMetaTarif(jsonEvent);
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
    
    private static String getMetaCommune(JSONObject jsonEvent) {
        EvenementInfolocale itEvent = InfolocaleEntityUtils.createEvenementInfolocaleFromJsonItem(jsonEvent);
        try {
            return itEvent.getLieu().getCommune().getNom();
        } catch (Exception e) {
            return "";
        }
    }
    
    private static String getMetaGenre(JSONObject jsonEvent) {
        EvenementInfolocale itEvent = InfolocaleEntityUtils.createEvenementInfolocaleFromJsonItem(jsonEvent);
        try {
            return itEvent.getGenre().getLibelle();
        } catch (Exception e) {
            return "";
        }
    }
    
    private static String getMetaOrganismes(JSONObject jsonEvent) {
        EvenementInfolocale itEvent = InfolocaleEntityUtils.createEvenementInfolocaleFromJsonItem(jsonEvent);
        try {
            return itEvent.getOrganismeNom();
        } catch (Exception e) {
            return "";
        }
    }
    
    private static String getMetaHoraires(JSONObject jsonEvent) {
        EvenementInfolocale itEvent = InfolocaleEntityUtils.createEvenementInfolocaleFromJsonItem(jsonEvent);
        try {
            Date[] dates = itEvent.getDates();
            StringBuilder horaires = new StringBuilder();
            for (Iterator<Date> iter = Arrays.asList(dates).iterator(); iter.hasNext();) {
                horaires.append(iter.next().getHoraire());
                if (iter.hasNext()) horaires.append(", ");
            }
            return horaires.toString();
        } catch (Exception e) {
            return "";
        }
    }
    
    private static String getMetaDuree(JSONObject jsonEvent) {
        EvenementInfolocale itEvent = InfolocaleEntityUtils.createEvenementInfolocaleFromJsonItem(jsonEvent);
        try {
            return itEvent.getDuree() + " jour(s)"; // TODO : vérifier la nature de la durée sur l'API
        } catch (Exception e) {
            return "";
        }
    }
    
    private static String getMetaTarif(JSONObject jsonEvent) {
        EvenementInfolocale itEvent = InfolocaleEntityUtils.createEvenementInfolocaleFromJsonItem(jsonEvent);
        try {
            return itEvent.getTarif();
        } catch (Exception e) {
            return "";
        }
    }
    
    private static String getMetaPublic(JSONObject jsonEvent) {
        // TODO Auto-generated method stub
        // Voir comment récupérer le public visé
        return null;
    }
    
    private static String getMetaAccessibilite(JSONObject jsonEvent) {
        Channel channel = Channel.getChannel();
        StringBuilder accessibilite = new StringBuilder();
        String separator = ", ";
        try {
            if (jsonEvent.getBoolean(channel.getProperty("jcmsplugin.socle.infolocale.metadata.accessibilite.auditif"))) {
                accessibilite.append(JcmsUtil.glp(channel.getCurrentUserLang(), "jcmsplugin.socle.infolocale.label.accessibilite.auditif"));
            }
        }
        catch (Exception e) {}
        try {
            if (jsonEvent.getBoolean(channel.getProperty("jcmsplugin.socle.infolocale.metadata.accessibilite.mental"))) {
                if (Util.notEmpty(accessibilite.toString())) accessibilite.append(separator);
                accessibilite.append(JcmsUtil.glp(channel.getCurrentUserLang(), "jcmsplugin.socle.infolocale.label.accessibilite.mental"));
            }
        }
        catch (Exception e) {}
        try {
            if (jsonEvent.getBoolean(channel.getProperty("jcmsplugin.socle.infolocale.metadata.accessibilite.visuel"))) {
                if (Util.notEmpty(accessibilite.toString())) accessibilite.append(separator);
                accessibilite.append(JcmsUtil.glp(channel.getCurrentUserLang(), "jcmsplugin.socle.infolocale.label.accessibilite.visuel"));
            }
        }
        catch (Exception e) {}
        try {
            if (jsonEvent.getBoolean(channel.getProperty("jcmsplugin.socle.infolocale.metadata.accessibilite.moteur"))) {
                if (Util.notEmpty(accessibilite.toString())) accessibilite.append(separator);
                accessibilite.append(JcmsUtil.glp(channel.getCurrentUserLang(), "jcmsplugin.socle.infolocale.label.accessibilite.moteur"));
            }
        }
        catch (Exception e) {}
        return accessibilite.toString();
    }
    
    private static String getMetaGroupeTheme(JSONObject jsonEvent, String id) {
        // TODO Auto-generated method stub
        // Voir comment récupérer le libellé de la thématique parent
        return null;
    }
    
    private static String getMetaTheme(JSONObject jsonEvent, String id) {
        Channel channel = Channel.getChannel();
        try {
            JSONArray thematiquesArrays = jsonEvent.getJSONArray(channel.getProperty("jcmsplugin.socle.infolocale.metadata.thematiques"));
            for (int count = 0; count < thematiquesArrays.length(); count++) {
                if (thematiquesArrays.getJSONObject(count).getString(channel.getProperty("jcmsplugin.socle.infolocale.metadata.thematiqueId")).equals(id)) {
                    return thematiquesArrays.getJSONObject(count).getString(channel.getProperty("jcmsplugin.socle.infolocale.metadata.libelle"));
                }
            }
        } catch (JSONException e) {
            return "";
        }
        
        return "";
    }
    
}