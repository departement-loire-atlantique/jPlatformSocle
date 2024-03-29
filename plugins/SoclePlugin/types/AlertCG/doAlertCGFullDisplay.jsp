<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% AlertCG obj = (AlertCG)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%
%><%@ include file='/front/doFullDisplay.jspf' %>
<%@ page import="fr.cg44.plugin.socle.SocleUtils"%>

<%
String titleLink = "";
String lblLink = glp("jcmsplugin.socle.etablissementpersonnesagees.savoirplus");
if (Util.notEmpty(obj.getTexteAlternatifLienBouton())) {
  titleLink = glp("jcmsplugin.socle.savoirplus.link", obj.getTexteAlternatifLienBouton());
} else {
  titleLink = glp("jcmsplugin.socle.savoirplus.link", obj.getTitle());
}

boolean externe = false;
String urlLink = "";
if (Util.notEmpty(obj.getLienInterne())) {
  urlLink = obj.getLienInterne().getDisplayUrl(userLocale);
} else if (Util.notEmpty(obj.getLienExterne())) {
  urlLink = obj.getLienExterne();
  externe = true;
  titleLink = glp("jcmsplugin.socle.lien.nouvelonglet", titleLink);
}

String iconId = SocleUtils.getDescriptionChampCategorie(obj.getIcone(loggedMember), userLang, channel.getCategory("$jcmsplugin.socle.alerte.icone"));
%>

<section class="ds44-alertMsg-container txtcenter">
    <div class="ds44-collapser center">
        <div class="ds44-collapser_element">
            <p role="heading" aria-level="1">
                <button type="button" class="ds44-collapser_button">
                    <div class="h1-like ds44-card__title">
                        <i class="icon <%= iconId %>" aria-hidden="true"></i><%= obj.getTitle(userLang) %>
                    </div>
                    <i class="icon icon-down icon--sizeXL" aria-hidden="true"></i>
                </button>
            </p>
            <div class="ds44-collapser_content">
                <div class="ds44-collapser_content--level2">
                    <jalios:if predicate="<%= Util.notEmpty(obj.getSoustitre(userLang)) %>">
	                   <h2 class="h2-like"><%= obj.getSoustitre(userLang) %></h2>
	                </jalios:if>
                    <jalios:wysiwyg><%= obj.getSummary(userLang) %></jalios:wysiwyg>
                    <jalios:if predicate="<%= Util.notEmpty(urlLink) %>">
	                   <p><a href="<%= urlLink %>" class="ds44-btnStd mts" title="<%= titleLink %>"<%= externe ? " target=\"_blank\"" : "" %>><span class="ds44-btnInnerText"><%= lblLink %></span><i class="icon icon-long-arrow-right" aria-hidden="true"></i></a></p>
	                </jalios:if>
                </div>
            </div>
        </div>
    </div>
</section>