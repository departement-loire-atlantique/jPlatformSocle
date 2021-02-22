<%@page import="com.jalios.jcms.handler.MemberQueryHandler"%>
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

<div class="page-header"><h1>Export CSV de contenu</h1></div>

<b>Export Fiches Article</b><br/>
<a href="plugins/SoclePlugin/jsp/export/exportFicheArticle.jsp" class="btn btn-info modal" target="_blank">Exporter en CSV</a>