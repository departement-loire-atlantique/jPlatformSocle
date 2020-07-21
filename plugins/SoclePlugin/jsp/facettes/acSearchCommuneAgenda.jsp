<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@page import="com.jalios.jcms.handler.QueryHandler"%><%
%><%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%><%
%><%@page import="com.google.gson.JsonObject"%><%
%><%@page import="com.google.gson.JsonArray"%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
response.setContentType("application/json");

String textSearch = getStringParameter("q", "", ".*");
String delegationId = getUntrustedStringParameter("delegationId", "");
String allCommunes = getUntrustedStringParameter("allCommunes", "");

String[] tabSearchedFields = new String[]{com.jalios.jcms.search.LucenePublicationSearchEngine.TITLE_FIELD, "zipCode", "codesPostaux", "nomDesCommunesDeleguees"};

QueryHandler qh = new QueryHandler();
qh.setText(textSearch);
qh.setTypes("City");
qh.setCheckPstatus(true);
qh.setSearchedFields(tabSearchedFields);

// Filtre sur la delegation
QueryResultSet result = qh.getResultSet();
if(Util.notEmpty(delegationId)) {
  Set remove = new HashSet();
  Delegation delegation = (Delegation) channel.getPublication(delegationId);
  for(Publication itPub : result) {
    City city = (City) itPub;
    if(!JcmsUtil.isSameId(city.getDelegation(), delegation)) {
      remove.add(itPub);
    }
  }
  result.removeAll(remove);
}

%><% 
%><%= SocleUtils.citiestoJsonArray(Util.notEmpty(allCommunes), true, result) %>