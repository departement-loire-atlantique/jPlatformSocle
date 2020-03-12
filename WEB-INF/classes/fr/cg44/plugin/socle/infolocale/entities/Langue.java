package fr.cg44.plugin.socle.infolocale.entities;

import com.jalios.jcms.Data;

/**
 * Classe Bean de l'objet Langue retourné par l'API infolocale
 * @author lchoquet
 *
 */
public class Langue extends Data {
    
    String langueId;
    String langueLibelle;
    
    public String getLangueId() {
        return langueId;
    }
    public void setLangueId(String langueId) {
        this.langueId = langueId;
    }
    public String getLangueLibelle() {
        return langueLibelle;
    }
    public void setLangueLibelle(String langueLibelle) {
        this.langueLibelle = langueLibelle;
    }
    
}