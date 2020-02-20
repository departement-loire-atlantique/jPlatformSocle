<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@page import="com.jalios.io.IOUtil"%><%
%><%@page import="fr.cg44.plugin.socle.bean.FacetSearch"%><%
%><%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%><%
%><%@page import="com.google.gson.JsonObject"%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%

response.setContentType("application/json");
Publication pub = getPublicationParameter("id");

JsonObject jsonObject = new JsonObject();

%><jalios:select><%
	%><jalios:if predicate="<%= Util.notEmpty(pub)%>"><%
		%><jalios:buffer name="pubFullGabarit"><%
		    %><jalios:include pub="<%= pub %>" usage="full" /><%
		%></jalios:buffer><%
		%><%	 
		jsonObject = SocleUtils.publicationToJsonObject(pub, null, null, pubFullGabarit);
	%></jalios:if><%
	%><jalios:default><%
	    jsonObject.addProperty("error", "Publication introuvable");
	%></jalios:default>
</jalios:select><%
%><%= jsonObject %>