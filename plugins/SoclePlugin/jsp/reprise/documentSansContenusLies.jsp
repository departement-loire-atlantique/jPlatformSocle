<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@page import="com.jalios.jcms.handler.QueryHandler"%>
<%@page import="java.io.IOException"%>
<%
  
%><%@ include file="/jcore/doInitPage.jsp"%>
<%
  if (!isAdmin) {
    sendForbidden(request, response);
    return;
  }
%>
<%@ include file='/admin/doAdminHeader.jspf'%>

<div class="page-header">
	<h1>Liste des documents sans contenus liés</h1>
</div>
<% 
	TreeSet<FileDocument> listePublication = channel.getPublicationSet(FileDocument.class, loggedMember);
	ArrayList<String> listeTypesContenu = new ArrayList<String>();
%>
<jalios:foreach name='itFileDoc' collection='<%= channel.getPublicationSet(FileDocument.class, loggedMember) %>' type='FileDocument'>
	<jalios:if predicate='<%= Util.isEmpty(itFileDoc.getLinkIndexedDataSet(Data.class)) && Util.isEmpty(itFileDoc.getWeakReferrerSet()) %>'>
		<% 
			// on verifie si le file doc a un nouveau type de contenu
			Boolean hasANewType = true;
			for (String itTypeContenu : listeTypesContenu) {
				if(!hasANewType) break;
				hasANewType = ! itFileDoc.getContentType().equalsIgnoreCase(itTypeContenu);
			}
		%>
		<jalios:if predicate='<%= hasANewType %>'>
			<%
				// si c'est le cas on boucle sur tous les elements de la liste qui ont ce type de contenu
				listeTypesContenu.add(itFileDoc.getContentType());
				// copyListePublication est juste là pour de l'optimisation, on vire de la liste les elements déjà affichés pour un type précédent
				TreeSet<FileDocument> copyListePublication = (TreeSet<FileDocument>)listePublication.clone();
			%>
			<h3><%= itFileDoc.getContentType() %></h3>
			<jalios:foreach name='itFileDoc2' collection='<%= listePublication %>' type='FileDocument'>
				<jalios:if predicate='<%= itFileDoc.getContentType().equals(itFileDoc2.getContentType()) %>'>
					<% copyListePublication.remove(itFileDoc2); %>
					<li>
						<jalios:edit pub="<%= itFileDoc2 %>" redirect="plugins/SoclePlugin/jsp/reprise/documentSansContenusLies.jsp" />
						<jalios:link data="<%= itFileDoc2 %>" />
					</li>
				</jalios:if>
			</jalios:foreach>
			<% listePublication = copyListePublication; %>
		</jalios:if>
	</jalios:if>
</jalios:foreach>
<%@ include file='/admin/doAdminFooter.jspf'%>
