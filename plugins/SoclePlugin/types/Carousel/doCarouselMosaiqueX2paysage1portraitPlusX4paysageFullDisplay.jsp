<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<%@ include file='/jcore/doInitPage.jspf'%>
<%@ page import="fr.cg44.plugin.socle.SocleUtils"%>
<%
	Object obj = request.getAttribute(PortalManager.PORTAL_PUBLICATION);
	
	Carousel carousel;
	if(obj instanceof Carousel) {
		carousel = (Carousel) obj;
	} else {
		%><%@ page import="com.jalios.jcms.taglib.card.*"%>
		<%@ include file='/jcore/media/mediaTemplateInit.jspf'%><%
		carousel = (Carousel) data;
	}

	if (Util.isEmpty(carousel.getElements1())) {
		return;
	}
	
	CarouselElement[][] elemCarousel2DArr = SocleUtils.initCarouselElement2DArr(carousel.getElements1(), 6);
%>

<jalios:foreach array="<%= elemCarousel2DArr %>" name="elemCarouselArr" type="CarouselElement[]">

	<ul class="grid-3-tiny-1 ds44-mosaique ds44-gutter ds44-list">

		<li class="col-2">
			<ds:mosaiqueImage image="<%= elemCarouselArr[0] %>" hasPopin="<%= carousel.getImageMosaiqueAvecPopin() %>"/>
		</li>

		<jalios:if predicate="<%= Util.notEmpty(elemCarouselArr[1]) %>">
			<li>
				<ds:mosaiqueImage image="<%= elemCarouselArr[1] %>" style="ds44-container-imgRatio--A4" hasPopin="<%= carousel.getImageMosaiqueAvecPopin() %>"/>
			</li>
		</jalios:if>
	</ul>

	<jalios:if predicate="<%= Util.notEmpty(elemCarouselArr[3]) %>">
		<ul class="grid-2-tiny-1 ds44-mosaique ds44-gutter ds44-list">
			<jalios:foreach array="<%= elemCarouselArr %>" name="elemCarousel" type="CarouselElement" skip="2" max="2">

				<jalios:if predicate="<%= Util.notEmpty(elemCarousel) %>">
					<li>
						<ds:mosaiqueImage image="<%= elemCarousel %>" hasPopin="<%= carousel.getImageMosaiqueAvecPopin() %>"/>
					</li>
				</jalios:if>

			</jalios:foreach>
		</ul>
		<jalios:if predicate="<%= Util.notEmpty(elemCarouselArr[5]) %>">
			<ul class="grid-2-tiny-1 ds44-mosaique ds44-gutter ds44-list">
				<jalios:foreach array="<%= elemCarouselArr %>" name="elemCarousel" type="CarouselElement" skip="4" max="2">

					<jalios:if predicate="<%= Util.notEmpty(elemCarousel) %>">
						<li>
							<ds:mosaiqueImage image="<%= elemCarousel %>" hasPopin="<%= carousel.getImageMosaiqueAvecPopin() %>"/>
						</li>
					</jalios:if>

				</jalios:foreach>
			</ul>
		</jalios:if>
	</jalios:if>

</jalios:foreach>

<%@ include file='/plugins/SoclePlugin/types/Carousel/mosaiqueOverlay.jspf'%>


