package fr.cg44.plugin.socle.infolocale.entities;

import com.jalios.jcms.Data;

public class Lieu extends Data {
    
    String nom;
    String adresse;
    String longitude;
    String latitude;
    Commune commune;
    
    public String getNom() {
        return nom;
    }
    public void setNom(String nom) {
        this.nom = nom;
    }
    public String getAdresse() {
        return adresse;
    }
    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }
    public String getLongitude() {
        return longitude;
    }
    public void setLongitude(String longitude) {
        this.longitude = longitude;
    }
    public String getLatitude() {
        return latitude;
    }
    public void setLatitude(String latitude) {
        this.latitude = latitude;
    }
    public Commune getCommune() {
        return commune;
    }
    public void setCommune(Commune commune) {
        this.commune = commune;
    }
    
}