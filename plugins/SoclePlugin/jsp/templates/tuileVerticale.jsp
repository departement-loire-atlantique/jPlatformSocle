<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ include file='/jcore/doInitPage.jspf' %>
<%@ page import="com.jalios.jcms.taglib.card.*" %>
<%@ include file='/jcore/media/mediaTemplateInit.jspf' %>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%><%

  if (data == null) {
  return;
}

Publication pub = (Publication) data;

%>

<%@include file="tuileCommon.jsp" %>

<%
SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");

try {
    subTitle = sdf.format((Date) pub.getFieldValue("dateActu"));
} catch(Exception e) {}

try {
    location = (String) pub.getFieldValue("lieu");
} catch(Exception e) {}
%>

<section class="ds44-card ds44-js-card ds44-card--verticalPicture <%=styleContext%>">
	<ds:figurePicture pub="<%= pub %>" format="mobile" pictureCss="ds44-container-imgRatio" imgCss="ds44-imgRatio"></ds:figurePicture>
    <div class="ds44-card__section">
        <p role="heading" aria-level="3" class="ds44-card__title">
            <a class="ds44-card__globalLink" href="<%= urlPub %>" <%=titleAttr%> <%=targetAttr%>>
                <%= pub.getTitle() %>
            </a>
        </p>
        <jalios:if predicate="<%= isDoc %>">
            <p class="ds44-cardFile"><%= fileType %> - <%= fileSize %></p>
        </jalios:if>
        <jalios:if predicate="<%= Util.notEmpty(subTitle) %>">
            <p><%= subTitle %></p>
        </jalios:if>
        <jalios:if predicate="<%= Util.notEmpty(location) %>">
            <p class="ds44-cardLocalisation">
                <i class="icon icon-marker" aria-hidden="true"></i><span class="ds44-iconInnerText"><%= location %></span>
            </p>
        </jalios:if>        
        <i class="icon icon-arrow-right ds44-cardArrow" aria-hidden="true"></i>
    </div>
</section>