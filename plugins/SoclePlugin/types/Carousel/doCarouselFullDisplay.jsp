<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<%@ include file='/jcore/doInitPage.jspf'%>
<%@ page import="fr.cg44.plugin.socle.SocleUtils"%>
<%
	Carousel obj = (Carousel) request.getAttribute(PortalManager.PORTAL_PUBLICATION);

	if (Util.isEmpty(obj.getElements1())) {
		return;
	}
%>

<jalios:if predicate="<%=Util.isEmpty(obj.getAffichageMosaique())%>">
	<%@ include file='/plugins/SoclePlugin/types/Carousel/CarouselCardsFull/CarouselCardFull.jspf'%>
</jalios:if>
<jalios:if predicate="<%=Util.notEmpty(obj.getAffichageMosaique())%>">
	<jsp:include page='<%="/plugins/SoclePlugin/types/Carousel/CarouselCardsFull/mosaique" + obj.getAffichageMosaique() + "CardFull.jsp"%>' />

	<section class="ds44-modal-container" id="overlay-mosaique" aria-hidden="true" role="dialog" aria-modal="true" aria-labelledby="overlay-title">
		<div class="ds44-modal-box">
			<h1 id="overlay-title" class="h2-like visually-hidden" aria-hidden="true"><%= glp("jcmsplugin.socle.mozaique.popin.title") %></h1>
			<button class="ds44-btnOverlay--modale ds44-btnOverlay--closeOverlay" type="button" 
					title='<%= glp("jcmsplugin.socle.ficheaide.fermerboitedialogue.label", glp("jcmsplugin.socle.mozaique.popin.title")) %>'
					data-js="ds44-modal-action-close">
				<i class="icon icon-cross icon--xlarge" aria-hidden="true"></i><span class="ds44-btnInnerText--bottom"><%= glp("jcmsplugin.socle.fermer") %></span>
			</button>
			<div class="ds44-modal-gab ds44-mt3 txtcenter">
				<figure class="ds44-legendeContainer ds44-container-imgRatio center">
					<img src="" alt="" class="ds44-imgRatio">
					<figcaption class="ds44-imgCaption" aria-describedby=""></figcaption>
				</figure>
			</div>
		</div>
	</section>
</jalios:if>