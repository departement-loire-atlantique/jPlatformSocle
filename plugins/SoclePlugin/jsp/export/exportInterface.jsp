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
<div class="jcms-message alert no-focus alert-info ">
    <h2>Importer le fichier CSV dans Excel</h2>
    <p>Pour ne pas avoir de problème d'encodage de caractères, suivre cette procédure dans Excel :</p>
	<ol>
		<li>Ouvrir un nouveau fichier</li>
		<li>Aller dans le menu "Données"</li>
		<li>Choisir "A partir d'un fichier texte/CSV"</li>
		<li>Sélectionner le fichier CSV préalablement téléchargé</li>
		<li>Cliquer sur "Importer"</li>
		<li>Dans la nouvelle fenêtre, modifier le 1er champ "Origine du fichier" et remplacer "1252: Europe de l'Ouest" par "65001: Unicode (UTF-8)"</li>
		<li>Cliquer sur "Charger"</li>
	    <li>Enregistrer en xlsx</li>
	</ol>
</div>
<div class="page-header"><h1>Export CSV et d'images de contenu</h1></div>

<h2>Chemin du fichier ZIP des images : <%= ExportImgZip.getZipFilePath() %></h2>
<b>Le fichier ZIP existe : <%= ExportImgZip.imgZipFileExists() %></b>
<jalios:if predicate="<%= ExportImgZip.imgZipFileExists() %>">
<p><a href="<%= ExportImgZip.getZipRelativeFilePath() %>" class="btn btn-success modal confirm" target="_blank">Télécharger le ZIP</a></p>
</jalios:if>

<h3>Export Fiches Article</h3>
<p><a href="plugins/SoclePlugin/jsp/export/exportCsvPrinter.jsp?type=FicheArticle" class="btn btn-info modal confirm" target="_blank">Exporter en CSV</a></p>

<h3>Export Images Fiche Article</h3>
<form>
    <input type="hidden" name="contentType" value="FicheArticle">
    <input type="hidden" name="exportImg" value="true">
    <input class="btn btn-info modal confirm" type="submit" value="Générer le ZIP pour les images : Fiche Article"/>
</form>

<hr>

<h3>Export Fiches Lieu</h3>
<p><a href="plugins/SoclePlugin/jsp/export/exportCsvPrinter.jsp?type=FicheLieu" class="btn btn-info modal confirm" target="_blank">Exporter en CSV</a></p>

<h3>Export Images Fiche Lieu</h3>
<form>
    <input type="hidden" name="contentType" value="FicheLieu">
    <input type="hidden" name="exportImg" value="true">
    <input class="btn btn-info modal confirm" type="submit" value="Générer le ZIP pour les images : Fiche Lieu"/>
</form>

<hr>

<h3>Export Etablissement personnes âgées</h3>
<p><a href="plugins/SoclePlugin/jsp/export/exportCsvPrinter.jsp?type=SeniorCitizensEstablishment" class="btn btn-info modal confirm" target="_blank">Exporter en CSV</a></p>

<hr>

<h3>Export Fiche SAAD</h3>
<p><a href="plugins/SoclePlugin/jsp/export/exportCsvPrinter.jsp?type=FicheSAAD" class="btn btn-info modal confirm" target="_blank">Exporter en CSV</a></p>

<hr>

<h3>Export Fiches Aide</h3>
<p><a href="plugins/SoclePlugin/jsp/export/exportCsvPrinter.jsp?type=FicheAide" class="btn btn-info modal confirm" target="_blank">Exporter en CSV</a></p>

<h3>Export Images Fiche Aide</h3>
<form>
    <input type="hidden" name="contentType" value="FicheAide">
    <input type="hidden" name="exportImg" value="true">
    <input class="btn btn-info modal confirm" type="submit" value="Générer le ZIP pour les images : Fiche Aide"/>
</form>

<h3>Export Formulaire Page Utile</h3>
<p><a href="plugins/SoclePlugin/jsp/export/exportPageUtileForm.jsp" class="btn btn-info modal confirm" target="_blank">Exporter en CSV</a></p>

<hr>

<h3>Export Communes</h3>
<p><a href="plugins/SoclePlugin/jsp/export/exportCsvPrinter.jsp?type=City" class="btn btn-info modal confirm" target="_blank">Exporter en CSV</a></p>
<p><a href="plugins/SoclePlugin/jsp/export/exportCsvPrinter.jsp?type=CommuneHorsDepartement" class="btn btn-info modal confirm" target="_blank">Exporter les communes hors département en CSV</a></p>

<hr>

<h3>Export Fiches élus</h3>
<p><a href="plugins/SoclePlugin/jsp/export/exportCsvPrinter.jsp?type=ElectedMember" class="btn btn-info modal confirm" target="_blank">Exporter en CSV</a></p>

<hr>

<h3>Export Fiches contacts</h3>
<p><a href="plugins/SoclePlugin/jsp/export/exportCsvPrinter.jsp?type=Contact" class="btn btn-info modal confirm" target="_blank">Exporter en CSV</a></p>

<hr>

<h3>Export Fiches action éducative</h3>
<p><a href="plugins/SoclePlugin/jsp/export/exportCsvPrinter.jsp?type=FicheActionEducative" class="btn btn-info modal confirm" target="_blank">Exporter en CSV</a></p>

<%@ include file="/admin/doAdminFooter.jspf" %>

