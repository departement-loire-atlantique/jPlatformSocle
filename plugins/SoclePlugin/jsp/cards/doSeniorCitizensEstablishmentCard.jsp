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

SeniorCitizensEstablishment pub = (SeniorCitizensEstablishment) data;

String uid = ServletUtil.generateUniqueDOMId(request, "uid");
%>

<section class='ds44-card ds44-js-card ds44-card--contact ds44-box ds44-bgGray'>
    
    <div class="ds44-card__section">
	    <div class="ds44-innerBoxContainer">
		    <p role="heading" aria-level="2" class="h4-like ds44-cardTitle" id="tuileSeniorCitizenTitle_<%= uid %>">
		      <a href="<%= pub.getDisplayUrl(userLocale) %>" class="ds44-card__globalLink"><%= pub.getTitle() %></a>
		    </p>
		    <jalios:if predicate="<%= Util.notEmpty(pub.getDescription()) %>">
	            <hr class="mbs" aria-hidden="true">
	            <div class="ds44-mt-std"><strong><jalios:wysiwyg><%= pub.getDescription() %></jalios:wysiwyg></strong></div>
            </jalios:if>
		    <hr class="mbs" aria-hidden="true">
		    <p class="ds44-docListElem ds44-mt-std"><i class="icon icon-tag ds44-docListIco" aria-hidden="true"></i><%= SocleUtils.formatCategories(pub.getStructureType(loggedMember)) %></p>
		    <div class="ds44-docListElem ds44-mt-std"><i class="icon icon-marker ds44-docListIco" aria-hidden="true"></i>
            <%= SocleUtils.formatAddress(null, null, null, null, HtmlUtil.html2text(pub.getAddress()), null, pub.getPostalBox(), pub.getZipCode(), pub.getCommune().getTitle(), null) %>
			</div>
		    <jalios:if predicate="<%= Util.notEmpty(pub.getPhones()) %>">
			    <div class="ds44-docListElem ds44-mt-std"><i class="icon icon-phone ds44-docListIco" aria-hidden="true"></i>
		            <ul class="ds44-list">
		                <jalios:foreach name="itPhone" type="String" array="<%= pub.getPhones() %>">
		                    <li><ds:phone number="<%= itPhone %>"></ds:phone></li>
		                </jalios:foreach>
		            </ul>
	            </div>
            </jalios:if>
	    </div>
	    <i class="icon icon-arrow-right ds44-cardArrow" aria-hidden="true"></i>
    </div>
</section>