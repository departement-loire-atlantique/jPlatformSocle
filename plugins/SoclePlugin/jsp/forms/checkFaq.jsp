<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%><%
%><%@page import="fr.cg44.plugin.socle.MailUtils"%><%
%><%@page import="fr.cg44.plugin.socle.SocleUtils"%><%
%><%@page import="com.jalios.jcms.JcmsConstants"%><%
%><%@page import="java.util.regex.Pattern"%><%
%><%@page import="com.google.gson.JsonObject"%><%
%><%@page import="com.google.gson.JsonArray"%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ include file="/jcore/portal/doPortletParams.jspf" %><%

String mailto = channel.getProperty("jcmsplugin.socle.contact-faq.default-mail");
String idFaq = request.getParameter("idFaq[value]");
FaqAccueil obj = (FaqAccueil)channel.getPublication(idFaq);

// On regarde si une adresse email est renseignée dans la FAQ
if(Util.notEmpty(obj.getEmailSpecifique())) {
    mailto = obj.getEmailSpecifique();
}

if(Util.notEmpty(request.getAttribute("contactfaq"))) {
    mailto = request.getAttribute("contactfaq").toString();
}

response.setContentType("application/json");

JsonObject jsonObject = new JsonObject();
JsonArray jsonArray = new JsonArray();


// contrôle des données
boolean isOK = true;
// Question
if (Util.isEmpty(request.getParameter("question[value]"))) {
  isOK = false;
  jsonArray.add(glp("jcmsplugin.socle.form.champ-obligatoire", "Question"));
}

// Mail
if (Util.isEmpty(request.getParameter("mail[value]"))) {
 isOK = false;
 jsonArray.add(glp("jcmsplugin.socle.form.champ-obligatoire", "Email"));
}

if (Util.notEmpty(request.getParameter("mail[value]"))) {
 String regexp = JcmsConstants.EMAIL_REGEXP;
 boolean correspond = Pattern.matches(regexp, request.getParameter("mail[value]"));
 if (!correspond) {
  isOK = false;
  jsonArray.add(glp("jcmsplugin.socle.form.champ-invalide", "Email"));
 }
} 
if(isOK){
    // Envoi du mail
    if(MailUtils.envoiMailFAQ(request, mailto)){
        // Retour réponse JSON Success
        jsonObject.addProperty("status", "information");
        jsonObject.addProperty("message", glp("jcmsplugin.socle.form.envoi-succes"));
    }
    else{
      // Retour réponse JSON Erreur envoi
      jsonObject.addProperty("status", "error");
      jsonObject.addProperty("message", glp("jcmsplugin.socle.form.envoi-erreur"));
    }
}
    
else{
  //Retour réponse JSON Erreur formulaire
  jsonObject.addProperty("status", "error");
  jsonObject.addProperty("message", glp("jcmsplugin.socle.form.invalidfields"));
  jsonObject.add("message_list", jsonArray);
}
%>

<%= jsonObject %>
