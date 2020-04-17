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






<div class="ds44-loader-text visually-hidden" tabindex="-1" aria-live="polite"></div>
<div class="ds44-loader hidden">
    <div class="ds44-loader-body">
        <svg class="ds44-loader-circular" focusable="false" aria-hidden="true">
            <circle class="ds44-loader-path" cx="30" cy="30" r="20" fill="none" stroke-width="5" stroke-miterlimit="10"></circle>
        </svg>
    </div>
</div>





<div class="ds44-facette">
	<div class="ds44-facette-body">
	
	    <jalios:if predicate='<%= !isInRechercheFacette %>'>
			<div class="ds44-inner-container ds44--mobile--m-padding-b">
				<header class="txtcenter">
					<h2 class="h2-like center"><%= Util.notEmpty(obj.getTitre(userLang)) ? obj.getTitre(userLang) : obj.getTitle(userLang) %></h2>
					<jalios:if predicate='<%= Util.notEmpty(obj.getSoustitre(userLang)) %>'>
						<p class="ds44-component-chapo ds44-centeredBlock"><%= obj.getSoustitre(userLang) %></p>
					</jalios:if>
				</header>
			</div>
		</jalios:if>
		
		<form data-is-ajax='<%= isInRechercheFacette ? "true" : "false" %>' action='<%= isInRechercheFacette ? "plugins/SoclePlugin/jsp/facettes/displayResultDecodeParams.jsp" : channel.getPublication("$jcmsplugin.socle.recherche.facettes.portal").getDisplayUrl(userLocale) %>'>
		    <jalios:if predicate='<%= !isInRechercheFacette %>'>
			  <p class="ds44-textLegend ds44-textLegend--mentions txtcenter"><%= glp("jcmsplugin.socle.facette.champs-obligatoires") %></p>
			</jalios:if>
			<div class="ds44-facetteContainer ds44-bgDark ds44-flex-container ds44-medium-flex-col">
		
				<% int maxFacettesPrincipales = SocleUtils.getNbrFacetteBeforeMaxWeight(4, obj.getFacettesPrincipales(), loggedMember); %>
		
				<jalios:foreach array="<%= obj.getFacettesPrincipales() %>" name="itFacette" type="AbstractPortletFacette" max="<%= maxFacettesPrincipales %>">
		
					<% Boolean isSelect = itFacette instanceof PortletFacetteCategorie || itFacette instanceof PortletFacetteCategoriesLiees; %>
		
					<div class='ds44-fieldContainer ds44-fg1 <%= isSelect ? "ds44-fieldContainer--select" : "" %>'>
						<jalios:include pub="<%= itFacette %>" usage="box"/>
					</div>
				</jalios:foreach>
		
				<div class="ds44-fieldContainer ds44-small-fg1">
					<% String styleButton = showFiltres ? "" : "--large"; %>
					<button class='<%= "jcms-js-submit ds44-btnStd ds44-btnStd"+styleButton+" ds44-theme" %>' title="<%= glp("jcmsplugin.socle.lancer.recherche") %>">
						<span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.rechercher") %></span>
						<i class="icon icon-long-arrow-right" aria-hidden="true"></i>
					</button>					
				</div>
		
			</div>
		
			<jalios:if predicate="<%= showFiltres %>">
				<div class="ds44-facetteContainer ds44-theme ds44-flex-container ds44-medium-flex-col">
		
					<jalios:if predicate='<%= Util.notEmpty(obj.getFacettesSecondaires()) %>'>
						<div class="ds44-fg1 ds44-flex-container ds44-medium-flex-col">
							<p class="ds44-heading ds44-small-fg1"><%= glp("jcmsplugin.socle.facette.filtrer-par") %></p>
		
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
						<div class="ds44-push ds44-small-fg1 ds44-hide-tiny-to-medium ds44-show-medium">
							<ul class="ds44-list">
								<li class="ds44-docListElem">
									<i class="icon icon-star-empty ds44-docListIco" aria-hidden="true"></i>
									<a href="#" title='<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.recherche.selection")) %>'><%= glp("jcmsplugin.socle.recherche.ma-selection", 2) %></a>
								</li>
								<li class="ds44-docListElem">
									<i class="icon icon-pdf ds44-docListIco" aria-hidden="true"></i>
									<a href="#" title='<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.recherche.export.pdf")) %>'><%= glp("jcmsplugin.socle.recherche.export.pdf") %></a>
								</li>
								<li class="ds44-docListElem">
									<i class="icon icon-csv ds44-docListIco" aria-hidden="true"></i>
									<a href="#" aria-label='<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.recherche.export.csv")) %>'><%= glp("jcmsplugin.socle.recherche.export.csv") %></a>
								</li>
							</ul>
						</div>
					</jalios:if>
		
				</div>
			</jalios:if>
		
		
            <input type="hidden" name='<%= "facetOperatorUnion" + glp("jcmsplugin.socle.facette.form-element") %>' value='<%= obj.getModeDesFacettes() %>' data-technical-field />
            
            <input type="hidden" name='<%= "sectorisation" + glp("jcmsplugin.socle.facette.form-element") %>' value='<%= obj.getSectorisation() %>' data-technical-field />
		
            <input type="hidden" name='<%= "modCatBranchesUnion" + glp("jcmsplugin.socle.facette.form-element") %>' value='<%= obj.getModeDesBranches() %>' data-technical-field />
            <input type="hidden" name='<%= "modCatNivUnion" + glp("jcmsplugin.socle.facette.form-element") %>' value='<%= obj.getModeDesCategories() %>' data-technical-field />
		
            <input type="hidden" name='<%= "boxId" + glp("jcmsplugin.socle.facette.form-element") %>' value='<%= obj.getId() %>' data-technical-field />
		
		</form>
	</div>
	
	
	<jalios:if predicate='<%= isInRechercheFacette %>'>
		<div class="ds44-facette-mobile-button ds44-bgDark ds44--l-padding ds44-show-tiny-to-medium ds44-hide-medium">
	        <button class="ds44-btnStd ds44-btn--contextual ds44-w100 ds44-js-toggle-search-view">
	            <span class="ds44-btnInnerText ds44-facette-mobile-button-collapse"><%= glp("jcmsplugin.socle.recherche.affiner") %></span>
	            <span class="ds44-btnInnerText ds44-facette-mobile-button-expand"><%= glp("jcmsplugin.socle.recherche.masquer") %></span>
	        </button>
	    </div>
	    
	    
	    <jalios:if predicate="<%= hasFonctionsAdditionnelles %>">
		     <div class="ds44-facette-mobile-export ds44-push ds44-small-fg1 ds44-show-tiny-to-medium ds44-hide-medium">
		        <ul class="ds44-list">
		            <li class="ds44-docListElem">
		                <i class="icon icon-star-empty ds44-docListIco" aria-hidden="true"></i>
		                <a href="#"><%= glp("jcmsplugin.socle.recherche.ma-selection", 2) %></a>
		            </li>
		            <li class="ds44-docListElem">
		                <i class="icon icon-pdf ds44-docListIco" aria-hidden="true"></i>
		                <a href="#"><%= glp("jcmsplugin.socle.recherche.export.pdf") %></a>
		            </li>
		            <li class="ds44-docListElem">
		                <i class="icon icon-csv ds44-docListIco" aria-hidden="true"></i>
		                <a href="#"><%= glp("jcmsplugin.socle.recherche.export.csv") %></a>
		            </li>
		        </ul>
		    </div>
	   </jalios:if>
    </jalios:if>
    
    
    
</div>



<jalios:if predicate='<%= isInRechercheFacette %>'>

	  <div class='ds44-flex-container ds44-results ds44-results<%=  obj.getAffichageDeLaCarte() ? "--mapVisible" : "" %>'>
	      <div class="ds44-listResults ds44-innerBoxContainer ds44-innerBoxContainer--list">
	          <div class="ds44-js-results-container">
	              <div class="ds44-js-results-card" data-url="plugins/SoclePlugin/jsp/facettes/displayPub.jsp" aria-hidden="true"></div>
	              <div class="ds44-js-results-list">
	                  <p aria-level="2" rôle="heading" id="ds44-results-new-search" class="h3-like mbs txtcenter center ds44--3xl-padding-t ds44--3xl-padding-b"><%= glp("jcmsplugin.socle.faire.recherche") %></p>
	                  <p class="ds44-textLegend mbs hidden"><%= glp("jcmsplugin.socle.recherche.trop.resultats", obj.getMaxResults()) %></p>
	              </div>
	          </div>
	      </div>
	      
	      <jalios:if predicate="<%= obj.getAffichageDeLaCarte() %>">
		      <div class="ds44-mapResults">
		          <div class="ds44-js-map"></div>
		      </div>
		      <button type="button" title="<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.recherche.carte.masquer")) %>" class="ds44-btnStd-showMap ds44-btnStd ds44-btn--invert ds44-js-toggle-map-view">
		          <span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.recherche.carte.masquer") %></span><i class="icon icon-map" aria-hidden="true"></i>
		      </button>
	      </jalios:if>
	      
	      
	  </div>
	
</jalios:if>


<% 
request.removeAttribute("rechercheId");
%>

<%-- TODO Méthode temporaire pour soumettre le formulaire à l'affiche de la recherche à facette --%> 
<jalios:if predicate="<%= isInRechercheFacette && request.getParameterMap().size() > 6 %>">
	<script>
	  function submitForm(){
		  document.getElementsByClassName("jcms-js-submit")[0].click();
      }    
      setTimeout(submitForm, 200);	  
	</script>
</jalios:if>
