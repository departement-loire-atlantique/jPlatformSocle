<%@ page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<%@ include file='/jcore/doInitPage.jspf'%>
<% City obj = (City)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %>
<%@ include file='/front/doFullDisplay.jspf' %>

<%-- On met en buffer le contenu HTML dela partie colorée du titre, avant de le passer au tag --%>
<%
String longitude = obj.getExtraData("extra.City.plugin.tools.geolocation.longitude");
String latitude = obj.getExtraData("extra.City.plugin.tools.geolocation.latitude");
String localisation = SocleUtils.formatOpenStreetMapLink(latitude, longitude);

%>

<jalios:buffer name="coloredSectionContent">
    <div class="grid-2-small-1 ds44-grid12-offset-1">
        <%-- Col gauche --%>
        <div class="col">

            <%-- Bloc "Adresse" --%>
            <jalios:if predicate='<%= Util.notEmpty(obj.getCouncilBuildingAddress(userLang)) %>'>
                <p role="heading" aria-level="3" class="ds44-box-heading"><%= glp("jcmsplugin.socle.adresse") %></p>
                <div class="ds44-docListElem mts">
                    <i class="icon icon-marker ds44-docListIco" aria-hidden="true"></i>
                    <jalios:wysiwyg><%= SocleUtils.formatAdresseCommune(obj) %></jalios:wysiwyg>
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
            
            <%-- Bloc "Contact" --%>
            <jalios:if predicate='<%=Util.notEmpty(obj.getPhones()) || Util.notEmpty(obj.getMails())
                        || Util.notEmpty(obj.getWebsites())%>'>
                <p role="heading" aria-level="3" class="ds44-box-heading ds44-box-heading mtl"><%= glp("jcmsplugin.socle.ficheaide.contact") %></p>
    
                <%-- Tel --%>
                <jalios:if predicate='<%=Util.notEmpty(obj.getPhones())%>'>
                    <div class="ds44-docListElem mts">
                        <i class="icon icon-phone ds44-docListIco" aria-hidden="true"></i>
    
                        <jalios:if predicate='<%= obj.getPhones().length == 1 %>'>
                            <% String numTel = obj.getPhones()[0]; %>
                            <ds:phone number="<%= numTel %>"/>
                        </jalios:if>
    
                        <jalios:if predicate='<%= obj.getPhones().length > 1 %>'>
                            <ul class="ds44-list">
                                <jalios:foreach name="numTel" type="String" array="<%= obj.getPhones() %>">
                                    <li>
                                        <ds:phone number="<%= numTel %>"/>
                                    </li>
                                </jalios:foreach>
                            </ul>
                        </jalios:if>
    
                    </div>
                </jalios:if>
    
                <%-- Mails --%>
                <jalios:if predicate='<%=Util.notEmpty(obj.getMails())%>'>
                    <div class="ds44-docListElem mts">
                        <i class="icon icon-mail ds44-docListIco" aria-hidden="true"></i>
    
                        <jalios:if predicate='<%= obj.getMails().length == 1 %>'>
                            <% String email = obj.getMails()[0]; %>
                            <a href='<%= "mailto:"+email %>'
                               title='<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.ficheaide.contacter-x-par-mail.label", obj.getTitle(), email)) %>'
                               data-statistic='{"name": "declenche-evenement","category": "BlocNousContacter","action": "Mailto","label": "<%= HttpUtil.encodeForHTMLAttribute(obj.getTitle()) %>"}'> 
                                <%=  glp("jcmsplugin.socle.ficheaide.contacter-par-mail.label")  %>
                            </a>
                        </jalios:if>
    
                        <jalios:if predicate='<%= obj.getMails().length > 1 %>'>
                            <ul class="ds44-list">
                                <jalios:foreach name="email" type="String" array='<%= obj.getMails() %>'>
                                    <li>
                                        <a href='<%= "mailto:"+email %>'
                                            title='<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.ficheaide.contacter-x-par-mail.label", obj.getTitle(), email)) %>'
                                            data-statistic='{"name": "declenche-evenement","category": "BlocNousContacter","action": "Mailto","label": "<%= HttpUtil.encodeForHTMLAttribute(obj.getTitle()) %>"}'> 
                                            <%= email %>
                                        </a>
                                    </li>
                                </jalios:foreach>
                            </ul>
                        </jalios:if>
    
                    </div>
                </jalios:if>
    
                <%-- Sites web --%>
                <jalios:if predicate='<%=Util.notEmpty(obj.getWebsites())%>'>
                    <div class="ds44-docListElem mts">
                        <i class="icon icon-link ds44-docListIco" aria-hidden="true"></i>
    
                        <jalios:if predicate='<%= obj.getWebsites().length == 1 %>'>
                            <% String site = obj.getWebsites()[0]; %>
                            <a href='<%= SocleUtils.parseUrl(site) %>'
                               title='<%= glp("jcmsplugin.socle.lien.site.nouvelonglet", obj.getTitle()) %>' target="_blank"
                               data-statistic='{"name": "declenche-evenement","category": "BlocNousContacter","action": "Site web","label": "<%= HttpUtil.encodeForHTMLAttribute(obj.getTitle()) %>"}'>
                                <%= glp("jcmsplugin.socle.ficheaide.visiter-site.label") %>
                            </a>
                        </jalios:if>
    
                        <jalios:if predicate='<%= obj.getWebsites().length > 1 %>'>
                            <ul class="ds44-list">
                                <jalios:foreach name="site" type="String" array='<%= obj.getWebsites() %>'>
                                    <li>
                                        <a href='<%= SocleUtils.parseUrl(site) %>'
                                           title='<%= glp("jcmsplugin.socle.lien.site.nouvelonglet", obj.getTitle()) %>' target="_blank"
                                           data-statistic='{"name": "declenche-evenement","category": "BlocNousContacter","action": "Site web","label": "<%= HttpUtil.encodeForHTMLAttribute(obj.getTitle()) %>"}'> 
                                            <%= SocleUtils.parseUrl(site) %>
                                        </a>
                                    </li>
                                </jalios:foreach>
                            </ul>
                        </jalios:if>
    
                    </div>
                </jalios:if>
    
            </jalios:if>            

        </div>
        
        <%-- Col droite --%>
        <div class="col ds44--xl-padding-l">
            
            <%-- Maire --%>
            <jalios:if predicate='<%= Util.notEmpty(obj.getMayor()) %>'>
                <p role="heading" aria-level="3" class="ds44-box-heading"><%= glp("jcmsplugin.socle.maire") %></p>
                <div class="ds44-docListElem mts"><i class="icon icon-user ds44-docListIco" aria-hidden="true"></i><jalios:wysiwyg><%= obj.getMayor() %></jalios:wysiwyg></div>
            </jalios:if>
            
            <%-- Intercommunalité --%>
            <jalios:if predicate='<%= Util.notEmpty(obj.getEpci(loggedMember)) %>'>
                <p role="heading" aria-level="3" class="ds44-box-heading mtl"><%= glp("jcmsplugin.socle.interco") %></p>
                <div class="mts">
                    <jalios:select>
	                    <jalios:if predicate='<%= Util.notEmpty(obj.getEpciWebsite())%>'>
	                       <% String epciLibelle = obj.getEpci(loggedMember).first().getName(); %>
                            <a href="<%= obj.getEpciWebsite() %>" target="_blank" title="<%= glp("jcmsplugin.socle.lien.site.nouvelonglet", epciLibelle) %>"><%= epciLibelle %></a>
	                    </jalios:if>
	                    <jalios:default>
	                        <%= obj.getEpci(loggedMember).first() %>
	                    </jalios:default>
                    </jalios:select>
                </div>
            </jalios:if>
            
            <%-- Canton --%>
            <jalios:if predicate='<%= Util.notEmpty(obj.getCanton()) %>'>
                <p role="heading" aria-level="3" class="ds44-box-heading mtl"><%= glp("jcmsplugin.socle.canton") %></p>
                <div class="mts">
                    <jalios:if predicate='<%= obj.getCanton().length == 1 %>'>
                        <jalios:link data="<%= obj.getCanton()[0] %>"><%= obj.getCanton()[0] %></jalios:link>
                    </jalios:if>
                    
                    <jalios:if predicate='<%= obj.getCanton().length > 1 %>'>
                        <ul class="ds44-list">
		                    <jalios:foreach name="itData" type="generated.Canton" array="<%= obj.getCanton() %>">
		                        <jalios:if predicate='<%= itData != null && itData.canBeReadBy(loggedMember)%>'>
				                  <li><jalios:link data="<%= itData %>"><%= itData %></jalios:link></li>
		                        </jalios:if>
		                    </jalios:foreach>
                        </ul>
                    </jalios:if>
              </div>
            </jalios:if>
            
            <%-- Délégation --%>
            <jalios:if predicate='<%= obj.getDelegation() != null %>'>
                <p role="heading" aria-level="3" class="ds44-box-heading mtl"><%= glp("jcmsplugin.socle.delegation") %></p>
                <div class="mts"><jalios:link data="<%= obj.getDelegation() %>"><%= obj.getDelegation() %></jalios:link></div>
            </jalios:if>
            
        
        </div>
    </div>
</jalios:buffer>

<main id="content" role="main" tabindex="-1">
    <article class="ds44-container-large">
    
    <jalios:include target="SOCLE_ALERTE"/>
    
        <ds:titleNoImage title="<%= obj.getTitle(userLang) %>" breadcrumb="true" coloredSection="<%= coloredSectionContent %>"></ds:titleNoImage>
      
        <%-- TODO : carte dynamique de la commune --%>      

        <%-- Partagez cette page --%>
        <%@ include file="/plugins/SoclePlugin/jsp/portal/socialNetworksShare.jspf" %>

    </article>
    
    <%-- Bannière Push --%>
    <jalios:if predicate="<%= Util.notEmpty(obj.getCityFromTheSky()) %>">        
	    <section class="ds44-container-large" id="sectionVuDuCiel">
            <ds:push title='<%= glp("jcmsplugin.socle.city.vuduciel.titre",obj.getTitle()) %>' subtitle='<%= glp("jcmsplugin.socle.city.vuduciel.soustitre") %>' linkLabel="Visiter le site" linkUrl="<%= obj.getCityFromTheSky() %>" linkTitle='<%= glp("jcmsplugin.socle.lien.site.nouvelonglet","http://vuduciel.loire-atlantique.fr") %>' newTab="true" bgstyle="triangle" />
	    </section>
    </jalios:if>
        
    <%-- Page utile --%>
    <jsp:include page="/plugins/SoclePlugin/types/PageUtileForm/editFormPageUtileForm.jsp"/>

</main>

