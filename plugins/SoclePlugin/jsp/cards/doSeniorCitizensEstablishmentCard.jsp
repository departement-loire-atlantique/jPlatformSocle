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

%>

<section class="ds44-card ds44-js-card ds44-card--contact ds44-box ds44-bgGray">
    
    <div class="ds44-card__section">
      
      <div class="ds44-innerBoxContainer">
          <h4 class="h4-like ds44-cardTitle" id="1"><a href="<%= pub.getDisplayUrl(userLocale) %>" class="ds44-card__globalLink"><%= pub.getTitle() %></a></h4>
          <hr class="mbs" aria-hidden="true">
          <p class="ds44-docListElem ds44-mt-std">
            <i class="icon icon-tag ds44-docListIco" aria-hidden="true"></i>
            <%= SocleUtils.formatCategories(pub.getStructureType(loggedMember)) %>
          </p>
		  <div class="ds44-docListElem ds44-mt-std">
			<i class="icon icon-marker ds44-docListIco" aria-hidden="true"></i>
			<%= pub.getAddress() %>
		  </div>
		  <jalios:if predicate="<%= Util.notEmpty(pub.getPhones) %>">
		  <p class="ds44-docListElem ds44-mt-std">
			<i class="icon icon-phone ds44-docListIco" aria-hidden="true"></i>
			<jalios:foreach name="itPhone" type="String" array="<%= pub.getPhones() %>">
                <ds:phone number="<%= itPhone %>"></ds:phone>
            </jalios:foreach>
		  </p>
		  </jalios:if>
      </div>
      <i class="icon icon-arrow-right ds44-cardArrow" aria-hidden="true"></i>
    </div>
</section>