<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<%@ include file='/jcore/doInitPage.jspf'%>
<%@ page import="com.jalios.jcms.taglib.card.*" %>
<%@ include file='/jcore/media/mediaTemplateInit.jspf' %>
<%
	if (data == null) {
	  return;
	}
	
	Carousel obj = (Carousel) data;
	
	if (Util.isEmpty(obj.getElements1())) {
	  return;
	}
	
	SimpleDateFormat sdfTuiles = new SimpleDateFormat("yyyy/MM");
%>

<jalios:if predicate="<%= Util.notEmpty(obj.getTitre()) %>">
    <p class="h4-like"><%= obj.getTitre() %></p>
</jalios:if>
<div class="swipper-carousel-wrap swipper-carousel-slideshow" data-nb-visible-slides="1">
   <div class="swiper-container">
      <button class="ds44-btnIco ds44-btnIco--carre ds44-bgDark" type="button">
      <i class="icon icon-pause" aria-hidden="true"></i>
      <span class="visually-hidden"><%= glp("jcmsplugin.socle.carrouselhome.stop") %></span>
      </button>
      <ul class="swiper-wrapper ds44-list grid-3-small-1 has-gutter-l ds44-carousel-swiper">
         <jalios:foreach name="itElement" type="CarouselElement" array="<%= obj.getElements1() %>">
             <%
             String urlImage = "";
             if (!jcmsContext.getBrowser().isSmallDevice()) {
               urlImage = itElement.getImage();
               
               if (Util.isEmpty(urlImage)) {
                 urlImage = itElement.getImageMobile();
               }
               
               urlImage = SocleUtils.getUrlOfFormattedImageDiaporamaDesktop(urlImage);
             } else {
               urlImage = itElement.getImageMobile();
                 
               if (Util.isEmpty(urlImage)) {
                 urlImage = itElement.getImage();
               }
                
               urlImage = SocleUtils.getUrlOfFormattedImageDiaporamaMobile(urlImage);
             }
             
             String titreTuile = glp("jcmsplugin.socle.diaporama.titre", sdfTuiles.format(itElement.getPdate()), itElement.getTitle());
             %>
	         <li class="swiper-slide">
	            <div class="ds44-diaporama-vignette">
	               <figure class="ds44-diaporama-vignette-container" role="figure" aria-label='<%= titreTuile %>'>
	                  <img class="ds44-diaporama-vignette-image" src="<%= urlImage %>" alt=<%= titreTuile %>' />
	                  <figcaption class="ds44-diaporama-vignette-text"><%= titreTuile %><br /><%= itElement.getImageLegend() %></figcaption>
	               </figure>
	            </div>
	         </li>
         </jalios:foreach>
      </ul>
      <button class="swiper-button-prev swiper-button-white swiper-button-disabled" type="button">
      <i class="icon icon-left" aria-hidden="true"></i>
      <span class="visually-hidden"></span>
      </button>
      <button class="swiper-button-next swiper-button-white swiper-button-disabled" type="button">
      <i class="icon icon-right" aria-hidden="true"></i>
      <span class="visually-hidden"></span>
      </button>
   </div>
   <div class="swiper-pagination"></div>
   <div class="swiper-thumbs">
      <div class="swiper-thumbs-container">
         <nav class="swiper-container">
            <ul class="swiper-wrapper ds44-list">
               <jalios:foreach name="itElement" type="CarouselElement" array="<%= obj.getElements1() %>">
                   <%
                   
                   String urlImage = itElement.getImageCarree();
                   
                   if (Util.isEmpty(urlImage)) {
                     urlImage = itElement.getImageMobile();
                   }
                   
                   if (Util.isEmpty(urlImage)) {
                     urlImage = itElement.getImage();
                   }
                   
                   urlImage = SocleUtils.getUrlOfFormattedImageDiaporamaVignette(urlImage);
                   
                   String titreTuile = glp("jcmsplugin.socle.diaporama.titre", sdfTuiles.format(itElement.getPdate()), itElement.getTitle());
                   %>
	               <li class="swiper-slide">
	                  <div class="ds44-diaporama-thumb" style="background-image: url('<%= urlImage %>');">
	                     <p class="visually-hidden"><%= titreTuile %><br /><%= itElement.getImageLegend() %></p>
	                  </div>
	               </li>
               </jalios:foreach>
            </ul>
         </nav>
      </div>
   </div>
</div>