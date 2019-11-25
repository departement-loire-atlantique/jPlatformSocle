<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ include file='/jcore/media/mediaTemplateInit.jspf' %><%

if (data == null || !(data instanceof Content)) {
  return;
}
Content content = (Content) data;
%>

<%ServletUtil.backupAttribute(pageContext , PortalManager.PORTAL_PUBLICATION);%>

<%@include file="commonCardTemplate.jsp" %>

<%--<jalios:include pub="<%= content %>" usage="verticalCard"/>--%>

<%ServletUtil.restoreAttribute(pageContext , PortalManager.PORTAL_PUBLICATION);%>