<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file='/jcore/doInitPage.jsp'%>
<%@ include file='/jcore/portal/doPortletParams.jsp' %>

<section class="ds44-container-large ds44--xl-padding-tb">


	<div class="grid-12-small-1 has-gutter-l">
		<div class="col-3-small-1">
			<ul
				class="ds44-mb3 ds44-list ds44-mobile-reduced-mt ds44-mobile-reduced-pt">
				<li class="ds44-inlineBlock"><img
					src="<%= channel.getProperty("jcmsplugin.socle.site.src.logofooter") %>"
					alt="Loire Atlantique"
					class="mbm ds44-logo ds44-valignTop ds44-inblLinks" /></li>
				<li class="ds44-inlineBlock"><img
					src="//design.loire-atlantique.fr/assets/images/logos/footer/Caisse_d_allocations_familiales_france_logo.png"
					alt="Caisse l'allocations familiales de France"
					class="ds44-logo--label ds44-valignTop ds44-inblLinks" /></li>
			</ul>
		</div>
		<div class="col-6-small-1">
		    <% request.setAttribute("center", true); %>
			<%@ include file='/plugins/SoclePlugin/jsp/portal/socialNetworksFooter.jspf' %>
			<% request.removeAttribute("center"); %>
		</div>
	</div>

</section>