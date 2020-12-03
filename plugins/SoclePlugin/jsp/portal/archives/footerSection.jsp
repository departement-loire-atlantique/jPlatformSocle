<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file='/jcore/doInitPage.jsp'%>
<%@ include file='/jcore/portal/doPortletParams.jsp' %>

<section class="ds44-container-large ds44--xl-padding-tb">
	<div class="grid-12-small-1 has-gutter-l">
	    <div class="col-2-small-1">
	        <picture class="ds44-logo ds44-mb3 ds44-mobile-reduced-mt ds44-mobile-reduced-pt">
	            <img src="//design.loire-atlantique.fr/assets/images/logo-loire-atlantique.svg" alt="Loire Atlantique" class="mbm">
	        </picture>
	    </div>
	    <div class="col-4-small-1 ds44-mb3">
            <jalios:include id='<%= channel.getProperty("jcmsplugin.socle.footer.portletcontact.id") %>'/>
	    </div>
	    <div class="col-3-small-1">
	        <%-- Inclusion de la portlet réseaux sociaux --%>
	        <%@ include file='../socialNetworksFooter.jspf' %>
	    </div>
	    <%-- <div class="col-3-small-1 ds44-mb3">
            Inclusion de la portlet JSP de Newsletter
            <%@ include file='../abonnementNewsletterFooter.jspf' %>
	    </div> --%>
    </div>
</section>

