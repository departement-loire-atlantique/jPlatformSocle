<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ include file='/jcore/portal/doPortletParams.jspf' %><%
%><%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%><%
%><% PortletMiseEnAvantDeContenus box = (PortletMiseEnAvantDeContenus)portlet; %><%
List<Content> allContents = new ArrayList<>();
if (Util.notEmpty(box.getFirstPublications())) {
    allContents.addAll(Arrays.asList(box.getFirstPublications()));
}
%>

<%@ include file="/types/PortletQueryForeach/doQuery.jspf" %>
<%@ include file="/types/PortletQueryForeach/doSort.jspf" %>

<%
if (Util.notEmpty(collection)) {
    allContents.addAll(collection);
}

%>

<section class="ds44-container-fluid ds44-theme ds44-bgCircle ds44-bg-br ds44--xxl-padding-tb">
    <header class="txtcenter ds44--xl-padding-b ds44-container-large">
      <h2 class="h2-like ds44-theme" id="titreMEA<%= box.getId() %>"><%= box.getTitreVisuel(userLang) %></h2>
    </header>

    <div class="ds44-mobile-extra-smt">
	    <div class="mod--hidden ds44-list swipper-carousel-wrap ds44-posRel ds44-container-large" data-nb-visible-slides="5" data-mobile-only="true">
		    <div class="swiper-container">
		        <ul class="swiper-wrapper ds44-list grid-5-small-1 has-gutter-l ds44-carousel-swiper">
		            <jalios:foreach name="itContent" type="Content" collection="<%= allContents %>" max="<%= box.getMaxResults() %>">
		                <li class="swiper-slide">
                            <jalios:media data="<%=itContent %>" template="tuileVerticaleLight"/>
		                </li>
		            </jalios:foreach>
		          
		        </ul>
		    </div>
		    <button class="swiper-button-prev swiper-button-disabled" type="button">
		        <i class="icon icon-left" aria-hidden="true"></i>
		        <span class="visually-hidden"></span>
		    </button>
		    <button class="swiper-button-next swiper-button-disabled" type="button">
		        <i class="icon icon-right" aria-hidden="true"></i>
		        <span class="visually-hidden"></span>
		    </button>
	    </div>
    </div>

    <div class="txtcenter ds44-container-large ">
        <button class="ds44-btnStd ds44-btnStd--large ds44-btnFullMobile" type="button" data-target="#overlay-sites-applis" data-js="ds44-modal"><span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.toussitesapplis") %></span><i class="icon icon-long-arrow-right" aria-hidden="true"></i></button>
    </div>

</section>