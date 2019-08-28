<%--
  Cache la topbar si le membre n'appartient pas au groupe défini pour la topbar
--%><%--
--%><%@page import="fr.cg44.plugin.socle.SocleConstants"%>
<%@page import="com.jalios.jcms.uicomponent.topbar.TopbarHandler"%><%
%><%@ include file='/jcore/doInitPage.jspf'%><%

// Cache la topbar si le membre n'appartient pas au groupe défini pour la topbar
if(inFO && isLogged && !loggedMember.belongsToGroup(channel.getGroup(SocleConstants.VISIBLE_TOPBAR_GROUP_PROP))) {
	request.setAttribute(TopbarHandler.JCMS_TOPBAR_DISPLAY_REQUEST_ATTR, false);
}
%>