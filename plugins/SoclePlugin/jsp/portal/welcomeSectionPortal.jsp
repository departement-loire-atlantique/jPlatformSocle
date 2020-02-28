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
    <%= getPortlet(bufferMap,"footer") %>
    <%= getPortlet(bufferMap,"footerNavigation") %>
    <p class="ds44-posAbs ds44-posTop ds44-posRi ds44-hide-mobile">
        <a class="ds44-icoLink ds44-icoLink--footer" href="#top"><i class="icon icon-arrow-up icon--sizeXL" aria-hidden="true"></i><span class="ds44-icoTxtWrapper"><%= glp("jcmsplugin.socle.hautDepage")%></span></a>
    </p>
</footer>