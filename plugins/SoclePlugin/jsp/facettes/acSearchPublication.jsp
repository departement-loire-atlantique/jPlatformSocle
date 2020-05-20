<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@page import="com.jalios.jcms.handler.QueryHandler"%><%
%><%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%><%
%><%@page import="com.google.gson.JsonObject"%><%
%><%@page import="com.google.gson.JsonArray"%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
response.setContentType("application/json");

String textSearch = getStringParameter("q", "", ".*");
String isMotCle = getStringParameter("motCle", "", ".*");
String query = getUntrustedStringParameter("query", "");
String sort = getUntrustedStringParameter("sort", "udate");
String[] tabSearchedFields = new String[]{com.jalios.jcms.search.LucenePublicationSearchEngine.TITLE_FIELD};
if(hasParameter("motCle")) {
  tabSearchedFields = new String[]{com.jalios.jcms.search.LucenePublicationSearchEngine.ALLFIELDS_FIELD};
}
Comparator<? super Publication> comp = ComparatorManager.getComparator(Publication.class, sort);
TreeSet collection = new TreeSet(comp);

QueryHandler qh = new QueryHandler(query);
qh.setText(textSearch);
qh.setCheckPstatus(true);
qh.setSearchedFields(tabSearchedFields);
collection.addAll(qh.getResultSet());

%><% 
%><%= SocleUtils.publicationToJsonArray(collection) %>