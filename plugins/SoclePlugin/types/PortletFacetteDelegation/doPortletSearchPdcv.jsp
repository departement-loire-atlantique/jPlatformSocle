<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<%@ include file='/plugins/SoclePlugin/jsp/facettes/commonParamsFacettes.jspf' %>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>

<% 
PortletFacetteDelegation obj = (PortletFacetteDelegation)portlet; 
Boolean isSimpleGabarit = Util.notEmpty(request.getAttribute("isSimpleGabarit"));

Delegation delegation = obj.getDelegationPourPDCV();
String dataUrl = "plugins/SoclePlugin/jsp/facettes/acSearchCommune.jsp";
if(Util.notEmpty(delegation)){
  dataUrl = dataUrl + "?delegationId=" + delegation.getId();
}
%>

<jalios:select>

	<jalios:if predicate="<%= !isInRechercheFacette && !isSimpleGabarit %>">	
		<section class="ds44-box ds44-theme ds44-mb3">
		    <div class="ds44-innerBoxContainer">
		        <p role="heading" aria-level="2" class="ds44-box-heading"><%= glp("jcmsplugin.socle.menu.pdcv") %></p>
		        <p class="ds44-textLegend ds44-textLegend--mentions "><%= glp("jcmsplugin.socle.facette.champs-obligatoires") %></p>
		            <div class="ds44-js-linked-fields ds44-js-masked-fields">
		                <%
		                String idFormElement= ServletUtil.generateUniqueDOMId(request, glp("jcmsplugin.socle.facette.form-element"));
		                String titleAttr = glp("jcmsplugin.socle.recherche.facettes.commune.autocomplete.title");
		                %>
		                <ds:facetteAutoCompletion idFormElement="<%= idFormElement %>"
		                        name="commune" 
		                        request="<%= request %>" 
		                        isFacetteObligatoire="<%= obj.getFacetteObligatoire() %>" 
		                        dataMode="select-only" 
		                        dataUrl="<%= dataUrl %>" 
		                        label='<%= Util.notEmpty(obj.getLabel()) ? obj.getLabel() : glp("jcmsplugin.socle.facette.commune.default-label") %>'
		                        title='<%= glp("jcmsplugin.socle.facette.champ-obligatoire.title",titleAttr) %>'
		                        isLarge="false"/>
		                <ds:pdcvSearchFields idFormElement='<%= ServletUtil.generateUniqueDOMId(request, glp("jcmsplugin.socle.facette.form-element")) %>'/>
		                
		                <input type="hidden" name="redirectToDelegation" value="true"/>
		                <button class="ds44-btnStd ds44-btn--invert" type="submit" title='<%= JcmsUtil.glp(userLang,"jcmsplugin.socle.menu.pdcv.valider") %>'>
		                    <span class="ds44-btnInnerText"><%= JcmsUtil.glp(userLang,"jcmsplugin.socle.valider") %></span><i class="icon icon-long-arrow-right" aria-hidden="true"></i>
		                </button>
		            </div>
		    </div>
		</section>	
	</jalios:if>

	<jalios:default>	
		<ds:facetteAutoCompletion idFormElement='<%= ServletUtil.generateUniqueDOMId(request, glp("jcmsplugin.socle.facette.form-element")) %>' 
		        name='commune' 
		        request="<%= request %>" 
		        isFacetteObligatoire="<%= obj.getFacetteObligatoire() %>" 
		        dataMode="select-only" 
		        dataUrl="<%= dataUrl %>" 
		        label='<%= Util.notEmpty(obj.getLabel()) ? obj.getLabel() : glp("jcmsplugin.socle.facette.commune.default-label") %>'
		        option='<%= Util.isEmpty(delegation) || (Util.notEmpty(delegation) && Util.arrayContains(channel.getStringArrayProperty("jcmsplugin.socle.delegation.needAddress", null), delegation.getCodePostal())) ? "adresse" : "" %>'
		        isLarge='<%= !isInRechercheFacette %>'/>		        
	</jalios:default>
	
</jalios:select>

<input type="hidden" name='<%= "delegationSearch" + glp("jcmsplugin.socle.facette.form-element") %>' value='<%= true %>' data-technical-field />

<jalios:if predicate='<%= Util.notEmpty(delegation) %>'>
    <input type="hidden" name='<%= "delegation" + glp("jcmsplugin.socle.facette.form-element") %>' value='<%= delegation.getId() %>' data-technical-field />
</jalios:if>
