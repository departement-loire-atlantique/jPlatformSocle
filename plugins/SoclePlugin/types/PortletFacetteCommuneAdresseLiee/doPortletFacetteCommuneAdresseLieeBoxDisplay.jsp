<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags" %>
<% PortletFacetteCommuneAdresseLiee obj = (PortletFacetteCommuneAdresseLiee)portlet; %>

<ds:facetteAutoCompletion idFormElement='<%= ServletUtil.generateUniqueDOMId(request, glp("jcmsplugin.socle.facette.form-element")) %>' 
		name="commune" 
		request="<%= request %>" 
		obj="<%= obj %>" 
		dataMode="select-only" 
		dataUrl="plugins/SoclePlugin/jsp/facettes/acSearchCommune.jsp" 
		label='<%= Util.notEmpty(obj.getLabel()) ? obj.getLabel() : glp("jcmsplugin.socle.facette.commune.default-label") %>'
		option="adresse"/>
