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
	
	CarouselElement[][] elemCarousel2DArr = SocleUtils.initCarouselElement2DArr(obj.getElements1(), 4);
%>

<jalios:foreach array="<%= elemCarousel2DArr %>" name="elemCarouselArr" type="CarouselElement[]">

	<ul class="grid-2-tiny-1 ds44-mosaique ds44-gutter ds44-list">
		<jalios:foreach array="<%= elemCarouselArr %>" name="elemCarousel" type="CarouselElement" max="2">

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

	<jalios:if predicate="<%= Util.notEmpty(elemCarouselArr[2]) || Util.notEmpty(elemCarouselArr[3]) %>">
		<ul class="grid-3-tiny-1 ds44-mosaique ds44-gutter ds44-list">
	
			<jalios:if predicate="<%= Util.notEmpty(elemCarouselArr[2]) %>">
				<li class="col-2">
					<figure class="ds44-legendeContainer ds44-container-imgRatio ds44-container-imgZoom " data-target="#overlay-mosaique" data-js="ds44-modal">
						<img src="<%= SocleUtils.getUrlImageElementCarousel(elemCarouselArr[2], userLang, jcmsContext) %>" alt="" class="ds44-imgRatio">
						<figcaption class="ds44-imgCaption">
							<%= glp("jcmsplugin.socle.diaporama.titre", sdfTuiles.format(elemCarouselArr[2].getPdate()), elemCarouselArr[2].getTitle(userLang, false)) %>
							<br /><%= glp("jcmsplugin.socle.symbol.copyright") %> <%=elemCarouselArr[2].getImageLegend(userLang, false) %>
						</figcaption>
					</figure>
	
				</li>
			</jalios:if>
	
			<jalios:if predicate="<%= Util.notEmpty(elemCarouselArr[3]) %>">
				<li>
					<figure class="ds44-legendeContainer ds44-container-imgRatio ds44-container-imgZoom ds44-container-imgRatio--A4" data-target="#overlay-mosaique" data-js="ds44-modal">
						<img src="<%= SocleUtils.getUrlImageElementCarousel(elemCarouselArr[3], userLang, jcmsContext) %>" alt="" class="ds44-imgRatio">
						<figcaption class="ds44-imgCaption">
							<%= glp("jcmsplugin.socle.diaporama.titre", sdfTuiles.format(elemCarouselArr[3].getPdate()), elemCarouselArr[3].getTitle(userLang, false)) %>
							<br /><%= glp("jcmsplugin.socle.symbol.copyright") %> <%=elemCarouselArr[3].getImageLegend(userLang, false) %>
						</figcaption>
					</figure>
	
				</li>
			</jalios:if>
		</ul>
	</jalios:if>

</jalios:foreach>

