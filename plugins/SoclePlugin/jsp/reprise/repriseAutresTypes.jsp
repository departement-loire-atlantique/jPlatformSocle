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
    <input type="hidden" name="dataType" value="<%= SAAD.class.getSimpleName() %>">
    <input type="hidden" name="executeReprise" value="true">
    <input class="btn btn-danger modal confirm" type="submit" value="Lancer la reprise"/>
</form>

<h3>Reprise des Etablisements personnes agées</h3>
<form>
    <input type="hidden" name="dataType" value="<%= SeniorCitizensEstablishment.class.getSimpleName() %>">
    <input type="hidden" name="executeReprise" value="true">
    <input class="btn btn-danger modal confirm" type="submit" value="Lancer la reprise"/>
</form>

<h3>Reprise des Equipements</h3>
<form>
    <input type="hidden" name="dataType" value="<%= Equipement.class.getSimpleName() %>">
    <input type="hidden" name="executeReprise" value="true">
    <input class="btn btn-danger modal confirm" type="submit" value="Lancer la reprise"/>
</form>

<h3>Reprise des Spectacles aidés</h3>
<form>
    <input type="hidden" name="dataType" value="<%= Show.class.getSimpleName() %>">
    <input type="hidden" name="executeReprise" value="true">
    <input class="btn btn-danger modal confirm" type="submit" value="Lancer la reprise"/>
</form>

<h3>Reprise des Fiches professionnel culture</h3>
<form>
    <input type="hidden" name="dataType" value="<%= CultureProfessionalCard.class.getSimpleName() %>">
    <input type="hidden" name="executeReprise" value="true">
    <input class="btn btn-danger modal confirm" type="submit" value="Lancer la reprise"/>
</form>

<h3>Reprise des Articles géolocalisés</h3>
<form>
    <input type="hidden" name="dataType" value="<%= ArticleGeolocalise.class.getSimpleName() %>">
    <input type="hidden" name="executeReprise" value="true">
    <input class="btn btn-danger modal confirm" type="submit" value="Lancer la reprise"/>
</form>

<% 

String dataType = getUntrustedStringParameter("dataType", "");

if(getBooleanParameter("executeReprise", false) && Util.notEmpty(dataType)) {
    
    QueryHandler qh = new QueryHandler();
    qh.setExactType(true);
    qh.setTypes(dataType);
    qh.setLoggedMember(loggedMember);
    QueryResultSet result = qh.getResultSet();
    
    for(Publication itPub : result) {
        
        try {
            if (Util.notEmpty(itPub.getFieldValue("cities"))) {
                Publication itClone = (Publication) itPub.getUpdateInstance();
                itClone.setFieldValue("communes", itPub.getFieldValue("cities"));
                itClone.checkAndPerformUpdate(loggedMember);
            }
        } catch (Exception e) {
            // do nothing
        }

        try {
            if (Util.notEmpty(itPub.getFieldValue("city"))) {
                Publication itClone = (Publication) itPub.getUpdateInstance();
                itClone.setFieldValue("commune", itPub.getFieldValue("city"));
                itClone.checkAndPerformUpdate(loggedMember);
            }
        } catch (Exception e) {
            // do nothing
        }
        
    }
    
}

%>


<%@ include file='/admin/doAdminFooter.jspf' %> 