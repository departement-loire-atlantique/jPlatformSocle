<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<% 
    PortletFacetteDelegation obj = (PortletFacetteDelegation)portlet;
    
    String idFormElement = ServletUtil.generateUniqueDOMId(request, glp("jcmsplugin.socle.facette.form-element"));
    String dataMode = "select-only";
    String dataUrl = "plugins/SoclePlugin/jsp/facettes/acSearchCommune.jsp";
    String name = "commune";
    String label = Util.notEmpty(obj.getLabel()) ? obj.getLabel() : glp("jcmsplugin.socle.facette.commune.default-label");
    String option = "";
    TreeSet<Category> setRayons = new TreeSet<Category>();
%>

<form data-statistic='{"name": "declenche-evenement","category": "Formulaire","action": "Recherchez un contact","label": "$commune|text"}' action="plugins/SoclePlugin/types/PortletFacetteDelegation/doDelegationPdcvRedirection.jsp" method="GET">
    <div class="ds44-js-linked-fields ds44-js-masked-fields">
        <%@ include file='/plugins/SoclePlugin/jsp/portlet/portletFacetteAutoCompletion.jspf' %>
        <ds:pdcvSearchFields idFormElement="<%= idFormElement %>"/>
    </div>
</form>