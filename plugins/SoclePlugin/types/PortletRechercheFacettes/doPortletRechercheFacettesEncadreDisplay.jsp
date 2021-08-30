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
	
	request.setAttribute("isInEncadre", true);
%>




<jalios:select>

    <jalios:if predicate="<%= isInRechercheFacette %>">
        <jalios:include jsp="plugins/SoclePlugin/types/PortletRechercheFacettes/doPortletRechercheFacettesBoxDisplay.jsp" />
    </jalios:if>
    
    <jalios:default>   
    
	    <section class="ds44-box ds44-theme ds44-mb3">
	        <div class="ds44-innerBoxContainer">
	     
		        <div class="ds44-loader-text visually-hidden" tabindex="-1" aria-live="polite"></div>
		        <div class="ds44-loader hidden">
		            <div class="ds44-loader-body">
		                <svg class="ds44-loader-circular" focusable="false" aria-hidden="true">
		                    <circle class="ds44-loader-path" cx="30" cy="30" r="20" fill="none" stroke-width="5" stroke-miterlimit="10"></circle>
		                </svg>
		            </div>
		        </div>
		        
	        
		        <p role="heading" aria-level="2" class="ds44-box-heading"><%= obj.getTitre(userLang) %></p>
		        <jalios:if predicate='<%= Util.notEmpty(obj.getSoustitre(userLang)) %>'>
		          <p class="ds44-textLegend ds44-textLegend--mentions "><%= obj.getSoustitre(userLang) %></p>
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
		        

		        <form role="search" method='<%= channel.getBooleanProperty("jcmsplugin.socle.url-rewriting", false) ? "POST" : "GET" %>' data-seo-url='<%= channel.getProperty("jcmsplugin.socle.url-rewriting")%>' data-search-url="plugins/SoclePlugin/jsp/facettes/displayParameters.jsp" data-is-ajax='false' data-auto-load='false' action='<%= seoUrl + "?boxId=" + obj.getId() %>'>
		        
		        
		            <% 
                    int maxFacettesPrincipales = SocleUtils.getNbrFacetteBeforeMaxWeight(4, obj.getFacettesPrincipales(), loggedMember); 
                    request.setAttribute("isFilter", false);
                    %>
        
	                <jalios:foreach array="<%= obj.getFacettesPrincipales() %>" name="itFacette" type="AbstractPortletFacette" max="<%= maxFacettesPrincipales %>">
	        
	                    <% Boolean isSelect = itFacette instanceof PortletFacetteCategorie || itFacette instanceof PortletFacetteCategoriesLiees; %>
	        
	                    <div class='ds44-fg1 <%= isSelect ? "ds44-fieldContainer--select" : "" %>'>
	                        <jalios:include pub="<%= itFacette %>" usage="box"/>
	                    </div>
	                    
	                </jalios:foreach>
	
	                <% request.removeAttribute("isFilter"); %>		      		        	        
		        
		            <%@ include file='/plugins/SoclePlugin/types/PortletRechercheFacettes/doSearchHiddenParams.jspf' %>
		        		        
			        <button class="ds44-btnStd ds44-btn--invert" type="submit" title='<%= JcmsUtil.glp(userLang,"jcmsplugin.socle.menu.pdcv.valider") %>'>
	                    <span class="ds44-btnInnerText"><%= JcmsUtil.glp(userLang,"jcmsplugin.socle.valider") %></span><i class="icon icon-long-arrow-right" aria-hidden="true"></i>
	                </button>
	                
	           </form>
		        
		        
	        </div>
	    </section>
        
    </jalios:default>
    
    
</jalios:select>


<% 
request.removeAttribute("rechercheId");
request.removeAttribute("isInEncadre");
%>

