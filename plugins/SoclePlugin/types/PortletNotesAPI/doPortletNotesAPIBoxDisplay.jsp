<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ include file="/jcore/doInitPage.jspf" %>
<%@ include file="/jcore/portal/doPortletParams.jspf" %>
<% PortletNotesAPI box = (PortletNotesAPI) portlet; %>

<section class="ds44-container-large ds44-mt-std ds44-partage-patrimoine">
   <div class="grid-12-small-1">
      <div class="col-6-small-1">
         <section class="ds44-partage-sliderHome ds44-theme ds44-flex-container ds44-flex-valign-center">
            <div class="ds44-fg2">
               <p role="heading" aria-level="2">Partagez vos expériences</p>
               <p class="hashtag">#chateau-clisson</p>
            </div>
            <ul class="ds44-list ds44-flex-container ds44-fg1">
               <li class="ds44-flex-align-center">
                  <a href="#" target="_blank" class="ds44-rsLink" title="Le Département de Loire-Atlantique sur Facebook - nouvelle fenêtre"><i class="icon icon-facebook" aria-hidden="true"></i><span class="visually-hidden">Le Département de Loire-Atlantique sur Facebook</span></a>
               </li>
               <li class="ds44-flex-align-center">
                  <a href="#" target="_blank" class="ds44-rsLink" title="Le Département de Loire-Atlantique sur Instagram - nouvelle fenêtre"><i class="icon icon-instagram" aria-hidden="true"></i><span class="visually-hidden">Le Département de Loire-Atlantique sur Instagram</span></a>
               </li>
            </ul>
         </section>
      </div>
      <div class="col-6-small-1 ds44-bgGray ds44-noteRS ">
         <ul class="ds44-list ds44-flex-container ds44-flex-valign-center">
            <li class="ds44-flex-align-center">
               <a href="#">
                  <i class="icon icon-tripadvisor" aria-hidden="true"></i>
                  <p>
                     <span class="h1-like ds44-block">4,5/5</span>
                     <span class="ds44-block">275 avis</span>
                     <span class="ds44-block">Tripadvisor</span>
                  </p>
               </a>
            </li>
            <li class="ds44-flex-align-center">
               <a href="#">
                  <i class="icon icon-google" aria-hidden="true"></i>
                  <p>
                     <span class="h1-like ds44-block">4,4/5</span>
                     <span class="ds44-block">2028 avis</span>
                     <span class="ds44-block">Google</span>
                  </p>
               </a>
            </li>
            <li class="ds44-flex-align-center">
               <a href="#">
                  <i class="icon icon-facebook" aria-hidden="true"></i>
                  <p>
                     <span class="h1-like ds44-block">4,7/5</span>
                     <span class="ds44-block">78 avis</span>
                     <span class="ds44-block">Facebook</span>
                  </p>
               </a>
            </li>
         </ul>
      </div>
   </div>
</section>