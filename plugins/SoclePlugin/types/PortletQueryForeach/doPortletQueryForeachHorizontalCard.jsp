<%@ include file="/jcore/doInitPage.jspf" %>
<%@ include file="/jcore/portal/doPortletParams.jspf" %>
<% PortletQueryForeach box = (PortletQueryForeach) portlet;  %>
<%@ include file="/types/PortletQueryForeach/doQuery.jspf" %>
<%@ include file="/types/PortletQueryForeach/doSort.jspf" %>

  <%@ include file="/types/PortletQueryForeach/doForeachHeader.jspf" %>
    <jalios:media data='<%=itPub %>' template='horizontalCard' />
  <%@ include file="/types/PortletQueryForeach/doForeachFooter.jspf" %>
  <%@ include file="/types/PortletQueryForeach/doPager.jspf" %>
