<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%><%
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ include file='/jcore/media/mediaTemplateInit.jspf' %><%
%><%
CarouselElement obj = (CarouselElement)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%

String format="vertical";
%>

<%@include file="doCarouselElement.jspf" %>