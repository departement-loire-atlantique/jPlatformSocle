<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%><%
%><%@page import="fr.cg44.plugin.socle.SocleUtils"%><%
%><%@page import="com.google.gson.JsonObject"%><%
%><%@page import="com.google.gson.JsonArray"%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ include file="/jcore/portal/doPortletParams.jspf" %><%


String codeSuivi = request.getParameter("codeSuivi[value]");
String url = glp("jcmsplugin.socle.ficheaide.demarche.suivi.url", codeSuivi);
sendRedirect(url);

%>


