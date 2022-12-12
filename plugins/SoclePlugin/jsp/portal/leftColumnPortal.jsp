<%@ include file='/jcore/doInitPage.jspf' %><%@ include file='/jcore/portal/doPortletParams.jspf'  %><% 
  PortalJspCollection box = (PortalJspCollection) portlet;
  ServletUtil.backupAttribute(pageContext , "ShowChildPortalElement");
  
%>
<%@ include file='/types/AbstractCollection/doIncludePortletCollection.jspf'%>
<%
  ServletUtil.restoreAttribute(pageContext , "ShowChildPortalElement");
  
  // Drag and Drop required a custom class wrapper 'dnd-container' and the wrapper ID. They also REQUIRED a DOM ID
  String dndCSS = (isLogged && loggedMember.canWorkOn(box)) ? "ID_"+box.getId()+" dnd-container" : "";
  
%>

<main role="main" id="content">

<%= getPortlet(bufferMap,"header") %>

<section class="ds44-container-large">
    <div class="ds44-mt3 ds44--xl-padding-t">
        <div class="ds44-inner-container">
            <div class="grid-12-medium-1 grid-12-small-1">

                <aside class="col-4 ds44-hide-tiny-to-medium">
                    <section class="ds44-box ds44-theme">
                        <%= getPortlet(bufferMap,"menu") %>
                    </section>
                </aside>
                
                <div class="col-1 grid-offset ds44-hide-tinyToLarge"></div>
                
                <article class="col-7">
                    <%= getPortlet(bufferMap,"selection") %>
                </article>
            </div>
        </div>
    </div>
</section>

</main>


<footer role="contentinfo">
    <%= getPortlet(bufferMap,"footer") %>
    <%= getPortlet(bufferMap,"footerNavigation") %>
    <p id="backToTop" class="ds44-posRi ds44-hide-mobile ds44-btn-fixed ds44-js-button-sticky" data-is-delayed="true">
        <a class="ds44-icoLink ds44-icoLink--footer" href="#top"><i class="icon icon-arrow-up icon--sizeXL" aria-hidden="true"></i><span class="ds44-icoTxtWrapper"><%= glp("jcmsplugin.socle.hautDepage")%></span></a>
    </p>
</footer>