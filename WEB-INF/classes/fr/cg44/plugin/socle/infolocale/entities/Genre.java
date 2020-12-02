package fr.cg44.plugin.socle.infolocale.entities;

import com.jalios.jcms.Data;

/**
 * Classe Bean de l'objet Genre retourné par l'API infolocale
 * @author lchoquet
 *
 */
public class Genre extends Data {
    
    String genreId;
    String categorie;
    String libelle;
    String urlPhotoLarge;
    
    public String getGenreId() {
        return genreId;
    }
    public void setGenreId(String genreId) {
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
    public String getUrlPhotoLarge() {
      return urlPhotoLarge;
    }
    public void setUrlPhotoLarge(String urlPhotoLarge) {
      this.urlPhotoLarge = urlPhotoLarge;
    }
    
}