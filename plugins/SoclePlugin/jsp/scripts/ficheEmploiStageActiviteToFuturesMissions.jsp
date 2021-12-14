<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %>

<jalios:select>
	<jalios:if predicate="<%= Util.isEmpty(loggedMember) || !loggedMember.isAdmin() %>">
	    <h2>Page accessible uniquement aux administateurs.</h2>
	</jalios:if>
	
	<jalios:default>
	   <h1>Màj des champs "Missions" et "Vous êtes fait pour le poste si" pour les contenus Fiche Emploi Stage</h1>
	
	   <%
	   TreeSet<FicheEmploiStage> allFiches = channel.getAllDataSet(FicheEmploiStage.class);
	   for (FicheEmploiStage itFiche : allFiches) {
		   FicheEmploiStage ficheClone = (FicheEmploiStage) itFiche.getUpdateInstance();
		   ficheClone.setMissions(ficheClone.getMissions(userLang) + ficheClone.getActivites(userLang));
		   ficheClone.setConnaissancesEtExperiences(ficheClone.getConnaissancesEtExperiences(userLang) + ficheClone.getConditionsARemplir(userLang));
		   ficheClone.performUpdate(loggedMember);
	   }
	   %>
	   
	   <p>Les contenus ont été mis à jour.</p>
	</jalios:default>
</jalios:select>

<p><a href="<%= channel.getUrl() %>">Retour à l'accueil</a></p>