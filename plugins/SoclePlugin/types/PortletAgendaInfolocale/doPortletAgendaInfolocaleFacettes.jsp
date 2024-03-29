<%@page import="fr.cg44.plugin.socle.infolocale.InfolocaleMetadataUtils"%>
<%@page import="fr.cg44.plugin.socle.infolocale.entities.DateHoraires"%>
<%@page import="fr.cg44.plugin.socle.infolocale.util.InfolocaleUtil"%>
<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@page import="fr.cg44.plugin.socle.infolocale.InfolocaleEntityUtils"%>
<%@page import="fr.cg44.plugin.socle.infolocale.RequestManager"%>
<%@page import="org.json.JSONObject"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jsp'%>
<%@ include file="/jcore/portal/doPortletParams.jspf" %>
<%@ include file='/plugins/SoclePlugin/jsp/facettes/commonParamsFacettes.jspf' %>
<%
   PortletAgendaInfolocale box = (PortletAgendaInfolocale) portlet;
   
   Boolean hasFonctionsAdditionnelles = false; // TODO
   Boolean showFiltres = isInRechercheFacette && Util.notEmpty(box.getFacettesSecondaires()) || hasFonctionsAdditionnelles;
   request.setAttribute("showFiltres", showFiltres);
   
   request.setAttribute("rechercheId", box.getId());
   
   String fluxId = Util.isEmpty(box.getIdDeFlux()) ? channel.getProperty("jcmsplugin.socle.infolocale.flux.default") : box.getIdDeFlux();
   
   request.setAttribute("fluxId", fluxId);
   %>
<div class="ds44-container-large">
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
	      <jalios:if predicate='<%= !isInRechercheFacette && Util.notEmpty(box.getTitre(userLang)) %>'>
	         <div class="ds44-inner-container ds44--mobile--m-padding-b">
	            <header class="txtcenter ds44--l-padding-b">
	               <h2 class="h2-like center"><%= box.getTitre(userLang) %></h2>
	               <jalios:if predicate='<%= Util.notEmpty(box.getSoustitre(userLang)) %>'>
	                  <p class="ds44-component-chapo ds44-centeredBlock"><%= box.getSoustitre(userLang) %></p>
	               </jalios:if>
	            </header>
	         </div>
	      </jalios:if>
	      <form data-is-ajax='<%= isInRechercheFacette ? "true" : "false" %>' data-auto-load='<%= isInRechercheFacette ? "true" : "false" %>' action='<%= isInRechercheFacette ? "plugins/SoclePlugin/jsp/facettes/displayResultDecodeParams.jsp" : channel.getPublication("$jcmsplugin.socle.recherche.facettes.portal").getDisplayUrl(userLocale) %>'>
	         <jalios:if predicate='<%= !isInRechercheFacette %>'>
	            <p class="ds44-textLegend ds44-textLegend--mentions txtcenter"><%= glp("jcmsplugin.socle.facette.champs-obligatoires") %></p>
	         </jalios:if>
	         <div class="ds44-facetteContainer ds44-bgDark ds44-flex-container ds44-medium-flex-col">
	            <% 
	               int maxFacettesPrincipales = SocleUtils.getNbrFacetteBeforeMaxWeight(4, box.getPortletsFacettesAgenda(), loggedMember); 
	               request.setAttribute("isFilter", false);
	               %>
	            <jalios:foreach array="<%= box.getPortletsFacettesAgenda() %>" name="itFacette" type="AbstractPortletFacette" max="<%= maxFacettesPrincipales %>">
	               <% Boolean isSelect = (itFacette instanceof PortletFacetteAgendaCategorie) || (itFacette instanceof PortletFacetteAgendaAccessibilit) || (itFacette instanceof PortletFacetteAgendaDate); %>
	               <div class='ds44-fieldContainer ds44-fg1 <%= isSelect ? "ds44-fieldContainer--select" : "" %>'>
	                  <jalios:include pub="<%= itFacette %>" usage="box"/>
	               </div>
	            </jalios:foreach>
	            <input type="hidden" name="redirectUrl" value="plugins/SoclePlugin/types/PortletAgendaInfolocale/displayResultAgenda.jsp" data-technical-field />
	            <input type="hidden" name="boxId" value="<%= box.getId() %>" data-technical-field />
	            <% request.removeAttribute("isFilter"); %>
	            <div class="ds44-fieldContainer ds44-small-fg1">
	               <% String styleButton = isInRechercheFacette ? "" : "--large"; %>
	               <button class='<%= "jcms-js-submit ds44-btnStd ds44-btnStd"+styleButton+" ds44-theme" %>'>
	               <span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.rechercher") %></span>
	               <i class="icon icon-long-arrow-right" aria-hidden="true"></i>
	               </button>                   
	            </div>
	         </div>
	         
	         <jalios:if predicate="<%= showFiltres %>">
                <div class="ds44-facetteContainer ds44-theme ds44-flex-container ds44-medium-flex-col">
        
                    <jalios:if predicate='<%= Util.notEmpty(box.getFacettesSecondaires()) %>'>
                        <div class="ds44-fg1 ds44-flex-container ds44-medium-flex-col">
                            <p class="ds44-heading ds44-small-fg1"><%= glp("jcmsplugin.socle.facette.filtrer-par") %></p>
        
                            <% 
                                int maxFacettesSecondaires = SocleUtils.getNbrFacetteBeforeMaxWeight(8, box.getFacettesSecondaires(), loggedMember); 
                                request.setAttribute("isFilter", true);
                            %>

                            <jalios:foreach array="<%= box.getFacettesSecondaires() %>" name="itFacette" type="AbstractPortletFacette" max="<%= maxFacettesSecondaires %>">
        
                                <% Boolean isSelect = itFacette instanceof PortletFacetteAgendaCategorie; %>
        
                                <div class='ds44-fieldContainer ds44-fg1 <%= isSelect ? "ds44-fieldContainer--select" : "" %>'>
                                    <jalios:include pub="<%= itFacette %>" usage="box"/>
                                </div>
        
                            </jalios:foreach>

                            <% request.removeAttribute("isFilter"); %>

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
	         
	         <input type="hidden" name='<%= "boxId" + glp("jcmsplugin.socle.facette.form-element") %>' value='<%= box.getId() %>' data-technical-field />
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
	   <div class='ds44-flex-container ds44-results ds44-results<%=  "listmap".equals(box.getTypeDaffichage()) ? "--mapVisible" : "" %> ds44-results--empty'>
	   <div class="ds44-listResults ds44-innerBoxContainer ds44-innerBoxContainer--list">
	      <div class="ds44-js-results-container">
	         <div class="ds44-js-results-card" data-url="plugins/SoclePlugin/jsp/facettes/displayPub.jsp" aria-hidden="true"></div>
	         <div class="ds44-js-results-list" data-display-mode='<%= true ? "external" : "inline" %>'>
	            <p aria-level="2" role="heading" id="ds44-results-new-search" class="h3-like mbs txtcenter center ds44--3xl-padding-t ds44--3xl-padding-b">
	               <span aria-level="2" role="heading"><%= glp("jcmsplugin.socle.faire.recherche") %></span>
	            </p>
	         </div>
	      </div>
	   </div>
	   <jalios:if predicate='<%= "listmap".equals(box.getTypeDaffichage()) %>'>
	      <button type="button" title='<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.recherche.carte.masquer")) %>' class="ds44-btnStd-showMap ds44-btnStd ds44-btn--invert ds44-js-toggle-map-view">
	      <span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.recherche.carte.masquer") %></span><i class="icon icon-map" aria-hidden="true"></i>
	      </button>
	      <div class="ds44-mapResults">
	         <div class="ds44-mapResults-container">
	            <div class="ds44-js-map"></div>
	            <button type="button" title='<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.recherche.carte.masquer")) %>' class="ds44-btnStd-showMap ds44-btnStd ds44-btn--invert ds44-js-toggle-map-view">
	            <span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.recherche.carte.masquer") %></span><i class="icon icon-map" aria-hidden="true"></i>
	            </button>
	         </div>
	   </jalios:if>
	   </div>
	</jalios:if>
</div>

