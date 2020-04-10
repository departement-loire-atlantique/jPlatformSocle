<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<% 
	PortletFacetteCommune obj = (PortletFacetteCommune)portlet; 
	

    String rechercheId = (String) request.getAttribute("rechercheId");

	String idFormElement = ServletUtil.generateUniqueDOMId(request, glp("jcmsplugin.socle.facette.form-element"));
	String dataMode = "select-only";
	String dataUrl = "plugins/SoclePlugin/jsp/facettes/acSearchCommune.jsp";
	String name = "commune" + glp("jcmsplugin.socle.facette.form-element") + "-" + rechercheId + obj.getId();
	String label = Util.notEmpty(obj.getLabel()) ? obj.getLabel() : glp("jcmsplugin.socle.facette.commune.default-label");
	String option = Util.isEmpty(obj.getRechercheEtendue()) || obj.getRechercheEtendue().equalsIgnoreCase("aucune") ? "" : obj.getRechercheEtendue();
	TreeSet<Category> setRayons = new TreeSet<Category>();
%>

<%@ include file='/plugins/SoclePlugin/jsp/portlet/portletFacetteAutoCompletion.jspf' %>
