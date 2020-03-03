<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<% 
	PortletFacetteAdresse obj = (PortletFacetteAdresse)portlet; 
	
	String idFormElement = ServletUtil.generateUniqueDOMId(request, glp("jcmsplugin.socle.facette.form-element"));
	String dataMode = "select-only";
	//TODO changer/enlever data url qd autcompletion adresse js faite
	String dataUrl = "plugins/SoclePlugin/jsp/facettes/acSearchCommune.jsp";
	String name = "adresse";
	String label = Util.notEmpty(obj.getLabel()) ? obj.getLabel() : glp("jcmsplugin.socle.facette.adresse.default-label");
	String option = Util.notEmpty(obj.getRayon(loggedMember)) ? "rayon" : "";
	TreeSet<Category> setRayons = Util.notEmpty(obj.getRayon(loggedMember)) ? obj.getRayon(loggedMember) : new TreeSet<Category>();
%>

<%@ include file='/plugins/SoclePlugin/jsp/portlet/portletFacetteAutoCompletion.jspf' %>
