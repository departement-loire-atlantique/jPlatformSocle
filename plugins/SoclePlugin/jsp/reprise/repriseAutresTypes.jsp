<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@page import="com.jalios.jcms.handler.QueryHandler"%>
<%@page import="java.io.IOException" %>
<%
%><%@ include file="/jcore/doInitPage.jsp" %><%

if(!isAdmin) {
	sendForbidden(request, response);
	return;
}

%>
<%@ include file='/admin/doAdminHeader.jspf' %>

<div class="page-header"><h1>Reprise des anciens types</h1></div>


<h3>Reprise des SAAD</h3>
<form>
    <input type="hidden" name="SAAD" value="true">
    <input class="btn btn-danger modal confirm" type="submit" value="Lancer la reprise"/>
</form>

<h3>Reprise des Etablisements personnes agées</h3>
<form>
    <input type="hidden" name="SeniorCitizensEstablishment" value="true">
    <input class="btn btn-danger modal confirm" type="submit" value="Lancer la reprise"/>
</form>

<% 

if(getBooleanParameter("SAAD", false)) {
    
    QueryHandler qh = new QueryHandler();
    qh.setExactType(true);
    qh.setTypes(SAAD.class.getSimpleName());
    QueryResultSet result = qh.getResultSet();
    
    for(Publication itPub : result) {
        
        
        SAAD itClone = (SAAD) itPub.getUpdateInstance();    
        
        itClone.setCommunes(itClone.getCities());
        itClone.checkAndPerformUpdate(loggedMember);
        
    }
    
}

if(getBooleanParameter("SeniorCitizensEstablishment", false)) {
    
    QueryHandler qh = new QueryHandler();
    qh.setExactType(true);
    qh.setTypes(SeniorCitizensEstablishment.class.getSimpleName());
    QueryResultSet result = qh.getResultSet();
    
    for(Publication itPub : result) {
        
        
    	SeniorCitizensEstablishment itClone = (SeniorCitizensEstablishment) itPub.getUpdateInstance();    
        
    	itClone.setCommune(itClone.getCity());
    	itClone.checkAndPerformUpdate(loggedMember);
        
    }
    
}

%>


<%@ include file='/admin/doAdminFooter.jspf' %> 