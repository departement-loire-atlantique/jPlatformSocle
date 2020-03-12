<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<% 
	PortletFacetteCategorie obj = (PortletFacetteCategorie)portlet; 

	String idFormElement = ServletUtil.generateUniqueDOMId(request, "form-element");

	String styleChamps = Util.notEmpty(request.getAttribute("showFiltres")) && (Boolean) request.getAttribute("showFiltres") ? "Std" : "Large";
	String styleChamps2 = styleChamps.equalsIgnoreCase("large") ? "XL" : "L";
%>

<ds:facetteCategorie obj='<%= obj %>' 
		listeCategory='<%= obj.getCategoriesRacines(loggedMember) %>'
		idFormElement='<%= idFormElement %>' 
		isDisabled='<%= false %>' 
		userLang='<%= userLang %>' 
		loggedMember='<%= loggedMember %>' 
		request='<%= request %>'/>