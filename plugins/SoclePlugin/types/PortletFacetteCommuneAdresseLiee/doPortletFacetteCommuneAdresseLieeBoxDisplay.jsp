<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<%@ include file='/plugins/SoclePlugin/jsp/facettes/commonParamsFacettes.jspf' %>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags" %>
<% 
	PortletFacetteCommuneAdresseLiee obj = (PortletFacetteCommuneAdresseLiee)portlet; 

	String rechercheId = (String) request.getAttribute("rechercheId");
%>

<ds:facetteAutoCompletion idFormElement='<%= ServletUtil.generateUniqueDOMId(request, glp("jcmsplugin.socle.facette.form-element")) %>' 
		name='<%= "commune" %>' 
		request="<%= request %>" 
		isFacetteObligatoire="<%= obj.getFacetteObligatoire() %>" 
		dataMode="select-only" 
		dataUrl="plugins/SoclePlugin/jsp/facettes/acSearchCommune.jsp" 
		label='<%= Util.notEmpty(obj.getLabel()) ? obj.getLabel() : glp("jcmsplugin.socle.facette.commune.default-label") %>'
		option="adresse"
		isLarge='<%= !isInRechercheFacette %>'/>
