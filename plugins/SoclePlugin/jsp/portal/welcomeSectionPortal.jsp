<%@ include file='/jcore/doInitPage.jspf' %><%@ include file='/jcore/portal/doPortletParams.jspf'  %><% 
  PortalJspCollection box = (PortalJspCollection) portlet;
  ServletUtil.backupAttribute(pageContext , "ShowChildPortalElement");
  
  //Marche pas...
  request.setAttribute("publicationActionsSticky", false);
%>
<%@ include file='/types/AbstractCollection/doIncludePortletCollection.jspf'%>
<%
  ServletUtil.restoreAttribute(pageContext , "ShowChildPortalElement");
  
  // Drag and Drop required a custom class wrapper 'dnd-container' and the wrapper ID. They also REQUIRED a DOM ID
  String dndCSS = (isLogged && loggedMember.canWorkOn(box)) ? "ID_"+box.getId()+" dnd-container" : "";
  
  // Retrieve Portlet's buffer for PortletSelection
  String selection = getPortlet(bufferMap,"selection");
%>
<%= getPortlet(bufferMap,"header") %>
<%= getPortlet(bufferMap,"selection") %>

<footer role="contentinfo">
    <section class="ds44-container-fluid">
        <%= getPortlet(bufferMap,"footer") %>
    </section>
</footer>