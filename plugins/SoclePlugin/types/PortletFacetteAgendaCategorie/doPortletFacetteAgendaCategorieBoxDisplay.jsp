<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="fr.cg44.plugin.socle.infolocale.RequestManager"%>
<%@ page import="fr.cg44.plugin.socle.infolocale.InfolocaleEntityUtils"%>
<%@ page import="fr.cg44.plugin.socle.infolocale.entities.Genre"%>
<%@ page import="org.json.JSONObject"%>
<%@ page import="org.json.JSONArray"%>
<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<% 
	PortletFacetteAgendaCategorie obj = (PortletFacetteAgendaCategorie)portlet; 

	String rechercheId = (String) request.getAttribute("rechercheId");
	
	String idFormElement = glp("jcmsplugin.socle.facette.form-element") + "-" + rechercheId + obj.getId();
	
	String fluxId = (String)request.getAttribute("fluxId");
	
	if(Util.isEmpty(fluxId)) return;
	
	JSONObject extractedFlux = RequestManager.filterFluxData(fluxId);
	
	if(Util.isEmpty(extractedFlux)) return;
	
	boolean fluxSuccess = Boolean.parseBoolean(extractedFlux.getString("success"));
	
	if(!fluxSuccess && extractedFlux.getJSONArray("result").length() <= 0) return;
		
	EvenementInfolocale[] evenements = InfolocaleEntityUtils.createEvenementInfolocaleArrayFromJsonArray(extractedFlux.getJSONArray("result"));

	Set<Genre> listeGenre = new HashSet<Genre>();
	
	for(EvenementInfolocale event : evenements) {
		listeGenre.add(event.getGenre());
	}
%>

<ds:facetteCategorie obj='<%= obj %>' 
		listeGenre='<%= listeGenre %>'
		idFormElement='<%= idFormElement %>' 
		isDisabled='<%= false %>' 
		request='<%= request %>' 
		selectionMultiple='<%= obj.getSelectionMultiple() %>' 
		profondeur='true'/>

<jalios:foreach collection='<%= listeGenre %>' name="itGenre" type="Genre">
    <input type="hidden" name='<%= "cidBranches" + idFormElement + itCounter %>' value='<%= itGenre.getGenreId() %>' data-technical-field />
</jalios:foreach>