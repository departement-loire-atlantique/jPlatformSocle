<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@page import="fr.cg44.plugin.socle.SocleUtils"%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%

Map<String, String[]> parametersMap = SocleUtils.getFormParameters(request);

String redirectUrl = request.getParameter("redirect[value]");

String url = URLUtils.buildUrl(redirectUrl, parametersMap);

// Transmet les fichiers dans la requete
Enumeration<String> names = request.getAttributeNames();
while (names.hasMoreElements()) {    
    String name = names.nextElement();
    Object value = request.getAttribute(name);
	if (value instanceof FileItem) {
	  session.setAttribute(name.replace("[value]", ""), value);
    }
}


sendRedirect(url, request, response);

%>


