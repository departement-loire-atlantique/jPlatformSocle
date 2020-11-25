<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ page import="com.jalios.jcms.taglib.card.*" %><%
%><%@ include file='/jcore/media/mediaTemplateInit.jspf' %><%

if (data == null) {
  return;
}

Publication pub = (Publication) data;
%>

<%@include file="tuileCommon.jsp" %>

<%
// Génération de la vignette
try {
  urlImage = (String) pub.getFieldValue("imageCarree");
 } catch(Exception e) {}
if (Util.isEmpty(urlImage)) {
  try {
   urlImage = (String) pub.getFieldValue("imageMobile");
  } catch(Exception e) {}
 }
 if (Util.isEmpty(urlImage)) {
     try {
      urlImage = (String) pub.getFieldValue("imagePrincipale");
     } catch(Exception e) {}
 }
 if (Util.isEmpty(urlImage)) {
     try {
      urlImage = (String) pub.getFieldValue("imageBandeau");
     } catch(Exception e) {}
 }
 if (Util.notEmpty(urlImage)) {
     urlImage = SocleUtils.getUrlOfFormattedImageCarree(urlImage);
 }
 
 String altImage = (String) pub.getFieldValue("texteAlternatif");
 if(Util.isEmpty(altImage)) altImage = JcmsUtil.glp(userLang, "jcmsplugin.socle.illustration");
 altImage = HttpUtil.encodeForHTMLAttribute(altImage);
%>

<section class="ds44-card ds44-js-card ds44-card--horizontal <%=styleContext%> <%= isSmall ? "ds44-tiny-reducedFont" : ""%>">
    <div class="ds44-flex-container ds44-flex-valign-center">
        <jalios:if predicate="<%= Util.notEmpty(urlImage) %>">
            <div class="ds44-card__section--horizontal--img<%= isSmall ? "--dim110" : "" %>">
                <picture class="ds44-container-imgRatio ds44-container-imgRatio--carre">
                    <img class="ds44-imgRatio" src="<%= urlImage %>" alt='<%= altImage %>'>
                </picture>
            </div>
        </jalios:if>
        <div class="ds44-card__section--horizontal">
            <p class="ds44-card__title" role="heading" aria-level="3">
                <%
                    String altText = (String) pub.getFieldValue("texteAlternatif");
                    if(Util.notEmpty(altText)) {
                        if(Util.notEmpty(pub.getFieldValue("lienExterne"))) altText = glp("jcmsplugin.socle.lien.nouvelonglet", altText);
                        titleAttr = " title=\"" + HttpUtil.encodeForHTMLAttribute(altText) + "\"";
                    }
                %>
                <a class="ds44-card__globalLink" href="<%= urlPub %>" <%=titleAttr%> <%=targetAttr%>>
                    <%= pub.getTitle() %>
                </a>
            </p>
            <jalios:if predicate="<%= isDossier %>">
	            <%
	            Dossier tmpDossier = (Dossier) pub;
	            %>
	            <jalios:if predicate="<%= Util.notEmpty(tmpDossier.getDate()) %>">
	                <p class='ds44-cardDate'>
	                     <span class="ds44-iconInnerText"><%= SocleUtils.formatDate("dd/MM/yy", tmpDossier.getDate()) %></span>
	                </p>
	            </jalios:if>
	        </jalios:if>
            <jalios:if predicate="<%= isDoc %>">
                <p class="ds44-cardFile"><%= fileType %> - <%= fileSize %></p>
            </jalios:if>
            <i class="icon icon-arrow-right ds44-cardArrow" aria-hidden="true"></i>
        </div>
    </div>
</section>