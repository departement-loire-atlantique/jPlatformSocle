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
%>

<div class="ds44-inner-container ds44--mobile--m-padding-b">
	<header class="txtcenter">
		<h2 class="h2-like center"><%= Util.notEmpty(obj.getTitre(userLang)) ? obj.getTitre(userLang) : obj.getTitle(userLang) %></h2>
		<jalios:if predicate='<%= Util.notEmpty(obj.getSoustitre(userLang)) %>'>
			<p class="ds44-component-chapo ds44-centeredBlock"><%= obj.getSoustitre(userLang) %></p>
		</jalios:if>
	</header>
</div>

<form data-is-ajax="true">

	<p class="ds44-textLegend ds44-textLegend--mentions txtcenter"><%= glp("jcmsplugin.socle.facette.champs-obligatoires") %></p>
	<div class="ds44-facetteContainer ds44-bgDark ds44-flex-container ds44-small-flex-col">

		<% int maxFacettesPrincipales = SocleUtils.getNbrFacetteBeforeMaxWeight(4, obj.getFacettesPrincipales(), loggedMember); %>

		<jalios:foreach array="<%= obj.getFacettesPrincipales() %>" name="itFacette" type="AbstractPortletFacette" max="<%= maxFacettesPrincipales %>">

			<% Boolean isSelect = itFacette instanceof PortletFacetteCategorie || itFacette instanceof PortletFacetteCategoriesLiees; %>

			<div class='ds44-fieldContainer ds44-fg1 <%= isSelect ? "ds44-fieldContainer--select" : "" %>'>
				<jalios:include pub="<%= itFacette %>" usage="box"/>
			</div>
		</jalios:foreach>

		<div class="ds44-fieldContainer ds44-small-fg1">
			<% String styleButton = showFiltres ? "" : "--large"; %>
			<button class='<%= "ds44-btnStd ds44-btnStd"+styleButton+" ds44-theme" %>'>
				<span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.rechercher") %></span>
				<i class="icon icon-long-arrow-right" aria-hidden="true"></i>
			</button>
		</div>

	</div>

	<jalios:if predicate="<%= showFiltres %>">
		<div class="ds44-facetteContainer ds44-theme ds44-flex-container ds44-medium-flex-col">

			<jalios:if predicate='<%= Util.notEmpty(obj.getFacettesSecondaires()) %>'>
				<div class="ds44-flex-container ds44-medium-flex-col">
					<p class="ds44-heading ds44-fg1"><%= glp("jcmsplugin.socle.facette.filtrer-par") %></p>

					<% int maxFacettesSecondaires = SocleUtils.getNbrFacetteBeforeMaxWeight(8, obj.getFacettesSecondaires(), loggedMember); %>

					<jalios:foreach array="<%= obj.getFacettesSecondaires() %>" name="itFacette" type="AbstractPortletFacette" max="<%= maxFacettesSecondaires %>">

						<% Boolean isSelect = itFacette instanceof PortletFacetteCategorie || itFacette instanceof PortletFacetteCategoriesLiees; %>

						<div class='ds44-fieldContainer ds44-fg1 <%= isSelect ? "ds44-fieldContainer--select" : "" %>'>
							<jalios:include pub="<%= itFacette %>" usage="box"/>
						</div>

					</jalios:foreach>
				</div>
			</jalios:if>

			<jalios:if predicate="<%= hasFonctionsAdditionnelles %>">
				<div class="ds44-push ds44-small-fg1">
					<ul class="ds44-list">
						<li class="ds44-docListElem">
							<i class="icon icon-star-empty ds44-docListIco" aria-hidden="true"></i>
							<a href="#" aria-label="Ma sélection">Ma sélection (2)</a>
						</li>
						<li class="ds44-docListElem">
							<i class="icon icon-pdf ds44-docListIco" aria-hidden="true"></i>
							<a href="#" aria-label="PDF">PDF</a>
						</li>
						<li class="ds44-docListElem">
							<i class="icon icon-csv ds44-docListIco" aria-hidden="true"></i>
							<a href="#" aria-label="CSV">CSV</a>
						</li>
					</ul>
				</div>
			</jalios:if>

		</div>
	</jalios:if>

	<input type="hidden" name="boxId" value='<%= obj.getId() %>'/>

</form>