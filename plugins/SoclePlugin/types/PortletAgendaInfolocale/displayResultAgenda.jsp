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
allEvents = InfolocaleUtil.purgeEventListFromDuplicates(allEvents, request.getParameterValues("agenda-date"), false);
allEvents = InfolocaleUtil.sortEvenementsCarrousel(allEvents);
%><%



JsonArray jsonArray = new JsonArray();
JsonObject jsonObject = new JsonObject();

jsonObject.addProperty("nb-result", allEvents.size());

//Limiter les résultats au nombre indiqué dans la portlet agenda
int limitResults = box.getNombreDeResultats();
if (allEvents.size() > limitResults) {
	List<EvenementInfolocale> limitedListEvents = new ArrayList<>();
	while (limitedListEvents.size() < limitResults) {
	   limitedListEvents.add(allEvents.get(limitedListEvents.size()));
	}
	allEvents = new ArrayList<>(limitedListEvents);
}

jsonObject.addProperty("nb-result-per-page", limitResults);
jsonObject.addProperty("max-result", limitResults);
jsonObject.add("result", jsonArray);

session.setAttribute("isSearchFacetLink", true);

request.setAttribute("metadata1", box.getMetadonneesTuileResultat_1());
request.setAttribute("metadata2", box.getMetadonneesTuileResultat_2());
request.setAttribute("defaultMetadata", box.getMetadonneeParDefaut());

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
        %><jalios:media data="<%= itEven %>" template="marker" /><%
    %></jalios:buffer>
    <%
    %><%     
     jsonArray.add(SocleUtils.publicationToJsonObject(itEven, itPubListGabarit, itPubMarkerGabarit, null));
    %><%
                                        
%></jalios:foreach><%
request.removeAttribute("metadata1");
request.removeAttribute("metadata2");
request.removeAttribute("defaultMetadata");
%><%= jsonObject %>