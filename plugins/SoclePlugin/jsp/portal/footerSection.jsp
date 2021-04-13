<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file='/jcore/doInitPage.jsp'%>
<%@ include file='/jcore/portal/doPortletParams.jsp' %>

<section class="ds44-container-large ds44--xl-padding-tb">
	<div class="grid-12-small-1 ds44-hasGutter-xxl">
	    <div class="col-2-small-1">
			<picture class="ds44-logo ds44-mb3 ds44-mobile-reduced-mt ds44-mobile-reduced-pt">
			    <img src="//design.loire-atlantique.fr/assets/images/logo-loire-atlantique.svg" alt="Loire-Atlantique" />
			</picture>
	    </div>
	    <div class="col-5-small-1">	    
	        <%-- Inclusion de la portlet JSP de Newsletter --%>
	        <jalios:if predicate='<%= Util.notEmpty(channel.getCategory("$jcmsplugin.socle.footer.newsletter.parutions.cat")) &&
	            Util.notEmpty(channel.getCategory("$jcmsplugin.socle.footer.newsletter.thematiques.cat")) &&
	            Util.notEmpty(channel.getProperty("jcmsplugin.socle.mailjet.apiKey")) &&
	            Util.notEmpty(channel.getProperty("jcmsplugin.socle.mailjet.apiSecretKey")) &&
	            Util.notEmpty(channel.getProperty("jcmsplugin.socle.mailjet.contactList")) &&
	            Util.notEmpty(channel.getProperty("jcmsplugin.socle.newsletter.encrypt.key"))
	            %>'>
	           <%@ include file='abonnementNewsletterFooter.jspf' %>	 
	        </jalios:if>       	        
	    </div>
	    <div class="col-5-small-1">
	        <%-- Inclusion de la portlet réseaux sociaux --%>
	        <%@ include file='socialNetworksFooter.jspf' %>
	    </div>
	</div>
</section>
