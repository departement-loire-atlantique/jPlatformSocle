<%@page import="javax.mail.MessagingException"%>
<%@page import="fr.cg44.plugin.socle.mailjet.MailjetManager"%>
<%@page import="com.jalios.jcms.mail.MailMessage"%>
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

Map<String, String[]> parametersMap = SocleUtils.getFacetsParameters(request);

// Permet de crypter l'email pour validation de la newsletter
StringEncrypter des3Encrypter = new StringEncrypter(StringEncrypter.DESEDE_ENCRYPTION_SCHEME, channel.getProperty("jcmsplugin.socle.newsletter.encrypt.key"));

String mail = request.getParameter("newletters-mail[value]");
String[] segment = parametersMap.get("segmentid");

// Le mail est encododé pour la génération du lien de validation
// Ne pas utiliser newletters-mail car sinon le mail encodé sera enregistré comme email dans le formulaire de newsletter de la page de validation
parametersMap.remove("newletters-mail");
parametersMap.put("newletters-mail-encrypt", new String[]{des3Encrypter.encrypt(mail)});

String redirectUrl = channel.getUrl() + "plugins/SoclePlugin/jsp/portal/valideAbonnementNewsletter.jsp";
String url = URLUtils.buildUrl(redirectUrl, parametersMap);

%>

<jalios:buffer name="mailTheme">
    <ul>
        <jalios:foreach array="<%= segment %>" name="itCatId" type="String">
            <%
            Category itCat = channel.getCategory(itCatId);
            %>
            <jalios:if predicate="<%= Util.notEmpty(itCat) %>">
                <li><%= itCat.getName(userLang) %></li>
            </jalios:if>
        </jalios:foreach>
    </ul>
</jalios:buffer>

<%

Boolean mailStatusOk = channel.isMailEnabled();

try { 
	MailMessage msg = new MailMessage("Newsletter");
	msg.setFrom(channel.getDefaultEmail());
	msg.setTo(mail);
		
	msg.setSubject(glp("jcmsplugin.socle.newletter.mail.confirme.sujet"));
	msg.setContentHtml(glp("jcmsplugin.socle.newletter.mail.confirme.content", new String[]{url, mailTheme}));
	msg.send();	
}catch (MessagingException e) {
    mailStatusOk = false;
}


if(mailStatusOk) {
  jsonObject.addProperty("status", "information");
  jsonObject.addProperty("message", glp("jcmsplugin.socle.newletter.valide-email"));  
}else {
  jsonObject.addProperty("status", "error");
  jsonObject.addProperty("message", glp("jcmsplugin.socle.form.envoi-erreur"));  
}


%>

<%= jsonObject %>