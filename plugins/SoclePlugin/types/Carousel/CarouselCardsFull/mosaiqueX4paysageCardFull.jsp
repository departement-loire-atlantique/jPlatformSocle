<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<%@ include file='/jcore/doInitPage.jspf'%>
<%@ page import="fr.cg44.plugin.socle.SocleUtils"%>
<%
	Carousel obj = (Carousel) request.getAttribute(PortalManager.PORTAL_PUBLICATION);

	if (Util.isEmpty(obj.getElements1())) {
		return;
	}
	
	SimpleDateFormat sdfTuiles = new SimpleDateFormat("yyyy/MM");
	
	CarouselElement[][] elemCarousel2DArr = SocleUtils.initCarouselElement2DArr(obj.getElements1(), 2);
%>

<jalios:foreach array="<%= elemCarousel2DArr %>" name="elemCarouselArr" type="CarouselElement[]">

	<ul class="grid-2-tiny-1 ds44-mosaique ds44-gutter ds44-list">
		<jalios:foreach array="<%= elemCarouselArr %>" name="elemCarousel" type="CarouselElement">

			<jalios:if predicate="<%= Util.notEmpty(elemCarousel) %>">
				<li>
					<figure class="ds44-legendeContainer ds44-container-imgRatio ds44-container-imgZoom " data-target="#overlay-mosaique" data-js="ds44-modal">
						<img src="<%= SocleUtils.getUrlImageElementCarousel(elemCarousel, userLang, jcmsContext) %>" alt="" class="ds44-imgRatio">
						<figcaption class="ds44-imgCaption">
							<%= glp("jcmsplugin.socle.diaporama.titre", sdfTuiles.format(elemCarousel.getPdate()), elemCarousel.getTitle(userLang, false)) %>
							<br /><%= glp("jcmsplugin.socle.symbol.copyright") %> <%=elemCarousel.getImageLegend(userLang, false) %>
						</figcaption>
					</figure>

				</li>
			</jalios:if>

		</jalios:foreach>
	</ul>

</jalios:foreach>

