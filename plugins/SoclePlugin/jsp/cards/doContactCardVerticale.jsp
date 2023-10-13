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

<%@include file="/plugins/SoclePlugin/jsp/templates/tuileCommon.jsp" %>

<%
SimpleDateFormat sdf = new SimpleDateFormat(glp("date-format"));

try {
    subTitle = sdf.format((Date) pub.getFieldValue("dateActu"));
} catch(Exception e) {}

try {
    location = (String) pub.getFieldValue("lieu");
} catch(Exception e) {}

String imageAlt = "-1"; // dans figurePicture, si la valeur de "alt" est à -1 on force le champ alt vide sauf si Lien (autrement, il ira chercher un alt dans le contenu)

String formatTuile = isLargeTuile ? "principale" : "carrousel";

boolean isGpla = Util.notEmpty(request.getParameter("context")) && "gpla".equalsIgnoreCase(request.getParameter("context"));
Contact contact = (Contact) data;
String title = contact.getPrenom()+" "+contact.getNom();
%>

<section class='ds44-card ds44-cardIsPartner ds44-card--contact ds44-js-card ds44-card--verticalPicture  <%= isGpla ? "ds44-darkContext" : "" %> <%=styleContext%> <%= isInSixPanelsContext ? "ds44-posRel" : "" %>'>
	<ds:figurePicture pub="<%= pub %>" format="<%= formatTuile %>" image="<%= ((Contact)pub).getPhotoDidentite() %>" pictureCss='<%= isInSixPanelsContext ? "" : "ds44-container-imgRatio" %>' imgCss='<%= isInSixPanelsContext ? "" : "ds44-imgRatio" %>' alt="<%= imageAlt %>"></ds:figurePicture>
    <div class="ds44-card__section">
        <div class="ds44-innerBoxContainer">
	      <p class="ds44-cardTitle h4-like" role="heading">
	          <a class="ds44-card__globalLink" href="<%= urlPub %>" <%=titleAttr%> <%=targetAttr%>>
	              <%= title %>
	          </a>
	      </p>
	      <jalios:if predicate="<%= Util.notEmpty(contact.getFonction()) %>">
	        <p class="ds44-docListElem ds44-mt-std">
	            <%= contact.getFonction() %>
	        </p>
	      </jalios:if>
	      <i class="icon icon-arrow-right ds44-cardArrow" aria-hidden="true"></i>
	    </div>
    </div>
</section>