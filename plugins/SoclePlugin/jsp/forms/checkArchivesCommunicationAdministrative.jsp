<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%><%
%><%@page import="fr.cg44.plugin.socle.MailUtils"%><%
%><%@page import="fr.cg44.plugin.socle.SocleUtils"%><%
%><%@page import="com.jalios.jcms.JcmsConstants"%><%
%><%@page import="java.util.regex.Pattern"%><%
%><%@page import="com.google.gson.JsonObject"%><%
%><%@page import="com.google.gson.JsonArray"%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ include file="/jcore/portal/doPortletParams.jspf" %><%

response.setContentType("application/json");

JsonObject jsonObject = new JsonObject();
JsonArray jsonArray = new JsonArray();

// Initialisation des variables à enregistrer
String nom = request.getParameter("nom[value]");
String prenom = request.getParameter("prenom[value]");
String administration = request.getParameter("administration[value]");
String direction = request.getParameter("direction[value]");
String service = request.getParameter("service[value]");
String adresse = request.getParameter("adresse[value]");
String complementAdresse = request.getParameter("complementAdresse[value]");
String codePostal = request.getParameter("codePostal[value]");
String ville = request.getParameter("ville[value]");
String telephone = request.getParameter("telephone[value]");
String courriel = request.getParameter("courriel[value]");
String versement = request.getParameter("versement[value]");
String dossier = request.getParameter("dossier[value]");
String natureRecherche = request.getParameter("natureRecherche[value]");
String dateVersement = request.getParameter("form-element-dateVersement[value]");
String dateRetour = request.getParameter("form-element-dateRetour[value]");



// contrôle des données
boolean isOK = true;

if (Util.isEmpty(nom)) {
  isOK = false;
  jsonArray.add(glp("jcmsplugin.socle.form.champ-obligatoire", glp("jcmsplugin.archives.form.communication.nom")));
}
if (Util.isEmpty(prenom)) {
  isOK = false;
  jsonArray.add(glp("jcmsplugin.socle.form.champ-obligatoire", glp("jcmsplugin.archives.form.communication.prenom")));
}
if (Util.isEmpty(administration)) {
  isOK = false;
  jsonArray.add(glp("jcmsplugin.socle.form.champ-obligatoire", glp("jcmsplugin.archives.form.communication.administration")));
}
if (Util.isEmpty(direction)) {
  isOK = false;
  jsonArray.add(glp("jcmsplugin.socle.form.champ-obligatoire", glp("jcmsplugin.archives.form.communication.direction")));
}
if (Util.isEmpty(service)) {
  isOK = false;
  jsonArray.add(glp("jcmsplugin.socle.form.champ-obligatoire", glp("jcmsplugin.archives.form.communication.service")));
}
if (Util.isEmpty(adresse)) {
  isOK = false;
  jsonArray.add(glp("jcmsplugin.socle.form.champ-obligatoire", glp("jcmsplugin.archives.form.communication.adresse")));
}
if (Util.isEmpty(codePostal)) {
  isOK = false;
  jsonArray.add(glp("jcmsplugin.socle.form.champ-obligatoire", glp("jcmsplugin.archives.form.communication.codePostal")));
}
if (Util.isEmpty(ville)) {
  isOK = false;
  jsonArray.add(glp("jcmsplugin.socle.form.champ-obligatoire", glp("jcmsplugin.archives.form.communication.ville")));
}
if (Util.isEmpty(telephone)) {
  isOK = false;
  jsonArray.add(glp("jcmsplugin.socle.form.champ-obligatoire", glp("jcmsplugin.archives.form.communication.telephone")));
}
if (Util.isEmpty(courriel)) {
  isOK = false;
  jsonArray.add(glp("jcmsplugin.socle.form.champ-obligatoire", glp("jcmsplugin.archives.form.communication.courriel")));
}



// Contrôle OK
if(isOK){
    // Enregistrement
    Member opAuthor = channel.getDefaultAdmin();
    
    CommunicationForm form = new CommunicationForm();
    form.setTitle(form.getTypeLabel(userLang));
    form.setNom(nom);
    form.setPrenom(prenom);
    form.setAdministration(administration);
    form.setDirection(direction);
    form.setServiceUnite(service);
    form.setAdresse(adresse);
    form.setComplementDadresse(complementAdresse);
    form.setCodePostal(codePostal);
    form.setVille(ville);
    form.setTelephone(telephone);
    form.setCourriel(courriel);
    form.setNumeroDeVersement(versement);
    form.setNumeroDuDossier(dossier);
    form.setNatureDeLaRecherche(natureRecherche);
    form.setDateDeVersement(dateVersement);
    form.setRetourDuDossierPrevuLe(dateRetour);
    form.setAuthor(opAuthor);
    
    
    // Check and perform the update
    ControllerStatus status = form.checkAndPerformCreate(opAuthor);
    if (!status.isOK()) {
      String msg = status.getMessage(opAuthor.getLanguage());
      logger.error("CommunicationForm - enregistrement impossible : " + msg);
      jsonObject.addProperty("status", "error");
      jsonObject.addProperty("message", glp("jcmsplugin.socle.form.envoi-erreur"));
    }
    
    else{
      // Envoi du mail
      if(! MailUtils.envoiMailCommunicationAdministrativeArchives(nom, prenom, administration, direction, service, adresse, complementAdresse, 
          codePostal, ville, telephone, courriel, versement, dossier, natureRecherche, dateVersement, dateRetour)){
        // Erreur d'envoi de mail. On ne prévient pas l'usager de cette erreur technique.
        logger.error("CommunicationForm : impossible d'envoyer le mail");
      }
      jsonObject.addProperty("status", "information");
      jsonObject.addProperty("message", glp("jcmsplugin.socle.pageutile.envoi-succes"));  
    }
    
}
else{
  //Retour réponse JSON Erreur validation formulaire
  jsonObject.addProperty("status", "error");
  jsonObject.addProperty("message", glp("jcmsplugin.socle.form.invalidfields"));
  jsonObject.add("message_list", jsonArray);
}
%>

<%= jsonObject %>
