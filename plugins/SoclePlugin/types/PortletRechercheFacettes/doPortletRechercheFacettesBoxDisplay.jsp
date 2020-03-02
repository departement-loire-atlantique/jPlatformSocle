<%@ page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file='/jcore/doInitPage.jspf'%>
<%@ include file='/jcore/portal/doPortletParams.jspf'%>
<% 
	PortletRechercheFacettes obj = (PortletRechercheFacettes)portlet;
%>

<form data-is-ajax="true">

	<div class="ds44-facetteContainer ds44-bgDark ds44-flex-container ds44-small-flex-col">

		<% int maxFacettesPrincipales = SocleUtils.getNbrFacetteBeforeMaxWeight(4, obj.getFacettesPrincipales(), loggedMember); %>

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
		<div class="ds44-facetteContainer ds44-theme ds44-flex-container ds44-medium-flex-col">
			<div class="ds44-flex-container ds44-medium-flex-col">
				<p class="ds44-heading ds44-fg1"><%= glp("jcmsplugin.socle.facette.filtrer-par") %></p>

				<% int maxFacettesSecondaires = SocleUtils.getNbrFacetteBeforeMaxWeight(8, obj.getFacettesSecondaires(), loggedMember); %>

				<jalios:foreach array="<%= obj.getFacettesSecondaires() %>" name="itFacette" type="AbstractPortletFacette" max="<%= maxFacettesSecondaires %>">

					<div class="ds44-fieldContainer ds44-fg1 ds44-fieldContainer--select">
						<jalios:include pub="<%= itFacette %>" usage="box"/>
					</div>

				</jalios:foreach>
			</div>
			
		</jalios:foreach>
	</jalios:if>
	
	<input type="hidden" name="boxId" value='<%= obj.getId() %>'/>
	
</form>