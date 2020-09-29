package fr.cg44.plugin.socle.infolocale.entities;

import com.jalios.jcms.Data;

/**
 * Classe Bean de l'objet Photo retourné par l'API infolocale
 * @author lchoquet
 *
 */
public class Photo extends Data {
    
    String path;
    String legend;
    String credit;
    String format;
    int width;
    int height;
    double ratio;
    
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
    public int getWidth() {
      return width;
    }
    public void setWidth(int width) {
      this.width = width;
    }
    public int getHeight() {
      return height;
    }
    public void setHeight(int height) {
      this.height = height;
    }
    public double getRatio() {
      return ratio;
    }
    public void setRatio(double ratio) {
      this.ratio = ratio;
    }
    public String getFormat() {
      return format;
    }
    public void setFormat(String format) {
      this.format = format;
    }
    
}