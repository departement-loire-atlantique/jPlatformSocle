<%@page import="fr.cg44.plugin.socle.queryfilter.CategoryFacetUtil"%>
<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@page import="com.jalios.io.IOUtil"%><%
%><%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%><%
%><%@page import="com.google.gson.JsonObject"%><%
%><%@page import="com.google.gson.JsonArray"%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ include file="/jcore/portal/doPortletParams.jspf" %><%

response.setContentType("application/json");

PortletQueryForeach boxTmp = (PortletQueryForeach) (channel.getPublication(request.getParameter("boxId"))).clone();  
PortletQueryForeach box = new PortletQueryForeach(boxTmp);

%><%

%><%@ include file="/types/PortletQueryForeach/doQuery.jspf" %><%
%><%@ include file="/plugins/SoclePlugin/jsp/facettes/doQueryText.jspf" %><%
%><%@ include file="/plugins/SoclePlugin/jsp/facettes/doQueryCids.jspf" %><%
%><%@ include file="/plugins/SoclePlugin/jsp/facettes/doQueryGeoloc.jspf" %><%


%><%@ include file="/types/PortletQueryForeach/doSort.jspf" %><%

JsonArray jsonArray = new JsonArray();
JsonObject jsonObject = new JsonObject();

jsonObject.addProperty("nb-result", collection.size());
jsonObject.addProperty("max-result", box.getMaxResults());
jsonObject.add("result", jsonArray);

%><%

%><%@ include file="/types/PortletQueryForeach/doForeachHeader.jspf" %><%

    %><jalios:buffer name="itPubListGabarit"><%
        %><jalios:media data="<%= itPub %>" template="card" /><%
    %></jalios:buffer><%
    
    %><jalios:buffer name="itPubMarkerGabarit"><%
        %><jalios:include pub="<%= itPub %>" usage="marker" /><%
    %></jalios:buffer>
    <%
    %><%     
     jsonArray.add(SocleUtils.publicationToJsonObject(itPub, itPubListGabarit, itPubMarkerGabarit, null));
    %><%
                                        
%><%@ include file="/types/PortletQueryForeach/doForeachFooter.jspf" %><%
%><%= jsonObject %>