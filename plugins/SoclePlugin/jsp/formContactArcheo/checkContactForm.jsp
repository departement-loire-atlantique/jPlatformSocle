<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="fr.cg44.plugin.archives.FormContactUtil"%>
<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ include file="/jcore/portal/doPortletParams.jspf" %>

<%
response.setContentType("application/json");
JsonObject jsonObject = new JsonObject();
JsonArray jsonArray = new JsonArray();

// Initialisation des variables à enregistrer
ContactFormArcheo form = FormContactUtil.getTmpFormArcheo(request);  
FormContactUtil.saveForm(jsonObject, jsonArray, form);
%>

<%= jsonObject %>
