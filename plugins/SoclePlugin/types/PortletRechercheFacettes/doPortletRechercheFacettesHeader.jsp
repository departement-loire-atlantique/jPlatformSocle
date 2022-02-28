<%@ page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file='/jcore/doInitPage.jspf'%>
<%@ include file='/jcore/portal/doPortletParams.jspf'%>
<%@ include file='/plugins/SoclePlugin/jsp/facettes/commonParamsFacettes.jspf'%>
<% 

    PortletRechercheFacettes obj = (PortletRechercheFacettes)portlet;
    
	//Url en utilsant le titre de la facette et non le titre du portal général facette
	// Permet d'avoir une url différente par recherche mais l'id reste celui du portal
	
	Publication portalFacet = channel.getPublication("$jcmsplugin.socle.recherche.facettes.portal");
	String urlFacet = DescriptiveURLs.getDescriptiveURL(portalFacet, userLocale);
	
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
	
	String descPortal = DescriptiveURLs.cleanDescriptiveURLText(portalFacet.getTitle(userLang), userLocale);
	String descFacet = DescriptiveURLs.cleanDescriptiveURLText(obj.getTitre(userLang), userLocale);
	
	String query = Util.notEmpty(obj.getQueries()) ? obj.getQueries()[0] : "";
	request.setAttribute("query", query);
	    
	request.setAttribute("rechercheId", obj.getId());
	    
	// Remplace le titre de l'url par le titre de la recherche à facette au lieu du titre du portail
	String seoUrl = urlFacet.replaceAll(descPortal, descFacet);
%>

<p class="h4-like" id="inp-rech" role="heading" aria-level="2"><%= glp("jcmsplugin.socle.rechercher") %></p>
<%
   String formUid = ServletUtil.generateUniqueDOMId(request, "uid");
   %>
<form role="search" name="queryForm" method='<%= channel.getBooleanProperty("jcmsplugin.socle.url-rewriting", false) ? "POST" : "GET" %>' data-seo-url='<%= channel.getProperty("jcmsplugin.socle.url-rewriting")%>' data-search-url="plugins/SoclePlugin/jsp/facettes/displayParameters.jsp" action='<%= seoUrl + "?boxId=" + obj.getId() %>'>
   <div class="ds44-form__container">
      <% 
        int maxFacettesPrincipales = SocleUtils.getNbrFacetteBeforeMaxWeight(4, obj.getFacettesPrincipales(), loggedMember); 
        request.setAttribute("isFilter", false);
        boolean putColCss = false;
      %>
        
      <jalios:foreach array="<%= obj.getFacettesPrincipales() %>" name="itFacette" type="AbstractPortletFacette" max="<%= maxFacettesPrincipales %>">
          <jalios:if predicate="<%= itCounter % 2 == 1 && obj.getFacettesPrincipales().length - itCounter > 0 %>">
            <div class="grid-2-small-1">
            <% putColCss = true; %>
          </jalios:if>
	      <% Boolean isSelect = itFacette instanceof PortletFacetteCategorie || itFacette instanceof PortletFacetteCategoriesLiees; %>
	        
	      <div class='ds44-fieldContainer ds44-mt1 ds44-fg1 <%= isSelect ? "ds44-fieldContainer--select" : "" %> <%= putColCss ? "col" : "" %>'>
	        <jalios:include pub="<%= itFacette %>" usage="box"/>
	      </div>
	      <jalios:if predicate="<%= itCounter % 2 == 0 %>">
	        <% putColCss = false; %>
            </div>
          </jalios:if>
      </jalios:foreach>

      <% request.removeAttribute("isFilter"); %>
   </div>
   <button type="submit" class="ds44-btnStd ds44-btn--invert" title='<%= glp("jcmsplugin.socle.rechercher") %>'>
   <span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.valider") %></span><i class="icon icon-long-arrow-right" aria-hidden="true"></i>
   </button>
   
   <%@ include file='/plugins/SoclePlugin/types/PortletRechercheFacettes/doSearchHiddenParams.jspf' %>
</form>
