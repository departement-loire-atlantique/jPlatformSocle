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
        
            <input type="hidden" name='<%= "boxId" + glp("jcmsplugin.socle.facette.form-element") %>' value='<%= obj.getId() %>' data-technical-field />
        
            <input type="hidden" name='<%= "typeCarte" + glp("jcmsplugin.socle.facette.form-element") %>' value='<%= obj.getTypeDeCarte() %>' data-technical-field />
            <input type="hidden" name='<%= "natureCarte" + glp("jcmsplugin.socle.facette.form-element") %>' value='<%= obj.getNatureDeLaCarte() ? "contour" : "actif" %>' data-technical-field />

            <input type="hidden" name='<%= "displayMode" + glp("jcmsplugin.socle.facette.form-element") %>' value='<%= obj.getModeDaffichageDuContenu() ? "inline" : "external" %>' data-technical-field />
        </form>

<jalios:if predicate='<%= isInRechercheFacette %>'>

    
      <div class='ds44-flex-container ds44-results ds44-results<%=  obj.getAffichageDeLaCarte() ? "--mapVisible" : "" %> ds44-results--empty'>
          <div class="ds44-listResults ds44-innerBoxContainer ds44-innerBoxContainer--list">
              <div class="ds44-js-results-container">
                  <div class="ds44-js-results-card" data-url="plugins/SoclePlugin/jsp/facettes/displayPub.jsp" aria-hidden="true"></div>
                  <div class="ds44-js-results-list">
                      <p aria-level="2" rôle="heading" id="ds44-results-new-search" class="h3-like mbs txtcenter center ds44--3xl-padding-t ds44--3xl-padding-b">
                        <span aria-level="2" role="heading"><%= glp("jcmsplugin.socle.faire.recherche") %></span>
                      </p>            
                  </div>
              </div>
          </div>
          
          <jalios:if predicate="<%= obj.getAffichageDeLaCarte() %>">
              
              <button type="button" title="Masquer la carte" class="ds44-btnStd-showMap ds44-btnStd ds44-btn--invert ds44-js-toggle-map-view">
                <span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.recherche.carte.masquer") %></span><i class="icon icon-map" aria-hidden="true"></i>
              </button>
              
              <div class="ds44-mapResults">
                  <div class="ds44-mapResults-container">
                      <div class="ds44-js-map"></div>
                      
                      <button type="button" title="<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.recherche.carte.masquer")) %>" class="ds44-btnStd-showMap ds44-btnStd ds44-btn--invert ds44-js-toggle-map-view">
                          <span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.recherche.carte.masquer") %></span><i class="icon icon-map" aria-hidden="true"></i>
                      </button>
                  </div>
          </jalios:if>
          
          
      </div>

</jalios:if>


<% 
request.removeAttribute("rechercheId");
%>

