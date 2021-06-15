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

if(getBooleanParameter("importLieux", false)) {

    System.out.println(request.getParameter("fichier"));
}

%>
<%@ include file='/admin/doAdminHeader.jspf' %>
<div class="jcms-message alert no-focus alert-info ">
    <h2>Notes importantes sur l'import de contenu Lieu</h2>
    <p>Ne <strong>pas</strong> utiliser l'import une fois le site initialisé ! L'objectif de cet import est d'initialiser un nouvel environnement.</p>
	<p>Réaliser un nouvel import après initialisation des contenus a un risque de <strong>dupliquer</strong> des contenus.</p>
</div>

<div class="page-header"><h1>Test d'import de contenu Lieu</h1></div>

<h2>Lancer une vérification du fichier CSV sans générer d'import</h2>
<form method="POST" enctype="multipart/form-data">
    <input type="hidden" name="importLieux" value="true">
    <input type="hidden" name="test" value="true">
    <p>Sélectionner un CSV à importer</p>
    <input type="file" name="fichier" accept=".csv"/>
    <br/>
    <input class="btn btn-info modal confirm" type="submit" value="Lancer un test d'import"/>
</form>


<%@ include file="/admin/doAdminFooter.jspf" %>

