<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<%@ include file='/jcore/doInitPage.jspf'%>
<%@ page import="fr.cg44.plugin.socle.SocleUtils"%>
<% int tuileNb = 3; %>
<%@ include file="/plugins/SoclePlugin/jsp/include/mosaiqueCommons.jspf" %>

<jalios:foreach array="<%= elemCarousel2DArr %>" name="elemCarouselArr" type="CarouselElement[]">

	<ul class="grid-3-tiny-1 ds44-mosaique ds44-gutter ds44-list">
		<jalios:foreach array="<%= elemCarouselArr %>" name="elemCarousel" type="CarouselElement">

			<jalios:if predicate="<%= Util.notEmpty(elemCarousel) %>">
				<li>
					<ds:mosaiqueImage image="<%= elemCarousel %>" hasPopin="<%= carousel.getImageMosaiqueAvecPopin() %>"/>
				</li>
			</jalios:if>

		</jalios:foreach>
	</ul>

</jalios:foreach>

<jalios:if predicate="<%= carousel.getImageMosaiqueAvecPopin() %>">
	<%@ include file='/plugins/SoclePlugin/types/Carousel/mosaiqueOverlay.jspf'%>
</jalios:if>

