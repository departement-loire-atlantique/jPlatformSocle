<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<%@ include file='/plugins/SoclePlugin/jsp/facettes/commonParamsFacettes.jspf' %>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags" %>
<% 
PortletFacetteAdresse obj = (PortletFacetteAdresse)portlet;
%>

<ds:facetteAutoCompletion idFormElement='<%= ServletUtil.generateUniqueDOMId(request, glp("jcmsplugin.socle.facette.form-element")) %>' 
		name="adresse" 
		request="<%= request %>" 
		isFacetteObligatoire="<%= obj.getFacetteObligatoire() %>" 
		dataMode="select-only" 
		dataUrl='<%= Channel.getChannel().getProperty("jcmsplugin.socle.autocompletion.adresse.url") %>' 
		label='<%= Util.notEmpty(obj.getLabel(userLang, false)) ? obj.getLabel(userLang, false) : glp("jcmsplugin.socle.facette.adresse.default-label") %>'
		option='<%= Util.notEmpty(obj.getRayon(loggedMember)) ? "rayon" : "" %>'
		setRayons="<%= Util.notEmpty(obj.getRayon(loggedMember)) ? obj.getRayon(loggedMember) : new TreeSet<Category>() %>"
		autourMoi="<%= obj.getAutourDeMoi() %>"
		isLarge='<%= !isInRechercheFacette %>'/>