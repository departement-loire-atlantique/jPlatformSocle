<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<% 
	PortletFacetteAgendaCommune obj = (PortletFacetteAgendaCommune)portlet;

	String rechercheId = (String) request.getAttribute("rechercheId");
	
	Category rayonRoot = channel.getCategory(channel.getProperty("jcmsplugin.socle.rayon.agenda.root.id"));
	if (Util.isEmpty(rayonRoot)) rayonRoot = new Category();
%>

<ds:facetteAutoCompletion idFormElement='<%= ServletUtil.generateUniqueDOMId(request, glp("jcmsplugin.socle.facette.form-element")) %>' 
		name='<%= "commune" + glp("jcmsplugin.socle.facette.form-element") + "-" + rechercheId + obj.getId() %>' 
		request="<%= request %>" 
		isFacetteObligatoire="<%= obj.getFacetteObligatoire() %>" 
		dataMode="select-only" 
		dataUrl="plugins/SoclePlugin/jsp/facettes/acSearchCommune.jsp" 
		label='<%= Util.notEmpty(obj.getLabel()) ? obj.getLabel() : glp("jcmsplugin.socle.facette.commune.default-label") %>'
		option='<%= channel.getProperty("jcmsplugin.socle.rayon.option") %>'
		setRayons='<%= rayonRoot.getChildrenSet() %>'/>
