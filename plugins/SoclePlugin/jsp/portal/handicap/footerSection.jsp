<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file='/jcore/doInitPage.jsp'%>
<%@ include file='/jcore/portal/doPortletParams.jsp' %>

<section class="ds44-container-large ds44--xl-padding-tb">
	<div class="grid-12-small-1 has-gutter-l">
	    <div class="col-2-small-1">
	        <div class="ds44-logo ds44-mb3 ds44-mobile-reduced-mt ds44-mobile-reduced-pt">
	           <img src="//design.loire-atlantique.fr/assets/images/logos/logo-mdph-2023.svg" alt="la MDPH - Maison départementale des personnes handicapées de Loire Atlantique">
	           <img src='<%= channel.getProperty("jcmsplugin.socle.site.src.logofooter") %>' alt="Loire Atlantique" class="mbm">
	        </div>
	    </div>
	    <div class="col-5-small-1 ds44-mb3">
            <jalios:include id='<%= channel.getProperty("jcmsplugin.socle.footer.portletcontact.id") %>'/>
	    </div>

        <%--
	    <div class="col-4-small-1 ds44-mb3">
            <%@ include file='../abonnementNewsletterFooter.jspf' %>
	    </div>
        --%>
    </div>
</section>

