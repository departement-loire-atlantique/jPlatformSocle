<%@page import="fr.cg44.plugin.socle.importation.ImportLieuFromCsv"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.io.IOException" %>
<%
%><%@ include file="/jcore/doInitPage.jsp" %><%

if(!isAdmin) {
    sendForbidden(request, response);
    return;
}

Map<String, String> filecheckLog = new TreeMap<>();

if(getBooleanParameter("importLieux", false)) {
    
    FileItem file = (FileItem) request.getAttribute("file");
    if (getBooleanParameter("test", false)) {
        filecheckLog = ImportLieuFromCsv.checkCsvImport(file);
    } else {
        ImportLieuFromCsv.importFichesLieuCsv(file);
    }
}

%>
<%@ include file='/admin/doAdminHeader.jspf' %>

<%@ include file='/jcore/doMessageBox.jspf' %>

<jalios:if predicate='<%= Util.notEmpty(request.getAttribute("traceImport")) %>'>
    <div class="jcms-message alert no-focus alert-warning ">
        <h2>Description de l'erreur : </h2>
        <%= trace %>
    </div>
</jalios:if>

<jalios:if predicate="<%= Util.notEmpty(filecheckLog) %>">
<div class="jcms-message alert no-focus alert-warning ">
    <h2>Des points d'attention ont �t� remont�s suite � la v�rification du fichier CSV</h2>
    <ul>
    <jalios:foreach name="itLine" type="String" collection="<%= filecheckLog.keySet() %>">
        <li>
            <strong><%= itLine %></strong> -> <%= filecheckLog.get(itLine) %>
        </li>
    </jalios:foreach>
    </ul>
</div>
</jalios:if>

<div class="jcms-message alert no-focus alert-info ">
    <h2>Notes importantes sur l'import de contenu Lieu</h2>
    <p>Ne <strong>pas</strong> utiliser l'import une fois le site initialis� ! L'objectif de cet import est d'initialiser un nouvel environnement.</p>
    <p>R�aliser un nouvel import apr�s initialisation des contenus a un risque de <strong>dupliquer</strong> des contenus.</p>
</div>

<div class="page-header"><h1>Test d'import de contenu Lieu</h1></div>

<h2>Lancer une v�rification du fichier CSV sans g�n�rer d'import</h2>
<form method="POST" enctype="multipart/form-data" action="plugins/SoclePlugin/jsp/import/importLieuInterface.jsp">
    <input type="hidden" name="importLieux" value="true">
    <input type="hidden" name="test" value="true">
    <p>S�lectionner un CSV � importer</p>
    <jalios:field name="file" label="Fichier CSV"> 
        <jalios:control settings="<%= new FileSettings().mode(FileSettings.Mode.SIMPLE_FILE) %>" /> 
    </jalios:field>
    <br/>
    <input class="btn btn-info modal confirm" type="submit" value="Lancer un test d'import"/>
</form>

<hr>

<h2>Lancer l'import CSV</h2>
<div class="jcms-message alert no-focus alert-warning">
    <p><strong>Ne pas lancer sans v�rification pr�alable</strong></p>
</div>
<form method="POST" enctype="multipart/form-data" action="plugins/SoclePlugin/jsp/import/importLieuInterface.jsp">
    <input type="hidden" name="importLieux" value="true">
    <p>S�lectionner un CSV � importer</p>
    <jalios:field name="file" label="Fichier CSV"> 
        <jalios:control settings="<%= new FileSettings().mode(FileSettings.Mode.SIMPLE_FILE) %>" /> 
    </jalios:field>
    <br/>
    <input class="btn btn-info modal confirm" type="submit" value="Lancer l'import"/>
</form>


<%@ include file="/admin/doAdminFooter.jspf" %>

