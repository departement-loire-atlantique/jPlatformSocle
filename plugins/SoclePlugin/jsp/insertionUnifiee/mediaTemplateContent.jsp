<%--
  Template utilisé pour afficher un contenu avec gabarit "embed" au sein d'une zone wysiwyg, via l'insertion unifiée.
  Si le gabarit "embed" n'est pas trouvé, l'affichage full est utilisé
--%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ page import="com.jalios.jcms.taglib.card.*" %><%
%><%@ include file='/jcore/media/mediaTemplateInit.jspf' %><%

if (data == null || !(data instanceof Content)) {
  return;
}
Content content = (Content) data;
String usage = content.getTemplate("embed").contains(".embed") ? "embed" : "full";%>

<%ServletUtil.backupAttribute(pageContext , PortalManager.PORTAL_PUBLICATION);%>

<jalios:include pub="<%= content %>" usage="<%= usage %>"/>

<%ServletUtil.restoreAttribute(pageContext , PortalManager.PORTAL_PUBLICATION);%>