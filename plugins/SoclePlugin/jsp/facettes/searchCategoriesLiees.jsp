<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@page import="com.jalios.jcms.handler.QueryHandler"%><%
%><%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%><%
%><%@page import="com.google.gson.JsonObject"%><%
%><%@page import="com.google.gson.JsonArray"%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%

response.setContentType("application/json");

Set<Category> collection = new HashSet<Category>();
collection.addAll(getDataListParameter("q", Category.class));

Set<Category> result = new HashSet<Category>();
for(Category itCat : collection) {
	result.addAll(itCat.getChildrenSet());
}


%><% 
%><%=  SocleUtils.categoriesToJsonArray(result) %>