package fr.cg44.plugin.socle.infolocale.entities;

import java.util.ArrayList;

import com.jalios.jcms.Data;

public class Horaires extends Data {
    
    int jourId; // Lundi = 1, Mardi = 2, etc
    String jourLibelle;
    ArrayList<String> plagesDebut;
    ArrayList<String> plagesFin;
    boolean isFerme;
    boolean isEmpty;
    
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
    public boolean isFerme() {
        return isFerme;
    }
    public void setFerme(boolean isFerme) {
        this.isFerme = isFerme;
    }
    public boolean isEmpty() {
      return isEmpty;
    }
    public void setEmpty(boolean isEmpty) {
      this.isEmpty = isEmpty;
    }

}