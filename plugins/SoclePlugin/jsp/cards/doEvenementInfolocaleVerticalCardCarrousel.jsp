<%@page import="fr.cg44.plugin.socle.infolocale.InfolocaleMetadataUtils"%>
<%@page import="fr.cg44.plugin.socle.infolocale.entities.DateHoraires"%>
<%@page import="fr.cg44.plugin.socle.infolocale.util.InfolocaleUtil"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ page import="com.jalios.jcms.taglib.card.*" %><%
%><%@ include file='/jcore/media/mediaTemplateInit.jspf' %><%
%><%

if (data == null) {
  return;
}

EvenementInfolocale itEvent = (EvenementInfolocale) data;

DateHoraires currentDisplayedDate = InfolocaleUtil.getClosestDate(itEvent);

String urlPhoto = Util.notEmpty(InfolocaleUtil.getLargestPicture(itEvent)) ? InfolocaleUtil.getLargestPicture(itEvent).getPath() : "s.gif";

%>

<section class="ds44-card ds44-js-card ds44-card--verticalPicture">
    <picture class="ds44-container-imgRatio">
        <img src="<%= urlPhoto %>" alt="" class="ds44-imgRatio">
    </picture>
    <div class="ds44-card__section">
        <%
          String dateIndexParam = Util.notEmpty(itEvent.getIndexDate()) ? "?dateIndex=" + itEvent.getIndexDate() : "";
        %>
        <p class="ds44-card__title"><a href="<%= itEvent.getDisplayUrl(userLocale) %><%= dateIndexParam %>" class="ds44-card__globalLink" tabindex="-1"><%= itEvent.getTitle() %></a> </p>
        <p class="ds44-cardDate"><i class="icon icon-date" aria-hidden="true"></i> <%= InfolocaleUtil.getFullStringFromEventDate(currentDisplayedDate) %></p>
        <%@ include file="../include/doMetadataEventInfolocale.jspf" %>
        <i class="icon icon-arrow-right ds44-cardArrow" aria-hidden="true"></i>
    </div>
</section>