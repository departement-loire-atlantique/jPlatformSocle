<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% AccueilAnnuaireAgenda obj = (AccueilAnnuaireAgenda)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%
%>

<main id="content" role="main">

    <jalios:include target="SOCLE_ALERTE"/>
    
    <section class="ds44-container-large">
	    <ds:titleBanner pub="<%= obj %>" imagePath="<%= obj.getImageBandeau() %>" mobileImagePath="<%= obj.getImageMobile() %>" title="<%= obj.getTitle() %>"
	        legend="<%= obj.getLegende() %>" copyright="<%= obj.getCopyright() %>" breadcrumb="true"></ds:titleBanner>
    </section>
        
    <section class="ds44-container-fluid ds44-mtb3 ds44--xl-padding-tb">
            <jalios:if predicate="<%= Util.notEmpty(obj.getIntroSelectionAgenda()) || Util.notEmpty(obj.getSoustitreSelectionAgenda()) %>">
                <header class="txtcenter ds44--mobile--m-padding-b">
                    <jalios:if predicate="<%= Util.notEmpty(obj.getSoustitreSelectionAgenda()) %>">
                        <h2 id="titreAccueilAgenda" class="h2-like center"><%= obj.getSoustitreSelectionAgenda() %></h2>
                    </jalios:if>
                    <jalios:if predicate="<%= Util.notEmpty(obj.getIntroSelectionAgenda()) %>">
	                    <div class="ds44-component-chapo ds44-centeredBlock">
	                        <jalios:wysiwyg><%= obj.getIntroSelectionAgenda() %></jalios:wysiwyg>
	                    </div>
                    </jalios:if>
                </header>
            </jalios:if>
			
			<jalios:if predicate="<%= Util.notEmpty(obj.getPortletRecherche()) %>">
                <div class="ds44-loader-text visually-hidden" tabindex="-1" aria-live="polite"></div>
	            <div class="ds44-loader hidden">
	                <div class="ds44-loader-body">
	                    <svg class="ds44-loader-circular" focusable="false" aria-hidden="true">
	                        <circle class="ds44-loader-path" cx="30" cy="30" r="20" fill="none" stroke-width="5" stroke-miterlimit="10"></circle>
	                    </svg>
	                </div>
	            </div>
                <jalios:include pub="<%= obj.getPortletRecherche() %>"/>
            </jalios:if>
			
    </section>
    
    <ds:carrousel promotedPubArray="<%= obj.getAlaUneAgenda() %>" carrouselPortlet="<%= obj.getCarrouselAgenda() %>"/>
    
    <jalios:if predicate="<%= Util.notEmpty(obj.getPortletsBas()) %>">
        <jalios:foreach name="itPortletBas" type="PortalElement" array="<%= obj.getPortletsBas() %>">
            <jalios:include pub="<%= itPortletBas %>"/>
        </jalios:foreach>    
    </jalios:if>
</main>