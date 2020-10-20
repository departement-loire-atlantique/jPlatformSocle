<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@page import="com.jalios.jcms.handler.QueryHandler"%>
<%@page import="java.io.IOException"%>
<%
  
%><%@ include file="/jcore/doInitPage.jsp"%>
<%
  if (!isAdmin) {
    sendForbidden(request, response);
    return;
  }
%>
<%@ include file='/admin/doAdminHeader.jspf'%>

<div class="page-header">
	<h1>Liste des documents sans contenus liés</h1>
</div>
<jalios:foreach name='itFileDoc' collection='<%= channel.getPublicationSet(FileDocument.class, loggedMember) %>' type='FileDocument'>
	<jalios:if predicate='<%= Util.isEmpty(itFileDoc.getLinkIndexedDataSet(Data.class)) && Util.isEmpty(itFileDoc.getWeakReferrerSet()) %>'>
		<li>
			<jalios:edit pub="<%= itFileDoc %>" redirect="plugins/SoclePlugin/jsp/reprise/documentSansContenusLies.jsp" />
			<jalios:link data="<%= itFileDoc %>" />
		</li>
	</jalios:if>
</jalios:foreach>
<%@ include file='/admin/doAdminFooter.jspf'%>
