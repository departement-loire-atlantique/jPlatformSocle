package fr.cg44.plugin.socle.infolocale.entities;

import java.util.ArrayList;
import java.util.Date;

import com.jalios.jcms.Data;

public class DateHoraires extends Data {
    
    Date date;
    ArrayList<String> horairesDebut;
    ArrayList<String> horairesFin;
    
    public Date getDate() {
        return date;
    }
    public void setDate(Date date) {
        this.date = date;
    }
    public ArrayList<String> getHorairesDebut() {
        return horairesDebut;
    }
    public void setHorairesDebut(ArrayList<String> horairesDebut) {
        this.horairesDebut = horairesDebut;
    }
    public ArrayList<String> getHorairesFin() {
        return horairesFin;
    }
    public void setHorairesFin(ArrayList<String> horairesFin) {
        this.horairesFin = horairesFin;
    }  

}