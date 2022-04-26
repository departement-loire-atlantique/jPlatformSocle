<%@ include file="/jcore/doInitPage.jspf" %>
<%@ include file="/jcore/portal/doPortletParams.jspf" %>
<% PortletQueryForeach box = (PortletQueryForeach) portlet;  %>
<%@ include file="/types/PortletQueryForeach/doQuery.jspf" %>
<%@ include file="/types/PortletQueryForeach/doSort.jspf" %>
<div class="ds44-results">
    <div class="ds44-listResults">
		<ul class="ds44-list ds44-list--results ds44-flex-container">
		  <%@ include file="/types/PortletQueryForeach/doForeachHeader.jspf" %>
		    <li class="ds44-fg1"><jalios:media data="<%= itPub %>" template="search"/></li>
		  <%@ include file="/types/PortletQueryForeach/doForeachFooter.jspf" %>
		</ul>
	</div>
</div>
<%@ include file="/types/PortletQueryForeach/doPager.jspf" %>