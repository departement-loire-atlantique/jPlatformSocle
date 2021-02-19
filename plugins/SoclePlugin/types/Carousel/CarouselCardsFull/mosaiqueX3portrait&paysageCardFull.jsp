<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<%@ include file='/jcore/doInitPage.jspf'%>
<%@ page import="fr.cg44.plugin.socle.SocleUtils"%>
<%
	Carousel obj = (Carousel) request.getAttribute(PortalManager.PORTAL_PUBLICATION);

	if (Util.isEmpty(obj.getElements1())) {
		return;
	}
	
	CarouselElement[][] elemCarousel2DArr = SocleUtils.initCarouselElement2DArr(obj.getElements1(), 3);
%>

<jalios:foreach array="<%= elemCarousel2DArr %>" name="elemCarouselArr" type="CarouselElement[]">

	<ul class="grid-2-tiny-1 ds44-mosaique ds44-gutter ds44-list">

		<jalios:if predicate="<%= Util.notEmpty(elemCarouselArr[0]) %>">
			<li class="row-2">
				<ds:mozaiqueImage image="<%= elemCarouselArr[0] %>" style="ds44-container-imgRatio--A4"/>
			</li>
		</jalios:if>

		<jalios:foreach array="<%= elemCarouselArr %>" name="elemCarousel" type="CarouselElement" skip="1">

			<jalios:if predicate="<%= Util.notEmpty(elemCarousel) %>">
				<li>
					<ds:mozaiqueImage image="<%= elemCarousel %>"/>
				</li>
			</jalios:if>

		</jalios:foreach>
	</ul>

</jalios:foreach>

