<%@page import="java.util.regex.Matcher"%><%
%><%@page import="java.util.regex.Pattern"%><%
%><%@page import="fr.cg44.plugin.socle.SocleUtils"%><%
%><%@page import="com.jalios.jcms.handler.QueryHandler"%><%
%><%@page import="java.io.IOException" %><%
%><%@page import="java.io.Writer" %><%
%><%  

response.setHeader("Content-Disposition", "attachment; filename=places.csv");
//inform doInitPage to set the proper content type
request.setAttribute("ContentType", "text/csv; charset=" + channel.getProperty("csv.charset"));

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

QueryHandler qh = new QueryHandler();
qh.setExactType(true);
qh.setTypes(Place.class.getSimpleName());
QueryResultSet result = qh.getResultSet();

if (Util.isEmpty(result)) return;

PrintWriter printWriter = new PrintWriter(out);

String separator = ";";

String newLine = "\n";

StringBuffer csvHeader = new StringBuffer();

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

StringBuffer csvData = new StringBuffer();

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
    csvData.append(itPlace.getTitle());
    csvData.append(separator);
    csvData.append(itPhones.toString());
    csvData.append(separator);
    csvData.append(itPlace.getStreet().replaceAll("\n{1,}",", ").replaceAll("\r{1,}",", ").replaceAll("[, ]{2,}", ", "));
    csvData.append(separator);
    csvData.append(itPlace.getZipCode());
    csvData.append(separator);
    csvData.append(itPlace.getPostalBox());
    csvData.append(newLine);
    
}

printWriter.write(csvData.toString());

%>