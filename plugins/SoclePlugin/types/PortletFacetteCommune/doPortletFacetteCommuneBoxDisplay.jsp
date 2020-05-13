<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<% 
	PortletFacetteCommune obj = (PortletFacetteCommune)portlet;

	String rechercheId = (String) request.getAttribute("rechercheId");
%>

<ds:facetteAutoCompletion idFormElement='<%= ServletUtil.generateUniqueDOMId(request, glp("jcmsplugin.socle.facette.form-element")) %>' 
		name='<%= "commune" + glp("jcmsplugin.socle.facette.form-element") + "-" + rechercheId + obj.getId() %>' 
		request="<%= request %>" 
		isFacetteObligatoire="<%= obj.getFacetteObligatoire() %>" 
		dataMode="select-only" 
		dataUrl="plugins/SoclePlugin/jsp/facettes/acSearchCommune.jsp" 
		label='<%= Util.notEmpty(obj.getLabel()) ? obj.getLabel() : glp("jcmsplugin.socle.facette.commune.default-label") %>'
		option='<%= Util.isEmpty(obj.getRechercheEtendue()) || obj.getRechercheEtendue().equalsIgnoreCase("aucune") ? "" : obj.getRechercheEtendue() %>'/>
