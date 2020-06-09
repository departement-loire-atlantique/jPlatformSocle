package fr.cg44.plugin.socle.infolocale.entities;

/**
 * Dossier de presse, comprenant des champs qui faciliteront le traitement en back et en front
 * @author lchoquet
 *
 */
public class DossierPresse  {
  
  String url;
  String filename;
  String format;
  
  
  
  public String getUrl() {
    return url;
  }
  public void setUrl(String url) {
    this.url = url;
  }
  public String getFilename() {
    return filename;
  }
  public void setFilename(String filename) {
    this.filename = filename;
  }
  public String getFormat() {
    return format;
  }
  public void setFormat(String format) {
    this.format = format;
  }
  
}