<%@ include file='/jcore/doInitPage.jsp'%>

<%
Portlet itPortlet = channel.getData(Portlet.class, channel.getProperty("jcmsplugin.socle.alertpri.id"));
%>

<jalios:if predicate='<%= Util.notEmpty(itPortlet) && (itPortlet instanceof PortletQueryForeach) && Util.isEmpty(request.getAttribute("isSearchFacetPanel")) %>'>
    <%
    PortletQueryForeach box = (PortletQueryForeach) itPortlet;
    %>
    <div class="ds44-container-large">
	    <%@ include file='/jcore/portal/doPortletParams.jspf' %>
	    <%@ include file="/types/PortletQueryForeach/doQuery.jspf" %>
		<%@ include file="/types/PortletQueryForeach/doSort.jspf" %>
		<%@ include file="/types/PortletQueryForeach/doForeachHeader.jspf" %>
		<jalios:include pub='<%= itPub %>' usage="full"/>
		<%@ include file="/types/PortletQueryForeach/doForeachFooter.jspf" %>
	    <%@ include file="/types/PortletQueryForeach/doPager.jspf" %>
    </div>
</jalios:if>