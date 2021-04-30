<%@page import="java.nio.charset.StandardCharsets"%>
<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@page import="java.security.MessageDigest"%>
<%@page import="com.jalios.io.IOUtil"%>
<%@page import="fr.cg44.plugin.socle.bean.FacetSearch"%>
<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%><%
%><%@page import="fr.cg44.plugin.socle.SocleUtils"%><%
%><%@page import="com.google.gson.JsonObject"%><%
%><%@page import="com.google.gson.JsonArray"%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ include file="/jcore/portal/doPortletParams.jspf" %><%

response.setContentType("application/json");

Map<String, String[]> parametersMap = SocleUtils.getFacetsParameters(request);

String redirectUrl = Util.notEmpty(request.getParameter("redirectUrl[value]")) ? request.getParameter("redirectUrl[value]") : "plugins/SoclePlugin/jsp/facettes/displayResultCanton.jsp";

String url = URLUtils.buildUrl(redirectUrl, parametersMap);

// Fix error HTTPS infra (mixed content). Passe en url absolue
if(url.indexOf("http") != 0) {
  url = channel.getUrl() + url;
}

sendRedirect(url);

%>


