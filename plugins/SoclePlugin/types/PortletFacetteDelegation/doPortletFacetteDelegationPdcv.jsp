<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<% PortletFacetteDelegation obj = (PortletFacetteDelegation)portlet; %>

    <div class="ds44-js-linked-fields ds44-js-masked-fields">
        <ds:facetteAutoCompletion idFormElement='<%= ServletUtil.generateUniqueDOMId(request, glp("jcmsplugin.socle.facette.form-element")) %>' 
				name="commune" 
				request="<%= request %>" 
				obj="<%= obj %>" 
				dataUrl="plugins/SoclePlugin/jsp/facettes/acSearchCommune.jsp" 
				dataMode="select-only" 
				label='<%= Util.notEmpty(obj.getLabel()) ? obj.getLabel() : glp("jcmsplugin.socle.facette.commune.default-label") %>'/>
        <ds:pdcvSearchFields idFormElement="<%= idFormElement %>"/>
    </div>