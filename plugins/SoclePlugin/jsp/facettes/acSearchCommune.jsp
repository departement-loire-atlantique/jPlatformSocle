<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@page import="com.jalios.jcms.handler.QueryHandler"%><%
%><%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%><%
%><%@page import="com.google.gson.JsonObject"%><%
%><%@page import="com.google.gson.JsonArray"%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
response.setContentType("application/json");

String textSearch = getStringParameter("q", "", ".*");

String[] tabSearchedFields = new String[]{com.jalios.jcms.search.LucenePublicationSearchEngine.TITLE_FIELD, "zipCode", "codesPostaux", "nomDesCommunesDeleguees"};

QueryHandler qh = new QueryHandler();
qh.setText(textSearch);
qh.setTypes("City");
qh.setCheckPstatus(true);
qh.setSearchedFields(tabSearchedFields);

%><% 
%><%= SocleUtils.citiestoJsonArray(qh.getResultSet()) %>