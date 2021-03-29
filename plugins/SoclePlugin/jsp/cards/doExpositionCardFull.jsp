<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ page import="com.jalios.jcms.taglib.card.*" %>
<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/media/mediaTemplateInit.jspf' %>
<%
	if (data == null) {
		return;
	}
	
	Exposition pub = (Exposition) data;
%>

<ds:card title="<%= pub.getTitle(userLang) %>" 
		imagePath="<%= pub.getImagePrincipale(userLang) %>" 
		alt="<%= pub.getTexteAlternatif(userLang) %>" 
		link="<%= pub.getDisplayUrl(userLocale) %>" 
		format="horizontal" 
		subtitle="<%= pub.getSoustitre(userLang) %>" 
		dark="true" 
		newTab="false" />

