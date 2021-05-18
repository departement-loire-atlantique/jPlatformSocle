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

// Permet de crypter les paramètres pour validation de la newsletter
StringEncrypter des3Encrypter = new StringEncrypter(StringEncrypter.DESEDE_ENCRYPTION_SCHEME, channel.getProperty("jcmsplugin.socle.newsletter.encrypt.key"));

String mail = request.getParameter("newletters-mail[value]");
String[] segment = parametersMap.get("segmentid");


// Ajout de la date d'expiration du lien de validation
Calendar calendar = Calendar.getInstance();
calendar.add(Calendar.HOUR_OF_DAY, Integer.parseInt(channel.getProperty("jcmsplugin.socle.footer.newsletter.expire.heure")));
parametersMap.put("expire", new String[]{Long.toString(calendar.getTimeInMillis())});


// Encode les paramètres de la requete  pour la génération du lien de validation
Map<String, String[]> parametersEncodeMap = new HashMap<String, String[]>();
String decodeParamsQuery = URLUtils.getQueryString(parametersMap);
parametersEncodeMap.put("confirm", new String[]{des3Encrypter.encrypt(decodeParamsQuery)});

// Création du lien de confirmation pour la newsletter
String redirectUrl = channel.getUrl() + "plugins/SoclePlugin/jsp/portal/valideAbonnementNewsletter.jsp";
String url = URLUtils.buildUrl(redirectUrl, parametersEncodeMap);

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
	msg.setFrom(channel.getProperty("jcmsplugin.socle.form.newsletter.mailTo"));
	msg.setTo(mail);
		
	msg.setSubject(glp("jcmsplugin.socle.newletter.mail.confirme.sujet"));
	//msg.setContentHtml(glp("jcmsplugin.socle.newletter.mail.confirme.content", new String[]{url, mailTheme}));
	HashMap mailParam = new HashMap<String, String>();
	mailParam.put("mailUrl", url);
	mailParam.put("mailTheme", mailTheme);
	msg.setContentHtmlFromJsp("/plugins/SoclePlugin/jsp/forms/doValideMail.jsp", loggedMember, userLang, mailParam, null);
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