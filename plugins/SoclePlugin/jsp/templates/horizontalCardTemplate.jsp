<%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ page import="com.jalios.jcms.taglib.card.*" %><%
%><%@ include file='/jcore/media/mediaTemplateInit.jspf' %><%

if (data == null || !(data instanceof Content)) {
  return;
}
Content content = (Content) data;
%>

<%ServletUtil.backupAttribute(pageContext , PortalManager.PORTAL_PUBLICATION);%>

<jalios:include pub="<%= content %>" usage="horizontalCard"/>

<%ServletUtil.restoreAttribute(pageContext , PortalManager.PORTAL_PUBLICATION);%>