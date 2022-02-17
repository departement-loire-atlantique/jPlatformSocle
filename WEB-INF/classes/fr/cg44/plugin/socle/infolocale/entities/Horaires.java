package fr.cg44.plugin.socle.infolocale.entities;

import java.util.ArrayList;

import com.jalios.jcms.Data;

public class Horaires extends Data {
    
    int jourId; // Lundi = 1
    String jourLibelle; // potentiellement inutile car multilingue possible sur le site ?
    ArrayList<String> plagesDebut;
    ArrayList<String> plagesFin;
    
    public int getJourId() {
        return jourId;
    }
    public void setJourId(int jourId) {
        this.jourId = jourId;
    }
    public String getJourLibelle() {
        return jourLibelle;
    }
    public void setJourLibelle(String jourLibelle) {
        this.jourLibelle = jourLibelle;
    }
    public ArrayList<String> getPlagesDebut() {
        return plagesDebut;
    }
    public void setPlagesDebut(ArrayList<String> plagesDebut) {
        this.plagesDebut = plagesDebut;
    }
    public ArrayList<String> getPlagesFin() {
        return plagesFin;
    }
    public void setPlagesFin(ArrayList<String> plagesFin) {
        this.plagesFin = plagesFin;
    }

}