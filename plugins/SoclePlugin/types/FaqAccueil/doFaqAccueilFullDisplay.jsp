<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<% 
	FaqAccueil obj = (FaqAccueil) request.getAttribute(PortalManager.PORTAL_PUBLICATION); 
%>

<section class="ds44--xxl-padding-b">
	<header class="txtcenter ds44--xxl-padding-b">
		<h2 class="h2-like center"><%= glp("jcmsplugin.socle.faq.vous-avez-question") %></h2>
	</header>
	
	<div class="ds44-inner-container ds44-flex-container ds44-flex-valign-center ds44-flex-align-center ds44--xl-padding-lr">
	   <%@ include file='doFaqAccueilFullDisplayContent.jsp' %>
    </div>

    
</section>
