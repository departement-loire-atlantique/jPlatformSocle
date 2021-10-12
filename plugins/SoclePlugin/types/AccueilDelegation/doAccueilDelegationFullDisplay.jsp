<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% AccueilDelegation obj = (AccueilDelegation)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%
%><%@ include file='/front/doFullDisplay.jspf' %>

<main id="content" role="main">

    <jalios:include target="SOCLE_ALERTE"/>

    <ds:titleDelegation pub="<%= obj %>" copyright="<%= obj.getCopyright() %>" legend="<%= obj.getLegende() %>" imagePath="<%= obj.getImagePrincipale() %>" mobileImagePath="<%= obj.getImageMobile() %>" title="<%= obj.getTitle() %>" alt="<%= obj.getTexteAlternatif() %>" breadcrumb="true" delegation="<%= obj.getDelegation() %>" cartePath="<%= obj.getImageCarte() %>"/>
            
    <%-- Rechercher contact ou aide --%>
    <%-- TODO --%>
    <jalios:if predicate="<%= Util.notEmpty(obj.getTitreAnnuaire()) || Util.notEmpty(obj.getIntroAnnuaire()) %>">
    <section class="ds44-container-fluid ds44-mtb3 ds44--xl-padding-tb">
        <div class="ds44-container-large">
            <header class="txtcenter ds44--l-padding-b">
                <jalios:if predicate="<%= Util.notEmpty(obj.getTitreAnnuaire()) %>">
                    <h2 class="h2-like center"><%= obj.getTitreAnnuaire() %></h2>
                </jalios:if>
                <jalios:if predicate="<%= Util.notEmpty(obj.getIntroAnnuaire()) %>">
                    <p role="heading" aria-level="3" class="ds44-component-chapo ds44-centeredBlock"><jalios:wysiwyg><%= obj.getIntroAnnuaire() %></jalios:wysiwyg></p>
                </jalios:if>
                <jalios:if predicate="<%= Util.notEmpty(obj.getPortletRecherche()) %>">
                    <jalios:include pub="<%= obj.getPortletRecherche() %>"/>
                </jalios:if>
            </header>
        </div>
    </section>
    </jalios:if>
    
    
    <%-- En ce moment --%>
    <%
    PortletCarousel carouselEnCeMoment = new PortletCarousel();
    carouselEnCeMoment.setTitreDuBloc(obj.getTitreActus());
    carouselEnCeMoment.setSoustitreDuBloc(obj.getIntroActus());
    carouselEnCeMoment.setFirstPublications(obj.getCarrouselActualites());
    carouselEnCeMoment.setContenusEnAvant(obj.getAlaUne());
    carouselEnCeMoment.setTemplate("box.sliderQuatre");
    carouselEnCeMoment.setSelectionDuTheme("tuileVerticaleLight");
    carouselEnCeMoment.setPositionTitre("bl");
    %>
    <jalios:include pub="<%= carouselEnCeMoment %>"/>
    
    <%-- Agenda --%>
    <jalios:if predicate='<%= Util.notEmpty(obj.getTitreAgenda(userLang)) || Util.notEmpty(obj.getPortletRechercheAgenda()) || Util.notEmpty(obj.getPortletCarrouselAgenda()) %>'>
		<section class="ds44-container-fluid ds44--l-padding-t ds44-mt3">
            <jalios:if predicate='<%= Util.notEmpty(obj.getTitreAgenda(userLang)) %>'>
	           <div class="ds44-inner-container">
                    <header class="txtcenter">
                        <h2 class="h2-like center"><%= obj.getTitreAgenda(userLang) %></h2>
		                <jalios:if predicate='<%= Util.notEmpty(obj.getIntroAgenda(userLang)) %>'>
		                   <p role="heading" aria-level="3" class="ds44-component-chapo ds44-centeredBlock"><%= obj.getIntroAgenda(userLang) %></p>
		                </jalios:if>
                    </header>
    	        </div>
            </jalios:if>
	        <jalios:if predicate='<%= Util.notEmpty(obj.getPortletRechercheAgenda()) %>'>
	           <jalios:include pub="<%= obj.getPortletRechercheAgenda() %>"></jalios:include>
	        </jalios:if>
	        
            <jalios:if predicate='<%= Util.notEmpty(obj.getPortletCarrouselAgenda()) %>'>
               <jalios:include pub="<%= obj.getPortletCarrouselAgenda() %>" usage="box"/>
            </jalios:if>
	        
        </section>   
		        
    </jalios:if>
    
    
    <%-- Portlets bas --%>
    <jalios:if predicate="<%= Util.notEmpty(obj.getPortletsBas()) %>">
        <jalios:foreach name="itPortlet" array="<%= obj.getPortletsBas() %>" type="com.jalios.jcms.portlet.PortalElement">      
           <section class='ds44-container-fluid<%= itPortlet instanceof PortletPush ? " ds44--l-padding" : "" %>'>
               <jalios:include id="<%= itPortlet.getId() %>" />
            </section>
        </jalios:foreach>
    </jalios:if>

    <%-- Partagez cette page --%>
    <%@ include file="/plugins/SoclePlugin/jsp/portal/socialNetworksShare.jspf" %>
    
    <%-- Page utile --%>
    <jsp:include page="/plugins/SoclePlugin/types/PageUtileForm/editFormPageUtileForm.jsp"/>
        
</main>