<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<%@ include file='/jcore/doInitPage.jspf'%>
<%
    Carousel obj = (Carousel) request.getAttribute(PortalManager.PORTAL_PUBLICATION);
%>
<%@ page import="fr.cg44.plugin.socle.SocleUtils"%>

<p class="h4-like">Diaporama photos</p>
<div class="swipper-carousel-wrap swipper-carousel-slideshow" data-nb-visible-slides="1">
   <div class="swiper-container">
      <button class="ds44-btnIco ds44-btnIco--carre ds44-bgDark" type="button">
      <i class="icon icon-pause" aria-hidden="true"></i>
      <span class="visually-hidden">Arrêter l'animation</span>
      </button>
      <ul class="swiper-wrapper ds44-list grid-3-small-1 has-gutter-l ds44-carousel-swiper">
         <li class="swiper-slide">
            <div class="ds44-diaporama-vignette">
               <figure class="ds44-diaporama-vignette-container" role="figure" aria-label="2013/29 - Titre vignette 1 - Antoine Parra Del Pozo, 2013">
                  <img class="ds44-diaporama-vignette-image" src="../../assets/images/sample-img-9.jpg" alt="2013/29 - Titre vignette 1 - Antoine Parra Del Pozo, 2013" />
                  <figcaption class="ds44-diaporama-vignette-text">2013/29 - Titre vignette 1<br />Antoine Parra Del Pozo, 2013</figcaption>
               </figure>
            </div>
         </li>
         <li class="swiper-slide">
            <div class="ds44-diaporama-vignette">
               <figure class="ds44-diaporama-vignette-container" role="figure" aria-label="2013/29 - Tell Me, technique mixte sur papier - Antoine Parra Del Pozo, 2013">
                  <img class="ds44-diaporama-vignette-image" src="../../assets/images/sample-img-8.jpg" alt="2013/29 - Tell Me, technique mixte sur papier - Antoine Parra Del Pozo, 2013" />
                  <figcaption class="ds44-diaporama-vignette-text">2013/29 - Tell Me, technique mixte sur papier<br />Antoine Parra Del Pozo, 2013</figcaption>
               </figure>
            </div>
         </li>
         <li class="swiper-slide">
            <div class="ds44-diaporama-vignette">
               <figure class="ds44-diaporama-vignette-container" role="figure" aria-label="2013/29 - Titre vignette 3 - Antoine Parra Del Pozo, 2013">
                  <img class="ds44-diaporama-vignette-image" src="../../assets/images/img_article_bigger@2x.jpg" alt="2013/29 - Titre vignette 3 - Antoine Parra Del Pozo, 2013" />
                  <figcaption class="ds44-diaporama-vignette-text">2013/29 - Titre vignette 3<br />Antoine Parra Del Pozo, 2013</figcaption>
               </figure>
            </div>
         </li>
         <li class="swiper-slide">
            <div class="ds44-diaporama-vignette">
               <figure class="ds44-diaporama-vignette-container" role="figure" aria-label="2013/29 - Titre vignette 4 - Antoine Parra Del Pozo, 2013">
                  <img class="ds44-diaporama-vignette-image" src="../../assets/images/sample-img-4.jpg" alt="2013/29 - Titre vignette 4 - Antoine Parra Del Pozo, 2013" />
                  <figcaption class="ds44-diaporama-vignette-text">2013/29 - Titre vignette 4<br />Antoine Parra Del Pozo, 2013</figcaption>
               </figure>
            </div>
         </li>
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
               <li class="swiper-slide">
                  <div class="ds44-diaporama-thumb" style="background-image: url('../../assets/images/sample-img-9.jpg');">
                     <p class="visually-hidden">2013/29 - Titre vignette 1<br />Antoine Parra Del Pozo, 2013</p>
                  </div>
               </li>
               <li class="swiper-slide">
                  <div class="ds44-diaporama-thumb" style="background-image: url('../../assets/images/sample-img-8.jpg');">
                     <p class="visually-hidden">2013/29 - Tell Me, technique mixte sur papier<br />Antoine Parra Del Pozo, 2013</p>
                  </div>
               </li>
               <li class="swiper-slide">
                  <div class="ds44-diaporama-thumb" style="background-image: url('../../assets/images/img_article_bigger@2x.jpg');">
                     <p class="visually-hidden">2013/29 - Titre vignette 3<br />Antoine Parra Del Pozo, 2013</p>
                  </div>
               </li>
               <li class="swiper-slide">
                  <div class="ds44-diaporama-thumb" style="background-image: url('../../assets/images/sample-img-4.jpg');">
                     <p class="visually-hidden">2013/29 - Titre vignette 4<br />Antoine Parra Del Pozo, 2013</p>
                  </div>
               </li>
            </ul>
         </nav>
      </div>
   </div>
</div>