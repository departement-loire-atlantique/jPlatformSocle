package fr.cg44.plugin.socle.infolocale;

import java.util.List;

import com.jalios.jcms.Content;
import com.jalios.jcms.Publication;

import fr.cg44.plugin.socle.infolocale.entities.Contact;
import fr.cg44.plugin.socle.infolocale.entities.DateHoraires;
import fr.cg44.plugin.socle.infolocale.entities.DateInfolocale;
import fr.cg44.plugin.socle.infolocale.entities.DossierPresse;
import fr.cg44.plugin.socle.infolocale.entities.Genre;
import fr.cg44.plugin.socle.infolocale.entities.Horaires;
import fr.cg44.plugin.socle.infolocale.entities.Langue;
import fr.cg44.plugin.socle.infolocale.entities.Lieu;
import fr.cg44.plugin.socle.infolocale.entities.Photo;
import fr.cg44.plugin.socle.infolocale.entities.Tarif;

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
    DateHoraires[] datesHoraires;
    DateInfolocale[] dates;
    Horaires[] horaires;
    Tarif[] tarifs;
    Genre genre;
    Photo[] photos;
    Langue[] langues;
    List<String> urlVideos;
    List<DossierPresse> dossiersDePresse;
    String titre;
    String metadata1;
    String metadata2;
    String metadataDefaultIcon;
    String metadataDefaultContent;
    String metadataHiddenLabel;
    int indexDate;
    
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
    
    public List<String> getUrlVideos() {
      return urlVideos;
    }

    public void setUrlVideos(List<String> urlVideos) {
      this.urlVideos = urlVideos;
    }

    public List<DossierPresse> getDossiersDePresse() {
      return dossiersDePresse;
    }

    public void setDossiersDePresse(List<DossierPresse> dossiersDePresse) {
      this.dossiersDePresse = dossiersDePresse;
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

    public String getMetadataDefaultIcon() {
      return metadataDefaultIcon;
    }

    public void setMetadataDefaultIcon(String metadataDefaultIcon) {
      this.metadataDefaultIcon = metadataDefaultIcon;
    }

    public String getMetadataDefaultContent() {
      return metadataDefaultContent;
    }

    public void setMetadataDefaultContent(String metadataDefaultContent) {
      this.metadataDefaultContent = metadataDefaultContent;
    }

    public String getMetadataHiddenLabel() {
      return metadataHiddenLabel;
    }

    public void setMetadataHiddenLabel(String metadataHiddenLabel) {
      this.metadataHiddenLabel = metadataHiddenLabel;
    }

    public Tarif[] getTarifs() {
      return tarifs;
    }

    public void setTarifs(Tarif[] tarifs) {
      this.tarifs = tarifs;
    }

    public int getIndexDate() {
      return indexDate;
    }

    public void setIndexDate(int indexDate) {
      this.indexDate = indexDate;
    }

    public Horaires[] getHoraires() {
        return horaires;
    }

    public void setHoraires(Horaires[] horaires) {
        this.horaires = horaires;
    }

    public DateHoraires[] getDatesHoraires() {
        return datesHoraires;
    }

    public void setDatesHoraires(DateHoraires[] datesHoraires) {
        this.datesHoraires = datesHoraires;
    }

    public DateInfolocale[] getDates() {
        return dates;
    }

    public void setDates(DateInfolocale[] dates) {
        this.dates = dates;
    }
    
}