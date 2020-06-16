<%@page import="fr.cg44.plugin.socle.queryfilter.CategoryFacetUtil"%>
<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@page import="com.jalios.io.IOUtil"%><%
%><%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%><%
%><%@page import="com.google.gson.JsonObject"%><%
%><%@page import="com.google.gson.JsonArray"%><%

request.setAttribute("inFO", Boolean.TRUE);

%><%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ include file="/jcore/portal/doPortletParams.jspf" %><%


response.setContentType("application/json");

PortletRechercheFacettes  boxTmp = (PortletRechercheFacettes) (channel.getPublication(request.getParameter("boxId"))).clone();  
PortletRechercheFacettes box = new PortletRechercheFacettes(boxTmp);

if(Util.notEmpty(box.getIdDeLaCategorieTag())) {
  request.setAttribute("tagRootCatId", box.getIdDeLaCategorieTag());
}

String typeDeTuileFicheLieu = request.getParameter("typeDeTuileFicheLieu");

%><%

%><%@ include file="/types/PortletQueryForeach/doQuery.jspf" %><%
%><%@ include file="/plugins/SoclePlugin/jsp/facettes/doQueryText.jspf" %><%
%><%@ include file="/plugins/SoclePlugin/jsp/facettes/doQueryCids.jspf" %><%
%><%@ include file="/plugins/SoclePlugin/jsp/facettes/doQueryGeoloc.jspf" %><%


%><%@ include file="/types/PortletQueryForeach/doSort.jspf" %><%

JsonArray jsonArray = new JsonArray();
JsonObject jsonObject = new JsonObject();

jsonObject.addProperty("nb-result", collection.size());
jsonObject.addProperty("nb-result-per-page", box.getMaxResults());
jsonObject.addProperty("max-result", box.getMaxResults());
jsonObject.add("result", jsonArray);

%><%

%><%@ include file="/types/PortletQueryForeach/doForeachHeader.jspf" %><%

    %><jalios:buffer name="itPubListGabarit"><%       
	    %><jalios:select><%	        
	        %><jalios:if predicate="<%= itPub instanceof FicheLieu %>"><%
	           %><jalios:media data="<%= itPub %>" template='<%= Util.notEmpty(typeDeTuileFicheLieu) ? typeDeTuileFicheLieu : "cardNoPic" %>' /><%
	        %></jalios:if><%
	        
	        %><jalios:default><%
	           %><jalios:media data="<%= itPub %>" template="card" /><%
	        %></jalios:default><%
	    %></jalios:select><%    
    %></jalios:buffer><%
    
    %><jalios:buffer name="itPubMarkerGabarit"><%
        %><jalios:include pub="<%= itPub %>" usage="marker" /><%
    %></jalios:buffer>
    <%
    %><%     
     jsonArray.add(SocleUtils.publicationToJsonObject(itPub, itPubListGabarit, itPubMarkerGabarit, null));
    %><%
                                        
%><%@ include file="/types/PortletQueryForeach/doForeachFooter.jspf" %><%
request.removeAttribute("tagRootCatId");
%><%= jsonObject %>