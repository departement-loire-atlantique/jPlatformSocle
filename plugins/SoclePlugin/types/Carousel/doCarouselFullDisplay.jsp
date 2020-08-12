<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<%@ include file='/jcore/doInitPage.jspf'%>
<%
    Carousel obj = (Carousel) request.getAttribute(PortalManager.PORTAL_PUBLICATION);
%>
<%@ page import="fr.cg44.plugin.socle.SocleUtils"%>

