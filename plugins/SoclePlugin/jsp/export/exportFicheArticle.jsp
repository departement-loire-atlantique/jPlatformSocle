<%@page import="fr.cg44.plugin.socle.export.ExportCsvUtil"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
response.setHeader("Content-Disposition", "attachment; filename=Export_FichesArticle.csv");
// inform doInitPage to set the proper content type
request.setAttribute("ContentType", "text/csv; charset=" + channel.getProperty("csv.charset"));
%><%@ include file='/jcore/doInitPage.jsp' %>
<%

if (!isAdmin) {
    sendForbidden(request, response);
    return;
}

out.clear();
ExportCsvFicheArticle.generateCsv(loggedMember, userlang, out);

%>