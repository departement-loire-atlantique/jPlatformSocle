<%@page import="fr.cg44.plugin.socle.export.ExportCsvPageUtileForm"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
response.setHeader("Content-Disposition", "attachment; filename=Export_PageUtileForm.csv");
// inform doInitPage to set the proper content type
request.setAttribute("ContentType", "text/csv; charset=UTF-8");
%><%@ include file='/jcore/doInitPage.jsp' %>
<%

if (!isAdmin) {
    sendForbidden(request, response);
    return;
}

out.clear();

ExportCsvPageUtileForm.generateCsv(loggedMember, userLang, out);

%>