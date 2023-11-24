<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ include file='/jcore/doInitPage.jspf' %>
<%@ page import="com.jalios.jcms.taglib.card.*" %>
<%@ include file='/jcore/media/mediaTemplateInit.jspf' %>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%><%

if (data == null) { return; }
Publication pub = (Publication) data;

%><%@include file="/plugins/SoclePlugin/jsp/templates/tuileCommon.jsp" %><%

FicheOperation fiche = (FicheOperation) data;
String imageAlt = "-1"; // dans figurePicture, si la valeur de "alt" est à -1 on force le champ alt vide sauf si Lien (autrement, il ira chercher un alt dans le contenu)
String formatTuile = isLargeTuile ? "principale" : "carrousel";
boolean isGpla = Util.notEmpty(request.getParameter("context")) && "gpla".equalsIgnoreCase(request.getParameter("context"));
%>

<section class='ds44-card ds44-cardIsPartner ds44-card--contact ds44-js-card ds44-card--verticalPicture <%= isGpla ? "ds44-darkContext" : "" %> <%=styleContext%> <%= isInSixPanelsContext ? "ds44-posRel" : "" %>'>
	<ds:figurePicture pub="<%= pub %>" format="<%= formatTuile %>" pictureCss='<%= isInSixPanelsContext ? "" : "ds44-container-imgRatio" %>' imgCss='<%= isInSixPanelsContext ? "" : "ds44-imgRatio" %>' alt="<%= imageAlt %>"></ds:figurePicture>
    <div class="ds44-card__section">
        <div class="ds44-innerBoxContainer">
	        <p class="ds44-cardTitle h4-like" role="heading">
	            <a class="ds44-card__globalLink" href="<%= urlPub %>" <%=titleAttr%> <%=targetAttr%>>
	                <%= fiche.getTitle(userLang) %>
	            </a>
	        </p>
	        <jalios:if predicate="<%= Util.notEmpty(fiche.getTypeDeChantier(loggedMember)) %>">
		        <p class="ds44-docListElem ds44-mt-std ">
		            <i class="icon icon-tag ds44-docListIco" aria-hidden="true"></i>
		            <%= SocleUtils.formatCategories(fiche.getTypeDeChantier(loggedMember)) %>
		        </p>
		    </jalios:if>
		    <jalios:if predicate="<%= Util.notEmpty(fiche.getAmenageur()) %>">
		        <p class="ds44-docListElem ds44-mt-std ">
		            <i class="icon icon-user ds44-docListIco" aria-hidden="true"></i>
		            <%= fiche.getAmenageur() %>
		        </p>
		    </jalios:if>  
	        <i class="icon icon-arrow-right ds44-cardArrow" aria-hidden="true"></i>
        </div>
    </div>
</section>