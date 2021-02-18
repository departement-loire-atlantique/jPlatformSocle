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
String urlImage = SocleUtils.getDescriptionChampCategorie(pub.getIcone(loggedMember), userLang, "");
%>

<section class='ds44-box <%= pub.getStyleDeFonds().equalsIgnoreCase("none") ? "" : pub.getStyleDeFonds() %>'>
	<div class="ds44-innerBoxContainer">
		<jalios:if predicate="<%= Util.notEmpty(urlImage) || Util.notEmpty(titreEncadre) %>">
			<div class="ds44-flex-container ds44-flex-valign-center">
				<jalios:if predicate="<%= Util.notEmpty(urlImage) %>">
					<img src='<%= urlImage %>' alt="">
				</jalios:if>
				<jalios:if predicate="<%= Util.notEmpty(titreEncadre) %>">
					<div class="ds44-card__section--horizontal">
						<p role="heading" aria-level="2" class="ds44-box-heading"><%= titreEncadre %></p>
					</div>
				</jalios:if>
			</div>
		</jalios:if>
		<jalios:if predicate="<%= Util.notEmpty(pub.getContenuEncadre(userLang)) %>">
			<jalios:wysiwyg><%= pub.getContenuEncadre(userLang) %></jalios:wysiwyg>
		</jalios:if>
	</div>
</section>