<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%><%
%><%@page import="fr.cg44.plugin.archives.ArchivesMailUtils"%><%
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
String adresse = request.getParameter("adresse[value]");
String complementAdresse = request.getParameter("complementAdresse[value]");
String codePostal = request.getParameter("codePostal[value]");
String ville = request.getParameter("ville[value]");
String telephone = request.getParameter("telephone[value]");
String courriel = request.getParameter("courriel[value]");
String anneeJugement = request.getParameter("anneeJugement[value]");
String dateJugement = request.getParameter("dateJugement[value]");
String lieuJugement = request.getParameter("lieuJugement[value]");
String nomPersonne1 = request.getParameter("nomPersonne1[value]");
String prenomPersonne1 = request.getParameter("prenomPersonne1[value]");
String nomPersonne2 = request.getParameter("nomPersonne2[value]");
String prenomPersonne2 = request.getParameter("prenomPersonne2[value]");
String motifJugement = request.getParameter("motifJugement[value]");
String autreMotifJugement = request.getParameter("autreMotifJugement[value]");
String motivations = request.getParameter("motivations[value]");

// contrôle des données
boolean isOK = true;

if (Util.isEmpty(nom)) {
  isOK = false;
  jsonArray.add(glp("jcmsplugin.socle.form.champ-obligatoire", glp("jcmsplugin.archives.form.nom")));
}
if (Util.isEmpty(prenom)) {
  isOK = false;
  jsonArray.add(glp("jcmsplugin.socle.form.champ-obligatoire", glp("jcmsplugin.archives.form.prenom")));
}
if (Util.isEmpty(adresse)) {
  isOK = false;
  jsonArray.add(glp("jcmsplugin.socle.form.champ-obligatoire", glp("jcmsplugin.archives.form.adresse")));
}
if (Util.isEmpty(codePostal)) {
  isOK = false;
  jsonArray.add(glp("jcmsplugin.socle.form.champ-obligatoire", glp("jcmsplugin.archives.form.codePostal")));
}
if (Util.isEmpty(ville)) {
  isOK = false;
  jsonArray.add(glp("jcmsplugin.socle.form.champ-obligatoire", glp("jcmsplugin.archives.form.ville")));
}
if (Util.isEmpty(telephone)) {
  isOK = false;
  jsonArray.add(glp("jcmsplugin.socle.form.champ-obligatoire", glp("jcmsplugin.archives.form.telephone")));
}
if (Util.isEmpty(courriel)) {
  isOK = false;
  jsonArray.add(glp("jcmsplugin.socle.form.champ-obligatoire", glp("jcmsplugin.archives.form.courriel")));
}
if (Util.isEmpty(lieuJugement)) {
  isOK = false;
  jsonArray.add(glp("jcmsplugin.socle.form.champ-obligatoire", glp("jcmsplugin.archives.form.lieuJugement")));
}
if (Util.isEmpty(nomPersonne1)) {
  isOK = false;
  jsonArray.add(glp("jcmsplugin.socle.form.champ-obligatoire", glp("jcmsplugin.archives.form.nomPersonne1")));
}
if (Util.isEmpty(prenomPersonne1)) {
  isOK = false;
  jsonArray.add(glp("jcmsplugin.socle.form.champ-obligatoire", glp("jcmsplugin.archives.form.prenomPersonne1")));
}
if (Util.isEmpty(motifJugement)) {
  isOK = false;
  jsonArray.add(glp("jcmsplugin.socle.form.champ-obligatoire", glp("jcmsplugin.archives.form.motifJugement")));
}
if (Util.isEmpty(motivations)) {
  isOK = false;
  jsonArray.add(glp("jcmsplugin.socle.form.champ-obligatoire", glp("jcmsplugin.archives.form.motivations")));
}
if (motifJugement.equals("Autre") && Util.isEmpty(autreMotifJugement)) {
  isOK = false;
  jsonArray.add(glp("jcmsplugin.archives.form.ctrl.motifJugement"));
}
if (Util.isEmpty(anneeJugement) && Util.isEmpty(dateJugement)) {
  isOK = false;
  jsonArray.add(glp("jcmsplugin.archives.form.ctrl.datesJugement"));
}

// Contrôle OK
if(isOK){
    // Enregistrement
    Member opAuthor = channel.getDefaultAdmin();
    
    RechercheJugementForm form = new RechercheJugementForm();
    form.setTitle(form.getTypeLabel(userLang));
    form.setNom(nom);
    form.setPrenom(prenom);
    form.setAdresse(adresse);
    form.setComplementDadresse(complementAdresse);
    form.setCodePostal(codePostal);
    form.setVille(ville);
    form.setTelephone(telephone);
    form.setCourriel(courriel);
    form.setAnneeJugement(anneeJugement);
    form.setDateJugement(dateJugement);
    form.setLieuJugement(lieuJugement);
    form.setNomPersonne1(nomPersonne1);
    form.setPrenomPersonne1(prenomPersonne1);
    form.setNomPersonne2(nomPersonne2);
    form.setPrenomPersonne2(prenomPersonne2);
    form.setMotifJugement(motifJugement);
    form.setAutreMotifJugement(autreMotifJugement);
    form.setMotivations(motivations);
        
    form.setAuthor(opAuthor);
    
    // Check and perform the update
    ControllerStatus status = form.checkAndPerformCreate(opAuthor);
    if (!status.isOK()) {
      String msg = status.getMessage(opAuthor.getLanguage());
      logger.error("RechercheJugementForm - enregistrement impossible : " + msg);
      jsonObject.addProperty("status", "error");
      jsonObject.addProperty("message", glp("jcmsplugin.socle.form.envoi-erreur"));
    }
    
    else{
      // Envoi du mail
      if(! ArchivesMailUtils.envoiMailRechercheJugementArchives(form)){
        // Erreur d'envoi de mail. On ne prévient pas l'usager de cette erreur technique.
        logger.error("RechercheJugementForm : impossible d'envoyer le mail");
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
