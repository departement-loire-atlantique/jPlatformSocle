<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@page import="com.jalios.jcms.handler.QueryHandler"%>
<%@page import="javafx.scene.shape.Box"%>
<%@page import="fr.cg44.plugin.socle.infolocale.InfolocaleEntityUtils"%>
<%@page import="fr.cg44.plugin.socle.infolocale.entities.Evenement"%>
<%@page import="fr.cg44.plugin.socle.infolocale.RequestManager"%>
<%@page import="org.json.JSONObject"%>
<%@ page contentType="text/html; charset=UTF-8"%><%
%><%@ include file='/jcore/doInitPage.jsp'%>

<%
PortletAgendaInfolocale box = (PortletAgendaInfolocale) channel.getPublication("$jcmsplugin.socle.temp.portletagendatest.id");

if (Util.isEmpty(box)) return;
%>

<h2><%= box.getTitreSEO() %></h2>

<%
Map<String, Object> parameters = new HashMap<String, Object>();
if (Util.notEmpty(box.getOrganismesInfolocale())) {
    parameters.put("organisme", box.getOrganismesInfolocale());
}
if (Util.notEmpty(box.getGenreInfolocale())) {
    parameters.put("rubrique", box.getGenreInfolocale());
}

String listCodesInsee = SocleUtils.getCodesInseeFromPortletAgenda(box, loggedMember);

if (Util.notEmpty(listCodesInsee)) {
    parameters.put("codeInsee", listCodesInsee);
}

parameters.put("limit", channel.getIntegerProperty("jcmsplugin.socle.infolocale.limit"));

String flux = Util.isEmpty(box.getIdDeFlux()) ? channel.getProperty("jcmsplugin.socle.infolocale.flux.default") : box.getIdDeFlux();

JSONObject extractedFlux = RequestManager.filterFluxData(flux, parameters);
%>

<%= extractedFlux.getString("success") %>

<p>Transformation des résultats en événements</p>

<%
Evenement[] evenements = InfolocaleEntityUtils.createEvenementArrayFromJsonArray(extractedFlux.getJSONArray("result"));
%>

<jalios:foreach name="itEvent" type="Evenement" array="<%= evenements %>">
    <%= itEvent %><br/>
</jalios:foreach>
