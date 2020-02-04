package fr.cg44.plugin.socle.infolocale.entities;

import com.jalios.jcms.Data;

public class Evenement extends Data {
    
    int evenementId;
    int organismeId;
    String organismeNom;
    String titre;
    String titreSlug;
    String description;
    String dateCreation;
    String dateModification;
    Lieu lieu;
    String tarif;
    Date[] dates;
    String dateString;
    Contact[] contacts;
    String reservation;
    String provider;
    Genre genre;
    Photo[] photos;
    int ageMinimum = 0;
    int ageMaximum = 0;
    int duree = 0;
    boolean mentionEvenementComplet = false;
    boolean mentionAccessibleHandicapAuditif = false;
    boolean mentionAccessibleHandicapVisuel = false;
    boolean mentionAccessibleHandicapMental = false;
    boolean mentionAccessibleHandicapMoteur = false;
    Langue[] langues;
    
    public int getEvenementId() {
        return evenementId;
    }
    public void setEvenementId(int evenementId) {
        this.evenementId = evenementId;
    }
    public int getOrganismeId() {
        return organismeId;
    }
    public void setOrganismeId(int organismeId) {
        this.organismeId = organismeId;
    }
    public String getOrganismeNom() {
        return organismeNom;
    }
    public void setOrganismeNom(String organismeNom) {
        this.organismeNom = organismeNom;
    }
    public String getTitre() {
        return titre;
    }
    public void setTitre(String titre) {
        this.titre = titre;
    }
    public String getTitreSlug() {
        return titreSlug;
    }
    public void setTitreSlug(String titreSlug) {
        this.titreSlug = titreSlug;
    }
    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }
    public String getDateCreation() {
        return dateCreation;
    }
    public void setDateCreation(String dateCreation) {
        this.dateCreation = dateCreation;
    }
    public String getDateModification() {
        return dateModification;
    }
    public void setDateModification(String dateModification) {
        this.dateModification = dateModification;
    }
    public Lieu getLieu() {
        return lieu;
    }
    public void setLieu(Lieu lieu) {
        this.lieu = lieu;
    }
    public String getTarif() {
        return tarif;
    }
    public void setTarif(String tarif) {
        this.tarif = tarif;
    }
    public Date[] getDates() {
        return dates;
    }
    public void setDates(Date[] dates) {
        this.dates = dates;
    }
    public String getDateString() {
        return dateString;
    }
    public void setDateString(String dateString) {
        this.dateString = dateString;
    }
    public Contact[] getContacts() {
        return contacts;
    }
    public void setContacts(Contact[] contacts) {
        this.contacts = contacts;
    }
    public String getReservation() {
        return reservation;
    }
    public void setReservation(String reservation) {
        this.reservation = reservation;
    }
    public String getProvider() {
        return provider;
    }
    public void setProvider(String provider) {
        this.provider = provider;
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
    public int getAgeMinimum() {
        return ageMinimum;
    }
    public void setAgeMinimum(int ageMinimum) {
        this.ageMinimum = ageMinimum;
    }
    public int getAgeMaximum() {
        return ageMaximum;
    }
    public void setAgeMaximum(int ageMaximum) {
        this.ageMaximum = ageMaximum;
    }
    public int getDuree() {
        return duree;
    }
    public void setDuree(int duree) {
        this.duree = duree;
    }
    public boolean isMentionEvenementComplet() {
        return mentionEvenementComplet;
    }
    public void setMentionEvenementComplet(boolean mentionEvenementComplet) {
        this.mentionEvenementComplet = mentionEvenementComplet;
    }
    public boolean isMentionAccessibleHandicapAuditif() {
        return mentionAccessibleHandicapAuditif;
    }
    public void setMentionAccessibleHandicapAuditif(boolean mentionAccessibleHandicapAuditif) {
        this.mentionAccessibleHandicapAuditif = mentionAccessibleHandicapAuditif;
    }
    public boolean isMentionAccessibleHandicapVisuel() {
        return mentionAccessibleHandicapVisuel;
    }
    public void setMentionAccessibleHandicapVisuel(boolean mentionAccessibleHandicapVisuel) {
        this.mentionAccessibleHandicapVisuel = mentionAccessibleHandicapVisuel;
    }
    public boolean isMentionAccessibleHandicapMental() {
        return mentionAccessibleHandicapMental;
    }
    public void setMentionAccessibleHandicapMental(boolean mentionAccessibleHandicapMental) {
        this.mentionAccessibleHandicapMental = mentionAccessibleHandicapMental;
    }
    public boolean isMentionAccessibleHandicapMoteur() {
        return mentionAccessibleHandicapMoteur;
    }
    public void setMentionAccessibleHandicapMoteur(boolean mentionAccessibleHandicapMoteur) {
        this.mentionAccessibleHandicapMoteur = mentionAccessibleHandicapMoteur;
    }
    public Langue[] getLangues() {
        return langues;
    }
    public void setLangues(Langue[] langues) {
        this.langues = langues;
    }
    
}