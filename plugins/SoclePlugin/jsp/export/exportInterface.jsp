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

String folderpath = channel.getProperty("jcmsplugin.socle.export.img.filepath");



%>
<%@ include file='/admin/doAdminHeader.jspf' %>

<div class="page-header"><h1>Export CSV et d'images de contenu</h1></div>

<h2>Dossier du fichier ZIP des images TODO : OK</h2>
<b>Le fichier ZIP existe : TODO</b>

<h3>Export Fiches Article</h3>
<a href="plugins/SoclePlugin/jsp/export/exportFicheArticle.jsp" class="btn btn-info modal" target="_blank">Exporter en CSV</a>

<h3>Export Images Fiche Article</h3>
<a href="plugins/SoclePlugin/jsp/export/exportImagesContenu.jsp?contentType=FicheArticle" class="btn btn-info modal" target="_blank">Générer et télécharger le ZIP</a>

<hr>

