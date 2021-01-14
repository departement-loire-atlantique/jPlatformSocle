<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<%@ include file='/jcore/doInitPage.jspf' %>
<%@ page import="com.jalios.jcms.taglib.card.*" %>
<%@ include file='/jcore/media/mediaTemplateInit.jspf' %>
<%
if (data == null) {
  return;
}
CarouselElement pub = (CarouselElement) data;
%>

<ds:figurePicture pub="<%= pub %>" 
		image="<%= pub.getImage() %>" 
		format="principale" 
		legend="<%= pub.getImageLegend() %>" 
		copyright="<%= pub.getImageCopyright() %>"/>

