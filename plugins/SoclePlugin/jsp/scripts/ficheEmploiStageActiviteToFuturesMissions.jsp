<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %>

<jalios:select>
	<jalios:if predicate="<%= Util.isEmpty(loggedMember) || !loggedMember.isAdmin() %>">
	    <h2>Page accessible uniquement aux administateurs.</h2>
	    
	    <p><a href="<%= channel.getUrl() %>">Retour à l'accueil</a></p>
	</jalios:if>
	
	<jalios:default>
	   <h1>Transfert du contenu du champ "Activités" vers le champ "Futures missions" pour les contenus Fiche Emploi Stage</h1>
	
	   <%
	   TreeSet<FicheEmploiStage> allFiches = channel.getAllDataSet(FicheEmploiStage.class);
	   for (FicheEmploiStage itFiche : allFiches) {
		   FicheEmploiStage ficheClone = (FicheEmploiStage) itFiche.getUpdateInstance();
		   ficheClone.setMissions(ficheClone.getActivites(userLang));
		   ficheClone.checkAndPerformUpdate(loggedMember);
	   }
	   %>
	   
	   <p>Les contenus ont été mis à jour.</p>
	</jalios:default>
</jalios:select>