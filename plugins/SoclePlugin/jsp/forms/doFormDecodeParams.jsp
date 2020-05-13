<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@page import="fr.cg44.plugin.socle.SocleUtils"%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%

Map<String, String[]> parametersMap = SocleUtils.getFormParameters(request);

String redirectUrl = request.getParameter("redirect[value]");

String url = URLUtils.buildUrl(redirectUrl, parametersMap);

sendRedirect(url);

%>


