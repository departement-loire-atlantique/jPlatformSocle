<%@ include file="/jcore/doInitPage.jspf" %>
<%@ include file="/jcore/portal/doPortletParams.jspf" %>
<% PortletQueryForeach box = (PortletQueryForeach) portlet;  %>
<%@ include file="/types/PortletQueryForeach/doQuery.jspf" %>
<%@ include file="/types/PortletQueryForeach/doSort.jspf" %>

<ul>
  <%@ include file="/types/PortletQueryForeach/doForeachHeader.jspf" %>
    <li><a href="<%= itPub.getDisplayUrl(userLocale) %>"><%= itPub %></a></li>
  <%@ include file="/types/PortletQueryForeach/doForeachFooter.jspf" %>
</ul>  
<%@ include file="/types/PortletQueryForeach/doPager.jspf" %>
