<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@page import="com.jalios.jcms.handler.QueryHandler"%><%
%><%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%><%
%><%@page import="com.google.gson.JsonObject"%><%
%><%@page import="com.google.gson.JsonArray"%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
response.setContentType("application/json");

String textSearch = getStringParameter("q", "", ".*");
String query = getUntrustedStringParameter("query", "");
String[] tabSearchedFields = new String[]{com.jalios.jcms.search.LucenePublicationSearchEngine.TITLE_FIELD};

QueryHandler qh = new QueryHandler(query);
qh.setText(textSearch);
qh.setSearchedFields(tabSearchedFields);

%><% 
%><%= SocleUtils.publicationToJsonArray(qh.getResultSet()) %>