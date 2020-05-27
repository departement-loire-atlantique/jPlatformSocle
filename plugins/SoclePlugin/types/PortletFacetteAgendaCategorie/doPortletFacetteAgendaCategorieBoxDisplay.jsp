<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<% 
	PortletFacetteAgendaCategorie obj = (PortletFacetteAgendaCategorie)portlet; 

	String rechercheId = (String) request.getAttribute("rechercheId");
	
	String idFormElement = glp("jcmsplugin.socle.facette.form-element") + "-" + rechercheId + obj.getId();
	
	JSONObject extractedFlux = (JSONObject)request.getAttribute("extractedFlux");
	
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