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
	
	obj.setTemplate("query.simple");
%>
<%ServletUtil.backupAttribute(pageContext , PortalManager.PORTAL_PUBLICATION);%>
<jalios:include pub="<%= obj %>" usage="query"/>
<%ServletUtil.restoreAttribute(pageContext , PortalManager.PORTAL_PUBLICATION);%>