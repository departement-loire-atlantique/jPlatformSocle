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
		BODY {
			overflow: scroll;
		}
		
		.marginBottom {
			margin-bottom: 20px;
		}
		
		.percentBlock {
			width: 250px;
		}
		
		.percentBlock > DIV {
			display: flex;
		}
		
		.percentBlock > DIV:first-child {
			justify-content: space-between;
		}
		
		.percentBlock > DIV:first-child SPAN:last-child {
			text-align: end;
		}
		
		.percentBlock DIV A {
			display: inline-flex;
			height: 14px;
			min-width: 14px;
		}
		
		.percentBlock DIV A:first-child {
			background: #24883E;
		}
		
		.percentBlock DIV A:last-child {
			background: #DC3545;
		}
		
		.legend {
			display: inline-flex;
			flex-direction: column;
			width: 270px;
			border-right: solid 1px;
			padding-right: 5px;
			margin-right: 5px;
		}
		
		.legend P {
			text-align: end;
		}
		
		.diagram {
			display: inline-flex;
			flex-direction: column;
			width: 220px;
			height: 90px;
			justify-content: space-around;
		}
		
		.diagram A {
			display: flex;
			background: #DC3545;
			height: 14px;
			min-width: 14px;
		}
		
		.btnExportCsv {
			position: absolute;
			right: 50px;
			top: 100px;
		}
	</style>
</head>

<div class="page-header"><h1>Tableau de bord des formulaires pages utiles</h1></div>

<% 
	TreeSet<PageUtileForm> sortedPubs = channel.getPublicationSet(PageUtileForm.class, loggedMember);
	int nbrAvis, nbrAvisPositif, nbrAvisNegatif, nbrPasAssezComplet, nbrInformationTropComplique, nbrTropALire, nbrComm, nbrCommPositif, nbrCommNegatif;
	nbrAvis = nbrAvisPositif = nbrAvisNegatif = nbrPasAssezComplet = nbrInformationTropComplique = nbrTropALire = nbrComm = nbrCommPositif = nbrCommNegatif = 0;
	
	for (Iterator<PageUtileForm> iter = sortedPubs.iterator(); iter.hasNext();) {
		
		nbrAvis++;
		
		PageUtileForm itPageUtileForm = iter.next();
		
		if(itPageUtileForm.getUtile()) {
			nbrAvisPositif++;
			
			if(Util.notEmpty(itPageUtileForm.getCommentaire())) {
				nbrComm++;
				nbrCommPositif++;
			}
		} else {
			nbrAvisNegatif++;
			
			if(Util.notEmpty(itPageUtileForm.getCommentaire())) {
				nbrComm++;
				nbrCommNegatif++;
			}
		
			if(itPageUtileForm.getMotif(userLang).contains("pasAssezComplet")) {
				nbrPasAssezComplet++;
			}
			if(itPageUtileForm.getMotif(userLang).contains("tropComplique")) {
				nbrInformationTropComplique++;
			}
			if(itPageUtileForm.getMotif(userLang).contains("tropLong")) {
				nbrTropALire++;
			}
		}
	}
%>

<div class="pageUtileStat">
	<div>
		<h2 class="marginBottom">
			<span class="jalios-icon log-icon icomoon-clipboard3"></span>
			<span class="ds44-js-dynamic-number" data-stop="<%= nbrAvis %>"><%= nbrAvis %></span> formulaire(s) page utile rempli(s)
		</h2>
		<div class="percentBlock">
			<div>
				<span>Positifs : <%= nbrAvisPositif %></span>
				<span>Négatifs : <%= nbrAvisNegatif %></span>
			</div>
			<div>
				<a style="flex-grow: <%= nbrAvisPositif %>;" title="Positifs : <%= nbrAvisPositif %>"></a>
				<a style="flex-grow: <%= nbrAvisNegatif %>;" title="Negatifs : <%= nbrAvisNegatif %>"></a>
			</div>
		</div>
	</div>
	<div class="ds44-wsg-encadreContour">
		<p><h2 class="h2-like"> Types d'avis </h2></p>
		<div class="legend">
			<p>Pas assez complet : <%= nbrPasAssezComplet %></p>
			<p>L'information est trop compliqué : <%= nbrInformationTropComplique %></p>
			<p>Il y a trop à lire : <%= nbrTropALire %></p>
		</div>
		<div class="diagram">
			<%
				int avisPlusNombreux = nbrPasAssezComplet;
				if(nbrInformationTropComplique > avisPlusNombreux) avisPlusNombreux = nbrInformationTropComplique;
				if(nbrTropALire > avisPlusNombreux) avisPlusNombreux = nbrTropALire;
			%>
			<a style="width: <%= (nbrPasAssezComplet*100/avisPlusNombreux) %>%;" title="Pas assez complet : <%= nbrPasAssezComplet %>"></a>
			<a style="width: <%= (nbrInformationTropComplique*100/avisPlusNombreux) %>%;" title="L'information est trop compliqué : <%= nbrInformationTropComplique %>"></a>
			<a style="width: <%= (nbrTropALire*100/avisPlusNombreux) %>%;" title="Il y a trop à lire : <%= nbrTropALire %>"></a>
		</div>
	</div>
	<div>
		<h2 class="marginBottom">
			<span class="jalios-icon log-icon icomoon-bubble-lines4"></span>
			<span class="ds44-js-dynamic-number" data-stop="<%= nbrComm %>"><%= nbrComm %></span> commentaire(s)
		</h2>
		<div class="percentBlock marginBottom">
			<div>
				<span>Commentaires positifs : <%= nbrCommPositif %></span>
				<span>Commentaires négatifs : <%= nbrCommNegatif %></span>
			</div>
			<div>
				<a style="flex-grow: <%= nbrCommPositif %>;" title="Commentaires positifs : <%= nbrCommPositif %>"></a>
				<a style="flex-grow: <%= nbrCommNegatif %>;" title="Commentaires négatifs : <%= nbrCommNegatif %>"></a>
			</div>
		</div>
	</div>
</div>

<p class="btnExportCsv">
	<a href="plugins/SoclePlugin/jsp/export/exportPageUtileForm.jsp" class="ds44-btnStd ds44-btnStd--large" target="_blank">
		<span class="ds44-btnInnerText">Exporter en CSV</span>
	</a>
</p>

<%@ include file="/admin/doAdminFooter.jspf" %>


