<%@page import="java.nio.charset.StandardCharsets"%>
<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@page import="java.security.MessageDigest"%>
<%@page import="com.jalios.io.IOUtil"%>
<%@page import="fr.cg44.plugin.socle.bean.FacetSearch"%>
<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%><%
%><%@page import="fr.cg44.plugin.socle.SocleUtils"%><%
%><%@page import="com.google.gson.JsonObject"%><%
%><%@page import="com.google.gson.JsonArray"%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ include file="/jcore/portal/doPortletParams.jspf" %><%

response.setContentType("application/json");


URL rechercheUrl = new URL(ServletUtil.getUrl(request));
Publication recherchePortal = channel.getPublication("$jcmsplugin.socle.recherche.facettes.portal");
String urlRecherche = recherchePortal.getDisplayUrl(userLocale) + "?" + rechercheUrl.getQuery();
session.setAttribute("urlRecherche", urlRecherche);

Map<String, String[]> parametersMap = SocleUtils.getFacetsParameters(request);

// Si la ré-écriture d'url est activé alors enregistrement en BDD
// Ne pas réécrire dans le cas particulier d'une carte sans facette
if (Util.isEmpty(request.getParameter("noFacette[value]"))) {
	if( channel.getBooleanProperty("jcmsplugin.socle.url-rewriting", false)) {
	    
	    // Compress et encode en base 64 les paramètre de la recherche
	    String queryRequest = ServletUtil.getQueryString(request, false);
	    MessageDigest digest = MessageDigest.getInstance("SHA-256");
	    byte[] hash = digest.digest(queryRequest.getBytes(StandardCharsets.UTF_8));
	    String idSearch = HttpUtil.encodeForURL(Base64.getEncoder().encodeToString(hash));
	    
	    
	    // Si la requete n'a jamais été faite alors la stocker en bdd
	    FacetSearch currentFacetSearch = HibernateUtil.queryUnique(FacetSearch.class, "guid", idSearch);
	    if(Util.isEmpty(currentFacetSearch)) {   
	      FacetSearch facetSearch = new FacetSearch();
	      facetSearch.setCpt(1);
	      facetSearch.setGuid(idSearch);
	      facetSearch.setQuery(queryRequest);
	      HibernateUtil.save(facetSearch); 
	    }
	    
	    // Ajout l'id de la recherche à la requete décodée pour que la jsp suivante puisse l'ajouter au json retourné au js
	    parametersMap.put("searchId", new String[]{(idSearch)});
	}else {
	  // Id à 0 mais non null pour le fonctionnement du js lorsque la ré-écriture d'url est désactivée
	  parametersMap.put("searchId", new String[]{("0")});
	}
}

String redirectUrl = Util.notEmpty(request.getParameter("redirectUrl[value]")) ? request.getParameter("redirectUrl[value]") : "plugins/SoclePlugin/jsp/facettes/displayResult.jsp";

String url = URLUtils.buildUrl(redirectUrl, parametersMap);

// Fix error HTTPS infra (mixed content). Passe en url absolue
if(url.indexOf("http") != 0) {
  url = channel.getUrl() + url;
}

sendRedirect(url);

%>


