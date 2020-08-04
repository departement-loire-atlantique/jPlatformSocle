<%@page import="fr.cg44.plugin.socle.infolocale.util.InfolocaleUtil"%>
<%@page import="fr.cg44.plugin.socle.infolocale.InfolocaleEntityUtils"%>
<%@page import="fr.cg44.plugin.socle.infolocale.RequestManager"%>
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

PortletAgendaInfolocale boxTmp = (PortletAgendaInfolocale) (channel.getPublication(request.getParameter("boxId"))).clone();  
PortletAgendaInfolocale box = new PortletAgendaInfolocale(boxTmp);

List<EvenementInfolocale> allEvents = InfolocaleEntityUtils.getQueryEvent(request);
allEvents = InfolocaleUtil.purgeEventListFromDuplicates(allEvents, request.getParameterValues("agenda-date"));
allEvents = InfolocaleUtil.sortEvenementsCarrousel(allEvents);
%><%



JsonArray jsonArray = new JsonArray();
JsonObject jsonObject = new JsonObject();

jsonObject.addProperty("nb-result", allEvents.size());
jsonObject.addProperty("nb-result-per-page", box.getNombreDeResultats());
jsonObject.addProperty("max-result", box.getNombreDeResultats());
jsonObject.add("result", jsonArray);

%><%

%><jalios:foreach collection="<%= allEvents %>" name="itEven" type="EvenementInfolocale"> <%

    %><jalios:buffer name="itPubListGabarit"><%
        %><jalios:select>
        <jalios:if predicate='<%= box.getTypeDeTuileResultats().equals("vertical")%>'>
            <jalios:media data="<%= itEven %>" template="cardVertical" />
        </jalios:if>
        <jalios:default>
            <jalios:media data="<%= itEven %>" template="card" />
        </jalios:default>
        </jalios:select><%
    %></jalios:buffer><%
    
    %><jalios:buffer name="itPubMarkerGabarit"><%
        %><jalios:include pub="<%= itEven %>" usage="marker" /><%
    %></jalios:buffer>
    <%
    %><%     
     jsonArray.add(SocleUtils.publicationToJsonObject(itEven, itPubListGabarit, itPubMarkerGabarit, null));
    %><%
                                        
%></jalios:foreach><%
%><%= jsonObject %>