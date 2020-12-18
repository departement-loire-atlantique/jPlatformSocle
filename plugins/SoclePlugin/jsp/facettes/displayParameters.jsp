<%@page import="fr.cg44.plugin.socle.bean.FacetSearch"%><%
%><%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%><%
%><%@page import="com.google.gson.JsonObject"%><%
%><%@page import="com.google.gson.JsonArray"%><%

request.setAttribute("inFO", Boolean.TRUE);

%><%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ include file="/jcore/portal/doPortletParams.jspf" %><%

response.setContentType("text/plain;charset=UTF-8");

// Recherche de la query dans la bdd à partir de son id
String idSearch = request.getParameter("id");


FacetSearch currentFacetSearch = HibernateUtil.queryUnique(FacetSearch.class, "guid", idSearch);

// Enregistrer quand partager
if(currentFacetSearch != null && channel.getBooleanProperty("jcmsplugin.socle.url-rewriting.mdate", false)){
  // Mettre à jour la date de derniere appel à cette requete (mdate et cpt)
  Integer cpt = currentFacetSearch.getCpt();
  if(cpt != null) {
   currentFacetSearch.setCpt(cpt + 1);
  }else {
    currentFacetSearch.setCpt(2);
  }
  HibernateUtil.save(currentFacetSearch); 
}

%><%
%><%= currentFacetSearch != null ? "&"+currentFacetSearch.getQuery() : "" %>