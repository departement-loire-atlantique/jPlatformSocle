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
request.setAttribute("itCarouselElement", pub);
%>
<%@ include file="/plugins/SoclePlugin/jsp/include/elementCarouselLinkCommons.jspf" %>
<%
request.removeAttribute("itCarouselElement");
%>
<ds:figurePicture pub="<%= pub %>" 
        image="<%= pub.getImage() %>" 
        format="principale" 
        alt="<%= pub.getImageLegend() %>" 
        legend="<%= pub.getImageLegend() %>" 
        copyright="<%= pub.getImageCopyright() %>"
        urlHref="<%= urlLien %>"
        urlTitle="<%= pub.getImageLegend() %>"
        urlIsExterne="<%= isExterne %>"/>

