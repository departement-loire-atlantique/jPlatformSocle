<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<% 
	PortletFacetteAgendaCategorie obj = (PortletFacetteAgendaCategorie)portlet; 

	String rechercheId = (String) request.getAttribute("rechercheId");
	
	String idFormElement = glp("jcmsplugin.socle.facette.form-element") + "-" + rechercheId + obj.getId();
	
	//TODO ajout parametre pour tag facetteCategorie : selection multiple ; categories racines ; profondeur (ici constante 1)
	//TODO recuperer le flux sous la forme d'un JSONObject pour reutiliser 
	//     InfolocaleMetadataUtils.getMetadata(String metadata, JSONObject jsonEvent) avec metadata = grtheme
	//     pour récuperer ensuite la liste des thématiques enfants
%>

<ds:facetteCategorie obj='<%= obj %>' 
		listeCategory='<%= obj.getCategoriesRacines(loggedMember) %>'
		idFormElement='<%= idFormElement %>' 
		isDisabled='<%= false %>' 
		request='<%= request %>'/>

<jalios:foreach collection='<%= obj.getCategoriesRacines(loggedMember) %>' name="itRootCat" type="Category">
    <input type="hidden" name='<%= "cidBranches" + idFormElement + itCounter %>' value='<%= itRootCat.getId() %>' data-technical-field />
</jalios:foreach>