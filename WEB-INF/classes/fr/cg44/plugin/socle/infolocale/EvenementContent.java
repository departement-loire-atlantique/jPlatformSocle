package fr.cg44.plugin.socle.infolocale;

import com.jalios.jcms.Content;
import com.jalios.jcms.Publication;

import fr.cg44.plugin.socle.infolocale.entities.Contact;
import fr.cg44.plugin.socle.infolocale.entities.Date;
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
    
    Lieu lieu;
    Contact[] contacts;
    Date[] dates;
    Genre genre;
    Photo[] photos;
    Langue[] langues;
    String titre;
    String metadata_1;
    String metadata_2;
    
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
    public Date[] getDates() {
        return dates;
    }
    public void setDates(Date[] dates) {
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

    public String getMetadata_1() {
        return metadata_1;
    }

    public void setMetadata_1(String metadata_1) {
        this.metadata_1 = metadata_1;
    }

    public String getMetadata_2() {
        return metadata_2;
    }

    public void setMetadata_2(String metadata_2) {
        this.metadata_2 = metadata_2;
    }
}