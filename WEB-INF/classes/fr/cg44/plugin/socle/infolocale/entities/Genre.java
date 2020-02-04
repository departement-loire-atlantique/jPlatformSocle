package fr.cg44.plugin.socle.infolocale.entities;

import com.jalios.jcms.Data;

public class Genre extends Data {
    
    int genreId;
    String categorie;
    String libelle;
    
    public int getGenreId() {
        return genreId;
    }
    public void setGenreId(int genreId) {
        this.genreId = genreId;
    }
    public String getCategorie() {
        return categorie;
    }
    public void setCategorie(String categorie) {
        this.categorie = categorie;
    }
    public String getLibelle() {
        return libelle;
    }
    public void setLibelle(String libelle) {
        this.libelle = libelle;
    }
    
}