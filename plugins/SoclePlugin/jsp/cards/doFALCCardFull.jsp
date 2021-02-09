<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<%@ include file='/jcore/doInitPage.jspf'%>
<%
%><%@ page import="com.jalios.jcms.taglib.card.*"%>
<%
%><%@ include file='/jcore/media/mediaTemplateInit.jspf'%>
<%
%>
<%

if (data == null) {
  return;
}

FALC pub = (FALC) data;


//recuperation de l'url de l'icone pour l'encadre
String urlImage = SocleUtils.getDescriptionChampCategorie(pub.getIcone(loggedMember), userLang, channel.getCategory("$jcmsplugin.socle.falc.icone.cat"));

String titreEncadre = Util.notEmpty(pub.getTitreEncadre(userLang)) ? pub.getTitreEncadre(userLang) : glp("jcmsplugin.socle.falc.titre");
%>

<section class='ds44-box <%= pub.getStyleDeFonds().equalsIgnoreCase("none") ? "" : pub.getStyleDeFonds() %>'>
	<div class="ds44-innerBoxContainer">
		<div class="ds44-flex-container ds44-flex-valign-center">
			<img src='<%= urlImage %>' alt="">
			<div class="ds44-card__section--horizontal">
				<p role="heading" aria-level="2" class="ds44-box-heading"><%= titreEncadre %></p>
			</div>
		</div>
		<jalios:if predicate="<%= Util.notEmpty(pub.getContenuEncadre(userLang)) %>">
			<jalios:wysiwyg><%= pub.getContenuEncadre(userLang) %></jalios:wysiwyg>
		</jalios:if>
	</div>
</section>