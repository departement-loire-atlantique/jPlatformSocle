<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file='/jcore/doInitPage.jsp'%>
<%@ include file='/jcore/portal/doPortletParams.jsp' %>

<div class="ds44-inner-container">            
    <div class="grid-12-small-1 ds44-hasGutter-xxl">
        <div class="col-2-small-1">
            <a href="#">
                <picture class="ds44-logoFooter ds44-mb3">
                    <img src="//design.loire-atlantique.fr/assets/images/logo-loire-atlantique.svg" alt="Loire Atlantique" />
                </picture>
            </a>
        </div>
        <div class="col-5-small-1">
            <%-- Inclusion de la portlet JSP de Newsletter --%>
            <jalios:include id='<%=channel.getProperty("jcmsplugin.socle.site.footer.portlet.newsletter.id") %>'/>
        </div>
        <div class="col-5-small-1">
            <%-- Inclusion de la portlet réseaux sociaux --%>
            <jsp:include page="socialNetworksFooter.jsp"/> 
        </div>
    </div>
    <p class="ds44-posAbs ds44-posTop ds44-posRi">
        <a class="ds44-icoLink ds44-icoLink--footer" href="#top"><i class="icon icon-arrow-up icon--large"></i><span class="ds44-icoTxtWrapper">Haut de page</span></a>
    </p>
</div>
