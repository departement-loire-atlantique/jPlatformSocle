package fr.cg44.plugin.socle.infolocale.entities;

import com.jalios.jcms.Data;

public class Photo extends Data {
    
    String path;
    String legend;
    String credit;
    
    public String getPath() {
        return path;
    }
    public void setPath(String path) {
        this.path = path;
    }
    public String getLegend() {
        return legend;
    }
    public void setLegend(String legend) {
        this.legend = legend;
    }
    public String getCredit() {
        return credit;
    }
    public void setCredit(String credit) {
        this.credit = credit;
    }
    
}