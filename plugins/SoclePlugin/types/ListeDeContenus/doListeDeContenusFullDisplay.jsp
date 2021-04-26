<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %>
<%-- 
    Affiche une liste de contenus selon différents gabarits, via l'usage correspondant.
    Si on a saisi des documents, gabarit "liste de documents"
    Si on a saisi des fiches lieu, gabarit "contacts fiches lieu"
    Etc
    Si on saisi des contenus pour lesquels il n'y a pas d'usage, on ne renvoie rien.
    
    Attention : on ne gère pas les listes mixtes. Le test sur le type s'effectue sur le 1er
    élément de la liste de contenus.
 --%>
<%
ListeDeContenus obj = (ListeDeContenus)request.getAttribute(PortalManager.PORTAL_PUBLICATION);
String usage = "";

Content[] contenus = obj.getContenus();
if(contenus[0] instanceof FileDocument){
	usage = "listeDocs";
}
else if(contenus[0] instanceof FicheLieu){
	usage = "listeContacts";
}
else if(contenus[0] instanceof Exposition){
	usage = "listeExpositions";
}
else{
	return;
}

%>
<%ServletUtil.backupAttribute(pageContext , PortalManager.PORTAL_PUBLICATION);%>
<jalios:include pub="<%= obj %>" usage="<%= usage %>"/>
<%ServletUtil.restoreAttribute(pageContext , PortalManager.PORTAL_PUBLICATION);%>