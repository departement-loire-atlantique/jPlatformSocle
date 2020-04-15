<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ include file='/jcore/portal/doPortletParams.jspf' %><%
%><% PortletMiseEnAvantDeContenus box = (PortletMiseEnAvantDeContenus)portlet; %><%
%>

<section id="en1clic_<%= box.getId() %>" class="ds44-mlr35 ds44-mtb2 ds44-mobile-reduced-mar">
    <h2 class="h2-like" id="titreEn1Clic_<%= box.getId() %>"><%= box.getTitreVisuel() %></h2>

	<%@ include file="/types/PortletQueryForeach/doQuery.jspf" %>
	<%@ include file="/types/PortletQueryForeach/doSort.jspf" %>
	
	<%@ include file="/types/PortletQueryForeach/doForeachHeader.jspf" %>
	
	   <jalios:media data="<%= itPub %>" template="tuileHorizontaleLightSmall"/>
	
	<%@ include file="/types/PortletQueryForeach/doForeachFooter.jspf" %>
	<%@ include file="/types/PortletQueryForeach/doPager.jspf" %>

</section>