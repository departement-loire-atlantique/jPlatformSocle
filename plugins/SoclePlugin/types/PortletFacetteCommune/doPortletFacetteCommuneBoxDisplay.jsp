<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<%@ include file='/plugins/SoclePlugin/jsp/facettes/commonParamsFacettes.jspf' %>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<% 
	PortletFacetteCommune obj = (PortletFacetteCommune)portlet;

	String rechercheId = (String) request.getAttribute("rechercheId");
	String dataUrl = "plugins/SoclePlugin/jsp/facettes/acSearchCommune.jsp";
	String option = obj.getRechercheEtendue();
	if(Util.notEmpty(option) && (option.equalsIgnoreCase("limitrophe") || option.equalsIgnoreCase("epci"))) {
	  dataUrl = dataUrl + "?allCommunes=true";
	}
%>

<ds:facetteAutoCompletion idFormElement='<%= ServletUtil.generateUniqueDOMId(request, glp("jcmsplugin.socle.facette.form-element")) %>' 
		name='<%= "commune" + glp("jcmsplugin.socle.facette.form-element") + "-" + rechercheId + obj.getId() %>' 
		request="<%= request %>" 
		isFacetteObligatoire="<%= obj.getFacetteObligatoire() %>" 
		dataMode="select-only" 
		dataUrl="<%= dataUrl %>" 
		label='<%= Util.notEmpty(obj.getLabel()) ? obj.getLabel() : glp("jcmsplugin.socle.facette.commune.default-label") %>'
		option='<%= Util.isEmpty(obj.getRechercheEtendue()) || obj.getRechercheEtendue().equalsIgnoreCase("aucune") ? "" : obj.getRechercheEtendue() %>'
		isLarge='<%= !isInRechercheFacette && !isInEncadre %>'/>
