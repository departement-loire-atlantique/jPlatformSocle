<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@page import="com.jalios.jcms.handler.QueryHandler"%>
<%  
%><%@ include file="/jcore/doInitPage.jsp" %><%!

public static FicheLieu getNewFiche(String idPlace) {
	QueryHandler qh = new QueryHandler();
    qh.setExactType(true);
    qh.setTypes(FicheLieu.class.getSimpleName());
    QueryResultSet result = qh.getResultSet();
    
    for(Publication itPub : result) {  
    	FicheLieu itFiche = (FicheLieu) (itPub);
    	if(idPlace.equals(itFiche.getIdAncienContenu())) {
    		return itFiche;
    	}
    }    
    return null;
}

%><%

if(!isAdmin) {
	sendForbidden(request, response);
	return;
}

%>
<%@ include file='/admin/doAdminHeader.jspf' %>

<div class="page-header"><h1>Reprise des fiches lieux</h1></div>


<h3>Reprise des fiche lieux</h3>
<form>
	<input type="hidden" name="reprise" value="true">
	<input class="btn btn-danger modal confirm" type="submit" value="Lancer la reprise"/>
</form>



<h3>Correction sur les virgules</h3>
<form>
    <input type="hidden" name="virgule" value="true" >
    <input class="btn btn-primary modal confirm" type="submit" value="Lancer la correction"/>
</form>



<h3>Lister les cedex / CS</h3>
<form>
    <input type="hidden" name="cedex" value="true" >
    <input class="btn btn-primary modal confirm" type="submit" value="Lancer le test"/>
</form>




<% 

if(getBooleanParameter("cedex", false)) {
	
	QueryHandler qh = new QueryHandler();
	qh.setExactType(true);
	qh.setTypes(Place.class.getSimpleName());
	QueryResultSet result = qh.getResultSet();	
	Pattern pattern = Pattern.compile("(\\D*)");	
	for(Publication itPub : result) {
		Place itPlace = (Place) itPub; 
		
		if(itPlace.getStreet().toLowerCase().contains("cedex") ) {%>
			<p><%= itPlace.getId() %> : <%= itPlace.getTitle() %> // Place <jalios:edit pub="<%= itPlace %>" /> -> Fiche <jalios:edit pub="<%= getNewFiche(itPlace.getId()) %>" />  : Cedex dans le champ adresse </p>
		<%}
						 
		if(itPlace.getPostalBox().toLowerCase().contains("cedex")) {%>
			<p><%= itPlace.getId() %> : <%= itPlace.getTitle() %> // Place <jalios:edit pub="<%= itPlace %>" /> -> Fiche <jalios:edit pub="<%= getNewFiche(itPlace.getId()) %>" />  : Boite postal <%= itPlace.getPostalBox() %> </p>
        <%}
		
		if(itPlace.getZipCode().toLowerCase().contains("cedex")) {%>
           <p><%= itPlace.getId() %> : <%= itPlace.getTitle() %> // Place <jalios:edit pub="<%= itPlace %>" /> -> Fiche <jalios:edit pub="<%= getNewFiche(itPlace.getId()) %>" />  : code postal <%= itPlace.getZipCode() %> </p>
    <%}
	}	
}






if(getBooleanParameter("virgule", false)) {
	
	QueryHandler qh = new QueryHandler();
	qh.setExactType(true);
	qh.setTypes(FicheLieu.class.getSimpleName());
	QueryResultSet result = qh.getResultSet();
	
	Pattern pattern = Pattern.compile("(^, *)(.*)");
	
	
	for(Publication itPub : result) {
		
		
		FicheLieu itFiche = (FicheLieu) itPub;    
		
        Matcher matcher = pattern.matcher(itFiche.getLibelleDeVoie());
		
        if(matcher.matches()) {
        	FicheLieu clone = (FicheLieu) (itFiche.getUpdateInstance());
        	
        	clone.setLibelleDeVoie(matcher.group(2).trim());
        	clone.performUpdate(itFiche.getAuthor());
        	out.print(itFiche.getDisplayUrl(userLocale) + "<br/>");
        }
		
	}
	
}










if(getBooleanParameter("reprise", false)) {

QueryHandler qh = new QueryHandler();
qh.setExactType(true);
qh.setTypes(Place.class.getSimpleName());
QueryResultSet result = qh.getResultSet();


for(Publication itPub : result) {
	
	if(itPub.isInVisibleState()) {
	
		   Place itPlace = (Place) itPub;		   
		   
		   Set<Category> categories = new HashSet<Category>();
		   categories.addAll(itPlace.getCategorySet());
		   
		   FicheLieu itFiche = new FicheLieu();
		   
		   itFiche.setTitle(itPlace.getTitle());
		   itFiche.setIdReferentiel(itPlace.getSolisId());
		   
		   itFiche.setIdAncienContenu(itPlace.getId());
		   
		   itFiche.setSoustitre(itPlace.getServiceOrHubOrUnit());
		   itFiche.setImagePrincipale(itPlace.getMainIllustration());
		   itFiche.setLegende(itPlace.getIllustrationLegend());
		   itFiche.setCopyright(itPlace.getIllustrationCopyright());
		   

		   String adresse = HtmlUtil.html2text(itPlace.getStreet());
		   if(Util.notEmpty(adresse)) {
			   Pattern pattern = Pattern.compile("(^\\d*)(.*)");
			   Matcher matcher = pattern.matcher(adresse);
			   if(matcher.matches()) {
				    itFiche.setNdeVoie(matcher.group(1));
				    itFiche.setLibelleDeVoie(matcher.group(2).trim());
			   }else {			   
				   itFiche.setLibelleDeVoie(adresse);
			   }
		   }
		     

		   itFiche.setCodePostal(SocleUtils.cleanNumber(itPlace.getZipCode()));
		   
		   itFiche.setCommune(itPlace.getCity());
		   itFiche.setPlanDacces(itPlace.getAccessMap());
		   
		   itFiche.setCs2(SocleUtils.cleanNumber(itPlace.getPostalBox()));
		   
		   itFiche.setTelephone(SocleUtils.cleanNumber(itPlace.getPhones()));
		   
		   itFiche.setEmail(itPlace.getMails());
		   itFiche.setSiteInternet(itPlace.getWebsites());
		   
		   categories.add(itPlace.getOpenToPublic() ? channel.getCategory("c_1156286") : channel.getCategory("c_1156287"));
		   
		   itFiche.setHorairesEtAcces(itPlace.getHours());
		   itFiche.setTransportsEnCommun(itPlace.getTransport());
		   itFiche.setDescription(itPlace.getDescription());
		   
				  
		   
		   itFiche.setCommunes(itPlace.getCities());
		   
		   
		   // TODO mapping délegation categorie -> contenu
		   
		   itFiche.setCantons(new Canton[]{itPlace.getCanton()});
		   		   
		   // Reprise de toutes les catégories
		   itFiche.setCategorySet(categories);
		   
		   
		   // extradata
		   itFiche.setExtraData("extra.Place.plugin.tools.geolocation.longitude", itPlace.getExtraData("extra.Place.plugin.tools.geolocation.longitude"));
		   itFiche.setExtraData("extra.Place.plugin.tools.geolocation.latitude", itPlace.getExtraData("extra.Place.plugin.tools.geolocation.latitude"));
		   
		   // meta donné et écriture
		   itFiche.setAuthor(itPlace.getAuthor());
		   itFiche.performCreate(itPlace.getAuthor());
	}
	
}

}

%>


<%@ include file='/admin/doAdminFooter.jspf' %> 