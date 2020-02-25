<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@page import="com.jalios.jcms.handler.QueryHandler"%><%
%><%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%><%
%><%@page import="com.google.gson.JsonObject"%><%
%><%@page import="com.google.gson.JsonArray"%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
String textSearch = getAlphaNumParameter("insee", "");
String[] tabSearchedFields = new String[]{"facet_city"};

QueryHandler qh = new QueryHandler();
qh.setText(textSearch);
qh.setTypes("City");
qh.setSearchedFields(tabSearchedFields);

Set<City> communeEpci = new HashSet<City>();
City communeRecherchee = (City) (Util.getFirst(qh.getResultSet())); 
if(Util.notEmpty(communeRecherchee)) {
	Category epciDeLaCommune = Util.getFirst(communeRecherchee.getEpci(null));
	communeEpci = epciDeLaCommune.getPublicationSet(City.class, null);	
}

%><% 
%><%= SocleUtils.citiestoJsonArray(communeEpci) %>