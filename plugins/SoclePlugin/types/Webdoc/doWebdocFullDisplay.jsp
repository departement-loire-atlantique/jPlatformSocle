<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ page import="fr.cg44.plugin.seo.SEOUtils"%><%
%><%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%><%
%><% Webdoc obj = (Webdoc)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%
%><% jcmsContext.setPageTitle(obj.getTitle(userLang)); %><%
%><%@ include file='/front/doFullDisplay.jspf' %>

<%

boolean newTab = Util.notEmpty(obj.getLienRetourInterne()) && obj.getOuvertureDansUnNouvelOnglet() || Util.notEmpty(obj.getLienRetourExterne());
String href = Util.notEmpty(obj.getLienRetourInterne()) ? obj.getLienRetourInterne() : Util.notEmpty(obj.getLienRetourExterne()) ? obj.getLienRetourExterne() : "#";
%>

<header role="banner" id="topPage">
    <div class="ds44-blocBandeau ds44-header">
        <div class="ds44-flex-container ds44-flex-valign-center" style="padding: 10px 50px;">
            <div class="ds44-colLeft">
                <a href="<%= href %>" alt='<%= Util.notEmpty(obj.getAltLien()) ? obj.getAltLien() : "" %>' <%= newTab ? "target='blank'" : "" %>>
                <button type="button" title='<%= Util.notEmpty(obj.getAltLien()) ? obj.getAltLien() : glp("jcmsplugin.socle.retour") %>' class="ds44-btn-backOverlay ds44-tmpFirstFocus"><i class="icon icon-arrow-left icon--xlarge" aria-hidden="true"></i><span class="ds44-btnInnerText--bottom"><%= glp("jcmsplugin.socle.retour") %></span></button>
                </a>
                <div class="ds44-menuBtn" style="position: absolute; top: 25px; left: 110px;"><%= glp("jcmsplugin.socle.sites-applis.institutionnel.label") %></div>
            </div>
            
            <div class="ds44-colRight" style="flex: revert;">
                <a href="index.jsp" class="ds44-logoContainer">
                    <picture class="ds44-logo">  
                        <img class="" style="margin-top: 15px;" src='<%= channel.getProperty("jcmsplugin.socle.site.src.logo") %>' alt='<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.retour.accueil", SEOUtils.getSiteName())) %>' />
                    </picture>
                </a>
            </div>
        </div>
    </div>
</header>

<main>
    <iframe width="100%" height="100%" frameborder="0" style="position: absolute; top: 0px; right: 0px; bottom: 0px; left: 0px; padding-top: 35px;" src="<%= obj.getUrlIframe() %>"/>
</main>