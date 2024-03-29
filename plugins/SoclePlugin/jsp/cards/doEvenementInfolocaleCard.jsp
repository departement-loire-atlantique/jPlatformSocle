<%@page import="fr.cg44.plugin.socle.infolocale.entities.DateInfolocale"%>
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

DateInfolocale currentDisplayedDate = InfolocaleUtil.getClosestDate(itEvent);

String cssCard = Util.notEmpty(request.getAttribute("cssCard")) ? request.getAttribute("cssCard").toString() : "";

%>

<section class='ds44-card ds44-card--horizontal <%= cssCard %>'>
   <div class="ds44-flex-container">
      <jalios:if predicate="<%= Util.notEmpty(currentDisplayedDate) %>">
        <jalios:select>
            <jalios:if predicate="<%= InfolocaleUtil.infolocaleDateIsSingleDay(currentDisplayedDate) %>">
               <div class="ds44-card__dateContainer ds44-flex-container ds44-flex-align-center" aria-hidden="true">
                  <p>
                     <span class="ds44-cardDateNumber">
                     <%= InfolocaleUtil.getDayOfMonthLabel(currentDisplayedDate.getDebut()) %>
                     </span>
                     <span class="ds44-cardDateMonth">
                     <%= InfolocaleUtil.getMonthLabel(currentDisplayedDate.getDebut(), true) %>
                     </span>
                  </p>
               </div>
            </jalios:if>
            <jalios:default>
               <div class="ds44-card__dateContainer ds44-flex-container ds44-flex-align-center ds44-two-dates" aria-hidden="true">
                  <p>
                     <span class="ds44-cardDateNumber">
                     <%= InfolocaleUtil.getDayOfMonthLabel(currentDisplayedDate.getDebut()) %>
                     </span>
                     <span class="ds44-cardDateMonth">
                     <%= InfolocaleUtil.getMonthLabel(currentDisplayedDate.getDebut(), true) %>
                     </span>
                  </p>
                  <i class="icon icon-down" aria-hidden="true"></i>
                  <p>
                     <span class="ds44-cardDateNumber">
                     <%= InfolocaleUtil.getDayOfMonthLabel(currentDisplayedDate.getFin()) %>
                     </span>
                     <span class="ds44-cardDateMonth">
                     <%= InfolocaleUtil.getMonthLabel(currentDisplayedDate.getFin(), true) %>
                     </span>
                  </p>
               </div>
            </jalios:default>
         </jalios:select>
      </jalios:if>
      <div class="ds44-card__section--horizontal ds44-flex-valign-center ds44-flex-align-center">
         <%
         String dateIndexParam = Util.notEmpty(itEvent.getIndexDate()) ? "?dateIndex=" + itEvent.getIndexDate() : "";
         %>
         <p class="ds44-card__title"><a href="<%= itEvent.getDisplayUrl(userLocale) %><%= dateIndexParam %>" class="ds44-card__globalLink"><%= itEvent.getTitre() %></a></p>
         <p class="visually-hidden"><%= InfolocaleUtil.getFullStringFromEventDate(currentDisplayedDate) %></p>
         <%@ include file="../include/doMetadataEventInfolocale.jspf" %>
         <a href="<%= itEvent.getDisplayUrl(userLocale) %><%= dateIndexParam %>" tabindex="-1" aria-hidden="true" data-a11y-exclude="true"><i class="icon icon-arrow-right ds44-cardArrow" aria-hidden="true"></i>
         <span class="visually-hidden"><%= itEvent.getTitre() %></span></a>
      </div>
   </div>
</section>