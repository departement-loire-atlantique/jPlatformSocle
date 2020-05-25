<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<% 
	PortletFacetteAgendaCategorie obj = (PortletFacetteAgendaCategorie)portlet; 

	String rechercheId = (String) request.getAttribute("rechercheId");
	
	String idFormElement = glp("jcmsplugin.socle.facette.form-element") + "-" + rechercheId + obj.getId();
	
	//TODO recuperer le flux sous la forme d'un JSONObject pour reutiliser 
	JSONObject jsonEvent = new JSONObject();
	
	InfolocaleMetadataUtils.getMetadata("grtheme", jsonEvent);
%>

<ds:facetteCategorie obj='<%= obj %>' 
		listeCategory='<%=  %>'
		idFormElement='<%= idFormElement %>' 
		isDisabled='<%= false %>' 
		request='<%= request %>' 
		selectionMultiple='<%= obj.getSelectionMultiple() %>' 
		profondeur='true'/>

<jalios:foreach collection='<%= obj.getCategoriesRacines(loggedMember) %>' name="itRootCat" type="Category">
    <input type="hidden" name='<%= "cidBranches" + idFormElement + itCounter %>' value='<%= itRootCat.getId() %>' data-technical-field />
</jalios:foreach>