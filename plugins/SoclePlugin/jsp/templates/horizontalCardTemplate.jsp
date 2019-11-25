<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ include file='/jcore/media/mediaTemplateInit.jspf' %><%
%><%

if (data == null || !(data instanceof Content)) {
  return;
}
AbstractElement obj = (AbstractElement) data;
%>

<%ServletUtil.backupAttribute(pageContext , PortalManager.PORTAL_PUBLICATION);%>

<%
String format="horizontal";
%>
<%@include file="commonCardTemplate.jsp" %>

<%-- <jalios:include pub="<%= content %>" usage="horizontalCard"/>--%>

<%ServletUtil.restoreAttribute(pageContext , PortalManager.PORTAL_PUBLICATION);%>