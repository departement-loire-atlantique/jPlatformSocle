<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<%@ include file='/jcore/doInitPage.jspf'%>
<%@ page import="fr.cg44.plugin.socle.SocleUtils"%>
<%
	Carousel obj = (Carousel) request.getAttribute(PortalManager.PORTAL_PUBLICATION);

	if (Util.isEmpty(obj.getElements1())) {
		return;
	}
	
	CarouselElement[][] elemCarousel2DArr = SocleUtils.initCarouselElement2DArr(obj.getElements1(), 2);
%>

<jalios:foreach array="<%= elemCarousel2DArr %>" name="elemCarouselArr" type="CarouselElement[]">

	<ul class="grid-2-tiny-1 ds44-mosaique ds44-gutter ds44-list">
		<jalios:foreach array="<%= elemCarouselArr %>" name="elemCarousel" type="CarouselElement">

			<jalios:if predicate="<%= Util.notEmpty(elemCarousel) %>">
				<li>
					<ds:mozaiqueImage image="<%= elemCarousel %>" style="ds44-container-imgRatio--A4"/>
				</li>
			</jalios:if>

		</jalios:foreach>
	</ul>

</jalios:foreach>

