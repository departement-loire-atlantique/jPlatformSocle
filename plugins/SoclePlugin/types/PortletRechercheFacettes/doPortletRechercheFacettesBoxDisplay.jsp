<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file='/jcore/doInitPage.jspf'%>
<%@ include file='/jcore/portal/doPortletParams.jspf'%>
<% 
	PortletRechercheFacettes obj = (PortletRechercheFacettes)portlet;
%>

<form data-is-ajax="true">

	<div class="ds44-facetteContainer ds44-bgDark ds44-flex-container ds44-small-flex-col">

		<%
			int weight = 0;
			int maxFacettesPrincipales = 0;
			
			for(AbstractPortletFacette itFacette : obj.getFacettesPrincipales()) {
				
				if(itFacette instanceof PortletFacetteCategoriesLiees 
						|| itFacette instanceof PortletFacetteCommuneAdresseLiee 
						|| (itFacette instanceof PortletFacetteAdresse
								&& Util.notEmpty(((PortletFacetteAdresse)itFacette).getRayon(loggedMember)))) {
					
					weight += 2;
					
				} else {
					
					weight ++;
				}
				// if too much facette
				if(weight > 4) break;
				
				maxFacettesPrincipales++;
			}
		%>
		
		<jalios:foreach array="<%= obj.getFacettesPrincipales() %>" name="itFacette" type="AbstractPortletFacette" max="<%= maxFacettesPrincipales %>">
			<div class="ds44-fieldContainer ds44-fg1">
				<jalios:include pub="<%= itFacette %>" usage="box"/>
			</div>
		</jalios:foreach>

		<div class="ds44-fieldContainer ds44-small-fg1">
			<button class="ds44-btnStd ds44-btnStd--large ds44-theme">
				<span class="ds44-btnInnerText">Rechercher</span>
				<i class="icon icon-long-arrow-right" aria-hidden="true"></i>
			</button>
		</div>

	</div>

	<jalios:if predicate="<%= Util.notEmpty(obj.getFacettesSecondaires()) %>">
		<jalios:foreach array="<%= obj.getFacettesSecondaires() %>" name="itFacette" type="AbstractPortletFacette">
		
			<div class="ds44-fieldContainer ds44-fg1">
				<jalios:include pub="<%= itFacette %>" usage="box"/>
			</div>
			
		</jalios:foreach>
	</jalios:if>
	
	<input type="hidden" name="boxId" value='<%= obj.getId() %>'/>
	
</form>