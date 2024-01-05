<%@page import="fr.cg44.plugin.socle.reprise.RepriseFicheArticleUtil"%>
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

%><%@ include file="/jcore/doInitPage.jsp" %><%

if (!isLogged) {
  sendForbidden(request, response);
  return;
}

RepriseFicheArticleUtil.exportNew(out, loggedMember)
%>