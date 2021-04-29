<%@ page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file='/jcore/doInitPage.jspf'%>
<%@ include file='/jcore/portal/doPortletParams.jspf'%>
<%@ include file='/plugins/SoclePlugin/jsp/facettes/commonParamsFacettes.jspf'%>
<% 

	PortletRechercheFacettes obj = (PortletRechercheFacettes)portlet;

    boolean isInPortletConteneur = Util.notEmpty(request.getAttribute("isInPortletConteneur")) ? true : false;

    isInRechercheFacette = isInRechercheFacette || obj.getAfficherResultatDansLannuaire();
    
    // SEO : bloque l'indexation des pages de résultats
    if(isInRechercheFacette){
      request.setAttribute("noindex", true);
      
      // Analytics : personnalisation du titre de page
      String pubTitle = "";
      if(Util.notEmpty(request.getParameter("pubId[value]"))){
        Publication pub = channel.getPublication(request.getParameter("pubId[value]"));
        pubTitle = " - " + pub.getTitle();
      }
      jcmsContext.setPageTitle(glp("jcmsplugin.socle.title.recherche-facettes") + pubTitle);
    }
	
	String query = Util.notEmpty(obj.getQueries()) ? obj.getQueries()[0] : "";
	request.setAttribute("query", query);
	
	Boolean hasFonctionsAdditionnelles = false; // TODO
	Boolean showFiltres = isInRechercheFacette && Util.notEmpty(obj.getFacettesSecondaires()) || hasFonctionsAdditionnelles;
	request.setAttribute("showFiltres", showFiltres);
	
	request.setAttribute("rechercheId", obj.getId());
%>


<jalios:if predicate="<%= isInPortletConteneur %>">
    <div class="ds44-container-large">
</jalios:if>



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
	
	    <jalios:if predicate='<%= obj.getAfficherResultatDansLannuaire() || (!isInRechercheFacette && Util.notEmpty(obj.getTitre(userLang))) %>'>
			<div class="ds44-inner-container ds44--mobile--m-padding-b">
				<header class="txtcenter ds44--l-padding-b">
					<h2 class="h2-like center"><%= obj.getTitre(userLang) %></h2>
					<jalios:if predicate='<%= Util.notEmpty(obj.getSoustitre(userLang)) %>'>
						<p class="ds44-component-chapo ds44-centeredBlock"><%= obj.getSoustitre(userLang) %></p>
					</jalios:if>
				</header>
			</div>
		</jalios:if>
		
		
		<% 
	    // Url en utilsant le titre de la facette et non le titre du portal général facette
        // Permet d'avoir une url différente par recherche mais l'id reste celui du portal
		
        Publication portalFacet = channel.getPublication("$jcmsplugin.socle.recherche.facettes.portal");
		String urlFacet = DescriptiveURLs.getDescriptiveURL(portalFacet, userLocale);
		
		String descPortal = DescriptiveURLs.cleanDescriptiveURLText(portalFacet.getTitle(userLang), userLocale);
		String descFacet = DescriptiveURLs.cleanDescriptiveURLText(obj.getTitre(userLang), userLocale);
			
		// Remplace le titre de l'url par le titre de la recherche à facette au lieu du titre du portail
		String seoUrl = urlFacet.replaceAll(descPortal, descFacet);
		%>

		<form method='<%= channel.getBooleanProperty("jcmsplugin.socle.url-rewriting", false) ? "POST" : "GET" %>' data-seo-url='<%= channel.getProperty("jcmsplugin.socle.url-rewriting")%>' data-search-url="plugins/SoclePlugin/jsp/facettes/displayParameters.jsp" data-is-ajax='<%= isInRechercheFacette ? "true" : "false" %>' data-auto-load='<%= isInRechercheFacette ? "true" : "false" %>' action='<%= isInRechercheFacette ? "plugins/SoclePlugin/jsp/facettes/displayResultDecodeParams.jsp" : seoUrl + "?boxId=" + obj.getId() %>'>
		    <jalios:if predicate='<%= !isInRechercheFacette %>'>
			  <p class="ds44-textLegend ds44-textLegend--mentions txtcenter"><%= glp("jcmsplugin.socle.facette.champs-obligatoires") %></p>
			</jalios:if>
		    
		    <input type="hidden" name='<%= "typeDeTuileFicheLieu" + glp("jcmsplugin.socle.facette.form-element") %>' value='<%= obj.getTypeDeTuileFicheLieu() %>' data-technical-field />
		
            <input type="hidden" name='<%= "facetOperatorUnion" + glp("jcmsplugin.socle.facette.form-element") %>' value='<%= obj.getModeDesFacettes() %>' data-technical-field />
            
            <input type="hidden" name='<%= "sectorisation" + glp("jcmsplugin.socle.facette.form-element") %>' value='<%= obj.getSectorisation() %>' data-technical-field />
		    <input type="hidden" name='<%= "afficheCarte" + glp("jcmsplugin.socle.facette.form-element") %>' value="<%= obj.getAffichageDeLaCarte() %>" data-technical-field />
		
            <input type="hidden" name='<%= "modCatBranchesUnion" + glp("jcmsplugin.socle.facette.form-element") %>' value='<%= obj.getModeDesBranches() %>' data-technical-field />
            <input type="hidden" name='<%= "modCatNivUnion" + glp("jcmsplugin.socle.facette.form-element") %>' value='<%= obj.getModeDesCategories() %>' data-technical-field />
            
            <jalios:if predicate="<%= Util.notEmpty(obj.getTypeDeLieu()) && Util.notEmpty(channel.getCategory(obj.getTypeDeLieu())) %>">
		       <input type="hidden" name='<%= "cidTypeLieu" + glp("jcmsplugin.socle.facette.form-element") %>' value="<%= channel.getCategory(obj.getTypeDeLieu()).getId() %>" data-technical-field />
		    </jalios:if>
		
            <input type="hidden" name='<%= "boxId" + glp("jcmsplugin.socle.facette.form-element") %>' value='<%= obj.getId() %>' data-technical-field />
            <input type="hidden" name='pubId' value='<%= Util.notEmpty(request.getAttribute("publication")) ? ((Publication)request.getAttribute("publication")).getId() : "" %>' data-technical-field />
		</form>
	</div>
    
</div>




    
	  <div class='ds44-flex-container ds44-results ds44-results<%=  obj.getAffichageDeLaCarte() ? "--mapVisible" : "" %> ds44-results--empty'>
	      <div class="ds44-listResults ds44-innerBoxContainer ds44-innerBoxContainer--list">
	          <div class="ds44-js-results-container">
	              <div class="ds44-js-results-card" data-url="plugins/SoclePlugin/jsp/facettes/displayPub.jsp" aria-hidden="true"></div>
	              <div class="ds44-js-results-list" data-display-mode='<%= obj.getModeDaffichageDuContenu() ? "external" : "inline" %>'>
	                  <p aria-level="2" role="heading" id="ds44-results-new-search" class="h3-like mbs txtcenter center ds44--3xl-padding-t ds44--3xl-padding-b">
	                    <span aria-level="2" role="heading"><%= glp("jcmsplugin.socle.faire.recherche") %></span>
	                  </p>            
	              </div>
	          </div>
	      </div>
	      
	      <jalios:if predicate="<%= obj.getAffichageDeLaCarte() %>">
		      
		      <button type="button" title='<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.recherche.carte.masquer")) %>' class="ds44-btnStd-showMap ds44-btnStd ds44-btn--invert ds44-js-toggle-map-view">
                <span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.recherche.carte.masquer") %></span><i class="icon icon-map" aria-hidden="true"></i>
              </button>
		      
		      <div class="ds44-mapResults">
		          <div class="ds44-mapResults-container">
				      <div class="ds44-js-map" 
                      		data-geojson-url='<%= Util.notEmpty(obj.getUrlDeGeojsonLibre()) ? obj.getUrlDeGeojsonLibre() : channel.getProperty(obj.getTypeDeCarte()) %>' 
                      		data-geojson-mode='<%= obj.getNatureDeLaCarte() ? "static" : "dynamic" %>' 
                      		data-geojson-refine='<%= obj.getCarteDynamique() %>'></div>
				      
				      <button type="button" title='<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.recherche.carte.masquer")) %>' class="ds44-btnStd-showMap ds44-btnStd ds44-btn--invert ds44-js-toggle-map-view">
				          <span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.recherche.carte.masquer") %></span><i class="icon icon-map" aria-hidden="true"></i>
				      </button>
				  </div>
			   </div>
	      </jalios:if>
	      
	      
	  </div>


<jalios:if predicate="<%= isInPortletConteneur %>">
    </div>
</jalios:if>

<% 
request.removeAttribute("rechercheId");
%>

