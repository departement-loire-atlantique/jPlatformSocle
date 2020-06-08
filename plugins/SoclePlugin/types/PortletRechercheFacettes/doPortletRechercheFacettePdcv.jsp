<%@ page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file='/jcore/doInitPage.jspf'%>
<%@ include file='/jcore/portal/doPortletParams.jspf'%>

<% 
    PortletRechercheFacettes obj = (PortletRechercheFacettes)portlet;
    
    String query = Util.notEmpty(obj.getQueries()) ? obj.getQueries()[0] : "";
    request.setAttribute("query", query);
    
    Object publication = request.getAttribute(PortalManager.PORTAL_PUBLICATION);
    Boolean isInRechercheFacette = Util.isEmpty(publication);
    Boolean hasFonctionsAdditionnelles = false; // TODO
    Boolean showFiltres = isInRechercheFacette && Util.notEmpty(obj.getFacettesSecondaires()) || hasFonctionsAdditionnelles;
    request.setAttribute("showFiltres", showFiltres);
    
    request.setAttribute("rechercheId", obj.getId());
%>

<jalios:select>

	<jalios:if predicate="<%= isInRechercheFacette %>">
	    <jalios:include jsp="plugins/SoclePlugin/types/PortletRechercheFacettes/doPortletRechercheFacettesBoxDisplay.jsp" />
	</jalios:if>
	
	
	<jalios:default>	
		<div class="ds44-loader-text visually-hidden" tabindex="-1" aria-live="polite"></div>
		<div class="ds44-loader hidden">
		    <div class="ds44-loader-body">
		        <svg class="ds44-loader-circular" focusable="false" aria-hidden="true">
		            <circle class="ds44-loader-path" cx="30" cy="30" r="20" fill="none" stroke-width="5" stroke-miterlimit="10"></circle>
		        </svg>
		    </div>
		</div>
		        
		<form data-is-ajax='<%= isInRechercheFacette ? "true" : "false" %>' data-statistic='{"name": "declenche-evenement","category": "Formulaire","action": "Recherchez un contact","label": "$commune|text"}' data-auto-load='<%= isInRechercheFacette ? "true" : "false" %>' action='<%= isInRechercheFacette ? "plugins/SoclePlugin/jsp/facettes/displayResultDecodeParams.jsp" : channel.getPublication("$jcmsplugin.socle.recherche.facettes.portal").getDisplayUrl(userLocale) %>'>
		     <jalios:if predicate='<%= !isInRechercheFacette %>'>
		       <p class="ds44-textLegend ds44-textLegend--mentions txtcenter"><%= glp("jcmsplugin.socle.facette.champs-obligatoires") %></p>
		     </jalios:if>
		     
		     <jalios:foreach array="<%= obj.getFacettesPrincipales() %>" name="itFacette" type="AbstractPortletFacette" max="1">
		         <jalios:include pub="<%= itFacette %>" usage="box"/>
		     </jalios:foreach>
		 
		 
		     <input type="hidden" name='<%= "facetOperatorUnion" + glp("jcmsplugin.socle.facette.form-element") %>' value='<%= obj.getModeDesFacettes() %>' data-technical-field />
		     
		     <input type="hidden" name='<%= "sectorisation" + glp("jcmsplugin.socle.facette.form-element") %>' value='<%= obj.getSectorisation() %>' data-technical-field />
		 
		     <input type="hidden" name='<%= "modCatBranchesUnion" + glp("jcmsplugin.socle.facette.form-element") %>' value='<%= obj.getModeDesBranches() %>' data-technical-field />
		     <input type="hidden" name='<%= "modCatNivUnion" + glp("jcmsplugin.socle.facette.form-element") %>' value='<%= obj.getModeDesCategories() %>' data-technical-field />
		     
		     <jalios:if predicate="<%= Util.notEmpty(obj.getTypeDeLieu()) && Util.notEmpty(channel.getCategory(obj.getTypeDeLieu())) %>">
		       <input type="hidden" name='<%= "cidTypeLieu" + glp("jcmsplugin.socle.facette.form-element") %>' value="<%= channel.getCategory(obj.getTypeDeLieu()).getId() %>" data-technical-field />
		    </jalios:if>
		 
		     <input type="hidden" name='<%= "boxId" + glp("jcmsplugin.socle.facette.form-element") %>' value='<%= obj.getId() %>' data-technical-field />
		</form>		
	</jalios:default>
	
</jalios:select>
<% 
request.removeAttribute("rechercheId");
%>

