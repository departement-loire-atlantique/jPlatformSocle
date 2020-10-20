package fr.cg44.plugin.socle.infolocale.entities;

import com.jalios.jcms.Data;

/**
 * Classe Bean de l'objet Tarif retourné par l'API infolocale
 * @author lchoquet
 *
 */
public class Tarif extends Data {
    
   boolean gratuit;
   boolean libre;
   boolean payantNonPrecise;
   boolean payant;
   String payantLibelle;
   String payantMontant;

   public boolean isGratuit() {
    return gratuit;
  }
  public void setGratuit(boolean gratuit) {
    this.gratuit = gratuit;
  }
  public boolean isLibre() {
    return libre;
  }
  public void setLibre(boolean libre) {
    this.libre = libre;
  }
  public boolean isPayantNonPrecise() {
    return payantNonPrecise;
  }
  public void setPayantNonPrecise(boolean payantNonPrecise) {
    this.payantNonPrecise = payantNonPrecise;
  }
  public boolean isPayant() {
    return payant;
  }
  public void setPayant(boolean payant) {
    this.payant = payant;
  }
  public String getPayantLibelle() {
    return payantLibelle;
  }
  public void setPayantLibelle(String payantLibelle) {
    this.payantLibelle = payantLibelle;
  }
  public String getPayantMontant() {
    return payantMontant;
  }
  public void setPayantMontant(String payantMontant) {
    this.payantMontant = payantMontant;
  }
    
}