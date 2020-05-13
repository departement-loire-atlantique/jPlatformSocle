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
				isFacetteObligatoire="<%= obj.getFacetteObligatoire() %>" 
				dataMode="select-only" 
				dataUrl="plugins/SoclePlugin/jsp/facettes/acSearchCommune.jsp" 
				label='<%= Util.notEmpty(obj.getLabel()) ? obj.getLabel() : glp("jcmsplugin.socle.facette.commune.default-label") %>'
				isLarge="false"/>
        <ds:pdcvSearchFields idFormElement="<%= idFormElement %>"/>
        
        <input type="hidden" name="redirectToDelegation" value="true"/>
        <button class="ds44-btnStd ds44-btn--invert" type="submit" aria-label='<%= JcmsUtil.glp(userLang,"jcmsplugin.socle.menu.pdcv.valider") %>'>
        	<span class="ds44-btnInnerText"><%= JcmsUtil.glp(userLang,"jcmsplugin.socle.valider") %></span><i class="icon icon-long-arrow-right" aria-hidden="true"></i>
        </button>
    </div>