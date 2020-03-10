<%--
  Template utilis� pour afficher un contenu avec gabarit "embed" au sein d'une zone wysiwyg, via l'insertion unifi�e.
  Si le gabarit "embed" n'est pas trouv�, l'affichage full est utilis�
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