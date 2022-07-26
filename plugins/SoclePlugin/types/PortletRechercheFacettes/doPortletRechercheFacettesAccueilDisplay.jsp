<%@ page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file='/jcore/doInitPage.jspf'%>
<%@ include file='/jcore/portal/doPortletParams.jspf'%>
<%@ include file='/plugins/SoclePlugin/jsp/facettes/commonParamsFacettes.jspf'%>
<% 

PortletRechercheFacettes obj = (PortletRechercheFacettes)portlet;

String query = Util.notEmpty(obj.getQueries()) ? obj.getQueries()[0] : "";
request.setAttribute("query", query);

Boolean hasFonctionsAdditionnelles = false; // TODO
Boolean showFiltres = isInRechercheFacette && Util.notEmpty(obj.getFacettesSecondaires()) || hasFonctionsAdditionnelles;
request.setAttribute("showFiltres", showFiltres);

request.setAttribute("rechercheId", obj.getId());

 %>
 
 <jalios:select>
 
    <jalios:if predicate="<%= isInRechercheFacette %>">
        <% String url = "plugins/SoclePlugin/types/PortletRechercheFacettes/doPortletRechercheFacettesBoxDisplay.jsp?redirectUrl=" + channel.getProperty("jcmsplugin.socle.recherche.accueil.jsp.display"); %>
        <jalios:include jsp='<%= url %>' />
    </jalios:if>
    
    
    
    
    <jalios:default>
    
        <section id="en1clic" class="ds44-mlr35 ds44-mtb2 ds44-mobile-reduced-mar">
    
	        <h2 class="h2-like" id="titreEn1Clic"><%= obj.getTitre(userLang) %></h2>
	        
	        <jalios:if predicate='<%= Util.notEmpty(obj.getSoustitre(userLang)) %>'>
	          <p class="ds44-mb2"><%= obj.getSoustitre(userLang) %></p>
	        </jalios:if>
	    
	    
	        <form role="search" method='<%= channel.getBooleanProperty("jcmsplugin.socle.url-rewriting", false) ? "POST" : "GET" %>' data-is-ajax='<%= isInRechercheFacette ? "true" : "false" %>' data-auto-load='<%= isInRechercheFacette ? "true" : "false" %>' action='<%= isInRechercheFacette ? "plugins/SoclePlugin/jsp/facettes/displayResultDecodeParams.jsp" : channel.getPublication("$jcmsplugin.socle.recherche.facettes.portal").getDisplayUrl(userLocale) + "?boxId=" + obj.getId() %>'>
	               
	            <% request.setAttribute("isInEncadre", true); %>   
	               
	            <jalios:foreach array="<%= obj.getFacettesPrincipales() %>" name="itFacette" type="AbstractPortletFacette" max="3">
	                 <jalios:include pub="<%= itFacette %>" usage="box"/>
	            </jalios:foreach>
	            
	            <% request.removeAttribute("IsInEncadre"); %>
	         
	            
	            <%@ include file='/plugins/SoclePlugin/types/PortletRechercheFacettes/doSearchHiddenParams.jspf' %>
	            
	            
	            <button class="ds44-btnStd ds44-bntFullw ds44-bntALeft ds44-btn--contextual" title='<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.lancer.recherche")) %>'><span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.rechercher") %></span><i class="icon icon-long-arrow-right" aria-hidden="true"></i></button>
	            
	        
	        </form>
    
        </section>
        
    </jalios:default>
    
    
 </jalios:select>
 
 