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
	
	boolean isContainerLarge = Util.isEmpty(request.getAttribute("cantonMapSearch"));
%>

<jalios:if predicate="<%= isContainerLarge %>">
    <div class="ds44-container-large">
</jalios:if>


    <div class="ds44-facette">
        <div class="ds44-facette-body">
	        <form role="search" method="POST" data-seo-url="false" data-keep-tab-name="true" data-search-url="plugins/SoclePlugin/jsp/facettes/displayParameters.jsp" data-is-ajax="true" data-auto-load="true" action="plugins/SoclePlugin/jsp/facettes/displayResultDecodeParams.jsp" novalidate="true">
	           
	            <input type="hidden" name="noFacette" value="true" data-technical-field />
	            
	            <% Integer codeCanton = null; %>	            
	            <jalios:if predicate='<%= Util.notEmpty(request.getAttribute("cantonMapSearch")) && (request.getAttribute("cantonMapSearch") instanceof Canton) %>'>
	               <% 
	               Canton cantonSearch = (Canton) request.getAttribute("cantonMapSearch");
	               codeCanton = cantonSearch.getCantonCode();
	               %>
	               <input type="hidden" name='<%= "canton" + glp("jcmsplugin.socle.facette.form-element") %>' value='<%= codeCanton %>' data-technical-field />        
	            </jalios:if>
	            
                <jalios:if predicate='<%= Util.notEmpty(request.getAttribute("currentCatSearch")) &&  Util.notEmpty(request.getAttribute("parentCatSearch"))%>'>
                   <input type="hidden" name='cids' value='<%= request.getAttribute("currentCatSearch") %>' data-technical-field />
                   <input type="hidden" name='cidBranches' value='<%= request.getAttribute("parentCatSearch") %>' data-technical-field />        
                </jalios:if>	            
	            
	            <%@ include file='/plugins/SoclePlugin/types/PortletRechercheFacettes/doSearchHiddenParams.jspf' %>
	            
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
	               data-geojson-refine='<%= obj.getCarteDynamique() %>' 
	               data-geojson-code='<%= codeCanton %>'></div>
	            <button type="button" title='<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.recherche.carte.masquer")) %>' class="ds44-btnStd-showMap ds44-btnStd ds44-btn--invert ds44-js-toggle-map-view">
	            <span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.recherche.carte.masquer") %></span><i class="icon icon-map" aria-hidden="true"></i>
	            </button>
	         </div>
	      </div>
	   </jalios:if>
	</div>

<jalios:if predicate="<%= isContainerLarge %>">
    </div>
</jalios:if>

<% 
request.removeAttribute("rechercheId");
%>

