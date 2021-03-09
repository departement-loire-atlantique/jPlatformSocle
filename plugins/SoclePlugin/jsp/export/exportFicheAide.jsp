<%@page import="fr.cg44.plugin.socle.export.ExportCsvFicheAide"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
response.setHeader("Content-Disposition", "attachment; filename=Export_FichesAide.csv");
// inform doInitPage to set the proper content type
request.setAttribute("ContentType", "text/csv; charset=UTF-8");
%><%@ include file='/jcore/doInitPage.jsp' %>
<%

if (!isAdmin) {
    sendForbidden(request, response);
    return;
}

out.clear();

ExportCsvFicheAide.generateCsv(loggedMember, userLang, out);

%>