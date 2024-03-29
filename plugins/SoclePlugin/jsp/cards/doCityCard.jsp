<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ page import="com.jalios.jcms.taglib.card.*" %><%
%><%@ include file='/jcore/media/mediaTemplateInit.jspf' %><%
%><%

if (data == null) {
  return;
}

City pub = (City) data;

String uid = ServletUtil.generateUniqueDOMId(request, "uid");
boolean hasBottomInfos = Util.notEmpty(pub.getMayor()) || Util.notEmpty(pub.getCouncilBuildingAddress())
                         || Util.notEmpty(pub.getPostalBox()) || Util.notEmpty(pub.getZipCode());

%>
<section class="ds44-card ds44-js-card ds44-card--contact ds44-bgGray">
    <div class="ds44-card__section">
        <div class="ds44-innerBoxContainer">
            <p class="h4-like ds44-cardTitle" id="tuileCommune_<%= uid %>">
                <a href="<%= pub.getDisplayUrl(userLocale) %>" class="ds44-card__globalLink"><%= pub.getTitle() %></a>
            </p>
            <jalios:if predicate="<%= hasBottomInfos %>">
	            <hr class="mbs" aria-hidden="true">
	            <jalios:if predicate="<%= Util.notEmpty(pub.getMayor()) %>">
	               <p class="ds44-docListElem ds44-mt-std"><i class="icon icon-user ds44-docListIco" aria-hidden="true"></i><strong><%= glp("jcmsplugin.socle.maire") %> :</strong> <%= pub.getMayor() %></p>
	            </jalios:if>
	            <jalios:if predicate="<%= Util.notEmpty(pub.getCouncilBuildingAddress()) %>">
		            <div class="ds44-docListElem ds44-mt-std"><i class="icon icon-marker ds44-docListIco" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.adresse") %> : </span>
		                <jalios:wysiwyg><%= SocleUtils.formatAdresseCommune(pub) %></jalios:wysiwyg>
		            </div>
	           </jalios:if>    
            </jalios:if>
        </div>
        <i class="icon icon-arrow-right ds44-cardArrow" aria-hidden="true"></i>
    </div>
</section>