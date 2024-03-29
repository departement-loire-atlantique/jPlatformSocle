<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<%@ include file='/plugins/SoclePlugin/jsp/facettes/commonParamsFacettes.jspf' %>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags" %>
<% 
PortletFacetteAdresse obj = (PortletFacetteAdresse)portlet;

String rechercheId = (String) request.getAttribute("rechercheId");
String idFormElement = glp("jcmsplugin.socle.facette.form-element") + "-" + rechercheId + obj.getId(); 

request.setAttribute("facetteType", "adresse");

%>


<ds:facetteAutoCompletion idFormElement='<%= idFormElement %>' 
		name='<%= "adresse" + glp("jcmsplugin.socle.facette.form-element") + "-" + rechercheId + obj.getId() %>'
		request="<%= request %>" 
		isFacetteObligatoire="<%= obj.getFacetteObligatoire() %>" 
		dataMode="select-only" 
		dataUrl='<%= Channel.getChannel().getProperty("jcmsplugin.socle.autocompletion.adresse.loire.url") %>' 
		label='<%= Util.notEmpty(obj.getLabel(userLang, false)) ? obj.getLabel(userLang, false) : glp("jcmsplugin.socle.facette.adresse.default-label") %>'
		option='<%= Util.notEmpty(obj.getRayon(loggedMember)) ? "rayon" : "" %>'
		setRayons="<%= Util.notEmpty(obj.getRayon(loggedMember)) ? obj.getRayon(loggedMember) : new TreeSet<Category>() %>"
		autourMoi="<%= obj.getAutourDeMoi() %>"
		isLarge='<%= !isInRechercheFacette && !isInEncadre %>'
		dataLimitChar="3"/>
		
<% request.removeAttribute("facetteType"); %>