<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<%@ include file='/jcore/doInitPage.jspf'%>
<%@ page import="fr.cg44.plugin.socle.SocleUtils"%>
<%
	Carousel obj = (Carousel) request.getAttribute(PortalManager.PORTAL_PUBLICATION);

	if (Util.isEmpty(obj.getElements1())) {
		return;
	}
	
	SimpleDateFormat sdfTuiles = new SimpleDateFormat("yyyy/MM"); 
%>

<jalios:if predicate="<%= Util.notEmpty(obj.getTitre(userLang, false)) || Util.notEmpty(obj.getSoustitre(userLang, false)) %>">
	<header class="txtcenter ds44--l-padding-tb">		
		<jalios:if predicate="<%= Util.notEmpty(obj.getTitre(userLang, false)) %>">
			<h3 class="h3-like"><%= obj.getTitre(userLang, false) %></h3>
		</jalios:if>
		<jalios:if predicate="<%= Util.notEmpty(obj.getSoustitre(userLang, false)) %>">
			<h4 class="h4-like"><%= obj.getSoustitre(userLang, false) %></h4>
		</jalios:if>
	</header>
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
					String urlImage = SocleUtils.getUrlImageElementCarousel(itElement, userLang, jcmsContext);
					String titreTuile = HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.diaporama.titre", sdfTuiles.format(itElement.getPdate()), itElement.getTitle(userLang, false)));
					String legend = Util.notEmpty(itElement.getImageLegend(userLang, false)) ? itElement.getImageLegend(userLang, false) : "";
                    String copyright = Util.notEmpty(itElement.getImageCopyright(userLang, false)) ? itElement.getImageCopyright(userLang, false) : "";
                    
                    String label = "";
                    if (Util.notEmpty(legend) || Util.notEmpty(copyright)) {
                        label = legend;
                        if (Util.notEmpty(copyright)) {
                          label += " ";
                          label += JcmsUtil.glp(userLang, "jcmsplugin.socle.symbol.copyright") + " " + copyright;
                        }
                    }
                    request.setAttribute("itCarouselElement", itElement);
                    %>
                    <%@ include file="/plugins/SoclePlugin/jsp/include/elementCarouselLinkCommons.jspf" %>
                    <%
                    request.removeAttribute("itCarouselElement");
                    
                %>
				<li class="swiper-slide">
					<div class="ds44-diaporama-vignette">
						<jalios:if predicate="<%= Util.notEmpty(itElement.getImageLegend(userLang, false)) %>">
							<figure class="ds44-diaporama-vignette-container" role="figure" aria-label='<%= titreTuile %>'>
							    <jalios:if predicate="<%= Util.notEmpty(urlLien) %>">
							    <a href="<%= urlLien %>" title="<%= titreTuile %>" <% if (isExterne) { %>target="_blank"<% } %>>
							    </jalios:if>
								<img class="ds44-diaporama-vignette-image" src="<%= urlImage %>" alt='<%= titreTuile %>' />
								<jalios:if predicate="<%= Util.notEmpty(urlLien) %>">
								</a>
								</jalios:if>
								<figcaption class="ds44-diaporama-vignette-text"><%= titreTuile %><jalios:if predicate="<%= Util.notEmpty(label) %>"><br /><%= label %></jalios:if></figcaption>
							</figure>
						</jalios:if>
						<jalios:if predicate="<%= Util.isEmpty(itElement.getImageLegend(userLang, false)) %>">
						    <jalios:if predicate="<%= Util.notEmpty(urlLien) %>">
                            <a href="<%= urlLien %>" title="<%= titreTuile %>" <% if (isExterne) { %>target="_blank"<% } %>>
                            </jalios:if>
							<img class="ds44-diaporama-vignette-image" src="<%= urlImage %>" alt='<%= titreTuile %>' />
							<jalios:if predicate="<%= Util.notEmpty(urlLien) %>">
                            </a>
                            </jalios:if>
						</jalios:if>
					</div>
				</li>
			</jalios:foreach>
		</ul>
		<button class="swiper-button-prev swiper-button-white swiper-button-disabled ds44-bgDark" type="button">
			<i class="icon icon-left" aria-hidden="true"></i> 
			<span class="visually-hidden"></span>
		</button>
		<button class="swiper-button-next swiper-button-white swiper-button-disabled ds44-bgDark" type="button">
			<i class="icon icon-right" aria-hidden="true"></i> 
			<span class="visually-hidden"></span>
		</button>
	</div>
	<div class="swiper-pagination"></div>
	<div class="swiper-thumbs">
		<div class="swiper-thumbs-container">
			<nav class="swiper-container" aria-label='<%= glp("jcmsplugin.socle.diaporama.nav-miniature.titre", obj.getTitre(userLang, false)) %>'>
				<ul class="swiper-wrapper ds44-list">
					<jalios:foreach name="itElement" type="CarouselElement" array="<%= obj.getElements1() %>">
						<%
							String urlImage = itElement.getImageCarree(userLang, false);
							
							if (Util.isEmpty(urlImage)) {
								urlImage = itElement.getImageMobile(userLang, false);
							}
							
							if (Util.isEmpty(urlImage)) {
								urlImage = itElement.getImage(userLang, false);
							}
							
							urlImage = SocleUtils.getUrlOfFormattedImageDiaporamaVignette(urlImage);
							
							String titreTuile = HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.diaporama.titre", sdfTuiles.format(itElement.getPdate()), itElement.getTitle(userLang, false)));
							
							String legend = Util.notEmpty(itElement.getImageLegend(userLang, false)) ? itElement.getImageLegend(userLang, false) : "";
							String copyright = Util.notEmpty(itElement.getImageCopyright(userLang, false)) ? itElement.getImageCopyright(userLang, false) : "";
							
							String label = "";
							if (Util.notEmpty(legend) || Util.notEmpty(copyright)) {
							    label = legend;
							    if (Util.notEmpty(copyright)) {
							      label += " ";
							      label += JcmsUtil.glp(userLang, "jcmsplugin.socle.symbol.copyright") + " " + copyright;
							    }
							}
						%>
						<li class="swiper-slide">
							<button class="ds44-diaporama-thumb" style="background-image: url('<%= urlImage %>');">
								<p class="visually-hidden"><%= titreTuile %><jalios:if predicate="<%= Util.notEmpty(label) %>"><br /><%= label %></jalios:if></p>
							</button>
						</li>
					</jalios:foreach>
				</ul>
			</nav>
		</div>
	</div>
</div>