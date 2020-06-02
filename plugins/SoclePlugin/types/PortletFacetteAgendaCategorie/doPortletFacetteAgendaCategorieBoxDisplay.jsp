<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="fr.cg44.plugin.socle.infolocale.RequestManager"%>
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
	
	Set<Genre> listeGenre = new HashSet<Genre>();
	
	JSONObject objThematiques = RequestManager.getFluxMetadata(fluxId, "thematique");
	
	for(int i = 2 ; i < objThematiques.length(); i++) {
		JSONArray listeThematiques = objThematiques.getJSONArray(objThematiques.names().getString(i));
		
		for (int j = 0; j < listeThematiques.length(); j++) {
			JSONObject objGenre = listeThematiques.getJSONObject(j);
			Genre genre = new Genre();
			genre.setGenreId(Integer.parseInt(objGenre.getString("id")));
			genre.setLibelle(objGenre.getString("libelle"));
			listeGenre.add(genre);
		}
	}
	
	JSONObject objThematiquesPersos = RequestManager.getFluxMetadata(fluxId, "thematique_perso");
	
	for(int i = 2 ; i < objThematiquesPersos.length(); i++) {
		JSONArray listeThematiquesPersos = objThematiquesPersos.getJSONArray(objThematiquesPersos.names().getString(i));
		
		for (int j = 0; j < listeThematiquesPersos.length(); j++) {
			JSONObject objGenre = listeThematiquesPersos.getJSONObject(j);
			Genre genre = new Genre();
			genre.setGenreId(Integer.parseInt(objGenre.getString("id")));
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