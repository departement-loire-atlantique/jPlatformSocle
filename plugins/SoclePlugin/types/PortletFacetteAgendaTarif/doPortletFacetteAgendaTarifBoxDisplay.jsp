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
	PortletFacetteAgendaTarif obj = (PortletFacetteAgendaTarif)portlet; 

	String rechercheId = (String) request.getAttribute("rechercheId");
	
	String idFormElement = glp("jcmsplugin.socle.facette.form-element") + "-" + rechercheId + obj.getId();
	
	String fluxId = (String)request.getAttribute("fluxId");
	
	if(Util.isEmpty(fluxId)) return;
	
	Category fakeCategory = new Category();
	fakeCategory.setId("estGratuit");
	fakeCategory.setName(Util.notEmpty(obj.getLibelle(userLang)) ? obj.getLibelle(userLang) : glp("jcmsplugin.socle.gratuit"));
	
%>

<ds:facetteCategorie obj='<%= obj %>'
        singleCat='<%= fakeCategory %>' 
        idFormElement='<%= idFormElement %>' 
        isDisabled='<%= false %>' 
        request='<%= request %>' 
        selectionMultiple='<%= false %>' 
        profondeur='<%= true %>'
        isSizeStd='<%= isInRechercheFacette %>'
        forcedLabel='<%= glp("jcmsplugin.socle.infolocale.label.tarif") %>'
        forcedName="isGratuit"/>
	
<%
	
    request.removeAttribute("showFiltres");
%>
		