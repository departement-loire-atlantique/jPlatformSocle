<%@page import="com.jalios.jcms.handler.QueryHandler"%>
<%@page import="fr.cg44.plugin.socle.queryfilter.CategoryFacetUtil"%>
<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@page import="com.jalios.io.IOUtil"%><%
%><%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%><%
%><%@page import="com.google.gson.JsonObject"%><%
%><%@page import="com.google.gson.JsonArray"%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ include file="/jcore/portal/doPortletParams.jspf" %><%

response.setContentType("application/json");


QueryHandler qh = new QueryHandler();
qh.setCids(request.getParameter("cid"));
qh.setTypes("FicheLieu");



JsonObject jsonObject = new JsonObject();


StringBuffer contentHtml = new StringBuffer();


%>
<jalios:foreach collection="<%= qh.getResultSet() %>" name="itPub" type="Publication"><%
    %><jalios:buffer name="fichesLieuxHTML"><%
        %>salut toi<%
    %></jalios:buffer><%   
    contentHtml.append(fichesLieuxHTML);
%></jalios:foreach><%
jsonObject.addProperty("content_html", contentHtml.toString());
%><%= jsonObject %>