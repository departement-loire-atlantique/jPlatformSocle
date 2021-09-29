<%@page import="org.codehaus.jackson.map.ObjectMapper"%>
<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ include file='/jcore/portal/doPortletParams.jspf' %><%
%><%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%><%
%><% PortletMiseEnAvantDeContenus box = (PortletMiseEnAvantDeContenus)portlet; %>

<%@ include file="/types/PortletQueryForeach/doQuery.jspf" %>
<%@ include file="/types/PortletQueryForeach/doSort.jspf" %>

<%

String urlLien = "";
String libelleLien = box.getTitreCompletDeLien(userLang);
String titleLien = "";
if(Util.notEmpty(box.getLienExterne())) {
    urlLien = box.getLienExterne();
    titleLien = HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.lien.nouvelonglet", libelleLien));
} else if(Util.notEmpty(box.getLienInterne())) {
    urlLien = box.getLienInterne().getDisplayUrl(userLocale);
    titleLien = HttpUtil.encodeForHTMLAttribute(libelleLien);
}

%>

<section class="ds44-container-fluid ds44-bgDark ds44-bg-patrimoine-sites ds44--xxl-padding-tb">
                
    <header class="txtcenter ds44--xl-padding-b ds44-container-large">
      <h2 class="h2-like ds44-dark" id="titreMEA<%= box.getId() %>"><%= box.getTitreVisuel(userLang) %></h2>
        <a class="ds44-block" title="<%= glp("jcmsplugin.socle.lien.site.nouvelonglet", glp("jcmsplugin.socle.gpla.site")) %>" href="<%= channel.getProperty("jcmsplugin.socle.gpla.site.url") %>" target="_blank" >       
	      <picture>
	          <img src='<%= channel.getProperty("jcmsplugin.socle.gpla.site.logo") %>' alt='<%= glp("jcmsplugin.socle.gpla.site") %>' class="ds44-logoCard"/>
	      </picture>
        </a>     
    </header>

    <div class="ds44-mobile-extra-smt"> 
        <div class="ds44-container-large">   
		    <div class="mod--hidden ds44-list swipper-carousel-wrap ds44-posRel ds44-container-large" data-nb-visible-slides="5" data-mobile-only="true">
		              		    
			    <div class="swiper-container">			    			    
			        <ul class="swiper-wrapper ds44-list grid-3-small-1 has-gutter-l ds44-carousel-swiper">			        			        
			            <%@ include file='/types/PortletQueryForeach/doForeachHeader.jspf' %>			            			            
			                <li class="swiper-slide">
	                            <jalios:media data="<%= itPub %>" template="tuileVerticaleGpla"/>
			                </li>			                			             			                
			            <%@ include file="/types/PortletQueryForeach/doForeachFooter.jspf" %>
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
    </div>

    <jalios:if predicate='<%= Util.notEmpty(urlLien) && Util.notEmpty(libelleLien) %>'>
        <div class="txtcenter ds44-container-large ">
            <p>
                <a href="<%= urlLien %>" title="<%= titleLien %>" <%= Util.notEmpty(box.getLienExterne()) ? "target=\"_blank\"" : "" %> class="ds44-btnStd ds44-btnStd--white ds44-btnStd--large ds44-btnFullMobile" type="button"><span class="ds44-btnInnerText"><%= box.getLabelDuLien(userLang) %></span><i class="icon icon-long-arrow-right" aria-hidden="true"></i></a>
            </p>                      
	    </div>
    </jalios:if>

</section>