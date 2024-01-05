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

%>
<%@ include file='/admin/doAdminHeader.jspf' %>

<div class="page-header"><h1>Export des fiches articles</h1></div>

<h3>Export CSV des Fiches Article</h3>
<p><i>Affiche les champs .... dans un fichier CSV</i></p>
<a href="plugins/SoclePlugin/jsp/reprise/repriseFicheLieuExportCsv.jsp" class="btn btn-primary modal confirm" style="max-width: 120px;">Lancer l'export</a>

<%@ include file='/admin/doAdminFooter.jspf' %> 