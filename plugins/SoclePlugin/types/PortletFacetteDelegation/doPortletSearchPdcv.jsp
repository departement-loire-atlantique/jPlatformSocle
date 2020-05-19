<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>

<% PortletFacetteDelegation obj = (PortletFacetteDelegation)portlet; %>


<form data-statistic="{&quot;name&quot;: &quot;declenche-evenement&quot;,&quot;category&quot;: &quot;Formulaire&quot;,&quot;action&quot;: &quot;Recherchez un contact&quot;,&quot;label&quot;: &quot;$commune|text&quot;}">
    <div class="ds44-js-linked-fields ds44-js-masked-fields">
        <% String idFormElement= ServletUtil.generateUniqueDOMId(request, glp("jcmsplugin.socle.facette.form-element")); %>
        <ds:facetteAutoCompletion idFormElement="<%= idFormElement %>"
			name="commune" 
			request="<%= request %>" 
			isFacetteObligatoire="<%= obj.getFacetteObligatoire() %>" 
			dataMode="select-only" 
			dataUrl="plugins/SoclePlugin/jsp/facettes/acSearchCommune.jsp" 
			label='<%= Util.notEmpty(obj.getLabel()) ? obj.getLabel() : glp("jcmsplugin.socle.facette.commune.default-label") %>'
			isLarge="false"/>
        <ds:pdcvSearchFields idFormElement='<%= ServletUtil.generateUniqueDOMId(request, glp("jcmsplugin.socle.facette.form-element")) %>'/>
        
        <input type="hidden" name="redirectToDelegation" value="true"/>
        <button class="ds44-btnStd ds44-btn--invert" type="submit" aria-label='<%= JcmsUtil.glp(userLang,"jcmsplugin.socle.menu.pdcv.valider") %>'>
            <span class="ds44-btnInnerText"><%= JcmsUtil.glp(userLang,"jcmsplugin.socle.valider") %></span><i class="icon icon-long-arrow-right" aria-hidden="true"></i>
        </button>
    </div>
</form>
