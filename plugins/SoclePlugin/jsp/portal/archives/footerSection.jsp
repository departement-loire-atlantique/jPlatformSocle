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
	    
	    <div class="col-3-small-1 ds44-mb3">
            <%-- Inclusion de la portlet JSP de Newsletter --%>
            <jalios:select>
             
	             <% Publication newsletterPub = channel.getPublication(channel.getProperty("jcmsplugin.socle.footer.newsletter.publication"));  %>
	             
	             <jalios:if predicate='<%= Util.notEmpty(newsletterPub) %>'>                
	                <h2 class="h4-like" id="idTitreFooterSection"><%=glp("jcmsplugin.socle.newsletter.abonnement.titre")%></h2>
					<p class="ds44-mb-std ds44-mobile-reduced-mb"><%=glp("jcmsplugin.socle.newsletter.abonnement.chapo")%></p>
					<p>
					    <a href="<%= newsletterPub.getDisplayUrl(userLocale) %>" class="ds44-btnStd ds44-mobile-extra-mb" type="button"
					        title="<%=glp("jcmsplugin.socle.newsletter.abonnement.titleBouton")%>">
					        <span class="ds44-btnInnerText"><%=glp("jcmsplugin.socle.newsletter.abonnement.labelBouton")%></span><i
					            class="icon icon-long-arrow-right" aria-hidden="true"></i>
					    </a>
					</p>               
	             </jalios:if>
	            
	             <jalios:if predicate='<%= channel.isMailEnabled() && Util.notEmpty(channel.getCategory("$jcmsplugin.socle.footer.newsletter.parutions.cat")) &&
	                Util.notEmpty(channel.getCategory("$jcmsplugin.socle.footer.newsletter.thematiques.cat")) &&
	                Util.notEmpty(channel.getProperty("jcmsplugin.socle.mailjet.apiKey")) &&
	                Util.notEmpty(channel.getProperty("jcmsplugin.socle.mailjet.apiSecretKey")) &&
	                Util.notEmpty(channel.getProperty("jcmsplugin.socle.mailjet.contactList")) &&
	                Util.notEmpty(channel.getProperty("jcmsplugin.socle.newsletter.encrypt.key")) &&
	                Util.notEmpty(channel.getProperty("jcmsplugin.socle.form.newsletter.mailTo"))
	                %>'>
	                <%@ include file='abonnementNewsletterArchivesFooter.jspf' %>
	            </jalios:if>
            
            </jalios:select>
            
        </div>
	    
	    <div class="col-3-small-1">
	        <%-- Inclusion de la portlet réseaux sociaux --%>
	        <%@ include file='../socialNetworksFooter.jspf' %>
	        <jalios:include id='<%= channel.getProperty("jcmsplugin.socle.footer.portletbottomright.id") %>'/>
	    </div>
	    
    </div>
</section>

