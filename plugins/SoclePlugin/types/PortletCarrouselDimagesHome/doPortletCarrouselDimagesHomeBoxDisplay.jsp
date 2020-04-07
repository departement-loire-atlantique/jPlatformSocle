<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/portal/doPortletParams.jspf' %><%
%><%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% PortletCarrouselDimagesHome obj = (PortletCarrouselDimagesHome)portlet; %><%
%>

<section class="ds44-container-large ds44-homepage-container ds44--xxl-padding-b">
    <div class="grid-12-small-1">
        <div class="col-8-small-1">
            <div class="mod--hidden ds44-list swipper-carousel-wrap swipper-carousel-wrap--homepage ds44-posRel swipper-carousel-slideshow" data-nb-visible-slides="1">
                <div role="heading" aria-level="1" class="h1-like ds44-text--colorInvert">
                    <jalios:wysiwyg><%= obj.getTitreAAfficher() %></jalios:wysiwyg>
			    </div>
			    <button class="ds44-btnIco ds44-btnIco--carre ds44-bgDark" type="button">
			        <i class="icon icon-play" aria-hidden="true"></i>
			        <span class="visually-hidden">Lancer l'animation</span>
			    </button>
			    <div class="swiper-container ds44-titleContainer ds44-titleContainer--home swiper-container-fade swiper-container-horizontal">
			        <ul class="swiper-wrapper ds44-list grid-3-small-1 has-gutter-l ds44-carousel-swiper">
			            <jalios:foreach name="itTuile" type="CarouselElement" array="<%= obj.getElementsDiaporamaPrincipaux() %>">
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
        </div>
        <div class="col-4-small-1 ds44-hide-mobile">
            <div class="ds44-flex-container ds44-flex-container--column ds44-h100">
                <div class="ds44-fl1 ds44-imgInsta ds44-hide-tiny-to-medium">
                    <div class="mod--hidden swipper-carousel-wrap swipper-carousel-wrap--homepage ds44-posRel swipper-carousel-slideshow swipper-carousel-slideshow-slave" data-nb-visible-slides="1">
                        <div class="swiper-container swiper-container-fade swiper-container-horizontal">
                            <ul class="swiper-wrapper ds44-list has-gutter-l ds44-carousel-swiper">
	                            <jalios:foreach name="itTuile" type="CarouselElement" array="<%= obj.getElementsDiaporamasSecondaires() %>">
	                                <li class="swiper-slide">
	                                  <ds:figurePicture imgCss="ds44-headerImg" pictureCss="ds44-pageHeaderContainer__pictureContainer" 
	                                     figureCss="ds44-pageHeaderContainer__pictureContainer" format="carouselCarree"
		                                 pub="<%= itTuile %>" imageMobile="<%= itTuile.getImageMobile() %>" alt="<%= itTuile.getTitle() %>" 
		                                 copyright="<%= itTuile.getImageCopyright() %>" legend="<%= itTuile.getImageLegend() %>" ariaLabel="<%= itTuile.getTitle() %>"/>
						            </li>
					            </jalios:foreach>
                            </ul>
                        </div>
                    </div>
                </div>
                <div>
                    <section class="ds44-partage-sliderHome ds44-theme ds44-flex-container ds44-flex-valign-center">
					    <div class="ds44-fg2">
					      <p role="heading" aria-level="2"><%= glp("jcmsplugin.socle.partagerVotreLA") %></p>
					      <p class="hashtag"><%= glp("jcmsplugin.socle.maLA.hashtag") %></p>
					    </div>
					    <%-- TODO : retirer la structure en dur pour les RS --%>
					    <%@ include file="/plugins/SoclePlugin/jsp/portal/socialNetworksCommon.jspf" %>
					    <%
					    Map<String, String> mapSocialNetworks = new HashMap<>();
					    for (int counter = 0; counter < socialNetworksLabels.length; counter++) {
					      mapSocialNetworks.put(socialNetworksLabels[counter], socialNetworksUrls[counter]);
					    }
					    %>
					    <ul class="ds44-list ds44-flex-container ds44-fg1">
					        <li class="ds44-flex-align-center">
					          <a href='<%= mapSocialNetworks.get(glp("jcmsplugin.socle.socialnetwork.facebook")) %>' target="_blank" class="ds44-rsLink" title='<%= glp("jcmsplugin.socle.socialnetwork.depsur.facebook") %> <%= glp("jcmsplugin.socle.accessibily.newTabLabel") %>'><i class="icon icon-facebook" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.socialnetwork.depsur.facebook") %></span></a>
					        </li>
					        <li class="ds44-flex-align-center">
					          <a href='<%= mapSocialNetworks.get(glp("jcmsplugin.socle.socialnetwork.instagram")) %>' target="_blank" class="ds44-rs²ink" title='<%= glp("jcmsplugin.socle.socialnetwork.depsur.instagram") %> <%= glp("jcmsplugin.socle.accessibily.newTabLabel") %>'><i class="icon icon-instagram" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.socialnetwork.depsur.instagram") %></span></a>
					        </li>
					        <li class="ds44-flex-align-center">
					          <a href='<%= mapSocialNetworks.get(glp("jcmsplugin.socle.socialnetwork.twitter")) %>' target="_blank" class="ds44-rsLink" title='<%= glp("jcmsplugin.socle.socialnetwork.depsur.twitter") %> <%= glp("jcmsplugin.socle.accessibily.newTabLabel") %>'><i class="icon icon-twitter" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.socialnetwork.depsur.twitter") %></span></a>
					        </li>
					        <li class="ds44-flex-align-center">
					          <a href='<%= mapSocialNetworks.get(glp("jcmsplugin.socle.socialnetwork.youtube")) %>' target="_blank" class="ds44-rsLink" title='<%= glp("jcmsplugin.socle.socialnetwork.depsur.youtube") %> <%= glp("jcmsplugin.socle.accessibily.newTabLabel") %>'><i class="icon icon-youtube" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.socialnetwork.depsur.youtube") %></span></a>
					        </li>
					    </ul>
					</section>
                </div>
            </div>
        </div>
    </div>
</section>