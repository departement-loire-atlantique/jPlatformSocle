<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<%@ include file='/plugins/SoclePlugin/jsp/facettes/commonParamsFacettes.jspf' %>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<% 
	PortletFacetteAgendaCommune obj = (PortletFacetteAgendaCommune)portlet;

	String rechercheId = (String) request.getAttribute("rechercheId");
	
	Category rayonRoot = channel.getCategory(channel.getProperty("jcmsplugin.socle.rayon.agenda.root.id"));
	if (Util.isEmpty(rayonRoot)) rayonRoot = new Category();
	Delegation delegation = obj.getDelegation();
	String dataUrl = "plugins/SoclePlugin/jsp/facettes/acSearchCommuneAgenda.jsp";
	if(Util.notEmpty(delegation)){
	  dataUrl = dataUrl + "?delegationId=" + delegation.getId();
	}
	
	boolean isFilter = Util.notEmpty(request.getAttribute("isFilter")) ? (boolean) request.getAttribute("isFilter") : false;
%>

<ds:facetteAutoCompletion idFormElement='<%= ServletUtil.generateUniqueDOMId(request, glp("jcmsplugin.socle.facette.form-element")) %>' 
		name='<%= "commune" + glp("jcmsplugin.socle.facette.form-element") + "-" + rechercheId + obj.getId() %>' 
		request="<%= request %>" 
		isFacetteObligatoire="<%= obj.getFacetteObligatoire() %>" 
		dataMode="select-only" 
		dataUrl="<%= dataUrl %>" 
		label='<%= Util.notEmpty(obj.getLabel(userLang, false)) ? obj.getLabel(userLang, false) : glp("jcmsplugin.socle.facette.commune.default-label") %>'
		option='<%= !isFilter ? channel.getProperty("jcmsplugin.socle.rayon.option") : "" %>'
		setRayons='<%= rayonRoot.getChildrenSet() %>'
		isLarge='<%= !isInRechercheFacette %>'/>
