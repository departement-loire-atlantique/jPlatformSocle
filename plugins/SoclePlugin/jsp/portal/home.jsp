<%@ include file='/jcore/doInitPage.jspf' %><%@ include file='/jcore/portal/doPortletParams.jspf'  %><% 
  PortalJspCollection box = (PortalJspCollection) portlet;
  ServletUtil.backupAttribute(pageContext , "ShowChildPortalElement");
  
  jcmsContext.setPageTitle(glp("jcmsplugin.socle.title.accueil"));
  
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

<main role="main" id="content" tabindex="-1">

<jalios:include target="SOCLE_ALERTE"/>
    
<%= getPortlet(bufferMap,"selection") %>
<%= getPortlet(bufferMap,"section") %>
        
</main>



<footer role="contentinfo">
    <%= getPortlet(bufferMap,"footer") %>
    <%= getPortlet(bufferMap,"footerNavigation") %>
    <p id="backToTop" class="ds44-posRi ds44-hide-mobile ds44-btn-fixed ds44-js-button-sticky" data-is-delayed="true">
        <a class="ds44-icoLink ds44-icoLink--footer" href="#top"><i class="icon icon-arrow-up icon--sizeXL" aria-hidden="true"></i><span class="ds44-icoTxtWrapper"><%= glp("jcmsplugin.socle.hautDepage")%></span></a>
    </p>
</footer>
<%= getPortlet(bufferMap,"popin") %>