<%--
  On inclut le gabarit avec usage "full" pour le type "ListeDeContenu"
  C'est dans ce gabarit full qu'on g-re le bon gabarit d'affichage. 
--%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ include file='/jcore/media/mediaTemplateInit.jspf' %><%

if (data == null || !(data instanceof ListeDeContenus)) {
  return;
}
ListeDeContenus content = (ListeDeContenus) data;

%>
<%ServletUtil.backupAttribute(pageContext , PortalManager.PORTAL_PUBLICATION);%>
<jalios:include pub="<%= content %>" usage="full"/>
<%ServletUtil.restoreAttribute(pageContext , PortalManager.PORTAL_PUBLICATION);%>