<%@page import="fr.cg44.plugin.socle.api.google.bean.GooglePlaceBean"%>
<%@page import="fr.cg44.plugin.socle.api.google.GoogleApiManager"%>
<%@ page contentType="text/html; charset=UTF-8" %><%

%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% 
Horaire obj = (Horaire)request.getAttribute(PortalManager.PORTAL_PUBLICATION);

String placeId =  Util.notEmpty(obj.getIdLieu()) ? obj.getIdLieu() : channel.getProperty("jcmsplugin.socle.api.places.google.id");
GooglePlaceBean googlePlace = Util.notEmpty(placeId) ? GoogleApiManager.getGooglePlaceBeanFromId(placeId) : null;

%>


<jalios:if predicate="<%= Util.notEmpty(googlePlace) %>">
   <%= GoogleApiManager.getOpening(googlePlace, obj.getMessageEnCasDabsenceDhoraire(userLang)) %>
</jalios:if>