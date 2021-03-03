<%@page import="fr.cg44.plugin.socle.export.ExportCsvUtils"%>
<%@page import="fr.cg44.plugin.socle.export.ExportImgZip"%>
<%@page import="com.jalios.jcms.handler.MemberQueryHandler"%>
<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@page import="com.jalios.jcms.handler.QueryHandler"%>
<%@page import="java.io.IOException" %>
<%
%><%@ include file="/jcore/doInitPage.jsp" %><%

if(!isAdmin) {
    sendForbidden(request, response);
    return;
}

if(getBooleanParameter("exportImg", false)) {
  
  String contentTypeParam = getStringParameter("contentType", "", ".*");
  
  ExportImgZip.generateImgZipFile(ExportCsvUtils.getPublicationsOfType(contentTypeParam, loggedMember));
  
}

%>
<%@ include file='/admin/doAdminHeader.jspf' %>

<div class="page-header"><h1>Export CSV et d'images de contenu</h1></div>

<h2>Chemin du fichier ZIP des images : <%= ExportImgZip.getZipFilePath() %></h2>
<b>Le fichier ZIP existe : <%= ExportImgZip.imgZipFileExists() %></b>
<jalios:if predicate="<%= ExportImgZip.imgZipFileExists() %>">
<a href="<%= ExportImgZip.getZipRelativeFilePath() %>" class="btn btn-success modal confirm" target="_blank">Télécharger le ZIP</a>
</jalios:if>

<h3>Export Fiches Article</h3>
<a href="plugins/SoclePlugin/jsp/export/exportFicheArticle.jsp" class="btn btn-info modal confirm" target="_blank">Exporter en CSV</a>

<h3>Export Images Fiche Article</h3>
<form>
    <input type="hidden" name="contentType" value="FicheArticle">
    <input type="hidden" name="exportImg" value="true">
    <input class="btn btn-info modal confirm" type="submit" value="Générer le ZIP pour les images : Fiche Article"/>
</form>

<hr>

<h3>Export Etablissement personnes agées</h3>
<a href="plugins/SoclePlugin/jsp/export/exportSeniorCitizensEstablishment.jsp" class="btn btn-info modal confirm" target="_blank">Exporter en CSV</a>

<hr>