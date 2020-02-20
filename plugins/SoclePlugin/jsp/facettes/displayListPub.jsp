<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@page import="com.jalios.io.IOUtil"%><%
%><%@page import="fr.cg44.plugin.socle.bean.FacetSearch"%><%
%><%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%><%
%><%@page import="com.google.gson.JsonObject"%><%
%><%@page import="com.google.gson.JsonArray"%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ include file="/jcore/portal/doPortletParams.jspf" %><%

response.setContentType("application/json");

Set<Publication> collection = new HashSet<Publication>();
collection.addAll(getDataListParameter("id", Publication.class));

%><%

JsonArray jsonArray = new JsonArray();
JsonObject jsonObject = new JsonObject();

jsonObject.addProperty("nb-result", collection.size());
jsonObject.add("result", jsonArray);

%><%

%><jalios:foreach collection="<%= collection %>" name="itPub" type="Publication"><%

    %><jalios:buffer name="itPubListGabarit"><%
        %><jalios:include pub="<%= itPub %>" usage="list" /><%
    %></jalios:buffer><%
    
    %><jalios:buffer name="itPubMarkerGabarit"><%
        %><jalios:include pub="<%= itPub %>" usage="marker" /><%
    %></jalios:buffer>
    <%
    %><%
    jsonArray.add(SocleUtils.publicationToJsonObject(itPub, itPubListGabarit, itPubMarkerGabarit, null));
    %><%
                                        
%></jalios:foreach><%
%><%= jsonObject %>