<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<%@ include file='/jcore/doInitPage.jspf'%>
<%@ page import="com.jalios.jcms.taglib.card.*"%>
<%@ include file='/jcore/media/mediaTemplateInit.jspf'%>
<%
	if (data == null) {
		return;
	}

	Carousel obj = (Carousel) data;

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