package fr.cg44.plugin.socle.infolocale.entities;

import com.jalios.jcms.Data;

/**
 * Classe Bean de l'objet Commune retourné par l'API infolocale
 * @author lchoquet
 *
 */
public class Commune extends Data {
    
    String Insee;
    String nom;
    String slug;
    String departement;
    String latitude;
    String longitude;
    String codePostal;
    
    public String getInsee() {
        return Insee;
    }
    public void setInsee(String insee) {
        Insee = insee;
    }
    public String getNom() {
        return nom;
    }
    public void setNom(String nom) {
        this.nom = nom;
    }
    public String getSlug() {
        return slug;
    }
    public void setSlug(String slug) {
        this.slug = slug;
    }
    public String getDepartement() {
        return departement;
    }
    public void setDepartement(String departement) {
        this.departement = departement;
    }
    public String getLatitude() {
        return latitude;
    }
    public void setLatitude(String latitude) {
        this.latitude = latitude;
    }
    public String getLongitude() {
        return longitude;
    }
    public void setLongitude(String longitude) {
        this.longitude = longitude;
    }
    public String getCodePostal() {
        return codePostal;
    }
    public void setCodePostal(String codePostal) {
        this.codePostal = codePostal;
    }
    
}