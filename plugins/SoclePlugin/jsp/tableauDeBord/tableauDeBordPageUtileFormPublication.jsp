<%@ page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ page import="fr.cg44.plugin.socle.export.ExportCsvUtils"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file='/jcore/doInitPage.jspf'%>
<%
	if(!isAdmin) {
		sendForbidden(request, response);
		return;
	}
%>
<%@ include file='/admin/doAdminHeader.jspf' %>
<head>
	<link rel="stylesheet" href="https://dev-design.loire-atlantique.fr/css/cd44.css">
	<script src="https://dev-design.loire-atlantique.fr/js/cd44.js"></script>
	<style type="text/css">
		.pageUtileStat ul.array > li {
			margin: 0;
		}
		
		.array {
			margin: 50px;
		}
		
		.array li p,
		.array li div {
			border: solid 1px #99E6D1;
			margin-bottom: 0;
			width: 16%;
			display: flex;
			justify-content: center;
			align-items: center;
			text-align: center;
			padding: 10px;
		}
		.array li p:nth-child(1) {
			width: 12%;
		}
		.array li p:nth-child(2),
		.array li div:nth-child(2) {
			width: 15%;
		}
		.array li p:nth-child(3) {
			width: 8%;
		}
		
		.array li p:nth-child(4) {
			width: 40%;
		}
		
		.array li p:nth-child(5) {
			width: 25%;
		}
		
		.array-header p {
			min-height: 51px;
			font-weight: bold;
		}
		
		.pageUtileStat .array li ul {
			padding: 0;
		}
	</style>
</head>

<%
	Publication pub = channel.getPublication(request.getParameterValues("id")[0]);

	Member mbr = pub.getAuthor();
	String fullName = "";
	if(Util.notEmpty(mbr.getFirstName())) {
		fullName = mbr.getFirstName();
	}
	if(Util.notEmpty(mbr.getFirstName()) && Util.notEmpty(mbr.getName())) {
		fullName += " ";
	}
	if(Util.notEmpty(mbr.getName())) {
		fullName += mbr.getName();
	}
%>

<div class="page-header"><h1>Liste des avis sur <%= pub.getTitle() %> - <%= fullName %></h1></div>

<% 
	Set<PageUtileForm> sortedPubs = channel.getPublicationSet(PageUtileForm.class, loggedMember);
	
	List<PageUtileForm> allAvisPub = new ArrayList();
	
	for (Iterator<PageUtileForm> iter = sortedPubs.iterator(); iter.hasNext();) {
		
		PageUtileForm itPageUtileForm = iter.next();
		
		Publication pubAvis = channel.getPublication(itPageUtileForm.getIdContenu());
		
		if(pub.equals(pubAvis)) {
			allAvisPub.add(itPageUtileForm);
		}
	}
%>

<div class="pageUtileStat">
	
	<% SimpleDateFormat sdfDate = new SimpleDateFormat("dd/MM/yyyy"); %>
	<ul class="array">
		<li class="array-header ds44-flex-container">
			<p>Date</p>
			<p>Motif(s) négatif(s)</p>
			<p>Positif/ Négatif</p>
			<p>Commentaire</p>
			<p>Adresse mail de l'internaute</p>
		</li>
		<jalios:foreach collection="<%= allAvisPub %>" name="itAvis" type="PageUtileForm">
			<li class="ds44-flex-container">
				<p><%= sdfDate.format(itAvis.getCdate()) %></p>
				<div>
					<ul>
						<jalios:if predicate='<%= itAvis.getMotif(userLang).contains("pasAssezComplet") %>'>
							<li>Pas assez complet</li>
						</jalios:if>
						<jalios:if predicate='<%= itAvis.getMotif(userLang).contains("tropComplique") %>'>
							<li>L'information est trop compliqué</li>
						</jalios:if>
						<jalios:if predicate='<%= itAvis.getMotif(userLang).contains("tropLong") %>'>
							<li>Il y a trop à lire</li>
						</jalios:if>
					</ul>
				</div>
				<p><%= itAvis.getUtile() ? "Positif" : "Négatif" %></p>
				<p><%= Util.notEmpty(itAvis.getCommentaire()) ? itAvis.getCommentaire() : "" %></p>
				<p><%= Util.notEmpty(itAvis.getEmail()) ? itAvis.getEmail() : "" %></p>
			</li>
		</jalios:foreach>
	</ul>
</div>

<%@ include file="/admin/doAdminFooter.jspf" %>


