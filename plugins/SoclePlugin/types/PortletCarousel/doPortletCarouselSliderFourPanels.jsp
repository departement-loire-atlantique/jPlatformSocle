<%@ page contentType="text/html; charset=UTF-8"%>
<%
    
%><%@ include file='/jcore/doInitPage.jspf'%>
<%
    
%><%@ include file='/jcore/portal/doPortletParams.jspf'%>
<%
    
%>
<%
    PortletCarousel box = (PortletCarousel) portlet;
    String themeSombre = "darkContext";
    
    String titreBloc = Util.notEmpty(box.getTitreDuBloc()) ? box.getTitreDuBloc() : glp("jcmsplugin.socle.label.encemoment");
    String sousTitreBloc = box.getSoustitreDuBloc();
%>

<section class='ds44-container-fluid <%= box.getSelectionDuTheme().equals(themeSombre) ? " ds44-lightBG ds44-wave-white" : "" %> ds44-mtb3 ds44--xl-padding-tb'>
    <div class="ds44-inner-container ds44--mobile--m-padding-b">
        <header class="txtcenter">
            <h2 class="h2-like center"><%= titreBloc %></h2>
            
            <jalios:if predicate="<%= Util.notEmpty(sousTitreBloc) %>">
                <div class="ds44-component-chapo ds44-centeredBlock">
                    <jalios:wysiwyg><%= sousTitreBloc %></jalios:wysiwyg>
                </div>
            </jalios:if>
        </header>
    </div>
    
    <jalios:if predicate="<%= Util.notEmpty(box.getContenusEnAvant()) %>">
        <div class="ds44-container-large">
            <%-- TODO : afficher les contenus mis en avant --%>
        </div>
    </jalios:if>
    

    <div class="mod--hidden ds44-list swipper-carousel-wrap ds44-posRel ds44-container-large">
        <div class="swiper-container">
            <ul class="swiper-wrapper ds44-list grid-4-small-1 has-gutter-l ds44-carousel-swiper">
                <%@ include file="/types/PortletQueryForeach/doQuery.jspf"%>
                <%@ include file="/types/PortletQueryForeach/doSort.jspf"%>
                <%@ include file="/types/PortletQueryForeach/doForeachHeader.jspf"%>
                
                <%
                String urlImage = "";
                String title = itPub.getTitle();
                String subTitle = "";
                String location = "";
                
                try {
                    urlImage = (String) itPub.getFieldValue("imageMobile");
                } catch(Exception e) {}
                if (Util.isEmpty(urlImage)) {
                    try {
                        urlImage = (String) itPub.getFieldValue("imageBandeau");
                    } catch(Exception e) {}
                }
                if (Util.isEmpty(urlImage)) {
                    try {
                        urlImage = (String) itPub.getFieldValue("imagePrincipale");
                    } catch(Exception e) {}
                }
                if (Util.isEmpty(urlImage)) {
                    urlImage = "s.gif";
                }
                
                // TODO : subTitle
                
                // TODO : location
                
                %>
                
                <li class="swiper-slide">
                    <section class="ds44-card ds44-card--verticalPicture ds44-<%= box.getSelectionDuTheme() %>">
                        <jalios:if predicate="<%= Util.notEmpty(urlImage) %>">
                        <a href="#" tabindex="-1" aria-hidden="true">
                            <picture class="ds44-container-imgRatio">
                                <img src="<%= urlImage %>" alt="" class="ds44-imgRatio" />
                            </picture>
                        </a>
                        </jalios:if>
                        <div class="ds44-card__section">
                            <p role="heading" aria-level="2" class="ds44-card__title">
                                <a href="<%= itPub.getDisplayUrl(userLocale) %>" class="ds44-card__globalLink">
                                    <%= title %>
                                </a>
                            </p>
                            <jalios:if predicate="<%= Util.notEmpty(subTitle) %>">
                            <p><%= subTitle %></p>
                            </jalios:if>
                            <jalios:if predicate="<%= Util.notEmpty(location) %>">
                            <p class="ds44-cardLocalisation">
                                <i class="icon icon-marker" aria-hidden="true"></i>
                                <span class="ds44-iconInnerText"><%= location %></span>
                            </p>
                            </jalios:if>
                            <a href="<%= itPub.getDisplayUrl(userLocale) %>" tabindex="-1" aria-hidden="true">
                                <i class="icon icon-arrow-right ds44-cardArrow" aria-hidden="true"></i>
                                <span class="visually-hidden"><%= title %></span>
                            </a>
                        </div>
                    </section>
                </li>
                
                <%@ include file="/types/PortletQueryForeach/doForeachFooter.jspf"%>
            </ul>
        </div>
    
        <button class="swiper-button-prev swiper-button-disabled" type="button">
            <i class="icon icon-left" aria-hidden="true"></i> <span
                class="visually-hidden"></span>
        </button>
        <button class="swiper-button-next swiper-button-disabled" type="button">
            <i class="icon icon-right" aria-hidden="true"></i> <span
                class="visually-hidden"></span>
        </button>
    
    </div>
</section>
