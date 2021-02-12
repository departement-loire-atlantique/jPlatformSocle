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
</jalios:if>