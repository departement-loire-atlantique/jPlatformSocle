<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%><%
%><% Timeline obj = (Timeline)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%
%><%@ include file='/front/doFullDisplay.jspf' %>

<main role="main" id="content">

<jalios:include target="SOCLE_ALERTE"/>

	<section class="ds44-container-large">
	
	   <ds:titleBanner pub="<%= obj %>" imagePath="<%= obj.getVisuel() %>" title="<%= obj.getTitle(userLang) %>" breadcrumb="true"></ds:titleBanner>
	
	    <nav class="ds44-theme txtcenter ds44--xl-padding ds44-timeline_index ds44-mtb5" aria-label='<%= glp("jcmsplugin.socle.barrenavsecondaire") %>'>
	        <p class="inbl"><%= glp("jcmsplugin.socle.goto") %></p>
	        <ul class="ds44-list">
	            <%-- générer automatiquement sur la liste des éléments --%>
	            <jalios:if predicate="<%= Util.notEmpty(obj.getPremierElement()) %>">
	            <li><a href="#time_elem_<%= obj.getPremierElement().getId() %>"><%= obj.getPremierElement().getTitle(userLang) %></a></li>
	            </jalios:if>
	            <jalios:foreach array="<%= obj.getElementsTimelines() %>" name="itCounter" type="Lien" counter="counterTimeline">
	            <%
	            String titleLink = itCounter.getTitle();
	            if (counterTimeline-1 < obj.getLibelleElementsTimeline(userLang).length && Util.notEmpty(obj.getLibelleElementsTimeline(userLang)[counterTimeline-1])) {
	              titleLink = obj.getLibelleElementsTimeline(userLang)[counterTimeline-1];
	            }
	            %>
	            <li><a href="#time_elem_<%= itCounter.getId() %>"><%= titleLink %></a></li>
	            </jalios:foreach>
	        </ul>
	    </nav>
	
	    <div class="ds44-inner-container">
	
	        <div class="ds44-timeline_container">
	
	            <%-- Affichage des éléments --%>
	
	        </div>
	
	    </div>
	</section>

</main>