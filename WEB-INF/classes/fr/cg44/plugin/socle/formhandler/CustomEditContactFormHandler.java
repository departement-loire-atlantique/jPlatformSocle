// This file has been automatically generated.
// Generation date : Sun Apr 26 14:32:43 CEST 2020
package fr.cg44.plugin.socle.formhandler;
   
   
import java.util.HashMap;
import java.util.HashSet;
import java.util.Set;
import java.util.regex.Pattern;

import com.jalios.jcms.Category;
import com.jalios.jcms.ControllerStatus;
import com.jalios.jcms.Member;
import com.jalios.jcms.Publication;
import com.jalios.jcms.TypeFieldEntry;
import com.jalios.jcms.context.JcmsMessage;
import com.jalios.jcms.context.JcmsMessage.Level;
import com.jalios.jcms.handler.EditFormHandler;
import com.jalios.util.Util;

import generated.ContactForm;
@SuppressWarnings({"unchecked", "unused"})
public class CustomEditContactFormHandler extends EditFormHandler {
   
  protected ContactForm theContent;
  
  public Class<? extends Publication> getPublicationClass() {
    return ContactForm.class;
  }
  
  // ----------------------------------------------------------------------
  // validateBeforeOpContactForm  
  // ----------------------------------------------------------------------
  
  public boolean validateBeforeOp() {
  	if(!op) {
  		return true;
  	}
   if (!super.validateBeforeOp()) {
    return false;
  }
  	// Validation de la saisie
  	boolean isOK = true;
  	StringBuffer messageErreur = new StringBuffer();
  	
  	String nom = (String)getAvailableField("nom");
  	String prenom = (String)getAvailableField("prenom");
  	String mail = (String)getAvailableField("mail");
  	String codePostal = ((String)getAvailableField("codePostal"));
  	String telephone = ((String)getAvailableField("telephone"));
  	Set<Category> sujet = (Set<Category>)getAvailableField("sujet");
  	String message = (String)getAvailableField("message");

  	if(Util.isEmpty(nom)) {
  		isOK = false;
  		addMsg(new JcmsMessage(Level.WARN, "Nom"));
  	}
  	
  	if(Util.isEmpty(prenom)) {
  		isOK = false;
  		addMsg(new JcmsMessage(Level.WARN, "Prenom"));
  	}
  	
  	if(Util.isEmpty(mail)) {
  		isOK = false;
  		addMsg(new JcmsMessage(Level.WARN, "Email"));
  	}
  	
   if (Util.notEmpty(mail)) {
    String regexp = EMAIL_REGEXP;
    boolean correspond = Pattern.matches(regexp, mail);
    if (!correspond) {
    	addMsg(new JcmsMessage(Level.WARN, "Email"));
    }
   }
   
  	if(Util.isEmpty(codePostal)) {
  		isOK = false;
  		addMsg(new JcmsMessage(Level.WARN, "Code postal"));
  	}
  	
   if (Util.notEmpty(codePostal)) {
    String regexp = channel.getProperty("jcmsplugin.socle.regex.postalcode");
    boolean correspond = Pattern.matches(regexp, codePostal);
    if (!correspond) {
    	addMsg(new JcmsMessage(Level.WARN, "Code postal"));
    }
  }

  	if(Util.isEmpty(telephone)) {
  		isOK = false;
  		addMsg(new JcmsMessage(Level.WARN, "Téléphone"));
  	}
  	
   if (Util.notEmpty(telephone)) {
    String regexp = channel.getProperty("jcmsplugin.socle.regex.phone");
    boolean correspond = Pattern.matches(regexp, telephone);
    if (!correspond) {
    	addMsg(new JcmsMessage(Level.WARN, "Téléphone"));
    }
  }

  	if(Util.isEmpty(sujet)) {
  		isOK = false;
  		addMsg(new JcmsMessage(Level.WARN, "Sujet"));
  	} 
  	
  	if(Util.isEmpty(message)) {
  		isOK = false;
  		addMsg(new JcmsMessage(Level.WARN, "Message"));
  	}   
  	
  	if(!isOK) {
  		return false;
  	}
    
    
    Member fdauthor = getAvailableAuthor();
    
    
    return true;
  }
  @Override
  public Object getAvailableField(String field) {
  
    if ("nom".equals(field)) {
      return getAvailableNom();
    }
    
    if ("prenom".equals(field)) {
      return getAvailablePrenom();
    }
    
    if ("mail".equals(field)) {
      return getAvailableMail();
    }
    
    if ("codePostal".equals(field)) {
      return getAvailableCodePostal();
    }
    
    if ("telephone".equals(field)) {
      return getAvailableTelephone();
    }
    
    if ("sujet".equals(field)) {
      return getSujetCatSet();
    }
    
    if ("message".equals(field)) {
      return getAvailableMessage();
    }
    
    return super.getAvailableField(field);
  }
  @Override
  public Object getEnumValues(String field) {
  
    return super.getEnumValues(field);
  }
  @Override
  public Object getEnumLabels(String field, String userLang) {
  
    return super.getEnumLabels(field, userLang);
  }
  // ----------------------------------------------------------------------
  // validateCommonCreateUpdateContactForm  
  // ----------------------------------------------------------------------
  public boolean validateCommonCreateUpdateContactForm() {
    return true;
  }
  
  // ----------------------------------------------------------------------
  // Create
  // ----------------------------------------------------------------------
  public boolean validateCreate() throws java.io.IOException {
    if (!super.validateCreate()) {
      return false;
    }
    if (!validateCommonCreateUpdateContactForm()) {
      return false;
    }
    return true;
  }
  
  // ----------------------------------------------------------------------
  // Update
  // ----------------------------------------------------------------------
  public boolean validateUpdate() throws java.io.IOException {
    if (!super.validateUpdate()) {
      return false;
    }
    
    if (!validateCommonCreateUpdateContactForm()) {
      return false;
    }
    
    return true;
  }
 
  // ----------------------------------------------------------------------
  // Next
  // ----------------------------------------------------------------------
  protected boolean validateNext() throws java.io.IOException {
   if (!super.validateNext()) {
      return false;
    }
	return true;
  }
  // ----------------------------------------------------------------------
  // Previous
  // ----------------------------------------------------------------------
  protected boolean validatePrevious() throws java.io.IOException {
  	if (!super.validatePrevious()) {
      return false;
    }
	return true;
  }
  // ----------------------------------------------------------------------
  // Finish
  // ----------------------------------------------------------------------
  protected boolean validateFinish() throws java.io.IOException {
  	if (!super.validateFinish()) {
      return false;
    }
	return true;
  }
  // ----------------------------------------------------------------------
  // setFields
  // ----------------------------------------------------------------------
  public void setFields(Publication data) {
    super.setFields(data);
    ContactForm obj = (ContactForm)data;
    obj.setNom(getAvailableNom());
    obj.setPrenom(getAvailablePrenom());
    obj.setMail(getAvailableMail());
    obj.setCodePostal(getAvailableCodePostal());
    obj.setTelephone(getAvailableTelephone());
    obj.setMessage(getAvailableMessage());
  }
  
  public void setId(String  v) {
    if (channel.getData(v) instanceof ContactForm) {
      super.setId(v);
      theContent = (ContactForm)publication;
    } else {
      super.setId(null);
      theContent = null;
    }
  }
  
   
  // ----------------------------------------------------------------------
  // nom
  // ----------------------------------------------------------------------  
  protected TypeFieldEntry nomTFE = channel.getTypeFieldEntry(ContactForm.class, "nom", true);
  protected String nom = channel.getTypeFieldEntry(ContactForm.class, "nom", true).getDefaultTextString();
  public void setNom(String[] v) {
    nom = getMonolingualValue(nomTFE, v);
  }
  public String getAvailableNom() {
    if (theContent != null && isFieldMissing("nom")) {
     String objectValue = theContent.getNom();
      return objectValue;
    }
    return nom;
  }
  
    
  
   
  // ----------------------------------------------------------------------
  // prenom
  // ----------------------------------------------------------------------  
  protected TypeFieldEntry prenomTFE = channel.getTypeFieldEntry(ContactForm.class, "prenom", true);
  protected String prenom = channel.getTypeFieldEntry(ContactForm.class, "prenom", true).getDefaultTextString();
  public void setPrenom(String[] v) {
    prenom = getMonolingualValue(prenomTFE, v);
  }
  public String getAvailablePrenom() {
    if (theContent != null && isFieldMissing("prenom")) {
     String objectValue = theContent.getPrenom();
      return objectValue;
    }
    return prenom;
  }
  
    
  
   
  // ----------------------------------------------------------------------
  // mail
  // ----------------------------------------------------------------------  
  protected TypeFieldEntry mailTFE = channel.getTypeFieldEntry(ContactForm.class, "mail", true);
  protected String mail = channel.getTypeFieldEntry(ContactForm.class, "mail", true).getDefaultTextString();
  public void setMail(String[] v) {
    mail = getMonolingualValue(mailTFE, v);
  }
  public String getAvailableMail() {
    if (theContent != null && isFieldMissing("mail")) {
     String objectValue = theContent.getMail();
      return objectValue;
    }
    return mail;
  }
  
    
  
   
  // ----------------------------------------------------------------------
  // codePostal
  // ----------------------------------------------------------------------  
  protected TypeFieldEntry codePostalTFE = channel.getTypeFieldEntry(ContactForm.class, "codePostal", true);
  protected String codePostal = channel.getTypeFieldEntry(ContactForm.class, "codePostal", true).getDefaultTextString();
  public void setCodePostal(String[] v) {
    codePostal = getMonolingualValue(codePostalTFE, v);
  }
  public String getAvailableCodePostal() {
    if (theContent != null && isFieldMissing("codePostal")) {
     String objectValue = theContent.getCodePostal();
      return objectValue;
    }
    return codePostal;
  }
  
    
  
   
  // ----------------------------------------------------------------------
  // telephone
  // ----------------------------------------------------------------------  
  protected TypeFieldEntry telephoneTFE = channel.getTypeFieldEntry(ContactForm.class, "telephone", true);
  protected String telephone = channel.getTypeFieldEntry(ContactForm.class, "telephone", true).getDefaultTextString();
  public void setTelephone(String[] v) {
    telephone = getMonolingualValue(telephoneTFE, v);
  }
  public String getAvailableTelephone() {
    if (theContent != null && isFieldMissing("telephone")) {
     String objectValue = theContent.getTelephone();
      return objectValue;
    }
    return telephone;
  }
  
    
  
   
  // ----------------------------------------------------------------------
  // message
  // ----------------------------------------------------------------------  
  protected TypeFieldEntry messageTFE = channel.getTypeFieldEntry(ContactForm.class, "message", true);
  protected String message = channel.getTypeFieldEntry(ContactForm.class, "message", true).getDefaultTextString();
  public void setMessage(String[] v) {
    message = getMonolingualValue(messageTFE, v);
  }
  public String getAvailableMessage() {
    if (theContent != null && isFieldMissing("message")) {
     String objectValue = theContent.getMessage();
      return objectValue;
    }
    return message;
  }
  
    
  
  
  public void setSujet(String[] v) {
    updateCids(v);
  }
  public Category getSujetRoot() {
    return channel.getCategory("$jcmsplugin.socle.form.contactform.sujet.root");
  }  
    
  public Set<Category> getSujetCatSet() {
    Category rootCat = getSujetRoot();
    if (rootCat == null) {
      return Util.emptyTreeSet();
    }
    Set<Category> set = new HashSet<>(rootCat.getDescendantSet());
    set.add(rootCat);
    return Util.interSet(getCategorySet(null), set);
  }
  
 
   
 
}