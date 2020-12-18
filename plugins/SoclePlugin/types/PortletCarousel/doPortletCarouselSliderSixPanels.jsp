<%@ page contentType="text/html; charset=UTF-8"%><%
%><%@ include file='/jcore/doInitPage.jspf'%><%
%><%@ include file='/jcore/portal/doPortletParams.jspf'%><%
%><%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>

<%
String cssSliderSize = "grid-3-small-1";
String sliderAmounts = "1";
%>

<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%
    PortletCarousel box = (PortletCarousel) portlet;
    String themeClair = "tuileVerticaleLight";
    
    String titreBloc = Util.notEmpty(box.getTitreDuBloc()) ? box.getTitreDuBloc() : glp("jcmsplugin.socle.label.encemoment");
    String sousTitreBloc = box.getSoustitreDuBloc();
    String positionTitre = Util.notEmpty(box.getPositionTitre()) && !box.getPositionTitre().equals("none") ? "ds44-blockAbsolute--"+box.getPositionTitre() : "";
%>

<section class='ds44-container-fluid <%= box.getSelectionDuTheme().equals(themeClair) ? " ds44-lightBG ds44-wave-white" : "" %> ds44--xxl-padding-tb'>
    <div class="ds44-inner-container ds44--mobile--m-padding-b">
        <header class="txtcenter <%=Util.isEmpty(sousTitreBloc) ? "ds44-mb2" : ""%>">
            <h2 class="h2-like center"><%= titreBloc %></h2>
            
            <jalios:if predicate="<%= Util.notEmpty(sousTitreBloc) %>">
                <div class="ds44-component-chapo ds44-centeredBlock" role="heading" aria-level="3">
                    <jalios:wysiwyg><%= sousTitreBloc %></jalios:wysiwyg>
                </div>
            </jalios:if>
        </header>
    </div>
    
    <jalios:if predicate="<%= Util.notEmpty(box.getContenusEnAvant()) %>">
        <div class="ds44-container-large">
            <jalios:if predicate="<%= box.getContenusEnAvant().length > 1 %>">
            <div class="grid-12-small-1">
            </jalios:if>
            <jalios:foreach name="itContenuEnAvant" type="Content" array="<%= box.getContenusEnAvant() %>" max="2">
                <jalios:select>
                    <jalios:if predicate="<%= itContenuEnAvant instanceof Lien %>">
                       <%
                       Lien itLien = (Lien) itContenuEnAvant;
                       String customUrl = SocleUtils.getUrlPubFromLien(itLien);
                       Boolean isExterne = SocleUtils.isLienExterne(itLien);
                       %>
                       <ds:tuileContenuEnAvant content="<%= itContenuEnAvant %>" isUnique="<%= Boolean.toString(box.getContenusEnAvant().length == 1) %>" 
                           positionTitre="<%= positionTitre %>" customUrl="<%= customUrl %>" isExterne="<%= isExterne %>"/>
                    </jalios:if>
                    <jalios:default>
                       <ds:tuileContenuEnAvant content="<%= itContenuEnAvant %>" isUnique="<%= Boolean.toString(box.getContenusEnAvant().length == 1) %>" positionTitre="<%= positionTitre %>"/>
                    </jalios:default>
                </jalios:select>
            </jalios:foreach>
            <jalios:if predicate="<%= box.getContenusEnAvant().length > 1 %>">
            </div>
            </jalios:if>
        </div>
    </jalios:if>

    <%@ include file="/types/PortletQueryForeach/doQuery.jspf"%>
    <%@ include file="/types/PortletQueryForeach/doSort.jspf"%>
    
    <%--
    Un bloc qui loop = 6 éléments restants ou moins

	Colonne 1 = 1 élément minimum restant
	Colonne 2 = 2 éléments minimum restants
	Colonne 3 = 3 éléments minimum restants
	
	Si 1 élément, colonne 1 prend la totalité (12)
	Si 3 ou moins, colonne 1 et 2 prennent moitié (8-4)
	Sinon, prennent un tiers (7-3-2)
	
	Dans un bloc
	    if counter%6 = 1
	        1 ligne
	    if counter%6 > 1 && counter%6 <= 3
	        2 lignes
	    default
           3 lignes
           
    Ouverture du bloc -> boolean à true
    Fermeture du bloc -> boolean à false
    
    Ouvrir avant boucle, fermer avant boucle SI boolean == true
    
    Passer par un buffer plutôt ?
     --%>
    
    <div class="ds44-container-large">
        <div class="mod--hidden ds44-list swipper-carousel-wrap ds44-posRel" data-nb-visible-slides="1">
            <div class="swiper-container">
				<ul class="swiper-wrapper ds44-list grid-1-small-1 has-gutter-l ds44-carousel-swiper">
				   <%
				   // Variables pour la boucle
				   int counterThisPanel = 0;
				   int remainingElements = 0;
                   String widthColOne = "";
                   String widthColTwo = "";
                   String widthColThree = "";
                   int maxElems = box.getMaxResults() <= collection.size() && box.getMaxResults() > 0 ? box.getMaxResults() : collection.size();
				   %>
				   <%@ include file="/types/PortletQueryForeach/doForeachHeader.jspf"%>
				   <%
				   // Initialisation boucle
				   // itPublicationCounter % 6 == 1 -> correspond au premier élément d'un bloc
				   // itPublicationCounter % 6 == 0 -> correspond au dernier élément d'un bloc s'il y a 6 éléments dans ce bloc
				   counterThisPanel = itPublicationCounter % 6;
				   
				   if (counterThisPanel == 1) {
				     // Début de bloc : on vérifie combien d'éléments il reste, y compris l'élément actuel
				     remainingElements = (maxElems - itPublicationCounter) + 1;
				   }
				   
				   // Trois cas se présentent
				   if (remainingElements >= 4) {
				     // il reste 4 éléments ou plus : on a 3 colonnes
				     widthColOne = "7";
		             widthColTwo = "3";
		             widthColThree = "2";
				   } else if (remainingElements >= 2) {
				     // il reste 2 éléments ou plus : on a deux colonnes
				     widthColOne = "9";
		             widthColTwo = "3";
				   } else {
				     // Il ne reste qu'un élément : on a une colonne
				     widthColOne = "12";
				   }
				   %>
				   <jalios:if predicate="<%= counterThisPanel == 1 %>">
				   <%-- On ouvre un bloc : on déclare l'ouverture du <LI> --%>
				   <li class="swiper-slide">
				       <div class="grid-12-small-1 ds44-tuiles-mosaiques has-gutter-l">
				   </jalios:if>
				         <%-- Bloc une ligne --%>
				         <jalios:if predicate="<%= counterThisPanel == 1 %>">
					         <div class="col-<%= widthColOne %>-small-1 ds44-mb2 ">
					            <jalios:media data="<%= itPub %>" template='<%= box.getSelectionDuTheme() + "Six" %>'/>
					         </div>
				         </jalios:if>
				         <%-- Bloc deux lignes --%>
				         <jalios:if predicate="<%= counterThisPanel >= 2 && counterThisPanel <= 3 %>">
					         <%-- Ouverture du sous-bloc --%>
					         <jalios:if predicate="<%= counterThisPanel == 2 %>">
					         <div class="col-<%= widthColTwo %>-small-1">
					           <div class="ds44-flex-container ds44-flex-container--column ds44-h100">
					         </jalios:if>
					               <div class="ds44-fl1 ds44-mb2">
					                  <jalios:media data="<%= itPub %>" template='<%= box.getSelectionDuTheme() + "Six" %>'/>
					               </div>
					         <%-- Ajout d'un bloc vide si compteur = 2 et qu'on a atteint la fin --%>
					         <jalios:if predicate="<%= counterThisPanel == 2 && itPublicationCounter == maxElems %>">
					               <div class="ds44-fl1 ds44-mb2"></div>
					         </jalios:if>
					         <%-- Fermeture du sous-bloc --%>
					         <jalios:if predicate="<%= counterThisPanel == 3 || itPublicationCounter == maxElems %>">
					           </div>
					         </div>
					         </jalios:if>
				         </jalios:if>
				         <%-- Bloc trois lignes --%>
				         <jalios:if predicate="<%= counterThisPanel >= 4 || counterThisPanel == 0 %>">
				             <%-- Ouverture du sous-bloc --%>
				             <jalios:if predicate="<%= counterThisPanel == 4 %>">
					         <div class="col-<%= widthColThree %>-small-1">
					           <div class="ds44-flex-container ds44-flex-container--column ds44-h100">
					         </jalios:if>
					               <div class="ds44-fl1 ds44-mb2">
					                  <jalios:media data="<%= itPub %>" template='<%= box.getSelectionDuTheme() + "Six" %>'/>
					               </div>
					         <%-- Ajout de deux blocs vides si compteur = 4 et qu'on a atteint la fin --%>
                             <jalios:if predicate="<%= counterThisPanel == 4 && itPublicationCounter == maxElems %>">
                                   <div class="ds44-fl1 ds44-mb2"></div>
                                   <div class="ds44-fl1 ds44-mb2"></div>
                             </jalios:if>
                             <%-- Ajout d'un bloc vide si compteur = 5 et qu'on a atteint la fin --%>
                             <jalios:if predicate="<%= counterThisPanel == 5 && itPublicationCounter == maxElems %>">
                                   <div class="ds44-fl1 ds44-mb2"></div>
                             </jalios:if>
					            <%-- Fermeture du sous-bloc --%>
                             <jalios:if predicate="<%= counterThisPanel == 0 || itPublicationCounter == maxElems %>">
                               </div>
                             </div>
                             </jalios:if>
					      </jalios:if>
				   <%-- Fermeture du bloc <LI> --%>
				   <jalios:if predicate="<%= counterThisPanel == 0 || itPublicationCounter == maxElems %>">
				      </div>
				   </li>
				   </jalios:if>
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
    </div>
</section>