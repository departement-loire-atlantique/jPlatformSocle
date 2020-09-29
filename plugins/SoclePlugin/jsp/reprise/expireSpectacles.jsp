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

<div class="page-header"><h1> Les spectacles cochés à non dans spectacle aidé seront expirés</h1></div>


<form>
    <input type="hidden" name="executeReprise" value="true">
    <input class="btn btn-danger modal confirm" type="submit" value="Lancer"/>
</form>


<% 

String dataType = getUntrustedStringParameter("dataType", "");

if(getBooleanParameter("executeReprise", false)) {
	
    QueryHandler qh = new QueryHandler();
    qh.setExactType(true);
    qh.setTypes(Show.class.getSimpleName());
    qh.setCheckPstatus(true);
    qh.setLoggedMember(loggedMember);
    QueryResultSet result = qh.getResultSet();
    
    for(Publication itPub : result) {
        Show itShow = (Show) itPub;     
        if (!itShow.getHelpedShow()) {
            Publication itClone = (Publication) itPub.getUpdateInstance();
            itClone.setPstatus(WorkflowConstants.EXPIRED_PSTATUS);
            itClone.performUpdate(loggedMember);
            %>
              <jalios:edit pub="<%= itPub  %>" > <%= itPub  %> </jalios:edit>
            <%
        }            
    }    
}

%>


<%@ include file='/admin/doAdminFooter.jspf' %> 