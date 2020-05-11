<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<% 
	PortletFacetteTitre obj = (PortletFacetteTitre)portlet; 

    String rechercheId = (String) request.getAttribute("rechercheId");
	
	String idFormElement = ServletUtil.generateUniqueDOMId(request, glp("jcmsplugin.socle.facette.form-element"));
	String dataMode = "free-text";
	String query = "";
	if(Util.notEmpty(request.getAttribute("query"))) {
		query = (String)(request.getAttribute("query"));
	}
	String dataUrl = "plugins/SoclePlugin/jsp/facettes/acSearchPublication.jsp?query="+HttpUtil.encodeForURL(query) + (obj.getEtendreLaRechercheATousLesChamps() ? "&motCle=true" : "");
	String rechercheEtendu =  obj.getEtendreLaRechercheATousLesChamps() ? "text" : "titre";
	String name = rechercheEtendu + glp("jcmsplugin.socle.facette.form-element") + "-" + rechercheId + obj.getId();
	String label = Util.notEmpty(obj.getLabel()) ? obj.getLabel() : glp("jcmsplugin.socle.facette.titre.default-label");
	String option = "";
	TreeSet<Category> setRayons = new TreeSet<Category>();
%>

<%@ include file='/plugins/SoclePlugin/jsp/portlet/portletFacetteAutoCompletion.jspf' %>