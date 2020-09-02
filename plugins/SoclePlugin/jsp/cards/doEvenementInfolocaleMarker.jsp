<%@page import="fr.cg44.plugin.socle.infolocale.util.InfolocaleUtil"%>
<%@page import="fr.cg44.plugin.socle.infolocale.entities.DateInfolocale"%>
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

String metadata1 = Util.notEmpty(request.getAttribute("metadata1")) ? request.getAttribute("metadata1").toString() : null;
String metadata2 = Util.notEmpty(request.getAttribute("metadata2")) ? request.getAttribute("metadata2").toString() : null;
String cssCard = Util.notEmpty(request.getAttribute("cssCard")) ? request.getAttribute("cssCard").toString() : "";

%>

   <div class="ds44-flex-container">
      <div class="ds44-card__section--horizontal ds44-flex-valign-center ds44-flex-align-center">
         <p role="heading" aria-level="3" class="ds44-card__title"><a href="<%= itEvent.getDisplayUrl(userLocale) %>" class="ds44-card__globalLink"><%= itEvent.getTitre() %></a></p>
         <p class="visually-hidden"><%= InfolocaleUtil.getFullStringFromEventDate(currentDisplayedDate) %></p>
         <jalios:if predicate="<%= Util.notEmpty(itEvent.getLieu()) %>">
            <p class="ds44-cardLocalisation"><i class="icon icon-marker" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.adresse") %></span>
               <span class="ds44-iconInnerText"><%= itEvent.getLieu().getCommune().getNom() %></span>
            </p>
         </jalios:if>
         <% String metaCommune = channel.getProperty("jcmsplugin.socle.infolocale.metadata.front.commune"); %>
         <jalios:if predicate="<%= Util.notEmpty(metadata1) && !metadata1.equals(metaCommune) && Util.notEmpty(itEvent.getMetadata1()) %>">
            <p><%= itEvent.getMetadata1() %></p>
         </jalios:if>
         <jalios:if predicate="<%= Util.notEmpty(metadata2) && !metadata2.equals(metaCommune) && Util.notEmpty(itEvent.getMetadata2()) %>">
            <p><%= itEvent.getMetadata2() %></p>
         </jalios:if>
         <span class="visually-hidden"><%= itEvent.getTitre() %></span></a>
      </div>
   </div>
