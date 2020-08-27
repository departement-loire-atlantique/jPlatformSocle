<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<%@ include file='/plugins/SoclePlugin/jsp/facettes/commonParamsFacettes.jspf' %>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags" %>
<% 
	PortletFacetteTitre obj = (PortletFacetteTitre)portlet; 

	String rechercheId = (String) request.getAttribute("rechercheId");

	String query = Util.notEmpty(request.getAttribute("query")) ? (String)(request.getAttribute("query")) : "";
	String dataUrl = "plugins/SoclePlugin/jsp/facettes/acSearchPublication.jsp?query="+HttpUtil.encodeForURL(query) + (obj.getEtendreLaRechercheATousLesChamps() ? "&motCle=true" : "");
	
	String rechercheEtendu =  obj.getEtendreLaRechercheATousLesChamps() ? "text" : "titre";
	String name = rechercheEtendu + glp("jcmsplugin.socle.facette.form-element") + "-" + rechercheId + obj.getId();
%>

<ds:facetteAutoCompletion idFormElement='<%= ServletUtil.generateUniqueDOMId(request, glp("jcmsplugin.socle.facette.form-element")) %>' 
		name="<%= name %>" 
		request="<%= request %>" 
		isFacetteObligatoire="<%= obj.getFacetteObligatoire() %>" 
		dataMode="free-text" 
		dataUrl='<%= dataUrl %>' 
		label='<%= Util.notEmpty(obj.getLabel()) ? obj.getLabel() : glp("jcmsplugin.socle.facette.titre.default-label") %>'
		isLarge='<%= !isInRechercheFacette %>'/>
