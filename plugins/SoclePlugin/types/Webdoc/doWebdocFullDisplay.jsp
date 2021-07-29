<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%><%
%><% Webdoc obj = (Webdoc)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%
%><% jcmsContext.setPageTitle(obj.getTitle(userLang)); %><%
%><%@ include file='/front/doFullDisplay.jspf' %>

<%

boolean newTab = Util.notEmpty(obj.getLienRetourInterne()) && obj.isOuvertureDansUnNouvelOnglet() || Util.notEmpty(obj.getLienRetourExterne());

%>

<header role="banner" id="topPage">
    <div class="ds44-blocBandeau ds44-header">
        <div class="ds44-flex-container ds44-flex-valign-center" style="padding: 10px 50px;">
            <div class="ds44-colLeft">
                <button type="button" title="Retour au premier niveau du menu de navigation" class="ds44-btn-backOverlay ds44-tmpFirstFocus"><i class="icon icon-arrow-left icon--xlarge" aria-hidden="true"></i><span class="ds44-btnInnerText--bottom">Retour</span></button>
            </div>
            
            <div class="ds44-colRight">
                <a href="index.jsp" class="ds44-logoContainer">
                    <picture class="ds44-logo">  
                        <img class="" src='<%= channel.getProperty("jcmsplugin.socle.site.src.logo") %>' alt='<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.retour.accueil")) %> <%=channel.getName() %>' />
                    </picture>
                </a>
            </div>
        </div>
    </div>
</header>