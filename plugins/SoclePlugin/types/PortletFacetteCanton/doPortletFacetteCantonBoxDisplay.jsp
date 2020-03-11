<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<% 
	PortletFacetteCanton obj = (PortletFacetteCanton)portlet; 
	
	String idFormElement = ServletUtil.generateUniqueDOMId(request, glp("jcmsplugin.socle.facette.form-element"));
	String dataMode = "select-only";
	String dataUrl = "plugins/SoclePlugin/jsp/facettes/acSearchPublication.jsp?query=types%3Dgenerated.Canton";
	String name = "canton";
	String label = Util.notEmpty(obj.getLabel()) ? obj.getLabel() : glp("jcmsplugin.socle.facette.canton.default-label");
	String option = "";
	TreeSet<Category> setRayons = new TreeSet<Category>();
%>

<%@ include file='/plugins/SoclePlugin/jsp/portlet/portletFacetteAutoCompletion.jspf' %>