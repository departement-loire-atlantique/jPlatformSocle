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





Map<String, Object> parameters = new HashMap<String, Object>();
if (Util.notEmpty(box.getOrganismesInfolocale())) {
    parameters.put("organisme", box.getOrganismesInfolocale());
}
if (Util.notEmpty(box.getGenresInfolocale())) {
    parameters.put("rubrique", box.getGenresInfolocale());
}

String listCodesInsee = SocleUtils.getCodesInseeFromPortletAgenda(box, loggedMember);

if (Util.notEmpty(listCodesInsee)) {
    parameters.put("codeInsee", listCodesInsee);
}

if (Util.notEmpty(box.getNombreDeResultats())) {
  parameters.put("limit", box.getNombreDeResultats());
} else {
  parameters.put("limit", channel.getIntegerProperty("jcmsplugin.socle.infolocale.limit", 20));
}

parameters.put("order", channel.getProperty("jcmsplugin.socle.infolocale.defaultOrder"));

SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
parameters.put("dateDebut", sdf.format(Calendar.getInstance().getTime()));
Calendar calInAMonth = Calendar.getInstance();
calInAMonth.set(Calendar.DAY_OF_YEAR, Calendar.getInstance().get(Calendar.DAY_OF_YEAR) + 30);
parameters.put("dateFin", sdf.format(calInAMonth.getTime()));

String flux = Util.isEmpty(box.getIdDeFlux()) ? channel.getProperty("jcmsplugin.socle.infolocale.flux.default") : box.getIdDeFlux();

org.json.JSONObject extractedFlux = RequestManager.filterFluxData(flux, parameters);




EvenementInfolocale[] evenements = InfolocaleEntityUtils.createEvenementInfolocaleArrayFromJsonArray(extractedFlux.getJSONArray("result"));
List<EvenementInfolocale> allEvents = InfolocaleUtil.splitEventListFromDateFields(evenements);




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
        %><jalios:media data="<%= itEven %>" template="card" /><%
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