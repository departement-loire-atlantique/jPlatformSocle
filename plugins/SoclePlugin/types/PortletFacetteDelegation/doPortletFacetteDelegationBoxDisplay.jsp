<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<% 
	PortletFacetteDelegation obj = (PortletFacetteDelegation)portlet; 
	
	String idFormElement = ServletUtil.generateUniqueDOMId(request, glp("jcmsplugin.socle.facette.form-element"));
	String dataMode = "select-only";
	String dataUrl = "plugins/SoclePlugin/jsp/facettes/acSearchPublication.jsp?query=types%3Dgenerated.Delegation";
	String name = "delegation";
	String label = Util.notEmpty(obj.getLabel()) ? obj.getLabel() : glp("jcmsplugin.socle.facette.delegation.default-label");
	String option = "";
	TreeSet<Category> setRayons = new TreeSet<Category>();
%>

<%@ include file='/plugins/SoclePlugin/jsp/portlet/portletFacetteAutoCompletion.jspf' %>