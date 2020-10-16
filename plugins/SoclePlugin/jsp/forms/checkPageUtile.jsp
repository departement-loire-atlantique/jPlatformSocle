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
boolean pageUtile = false;
String commentaire = request.getParameter("commentaire[value]");
StringBuffer motif = new StringBuffer();
String motifTexte = request.getParameter("bloc-utile-informations-questions[text]");
String id = request.getParameter("id[value]");
Publication pub = channel.getPublication(id);
String emailRedacteur = pub.getAuthor().getEmail();
String titre = pub.getTitle();
String url = request.getParameter("url[value]");
String date = SocleUtils.formatDate("dd/MM/yy HH:mm", new Date());
String emailReponse = request.getParameter("email[value]");

// contrôle des données
boolean isOK = true;

// Réponse "Oui"
if (request.getParameter("utile[value]").equals("true")) {
  pageUtile = true;  
  
}
//Réponse "Non"
else if(request.getParameter("utile[value]").equals("false")) {
  
  if(Util.notEmpty(request.getParameter("bloc-utile-informations-questions[value][0]"))){
    motif.append(request.getParameter("bloc-utile-informations-questions[value][0]"));
    motif.append("|");
  }
  if(Util.notEmpty(request.getParameter("bloc-utile-informations-questions[value][1]"))){
    motif.append(request.getParameter("bloc-utile-informations-questions[value][1]"));
    motif.append("|");
  }
  if(Util.notEmpty(request.getParameter("bloc-utile-informations-questions[value][2]"))){
    motif.append(request.getParameter("bloc-utile-informations-questions[value][2]"));
    motif.append("|");
  }
  
  if (Util.isEmpty(motif.toString())) {
    isOK = false;
    jsonArray.add(glp("jcmsplugin.socle.form.champ-obligatoire", "Case à cocher"));
  }
}

// Contrôle OK
if(isOK){
    // Enregistrement
    Member opAuthor = channel.getDefaultAdmin();
    
    PageUtileForm pageUtileForm = new PageUtileForm();
    pageUtileForm.setTitle("Page utile");
    pageUtileForm.setUtile(pageUtile);
    pageUtileForm.setCommentaire(commentaire);
    pageUtileForm.setIdContenu(id);
    pageUtileForm.setUrl(url);
    pageUtileForm.setAuthor(opAuthor);
    
    if(Util.notEmpty(motif)) {
      pageUtileForm.setMotif(motif.toString());
    }
    
    // Check and perform the update
    ControllerStatus status = pageUtileForm.checkAndPerformCreate(opAuthor);
    if (!status.isOK()) {
      String msg = status.getMessage(opAuthor.getLanguage());
      logger.error("Page utile : impossible d'enregistrer l'avis depuis l'URL " + url + " : " + msg);
      jsonObject.addProperty("status", "error");
      jsonObject.addProperty("message", glp("jcmsplugin.socle.form.envoi-erreur"));
    }
    
    else{
      // Envoi du mail
      if(! MailUtils.envoiMailPageUtile(pageUtile, titre, url, commentaire, date, motifTexte, emailRedacteur, emailReponse)){
        // Erreur d'envoi de mail. On ne prévient pas l'usager de cette erreur technique.
        logger.error("Page utile : impossible d'envoyer le mail depuis l'URL " + url);
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
