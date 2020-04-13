<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% Carousel obj = (Carousel)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%
%><%@ include file='/front/doFullDisplay.jspf' %>

<div class="mod--hidden ds44-list swipper-carousel-wrap swipper-carousel-wrap--homepage ds44-posRel swipper-carousel-slideshow" data-nb-visible-slides="1">

    <jalios:if predicate='<%= Util.notEmpty(obj.getTitre()) %>'>
	    <p role="heading" aria-level="1" class="h1-like ds44-text--colorInvert">
	        <%= obj.getTitre(userLang) %>
            <jalios:if predicate='<%= Util.notEmpty(obj.getSoustitre()) %>'>
                <br><span class="ds44-ssTitreH1_home"><%= obj.getSoustitre(userLang) %></span>
            </jalios:if>	        
	    </p>
    </jalios:if>
    
    <button class="ds44-btnIco ds44-btnIco--carre ds44-bgDark" type="button">
        <i class="icon icon-play" aria-hidden="true"></i>
        <span class="visually-hidden">Lancer l'animation</span>
    </button>
    
    <div class="swiper-container ds44-titleContainer ds44-titleContainer--home swiper-container-fade swiper-container-horizontal">
        <ul class="swiper-wrapper ds44-list grid-3-small-1 has-gutter-l ds44-carousel-swiper">
            <jalios:foreach name="itTuile" type="CarouselElement" array="<%= obj.getElements1() %>">
	            <li class="swiper-slide">
	                <div class="ds44-titleContainer ds44-titleContainer--home">
	                    <div class="ds44-alphaGradient ds44-alphaGradient--header"></div>
	                    <ds:figurePicture imgCss="ds44-headerImg" pictureCss="ds44-pageHeaderContainer__pictureContainer"
	                           figureCss="ds44-pageHeaderContainer__pictureContainer" format="carouselFull"
	                           pub="<%= itTuile %>" imageMobile="<%= itTuile.getImageMobile() %>" alt="<%= itTuile.getTitle() %>" 
	                           copyright="<%= itTuile.getImageCopyright() %>" legend="<%= itTuile.getImageLegend() %>" ariaLabel="<%= itTuile.getTitle() %>"/>
	                </div>
	            </li>
            </jalios:foreach>
        </ul>
    </div>
</div>
