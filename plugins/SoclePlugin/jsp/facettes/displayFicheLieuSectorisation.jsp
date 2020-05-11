<%@page import="com.jalios.jcms.handler.QueryHandler"%>
<%@page import="fr.cg44.plugin.socle.queryfilter.CategoryFacetUtil"%>
<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@page import="com.jalios.io.IOUtil"%><%
%><%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%><%
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
QueryResultSet resultSet = qh.getResultSet();

%>
<jalios:foreach collection="<%= resultSet %>" name="itPub" type="Publication"><%
    %><jalios:buffer name="fichesLieuxHTML"><%
        FicheLieu itFicheLieu = (FicheLieu) itPub;        
       %>
        
       <jalios:media data="<%= itFicheLieu %>" template="contact"/>
      
       <jalios:if predicate="<%= itCounter != resultSet.size() %>">
           <hr />
       </jalios:if><%
   %></jalios:buffer><%   
    contentHtml.append(fichesLieuxHTML);
%></jalios:foreach><%
jsonObject.addProperty("content_html", contentHtml.toString());
%><%= jsonObject %>