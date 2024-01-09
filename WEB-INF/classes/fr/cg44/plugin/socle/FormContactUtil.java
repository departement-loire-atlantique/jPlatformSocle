package fr.cg44.plugin.archives;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.jalios.jcms.Channel;
import com.jalios.jcms.ControllerStatus;
import com.jalios.jcms.Form;
import com.jalios.jcms.JcmsUtil;
import com.jalios.jcms.Member;
import com.jalios.util.Util;

import fr.cg44.plugin.socle.MailUtils;
import fr.cg44.plugin.socle.SocleUtils;
import generated.ContactFormArcheo;
import generated.RechercheJugementForm;

public class FormContactUtil {
  private static Channel channel = Channel.getChannel();
  private static final Logger logger = Logger.getLogger(FormContactUtil.class);
  
  public static RechercheJugementForm getTmpForm(HttpServletRequest request) {
    RechercheJugementForm form = new RechercheJugementForm();
    form.setTitle(form.getTypeLabel(channel.getCurrentUserLang()));
    form.setNom(request.getParameter("nom[value]"));
    form.setPrenom(request.getParameter("prenom[value]"));
    form.setAdresse(request.getParameter("adresse[value]"));
    form.setComplementDadresse(request.getParameter("complementAdresse[value]"));
    form.setCodePostal(request.getParameter("codePostal[value]"));
    form.setVille(request.getParameter("ville[value]"));
    form.setTelephone(request.getParameter("telephone[value]"));
    form.setCourriel(request.getParameter("courriel[value]"));
    form.setAnneeJugement(request.getParameter("anneeJugement[value]"));
    form.setDateJugement(request.getParameter("dateJugement[value]"));
    form.setLieuJugement(request.getParameter("lieuJugement[value]"));
    form.setNomPersonne1(request.getParameter("nomPersonne1[value]"));
    form.setPrenomPersonne1(request.getParameter("prenomPersonne1[value]"));
    form.setNomPersonne2(request.getParameter("nomPersonne2[value]"));
    form.setPrenomPersonne2(request.getParameter("prenomPersonne2[value]"));
    form.setMotifJugement(request.getParameter("motifJugement[value]"));
    form.setAutreMotifJugement(request.getParameter("autreMotifJugement[value]"));
    form.setMotivations(request.getParameter("motivations[value]"));
    return form;
  }
  
  public static ContactFormArcheo getTmpFormArcheo(HttpServletRequest request) {
    ContactFormArcheo form = new ContactFormArcheo();
    form.setTitle(form.getTypeLabel(channel.getCurrentUserLang()));
    form.setNom(request.getParameter("nom[value]"));
    form.setPrenom(request.getParameter("prenom[value]"));
    form.setMail(request.getParameter("mail[value]"));
    form.setStructure(request.getParameter("structure[value]"));
    //form.setSujet
    form.setMessage(request.getParameter("message[value]"));
    form.setUtilisationEnvisagee(request.getParameter("utilisationEnvisagee[value]"));
    form.setNumeroDinventaireDeLoeuvre(request.getParameter("numeroDinventaireDeLoeuvre[value]"));
    form.setIdentifiantMedia(request.getParameter("identifiantMedia[value]"));
    return form;
  }
  
  /**
   * Save form or send an error message
   * @param jsonObject
   * @param jsonArray
   * @param form
   * @param isOK
   */
  public static void saveForm(JsonObject jsonObject, JsonArray jsonArray, Form form) {
    if(formIsOK(jsonArray, form)){
        // Enregistrement
        Member opAuthor = channel.getDefaultAdmin();           
        form.setAuthor(opAuthor);
        // Check and perform the update
        ControllerStatus status = form.checkAndPerformCreate(opAuthor);
        if (!status.isOK()) {
          String msg = status.getMessage(opAuthor.getLanguage());
          logger.error("RechercheJugementForm - enregistrement impossible : " + msg);
          jsonObject.addProperty("status", "error");
          jsonObject.addProperty("message", glp("jcmsplugin.socle.form.envoi-erreur"));
        } else {
          // Envoi du mail
          if(!envoiMailArchives(form)){
            // Erreur d'envoi de mail. On ne prévient pas l'usager de cette erreur technique.
            logger.error("RechercheJugementForm : impossible d'envoyer le mail");
          }
          jsonObject.addProperty("status", "information");
          jsonObject.addProperty("message", glp("jcmsplugin.socle.pageutile.envoi-succes"));  
        }       
    } else {
      //Retour réponse JSON Erreur validation formulaire
      jsonObject.addProperty("status", "error");
      jsonObject.addProperty("message", glp("jcmsplugin.socle.form.invalidfields"));
      jsonObject.add("message_list", jsonArray);
    }
  }

  private static boolean envoiMailArchives(Form form) {
    if(form instanceof RechercheJugementForm) {
      return envoiMailArchives((RechercheJugementForm)form);
    }
    if(form instanceof ContactFormArcheo) {
      return envoiMailArchives((ContactFormArcheo)form);
    }
    return false;
  }

  private static boolean formIsOK(JsonArray jsonArray, Form form) {
    if(form instanceof RechercheJugementForm) {
      return formIsOK(jsonArray, (RechercheJugementForm)form);
    }
    if(form instanceof ContactFormArcheo) {
      return formIsOK(jsonArray, (ContactFormArcheo)form);
    }
    return false;
  }

  /**
   * Save form or send an error message
   * @param jsonObject
   * @param jsonArray
   * @param form
   * @param isOK
   */
  public static void saveForm(JsonObject jsonObject, JsonArray jsonArray, RechercheJugementForm form) {
    if(formIsOK(jsonArray, form)){
        // Enregistrement
        Member opAuthor = channel.getDefaultAdmin();           
        form.setAuthor(opAuthor);
        // Check and perform the update
        ControllerStatus status = form.checkAndPerformCreate(opAuthor);
        if (!status.isOK()) {
          String msg = status.getMessage(opAuthor.getLanguage());
          logger.error("RechercheJugementForm - enregistrement impossible : " + msg);
          jsonObject.addProperty("status", "error");
          jsonObject.addProperty("message", glp("jcmsplugin.socle.form.envoi-erreur"));
        } else {
          // Envoi du mail
          if(!envoiMailArchives(form)){
            // Erreur d'envoi de mail. On ne prévient pas l'usager de cette erreur technique.
            logger.error("RechercheJugementForm : impossible d'envoyer le mail");
          }
          jsonObject.addProperty("status", "information");
          jsonObject.addProperty("message", glp("jcmsplugin.socle.pageutile.envoi-succes"));  
        }       
    } else {
      //Retour réponse JSON Erreur validation formulaire
      jsonObject.addProperty("status", "error");
      jsonObject.addProperty("message", glp("jcmsplugin.socle.form.invalidfields"));
      jsonObject.add("message_list", jsonArray);
    }
  }
  
  /**
   * Save form or send an error message
   * @param jsonObject
   * @param jsonArray
   * @param form
   * @param isOK
   */
  public static void saveFormContactArcheo(JsonObject jsonObject, JsonArray jsonArray, ContactFormArcheo form) {
    if(formIsOK(jsonArray, form)){
        // Enregistrement
        Member opAuthor = channel.getDefaultAdmin();           
        form.setAuthor(opAuthor);
        // Check and perform the update
        ControllerStatus status = form.checkAndPerformCreate(opAuthor);
        if (!status.isOK()) {
          String msg = status.getMessage(opAuthor.getLanguage());
          logger.error("RechercheJugementForm - enregistrement impossible : " + msg);
          jsonObject.addProperty("status", "error");
          jsonObject.addProperty("message", glp("jcmsplugin.socle.form.envoi-erreur"));
        } else {
          // Envoi du mail
          if(!envoiMailArchives(form)){
            // Erreur d'envoi de mail. On ne prévient pas l'usager de cette erreur technique.
            logger.error("RechercheJugementForm : impossible d'envoyer le mail");
          }
          jsonObject.addProperty("status", "information");
          jsonObject.addProperty("message", glp("jcmsplugin.socle.pageutile.envoi-succes"));  
        }       
    } else {
      //Retour réponse JSON Erreur validation formulaire
      jsonObject.addProperty("status", "error");
      jsonObject.addProperty("message", glp("jcmsplugin.socle.form.invalidfields"));
      jsonObject.add("message_list", jsonArray);
    }
  }

  /**
   * Add error message if necessary
   * @param jsonArray
   * @param form
   * @return
   */
  private static boolean formIsOK(JsonArray jsonArray, RechercheJugementForm form) {
    boolean isOK = true;
    String prefixe = "jcmsplugin.archives.form.";
    if (Util.isEmpty(form.getNom())) {
      isOK = false;
      jsonArray.add(glpOblig(prefixe+"nom"));
    }
    if (Util.isEmpty(form.getPrenom())) {
      isOK = false;
      jsonArray.add(glpOblig(prefixe+"prenom"));
    }
    if (Util.isEmpty(form.getAdresse())) {
      isOK = false;
      jsonArray.add(glpOblig(prefixe+"adresse"));
    }
    if (Util.isEmpty(form.getCodePostal())) {
      isOK = false;
      jsonArray.add(glpOblig(prefixe+"codePostal"));
    }
    if (Util.isEmpty(form.getVille())) {
      isOK = false;
      jsonArray.add(glpOblig(prefixe+"ville"));
    }
    if (Util.isEmpty(form.getTelephone())) {
      isOK = false;
      jsonArray.add(glpOblig(prefixe+"telephone"));
    }
    if (Util.isEmpty(form.getCourriel())) {
      isOK = false;
      jsonArray.add(glpOblig(prefixe+"courriel"));
    }
    if (Util.isEmpty(form.getLieuJugement())) {
      isOK = false;
      jsonArray.add(glpOblig(prefixe+"lieuJugement"));
    }
    if (Util.isEmpty(form.getNomPersonne1())) {
      isOK = false;
      jsonArray.add(glpOblig(prefixe+"nomPersonne1"));
    }
    if (Util.isEmpty(form.getPrenomPersonne1())) {
      isOK = false;
      jsonArray.add(glpOblig(prefixe+"prenomPersonne1"));
    }
    if (Util.isEmpty(form.getMotifJugement())) {
      isOK = false;
      jsonArray.add(glpOblig(prefixe+"motifJugement"));
    }
    if (Util.isEmpty(form.getMotivations())) {
      isOK = false;
      jsonArray.add(glpOblig(prefixe+"motivations"));
    }
    if (form.getMotifJugement().equals("Autre") && Util.isEmpty(form.getAutreMotifJugement())) {
      isOK = false;
      jsonArray.add(glp(prefixe+"ctrl.motifJugement"));
    }
    if (Util.isEmpty(form.getAnneeJugement()) && Util.isEmpty(form.getDateJugement())) {
      isOK = false;
      jsonArray.add(glp(prefixe+"ctrl.datesJugement"));
    }
    return isOK;
  }
  
  /**
   * Add error message if necessary
   * @param jsonArray
   * @param form
   * @return
   */
  private static boolean formIsOK(JsonArray jsonArray, ContactFormArcheo form) {
    boolean isOK = true;
    String prefixe = "jcmsplugin.archives.form.contact.archeo.";
    if (Util.isEmpty(form.getNom())) {
      isOK = false;
      jsonArray.add(glpOblig(prefixe+"nom"));
    }
    if (Util.isEmpty(form.getPrenom())) {
      isOK = false;
      jsonArray.add(glpOblig(prefixe+"prenom"));
    }
    if (Util.isEmpty(form.getMail())) {
      isOK = false;
      jsonArray.add(glpOblig(prefixe+"mail"));
    }
    if (Util.isEmpty(form.getStructure())) {
      isOK = false;
      jsonArray.add(glpOblig(prefixe+"structure"));
    }
    if (Util.isEmpty(form.getMessage())) {
      isOK = false;
      jsonArray.add(glpOblig(prefixe+"message"));
    }
    if (Util.isEmpty(form.getUtilisationEnvisagee())) {
      isOK = false;
      jsonArray.add(glpOblig(prefixe+"utilisationEnvisagee"));
    }
    if (Util.isEmpty(form.getNumeroDinventaireDeLoeuvre())) {
      isOK = false;
      jsonArray.add(glpOblig(prefixe+"numeroInventaireOeuvre"));
    }
    if (Util.isEmpty(form.getIdentifiantMedia())) {
      isOK = false;
      jsonArray.add(glpOblig(prefixe+"identifiantMedia"));
    }
    return isOK;
  }

  private static String glp(String prop) {
    return JcmsUtil.glpd(prop);
  } 
  
  private static String glpOblig(String prop) {
    return JcmsUtil.glp(channel.getCurrentUserLang(), "jcmsplugin.socle.form.champ-obligatoire", glp(prop));
  }   
  
  /**
   * Envoi de l'email du formulaire de communication administrative (site Archives)
   */
  private static boolean envoiMailArchives(String jsp, String formName, String propObjet, ArrayList<String> listeEmailCC, HashMap<Object, Object> parametersMap) {
    String objet = JcmsUtil.glpd(propObjet);
    boolean result = false;
    String date = SocleUtils.formatDate("dd/MM/yy HH:mm", new Date());
    parametersMap.put("date", date);
    // Destinataire / emetteur
    String emailTo = channel.getProperty("jcmsplugin.archives.form.mailTo");
    String emailFrom = channel.getProperty("jcmsplugin.archives.form.from");

    if (Util.notEmpty(emailFrom) && Util.notEmpty(emailTo)) {
      try {
        MailUtils.sendMail(objet, null, emailFrom, emailTo, listeEmailCC, null, jsp, parametersMap);
        result = true;
      } catch (Exception e) {
        result = false;
        logger.error(formName + " - Erreur lors de l'envoi du mail : " + e.getMessage());
      }
    } else {
      result = false;
      logger.error(formName + " - Paramètres d'envois (emetteur / destinataire) non définis.");
    }
    return result;
  }
  
  /**
   * Envoi de l'email du formulaire de recherche de jugement (site Archives)
   */
  public static boolean envoiMailArchives(RechercheJugementForm form) {
    String jsp = "/plugins/SoclePlugin/jsp/mail/formulaireArchivesRechercheJugementTemplate.jsp";
    
    // Contenu
    HashMap<Object, Object> parametersMap = new HashMap<Object, Object>();
    parametersMap.put("nom", form.getNom());
    parametersMap.put("prenom", form.getPrenom());
    parametersMap.put("adresse", form.getAdresse());
    parametersMap.put("complementAdresse", form.getComplementDadresse());
    parametersMap.put("codePostal", form.getCodePostal());
    parametersMap.put("ville", form.getVille());
    parametersMap.put("telephone", form.getTelephone());
    parametersMap.put("courriel", form.getCourriel());
    parametersMap.put("anneeJugement", form.getAnneeJugement());
    parametersMap.put("dateJugement", form.getDateJugement());
    parametersMap.put("lieuJugement", form.getLieuJugement());
    parametersMap.put("nomPersonne1", form.getNomPersonne1());
    parametersMap.put("prenomPersonne1", form.getPrenomPersonne1());
    parametersMap.put("nomPersonne2", form.getNomPersonne2());
    parametersMap.put("prenomPersonne2", form.getPrenomPersonne2());
    parametersMap.put("motifJugement", form.getMotifJugement());
    parametersMap.put("autreMotifJugement", form.getAutreMotifJugement());
    parametersMap.put("motivations", form.getMotivations());
    
    // CC
    ArrayList<String> listeEmailCC = new ArrayList<>();
    if(Util.notEmpty(form.getCourriel())){
      listeEmailCC.add(form.getCourriel());
    }    
    return envoiMailArchives(jsp, "RechercheJugementForm", "jcmsplugin.archives.email.jugement.objet", 
        listeEmailCC, parametersMap);   
  }
  
  /**
   * Envoi de l'email du formulaire de contact archéologie
   */
  public static boolean envoiMailArchives(ContactFormArcheo form) {
    String jsp = "/plugins/SoclePlugin/jsp/mail/formulaireArchivesRechercheJugementTemplate.jsp";
    
    // Contenu
    HashMap<Object, Object> parametersMap = new HashMap<Object, Object>();
    parametersMap.put("nom", form.getNom());
    parametersMap.put("prenom", form.getPrenom());
    parametersMap.put("structure", form.getStructure());
    //parametersMap.put("sujet", form.get());
    parametersMap.put("message", form.getMessage());
    parametersMap.put("utilisationEnvisagee", form.getUtilisationEnvisagee());
    parametersMap.put("numeroDinventaireDeLoeuvre", form.getNumeroDinventaireDeLoeuvre());
    parametersMap.put("identifiantMedia", form.getIdentifiantMedia());

    // CC
    ArrayList<String> listeEmailCC = new ArrayList<>();
    if(Util.notEmpty(form.getMail())){
      listeEmailCC.add(form.getMail());
    }    
    return envoiMailArchives(jsp, "ContactFormArcheo", "jcmsplugin.archives.email.ContactFormArcheo.objet", 
        listeEmailCC, parametersMap);   
  }
}
