<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<%@ include file='/jcore/doInitPage.jspf'%>
<%@ page import="fr.cg44.plugin.socle.SocleUtils"%>
<% int tuileNb = 2; %>
<%@ include file="/plugins/SoclePlugin/jsp/include/mosaiqueCommons.jspf" %>

<jalios:foreach array="<%= elemCarousel2DArr %>" name="elemCarouselArr" type="CarouselElement[]">

	<ul class="grid-3-tiny-1 ds44-mosaique ds44-gutter ds44-list">

		<jalios:if predicate="<%= Util.notEmpty(elemCarouselArr[0]) %>">
			<li class="col-2">
				<ds:mosaiqueImage image="<%= elemCarouselArr[0] %>" hasPopin="<%= carousel.getImageMosaiqueAvecPopin() %>"/>
			</li>
		</jalios:if>

		<jalios:if predicate="<%= Util.notEmpty(elemCarouselArr[1]) %>">
			<li>
				<ds:mosaiqueImage image="<%= elemCarouselArr[1] %>" style="ds44-container-imgRatio--A4" hasPopin="<%= carousel.getImageMosaiqueAvecPopin() %>"/>
			</li>
		</jalios:if>
	</ul>

</jalios:foreach>

<jalios:if predicate="<%= carousel.getImageMosaiqueAvecPopin() %>">
	<%@ include file='/plugins/SoclePlugin/types/Carousel/mosaiqueOverlay.jspf'%>
</jalios:if>


