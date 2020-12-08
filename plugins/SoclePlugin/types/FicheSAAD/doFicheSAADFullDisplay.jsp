<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% FicheSAAD obj = (FicheSAAD)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%
%><%@ include file='/front/doFullDisplay.jspf' %>

<jalios:if predicate='<%= Util.isEmpty(request.getAttribute("isSearchFacetPanel")) %>'>
	<%@ include file="/plugins/SoclePlugin/types/FicheSAAD/doFicheSAADFullDisplay.jspf" %>
</jalios:if>
<jalios:if predicate='<%= Util.notEmpty(request.getAttribute("isSearchFacetPanel")) %>'>
	<%@ include file="/plugins/SoclePlugin/types/FicheSAAD/doFicheSAADResultDisplay.jspf" %>
</jalios:if>