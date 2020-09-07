<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="fr.cg44.plugin.socle.infolocale.RequestManager"%>
<%@ page import="fr.cg44.plugin.socle.infolocale.InfolocaleEntityUtils"%>
<%@ page import="fr.cg44.plugin.socle.infolocale.entities.Genre"%>
<%@ page import="org.json.JSONObject"%>
<%@ page import="org.json.JSONArray"%>
<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<%@ include file='/plugins/SoclePlugin/jsp/facettes/commonParamsFacettes.jspf' %>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<% 
	PortletFacetteAgendaCategorie obj = (PortletFacetteAgendaCategorie)portlet; 

	String rechercheId = (String) request.getAttribute("rechercheId");
	
	String idFormElement = glp("jcmsplugin.socle.facette.form-element") + "-" + rechercheId + obj.getId();
	
	String fluxId = (String)request.getAttribute("fluxId");
	
    request.setAttribute("showFiltres", isInRechercheFacette);
	
	if(Util.isEmpty(fluxId)) return;
	
	// Cas 1 : thématiques personnalisées
	if (Util.notEmpty(obj.getIdDeThematiquesPersonnalisees())) {
        Set<Genre> listeGenre = InfolocaleEntityUtils.getThematiquesPersoOfMetadata(obj.getIdDeThematiquesPersonnalisees(), fluxId);
    
        if(Util.isEmpty(listeGenre)) return;
        
        %>

<ds:facetteCategorie obj='<%= obj %>' 
        listeGenre='<%= listeGenre %>'
        idFormElement='<%= idFormElement %>' 
        isDisabled='<%= false %>' 
        request='<%= request %>' 
        selectionMultiple='<%= obj.getSelectionMultiple() %>' 
        profondeur='<%= Boolean.getBoolean(obj.getProfondeur()) %>'/>
	
        <%
        
	}
	
	
	// Cas 2 : Genres et catégories
	
	if (Util.notEmpty(obj.getIdsDeGenresCategories())) {
	  
	   Map<String, Set<Genre>> couplesLibellesGenres = InfolocaleEntityUtils.getAllGenreOfMetadata(obj.getLibellesDeGenres(), obj.getIdsDeGenresCategories(), fluxId);
	   
	   if (Util.isEmpty(couplesLibellesGenres)) return;
	   
	   %>
	   
	      <ds:facetteCategorie obj='<%= obj %>'
              listeCouplesLibellesGenres='<%= couplesLibellesGenres %>'
              idFormElement='<%= idFormElement %>' 
              isDisabled='<%= false %>' 
              request='<%= request %>' 
              selectionMultiple='<%= obj.getSelectionMultiple() %>' 
              profondeur='<%= Boolean.getBoolean(obj.getProfondeur()) %>' />
	   
	   <%
	  
	}
        
    request.removeAttribute("showFiltres");
%>
		