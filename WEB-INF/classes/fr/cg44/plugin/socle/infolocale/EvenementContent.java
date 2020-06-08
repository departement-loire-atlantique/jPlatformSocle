package fr.cg44.plugin.socle.infolocale;

import com.jalios.jcms.Content;
import com.jalios.jcms.Publication;

import fr.cg44.plugin.socle.infolocale.entities.Contact;
import fr.cg44.plugin.socle.infolocale.entities.DateInfolocale;
import fr.cg44.plugin.socle.infolocale.entities.Genre;
import fr.cg44.plugin.socle.infolocale.entities.Langue;
import fr.cg44.plugin.socle.infolocale.entities.Lieu;
import fr.cg44.plugin.socle.infolocale.entities.Photo;

/**
 * Classe utilisée pour le type de contenu EvenementInfolocale afin d'ajouter champs et getters/setters
 * @author lchoquet
 *
 */
public class EvenementContent extends Content {
    
    String titreLibre;
    String texteCourt;
    String texteLong;
    String urlBilletterie;
    Lieu lieu;
    Contact[] contacts;
    DateInfolocale[] dates;
    Genre genre;
    Photo[] photos;
    Langue[] langues;
    String titre;
    String metadata1;
    String metadata2;
    
    public EvenementContent() {}
    
    public EvenementContent(Publication paramPublication) {
      super(paramPublication);
    }
    
    public EvenementContent(Content paramContent) {
      super(paramContent);
    }
    
    public void setId(int id) {
        this.setId("INFOLOCALE_" + Integer.toString(id));
    }
    
    public String getTitreLibre() {
      return titreLibre;
    }

    public void setTitreLibre(String titreLibre) {
      this.titreLibre = titreLibre;
    }

    public String getTexteCourt() {
      return texteCourt;
    }

    public void setTexteCourt(String texteCourt) {
      this.texteCourt = texteCourt;
    }

    public String getTexteLong() {
      return texteLong;
    }

    public void setTexteLong(String texteLong) {
      this.texteLong = texteLong;
    }

    public String getUrlBilletterie() {
      return urlBilletterie;
    }

    public void setUrlBilletterie(String urlBilletterie) {
      this.urlBilletterie = urlBilletterie;
    }

    public Lieu getLieu() {
        return lieu;
    }
    public void setLieu(Lieu lieu) {
        this.lieu = lieu;
    }
    public Contact[] getContacts() {
        return contacts;
    }
    public void setContacts(Contact[] contacts) {
        this.contacts = contacts;
    }
    public DateInfolocale[] getDates() {
        return dates;
    }
    public void setDates(DateInfolocale[] dates) {
        this.dates = dates;
    }
    public Genre getGenre() {
        return genre;
    }
    public void setGenre(Genre genre) {
        this.genre = genre;
    }
    public Photo[] getPhotos() {
        return photos;
    }
    public void setPhotos(Photo[] photos) {
        this.photos = photos;
    }
    public Langue[] getLangues() {
        return langues;
    }
    public void setLangues(Langue[] langues) {
        this.langues = langues;
    }
    
    public void setTitre(String titre) {
        this.setTitle(titre);
        this.titre = titre;
    }
    
    public String getTitre() {
        return this.titre;
    }

    public String getMetadata1() {
        return metadata1;
    }

    public void setMetadata1(String metadata1) {
        this.metadata1 = metadata1;
    }

    public String getMetadata2() {
        return metadata2;
    }

    public void setMetadata2(String metadata2) {
        this.metadata2 = metadata2;
    }
}