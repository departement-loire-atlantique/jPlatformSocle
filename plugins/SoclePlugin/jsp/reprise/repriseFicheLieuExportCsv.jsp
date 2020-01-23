<%@page import="java.util.regex.Matcher"%><%
%><%@page import="java.util.regex.Pattern"%><%
%><%@page import="fr.cg44.plugin.socle.SocleUtils"%><%
%><%@page import="com.jalios.jcms.handler.QueryHandler"%><%
%><%@page import="java.io.IOException" %><%
%><%@page import="java.io.Writer" %><%
%><%  

response.setHeader("Content-Disposition", "attachment; filename=places.csv");
//inform doInitPage to set the proper content type
request.setAttribute("ContentType", "text/csv; charset=ISO-8859-1");

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

if (!isLogged) {
  sendForbidden(request, response);
  return;
}

String separator = ";";

String newLine = "\n";

PrintWriter printWriter = new PrintWriter(out);

StringBuffer csvHeader = new StringBuffer();
StringBuffer csvData = new StringBuffer();

if(getBooleanParameter("exportNew", false)) {
	
	QueryHandler qh = new QueryHandler();
    qh.setExactType(true);
    qh.setTypes(FicheLieu.class.getSimpleName());
    QueryResultSet result = qh.getResultSet();
    
    if (Util.isEmpty(result)) return;

    csvHeader.append("Identifiant");
    csvHeader.append(separator);
    csvHeader.append("Titre");
    csvHeader.append(separator);
    csvHeader.append("Sous-titre");
    csvHeader.append(separator);
    csvHeader.append("Chapo");
    csvHeader.append(separator);
    csvHeader.append("ID référentiel");
    csvHeader.append(separator);
    csvHeader.append("Etage - couloir - escalier");
    csvHeader.append(separator);
    csvHeader.append("Entrée - bâtiment - immeuble");
    csvHeader.append(separator);
    csvHeader.append("N° de voie");
    csvHeader.append(separator);
    csvHeader.append("Libellé voie");
    csvHeader.append(separator);
    csvHeader.append("Lieu-dit");
    csvHeader.append(separator);
    csvHeader.append("Code postal");
    csvHeader.append(separator);
    csvHeader.append("Commune");
    csvHeader.append(separator);
    csvHeader.append("Plan d'accès");
    csvHeader.append(separator);
    csvHeader.append("Libellé autre adresse");
    csvHeader.append(separator);
    csvHeader.append("Etage - couloir - escalier 2");
    csvHeader.append(separator);
    csvHeader.append("Entrée - bâtiment - immeuble 2");
    csvHeader.append(separator);
    csvHeader.append("N° de voie 2");
    csvHeader.append(separator);
    csvHeader.append("Libellé voie 2");
    csvHeader.append(separator);
    csvHeader.append("Lieu-dit 2");
    csvHeader.append(separator);
    csvHeader.append("Code postal 2");
    csvHeader.append(separator);
    csvHeader.append("CS");
    csvHeader.append(separator);
    csvHeader.append("Cedex");
    csvHeader.append(separator);
    csvHeader.append("Commune 2");
    csvHeader.append(separator);
    csvHeader.append("Téléphone");
    csvHeader.append(separator);
    csvHeader.append("Email");
    csvHeader.append(separator);
    csvHeader.append("Site internet");
    csvHeader.append(separator);
    csvHeader.append("Plus de détail (interne)");
    csvHeader.append(separator);
    csvHeader.append("Plus de détail (externe)");
    csvHeader.append(separator);
    csvHeader.append("Type d'accés");
    csvHeader.append(separator);
    csvHeader.append("Complément type d'accès");
    csvHeader.append(separator);
    csvHeader.append("Pour qui ?");
    csvHeader.append(separator);
    csvHeader.append("Modalités d'accueil");
    csvHeader.append(separator);
    csvHeader.append("Horaires et accès");
    csvHeader.append(separator);
    csvHeader.append("Transports en commun");
    csvHeader.append(separator);
    csvHeader.append("Parkings");
    csvHeader.append(separator);
    csvHeader.append("Description");
    csvHeader.append(separator);
    csvHeader.append("Vidéo");
    csvHeader.append(separator);
    csvHeader.append("Autres lieux");
    csvHeader.append(separator);
    csvHeader.append("Portlet bas");
    csvHeader.append(separator);
    csvHeader.append("Communes concernées");
    csvHeader.append(separator);
    csvHeader.append("Toutes communes");
    csvHeader.append(separator);
    csvHeader.append("Délégations concernées");
    csvHeader.append(separator);
    csvHeader.append("EPCI concernées");
    csvHeader.append(separator);
    csvHeader.append("Cantons concernés");
    csvHeader.append(separator);
    csvHeader.append(newLine);

    printWriter.write(csvHeader.toString());
    
    for (Publication itPub : result) {
        
    	FicheLieu itLieu = (FicheLieu) itPub;    
        
        if (!itLieu.isInVisibleState()) continue;
        
        StringBuffer planDacces = new StringBuffer();
        if (Util.notEmpty(itLieu.getPlanDacces())) {
            for (int i = 0; i < itLieu.getPlanDacces().length; i++) {
                planDacces.append(itLieu.getPlanDacces()[i].getTitle());
                if (i < itLieu.getPlanDacces().length-1) planDacces.append(", ");
            }
        } else {
            planDacces.append("");
        }
        
        StringBuffer telephone = new StringBuffer();
        if (Util.notEmpty(itLieu.getTelephone())) {
            for (int i = 0; i < itLieu.getTelephone().length; i++) {
                telephone.append(itLieu.getTelephone()[i]);
                if (i < itLieu.getTelephone().length-1) telephone.append(", ");
            }
        } else {
            telephone.append("");
        }
        
        StringBuffer email = new StringBuffer();
        if (Util.notEmpty(itLieu.getEmail())) {
            for (int i = 0; i < itLieu.getEmail().length; i++) {
                email.append(itLieu.getEmail()[i]);
                if (i < itLieu.getEmail().length-1) email.append(", ");
            }
        } else {
            email.append("");
        }
        
        StringBuffer siteInternet = new StringBuffer();
        if (Util.notEmpty(itLieu.getSiteInternet())) {
            for (int i = 0; i < itLieu.getSiteInternet().length; i++) {
            	siteInternet.append(itLieu.getSiteInternet()[i]);
                if (i < itLieu.getSiteInternet().length-1) siteInternet.append(", ");
            }
        } else {
        	siteInternet.append("");
        }
        
        StringBuffer typeDacces = new StringBuffer();
        if (Util.notEmpty(itLieu.getTypeDacces(loggedMember))) {
        	for (Iterator iter = itLieu.getTypeDacces(loggedMember).iterator(); iter.hasNext();) {
        		Category itCat = (Category) iter.next();
        		typeDacces.append(itCat.getName());
        		if (iter.hasNext()) typeDacces.append(", ");
        	}
        } else {
        	typeDacces.append("");
        }
        
        StringBuffer video = new StringBuffer();
        if (Util.notEmpty(itLieu.getVideo())) {
            for (int i = 0; i < itLieu.getVideo().length; i++) {
                video.append(itLieu.getVideo()[i].getTitle());
                if (i < itLieu.getVideo().length-1) video.append(", ");
            }
        } else {
            video.append("");
        }
        
        StringBuffer autresLieux = new StringBuffer();
        if (Util.notEmpty(itLieu.getAutresLieuxAssocies())) {
            for (int i = 0; i < itLieu.getAutresLieuxAssocies().length; i++) {
                autresLieux.append(itLieu.getAutresLieuxAssocies()[i].getTitle());
                if (i < itLieu.getAutresLieuxAssocies().length-1) autresLieux.append(", ");
            }
        } else {
            autresLieux.append("");
        }
        
        StringBuffer portletBas = new StringBuffer();
        if (Util.notEmpty(itLieu.getPortletBas())) {
            for (int i = 0; i < itLieu.getPortletBas().length; i++) {
                portletBas.append(itLieu.getPortletBas()[i].getTitle());
                if (i < itLieu.getPortletBas().length-1) portletBas.append(", ");
            }
        } else {
            portletBas.append("");
        }
        
        StringBuffer communesConcernees = new StringBuffer();
        if (Util.notEmpty(itLieu.getCommunes())) {
            for (int i = 0; i < itLieu.getCommunes().length; i++) {
            	communesConcernees.append(itLieu.getCommunes()[i]);
                if (i < itLieu.getCommunes().length-1) communesConcernees.append(", ");
            }
        } else {
        	communesConcernees.append("");
        }
        
        StringBuffer delegations = new StringBuffer();
        if (Util.notEmpty(itLieu.getDelegations(loggedMember))) {
            for (Iterator iter = itLieu.getDelegations(loggedMember).iterator(); iter.hasNext();) {
                Category itCat = (Category) iter.next();
                delegations.append(itCat.getName());
                if (iter.hasNext()) delegations.append(", ");
            }
        } else {
        	delegations.append("");
        }
        
        StringBuffer epci = new StringBuffer();
        if (Util.notEmpty(itLieu.getEpci(loggedMember))) {
            for (Iterator iter = itLieu.getEpci(loggedMember).iterator(); iter.hasNext();) {
                Category itCat = (Category) iter.next();
                epci.append(itCat.getName());
                if (iter.hasNext()) epci.append(", ");
            }
        } else {
        	epci.append("");
        }
        
        StringBuffer cantons = new StringBuffer();
        if (Util.notEmpty(itLieu.getCantons())) {
            for (int i = 0; i < itLieu.getCantons().length; i++) {
            	cantons.append(itLieu.getCantons()[i].getTitle());
                if (i < itLieu.getCantons().length-1) cantons.append(", ");
            }
        } else {
        	cantons.append("");
        }
            
        csvData.append(itLieu.getId());
        csvData.append(separator);
        csvData.append(itLieu.getTitle().replaceAll(";", ","));
        csvData.append(separator);
        csvData.append(itLieu.getSoustitre().replaceAll(";", ","));
        csvData.append(separator);
        csvData.append(itLieu.getChapo().replaceAll("\n{1,}",", ").replaceAll("\r{1,}",", ").replaceAll("[, ]{2,}", ", ").replaceAll(";", ","));
        csvData.append(separator);
        csvData.append(itLieu.getIdReferentiel().replaceAll(";", ","));
        csvData.append(separator);
        csvData.append(itLieu.getEtageCouloirEscalier().replaceAll(";", ","));
        csvData.append(separator);
        csvData.append(itLieu.getEntreeBatimentImmeuble().replaceAll(";", ","));
        csvData.append(separator);
        csvData.append(itLieu.getNdeVoie().replaceAll(";", ","));
        csvData.append(separator);
        csvData.append(itLieu.getLibelleDeVoie().replaceAll(";", ","));
        csvData.append(separator);
        csvData.append(itLieu.getLieudit().replaceAll(";", ","));
        csvData.append(separator);
        csvData.append(itLieu.getCodePostal().replaceAll(";", ","));
        csvData.append(separator);
        csvData.append(itLieu.getCommune());
        csvData.append(separator);
        csvData.append(planDacces);
        csvData.append(separator);
        csvData.append(itLieu.getLibelleAutreAdresse().replaceAll(";", ","));
        csvData.append(separator);
        csvData.append(itLieu.getEtageCouloirEscalier2());
        csvData.append(separator);
        csvData.append(itLieu.getEntreeBatimentImmeuble2());
        csvData.append(separator);
        csvData.append(itLieu.getNdeVoie2());
        csvData.append(separator);
        csvData.append(itLieu.getLibelleDeVoie2());
        csvData.append(separator);
        csvData.append(itLieu.getLieudit2());
        csvData.append(separator);
        csvData.append(itLieu.getCodePostal2());
        csvData.append(separator);
        csvData.append(itLieu.getCs2());
        csvData.append(separator);
        csvData.append(itLieu.getCedex2());
        csvData.append(separator);
        csvData.append(Util.notEmpty(itLieu.getCommune2()) ? itLieu.getCommune2() : "");
        csvData.append(separator);
        csvData.append(telephone);
        csvData.append(separator);
        csvData.append(email);
        csvData.append(separator);
        csvData.append(siteInternet);
        csvData.append(separator);
        csvData.append(Util.notEmpty(itLieu.getPlusDeDetailInterne()) ? itLieu.getPlusDeDetailInterne() : "");
        csvData.append(separator);
        csvData.append(itLieu.getPlusDeDetailExterne().replaceAll(";", ","));
        csvData.append(separator);
        csvData.append(typeDacces);
        csvData.append(separator);
        csvData.append(itLieu.getComplementTypeDacces().replaceAll(";", ","));
        csvData.append(separator);
        csvData.append(HtmlUtil.html2text(itLieu.getPourQui()).replaceAll(";", ","));
        csvData.append(separator);
        csvData.append(HtmlUtil.html2text(itLieu.getModalitesDaccueil()).replaceAll(";", ","));
        csvData.append(separator);
        csvData.append(HtmlUtil.html2text(itLieu.getHorairesEtAcces()).replaceAll(";", ","));
        csvData.append(separator);
        csvData.append(HtmlUtil.html2text(itLieu.getTransportsEnCommun()).replaceAll(";", ","));
        csvData.append(separator);
        csvData.append(HtmlUtil.html2text(itLieu.getParkings()).replaceAll(";", ","));
        csvData.append(separator);
        csvData.append(HtmlUtil.html2text(itLieu.getDescription()).replaceAll(";", ","));
        csvData.append(separator);
        csvData.append(video);
        csvData.append(separator);
        csvData.append(autresLieux);
        csvData.append(separator);
        csvData.append(portletBas);
        csvData.append(separator);
        csvData.append(communesConcernees);
        csvData.append(separator);
        csvData.append(itLieu.getToutesLesCommunesDuDepartement());
        csvData.append(separator);
        csvData.append(delegations);
        csvData.append(separator);
        csvData.append(epci);
        csvData.append(separator);
        csvData.append(cantons);
        csvData.append(separator);
        csvData.append(newLine);
        
    }

} else {
	QueryHandler qh = new QueryHandler();
	
	qh.setExactType(true);
	qh.setTypes(Place.class.getSimpleName());
	QueryResultSet result = qh.getResultSet();

	if (Util.isEmpty(result)) return;

	csvHeader.append("Identifiant");
	csvHeader.append(separator);
	csvHeader.append("ID Fiche Lieu");
	csvHeader.append(separator);
	csvHeader.append("Titre");
	csvHeader.append(separator);
	csvHeader.append("Téléphone");
	csvHeader.append(separator);
	csvHeader.append("Adresse");
	csvHeader.append(separator);
	csvHeader.append("Code Postal");
	csvHeader.append(separator);
	csvHeader.append("Boîte Postale");
	csvHeader.append(newLine);

	printWriter.write(csvHeader.toString());

	for (Publication itPub : result) {
	    
	    Place itPlace = (Place) itPub;    
	    
	    if (!itPlace.isInVisibleState()) continue;
	    
	    FicheLieu itAssociatedLieu = getNewFiche(itPlace.getId());
	    
	    StringBuffer itPhones = new StringBuffer();
	    if (Util.notEmpty(itPlace.getPhones())) {
	        for (int i = 0; i < itPlace.getPhones().length; i++) {
	            itPhones.append(itPlace.getPhones()[i]);
	            if (i < itPlace.getPhones().length-1) itPhones.append(", ");
	        }
	    } else {
	        itPhones.append("");
	    }
	        
	    csvData.append(itPlace.getId());
	    csvData.append(separator);
	    csvData.append(Util.isEmpty(itAssociatedLieu) ? "" : itAssociatedLieu.getId());
	    csvData.append(separator);
	    csvData.append(itPlace.getTitle().replaceAll(";", ","));
	    csvData.append(separator);
	    csvData.append(itPhones.toString().replaceAll(";", ","));
	    csvData.append(separator);
	    csvData.append(itPlace.getStreet().replaceAll("\n{1,}",", ").replaceAll("\r{1,}",", ").replaceAll("[, ]{2,}", ", "));
	    csvData.append(separator);
	    csvData.append(itPlace.getZipCode().replaceAll(";", ","));
	    csvData.append(separator);
	    csvData.append(itPlace.getPostalBox().replaceAll(";", ","));
	    csvData.append(newLine);
	    
	}
	
}

printWriter.write(csvData.toString());

%>