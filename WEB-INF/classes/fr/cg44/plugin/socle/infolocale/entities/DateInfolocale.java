package fr.cg44.plugin.socle.infolocale.entities;

import com.jalios.jcms.Data;

/**
 * Classe Bean de l'objet Date retourné par l'API infolocale
 * @author lchoquet
 *
 */
public class DateInfolocale extends Data {
    
    String debut;
    String fin;
    String horaire;
    
    public String getDebut() {
        return debut;
    }
    public void setDebut(String debut) {
        this.debut = debut;
    }
    public String getFin() {
        return fin;
    }
    public void setFin(String fin) {
        this.fin = fin;
    }
    public String getHoraire() {
        return horaire;
    }
    public void setHoraire(String horaire) {
        this.horaire = horaire;
    }
    
}