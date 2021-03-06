package fr.cg44.plugin.socle.infolocale.entities;

import com.jalios.jcms.Data;

/**
 * Classe Bean de l'objet Contact retourné par l'API infolocale
 * @author lchoquet
 *
 */
public class Contact extends Data {
    
    Integer typeId;
    String type;
    String telephone1;
    String telephone2;
    String url;
    String email;
    
    public Integer getTypeId() {
      return typeId;
    }
    public void setTypeId(Integer typeId) {
      this.typeId = typeId;
    }
    public String getType() {
        return type;
    }
    public void setType(String type) {
        this.type = type;
    }
    public String getTelephone1() {
        return telephone1;
    }
    public void setTelephone1(String telephone1) {
        this.telephone1 = telephone1;
    }
    public String getTelephone2() {
        return telephone2;
    }
    public void setTelephone2(String telephone2) {
        this.telephone2 = telephone2;
    }
    public String getUrl() {
        return url;
    }
    public void setUrl(String url) {
        this.url = url;
    }
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    
}