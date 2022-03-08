<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ page import="com.jalios.jcms.taglib.card.*" %><%
%><%@ include file='/jcore/media/mediaTemplateInit.jspf' %><%

if (data == null) {
  return;
}

FichePublication pub = (FichePublication) data;

%>

<section class='ds44-card ds44-js-card ds44-card--horizontal <%= Util.notEmpty(request.getParameter("wysiwygEmbed")) ? "large-w50" : ""%>'>
  <div class="ds44-flex-container ds44-flex-valign-center">
    <div class="ds44-card__section--horizontal--img">
     <ds:figurePicture pub="<%= pub %>" image="<%= pub.getImagePrincipale() %>" format="mobile" pictureCss="ds44-container-imgRatio ds44-container-imgRatio--A4" imgCss="ds44-w100 ds44-imgRatio"
     width='<%= channel.getIntegerProperty("jcmsplugin.socle.image.magazine.tuile.width", 0) %>' height='<%= channel.getIntegerProperty("jcmsplugin.socle.image.magazine.tuile.height", 0) %>'/>
   </div>
    <div class="ds44-card__section--horizontal">
      <p class="ds44-card__title"><a href="<%= pub.getDisplayUrl(userLocale) %>" class="ds44-card__globalLink"><%= pub.getTitle(userLang) %></a></p>
      <jalios:if predicate="<%= Util.notEmpty(pub.getTitreUne(userLang)) %>">
        <p class="ds44-cardFile"><%= pub.getTitreUne(userLang) %></p>
      </jalios:if>

      <i class="icon icon-arrow-right ds44-cardArrow" aria-hidden="true"></i>

    </div>
  </div>
</section>