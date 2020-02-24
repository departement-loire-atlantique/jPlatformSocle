<%@ page contentType="text/html; charset=UTF-8"%><%
%><%@ include file='/jcore/doInitPage.jspf'%><%
%><%@ include file='/jcore/portal/doPortletParams.jspf'%><%
%><%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
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
            <jalios:foreach name="itContenuEnAvant" type="Content" array="<%= box.getContenusEnAvant() %>" max="2">
                <ds:tuileContenuEnAvant content="<%= itContenuEnAvant %>" isUnique="<%= Boolean.toString(box.getContenusEnAvant().length == 1) %>"/>
            </jalios:foreach>
        </div>
    </jalios:if>
    

    <div class="mod--hidden ds44-list swipper-carousel-wrap ds44-posRel ds44-container-large">
        <div class="swiper-container">
            <ul class="swiper-wrapper ds44-list grid-3-small-1 has-gutter-l ds44-carousel-swiper">
                <%@ include file="/types/PortletQueryForeach/doQuery.jspf"%>
                <%@ include file="/types/PortletQueryForeach/doSort.jspf"%>
                <%@ include file="/types/PortletQueryForeach/doForeachHeader.jspf"%>
                
                <ds:tuileSlider pub="<%= itPub %>" theme="<%= box.getSelectionDuTheme() %>"/>
                
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
