<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<% 
	PortletFacetteAgendaCategorie obj = (PortletFacetteAgendaCategorie)portlet; 

	String rechercheId = (String) request.getAttribute("rechercheId");
	
	String idFormElement = glp("jcmsplugin.socle.facette.form-element") + "-" + rechercheId + obj.getId();
	
	String fluxId = (String)request.getAttribute("fluxId");
	
	if(Util.isEmpty(fluxId)) return;
	
	Set<Genre> listeGenre = new HashSet<Genre>();
	
	JSONObject objThematiques = RequestManager.getFluxMetadata(fluxId, "thematique");
	
	for(int i = 2 ; i < objThematiques.length(); i++) {
		JSONArray listeThematiques = objThematiques.getJSONArray(objThematiques.names().getString(i));
		
		for(JSONObject objGenre : listeThematiques) {
			Genre genre = new Genre();
			genre.setGenreId(objGenre.getString("id"));
			genre.setLibelle(objGenre.getString("libelle"));
			listeGenre.add(genre);
		}
	}
	
	JSONObject objThematiquesPersos = RequestManager.getFluxMetadata(fluxId, "thematique_perso");
	
	for(int i = 2 ; i < objThematiquesPersos.length(); i++) {
		JSONArray listeThematiquesPersos = objThematiquesPersos.getJSONArray(objThematiquesPersos.names().getString(i));
		
		for(JSONObject objGenre : listeThematiquesPersos) {
			Genre genre = new Genre();
			genre.setGenreId(objGenre.getString("id"));
			genre.setLibelle(objGenre.getString("libelle"));
			listeGenre.add(genre);
		}
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