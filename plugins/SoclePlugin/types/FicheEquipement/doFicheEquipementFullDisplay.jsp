<%@ page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %>
<% FicheEquipement obj = (FicheEquipement)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %>
<%@ include file='/front/doFullDisplay.jspf' %>

<%
String longitude = obj.getExtraData("extra.FicheEquipement.plugin.tools.geolocation.longitude");
String latitude = obj.getExtraData("extra.FicheEquipement.plugin.tools.geolocation.latitude");
String localisation = SocleUtils.formatOpenStreetMapLink(latitude, longitude);
%>

<%-- bouton Retour a la liste --%>
<%@ include file="/plugins/SoclePlugin/jsp/facettes/doRetourListe.jspf" %>

<section class="ds44-card ds44-card--fiche ">
    <div class="ds44-card__section ds44-mb3">
        <h3 class="h2-like"><%= obj.getTitle() %></h3>
        <section class="ds44-box ds44-theme ds44-mt4">
            <div class="ds44-innerBoxContainer">
	            <jalios:if predicate='<%= Util.notEmpty(obj.getAnnee(loggedMember)) %>'>
	                <p class="ds44-docListElem"><i class="icon icon-date ds44-docListIco" aria-hidden="true"></i><strong><%= glp("jcmsplugin.socle.equipement.date-decison") %></strong> <%= obj.getAnnee(loggedMember).first() %></p>
	            </jalios:if>
	            <jalios:if predicate='<%= Util.notEmpty(obj.getMontantTotalDesTravaux()) %>'>
	                <p class="ds44-docListElem ds44-mt-std"><i class="icon icon-cost ds44-docListIco" aria-hidden="true"></i><strong><%= glp("jcmsplugin.socle.equipement.montant-travaux") %></strong> <%= NumberFormat.getInstance(userLocale).format(obj.getMontantTotalDesTravaux()) %> <%= glp("jcmsplugin.socle.symbol.euro") %></p>
	            </jalios:if>
	            <jalios:if predicate='<%= Util.notEmpty(obj.getMontantDeLaSubvention()) %>'>
                    <p class="ds44-docListElem ds44-mt-std"><strong><%= glp("jcmsplugin.socle.equipement.financement-dep") %></strong> <%= NumberFormat.getInstance(userLocale).format(obj.getMontantDeLaSubvention()) %> <%= glp("jcmsplugin.socle.symbol.euro") %></p>
                </jalios:if>
                <jalios:if predicate='<%= obj.getPourcentageDepartement() > 0 %>'>
                    <p class="ds44-docListElem ds44-mt-std"><strong><%= glp("jcmsplugin.socle.equipement.pourcentage-dep") %></strong> <%= NumberFormat.getInstance(userLocale).format(obj.getPourcentageDepartement()) %> %</p>
                </jalios:if>                    
                <jalios:if predicate='<%= Util.notEmpty(obj.getEpci(loggedMember)) %>'>
                    <div class="ds44-docListElem ds44-mt-std"><i class="icon icon-marker ds44-docListIco" aria-hidden="true"></i>
                        <jalios:if predicate='<%= obj.getEpci(loggedMember).size() == 1 %>'>
                            <%= obj.getEpci(loggedMember).first() %>
                        </jalios:if>
                                                    
                        <jalios:if predicate='<%= obj.getEpci(loggedMember).size() > 1 %>'>
                            <ul class="ds44-list">
	                            <jalios:foreach name="itEpci" type="Category" collection='<%= obj.getEpci(loggedMember) %>'>
	                                <li>
                                        <%= itEpci %>
	                                </li>
	                            </jalios:foreach>
                            </ul>
                        </jalios:if>
                    </div>
                </jalios:if>
	            <jalios:if predicate='<%= Util.notEmpty(localisation) %>'>
	                <p class="ds44-docListElem mts">
	                    <i class="icon icon-map ds44-docListIco" aria-hidden="true"></i>
	                    <a href='<%= localisation%>' 
	                        title='<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.ficheaide.localiser-carte.label")+" : " + obj.getTitle(userLang) + " " + glp("jcmsplugin.socle.accessibily.newTabLabel"))%>' 
	                        target="_blank"
	                        data-statistic='{"name": "declenche-evenement","category": "BlocNousContacter","action": "Localiser","label": "<%= HttpUtil.encodeForHTMLAttribute(obj.getTitle()) %>"}'> 
	                        
	                        <%= glp("jcmsplugin.socle.ficheaide.localiser-carte.label") %> 
	                    </a>
	                </p>
	            </jalios:if>
             </div>
        </section>
        
        <section>
        
            <jalios:if predicate='<%= Util.notEmpty(obj.getChapo()) %>'>
                <h4 class="h3-like ds44-mt3"><%= glp("jcmsplugin.socle.enbref") %></h4>
                <jalios:wysiwyg><%= obj.getChapo() %></jalios:wysiwyg>
            </jalios:if>
            
            <jalios:if predicate='<%= Util.notEmpty(obj.getImagePrincipale()) %>'>
                <ds:figurePicture imgCss="ds44-w100 ds44-imgRatio" pictureCss="ds44-legendeContainer ds44-container-imgRatio" format="custom" width="500" height="333" 
                    image="<%= obj.getImagePrincipale() %>" copyright="<%= obj.getCopyright() %>" legend="<%= obj.getLegende() %>"/>
            </jalios:if>
            
        </section>
        
  </div>
</section>
