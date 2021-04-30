<%@ page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file='/jcore/doInitPage.jspf'%>
<%@ include file='/jcore/portal/doPortletParams.jspf'%>
<%@ include file='/plugins/SoclePlugin/jsp/facettes/commonParamsFacettes.jspf'%>
<% 

	PortletRechercheFacettes obj = (PortletRechercheFacettes)portlet;

    boolean isInPortletConteneur = Util.notEmpty(request.getAttribute("isInPortletConteneur")) ? true : false;

    isInRechercheFacette = isInRechercheFacette || obj.getAfficherResultatDansLannuaire();
	
	String query = Util.notEmpty(obj.getQueries()) ? obj.getQueries()[0] : "";
	request.setAttribute("query", query);
	
	Boolean hasFonctionsAdditionnelles = false; // TODO
	Boolean showFiltres = isInRechercheFacette && Util.notEmpty(obj.getFacettesSecondaires()) || hasFonctionsAdditionnelles;
	request.setAttribute("showFiltres", showFiltres);
	
	request.setAttribute("rechercheId", obj.getId());
	request.setAttribute("noFacette", true);
%>


<div class="ds44-container-large">
    <div class="ds44-facette">
        <div class="ds44-facette-body">
	        <form method="POST" data-seo-url="false" data-keep-tab-name="true" data-search-url="plugins/SoclePlugin/jsp/facettes/displayParameters.jsp" data-is-ajax="true" data-auto-load="true" action="plugins/SoclePlugin/jsp/facettes/displayResultDecodeParams.jsp" novalidate="true">
	           
	            <input type="hidden" name='<%= "typeDeTuileFicheLieu" + glp("jcmsplugin.socle.facette.form-element") %>' value='<%= obj.getTypeDeTuileFicheLieu() %>' data-technical-field />
	        
	            <input type="hidden" name='<%= "facetOperatorUnion" + glp("jcmsplugin.socle.facette.form-element") %>' value='<%= obj.getModeDesFacettes() %>' data-technical-field />
	            
	            <input type="hidden" name='<%= "sectorisation" + glp("jcmsplugin.socle.facette.form-element") %>' value='<%= obj.getSectorisation() %>' data-technical-field />
	            <input type="hidden" name='<%= "afficheCarte" + glp("jcmsplugin.socle.facette.form-element") %>' value="<%= obj.getAffichageDeLaCarte() %>" data-technical-field />
	        
	            <input type="hidden" name='<%= "modCatBranchexsUnion" + glp("jcmsplugin.socle.facette.form-element") %>' value='<%= obj.getModeDesBranches() %>' data-technical-field />
	            <input type="hidden" name='<%= "modCatNivUnion" + glp("jcmsplugin.socle.facette.form-element") %>' value='<%= obj.getModeDesCategories() %>' data-technical-field />
	            
	            <jalios:if predicate="<%= Util.notEmpty(obj.getTypeDeLieu()) && Util.notEmpty(channel.getCategory(obj.getTypeDeLieu())) %>">
	               <input type="hidden" name='<%= "cidTypeLieu" + glp("jcmsplugin.socle.facette.form-element") %>' value="<%= channel.getCategory(obj.getTypeDeLieu()).getId() %>" data-technical-field />
	            </jalios:if>
	        
	            <input type="hidden" name='<%= "boxId" + glp("jcmsplugin.socle.facette.form-element") %>' value='<%= obj.getId() %>' data-technical-field />
	            <input type="hidden" name='pubId' value='<%= Util.notEmpty(request.getAttribute("publication")) ? ((Publication)request.getAttribute("publication")).getId() : "" %>' data-technical-field />
	        </form>
        </div>
    </div>

	<div class="ds44-loader-text visually-hidden" tabindex="-1" aria-live="polite"></div>
	
	<div class="ds44-loader hidden">
	   <div class="ds44-loader-body">
	      <svg class="ds44-loader-circular" focusable="false" aria-hidden="true">
	         <circle class="ds44-loader-path" cx="30" cy="30" r="20" fill="none" stroke-width="5" stroke-miterlimit="10"></circle>
	      </svg>
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

</div>
<% 
request.removeAttribute("rechercheId");
request.removeAttribute("noFacette");
%>

