<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@page import="fr.cg44.plugin.socle.export.ExportCsvUtils"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
String type = getStringParameter("type", "", ".*");

response.setHeader("Content-Disposition", "attachment; filename=Export_" + type + ".csv");
// inform doInitPage to set the proper content type
request.setAttribute("ContentType", "text/csv; charset=UTF-8");
%><%@ include file='/jcore/doInitPage.jsp' %>
<%

if (!isAdmin) {
    sendForbidden(request, response);
    return;
}

out.clear();

switch (type) {
case "Video":
  ExportCsvUtils.printCsvFileForPublicationTypeAndSet(type, userLang, loggedMember, out, SocleUtils.getAllVideosWithoutTranscript());
  break;
default:
  ExportCsvUtils.printCsvFileForPublicationType(type, userLang, loggedMember, out);
}
%>