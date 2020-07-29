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
            
            <jalios:if predicate='<%= Util.notEmpty(obj.getMayor()) %>'>
                <p role="heading" aria-level="3" class="ds44-box-heading"><%= glp("jcmsplugin.socle.maire") %></p>
                <div class="ds44-docListElem mts"><i class="icon icon-user ds44-docListIco" aria-hidden="true"></i><jalios:wysiwyg><%= obj.getMayor() %></jalios:wysiwyg></div>
            </jalios:if>
        
        </div>
    </div>
</jalios:buffer>

<main id="content" role="main">
    <article class="ds44-container-large">
    
        <ds:titleNoImage title="<%= obj.getTitle(userLang) %>" breadcrumb="true" coloredSection="<%= coloredSectionContent %>"></ds:titleNoImage>
      
        <section class="ds44-contenuArticle" id="section1">
            <div class="ds44-inner-container">
                <div class="ds44-grid12-offset-2">
                    <div class="grid-2-small-1">
                    

                        
                  </div>
                </div>
            </div>
        </section>
        
        <%-- TODO : bloc des réseaux sociaux --%>

    </article>
</main>




<div class="fullDisplay City <%= obj.canBeEditedFieldByField(loggedMember) ? "unitFieldEdition" : "" %>" itemscope="itemscope">
<%@ include file='/front/publication/doPublicationHeader.jspf' %>
<table class="fields">
  <tr class="field cityCode intEditor  ">
    <td class='field-label'><%= channel.getTypeFieldLabel(City.class, "cityCode", userLang) %><jalios:edit pub='<%= obj %>' fields='cityCode'/></td>
    <td class='field-data' >
            <% /* %>123456789<% */ %><%= NumberFormat.getInstance(userLocale).format(obj.getCityCode()) %>
    </td>
  </tr>
  <tr class="field mayor textfieldEditor  <%= Util.isEmpty(obj.getMayor()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(City.class, "mayor", userLang) %><jalios:edit pub='<%= obj %>' fields='mayor'/></td>
    <td class='field-data' <%= gfla(obj, "mayor") %>>
            <% if (Util.notEmpty(obj.getMayor())) { %>
            <%= obj.getMayor() %>
            <% } %>
    </td>
  </tr>
  <tr class="field councilBuildingAddress textareaEditor  <%= Util.isEmpty(obj.getCouncilBuildingAddress(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(City.class, "councilBuildingAddress", userLang) %><jalios:edit pub='<%= obj %>' fields='councilBuildingAddress'/></td>
    <td class='field-data' <%= gfla(obj, "councilBuildingAddress") %>>
            <% if (Util.notEmpty(obj.getCouncilBuildingAddress(userLang))) { %>
            <jalios:wiki><%= obj.getCouncilBuildingAddress(userLang) %></jalios:wiki>
            <% } %>
    </td>
  </tr>
  <tr class="field postalBox textfieldEditor  <%= Util.isEmpty(obj.getPostalBox(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(City.class, "postalBox", userLang) %><jalios:edit pub='<%= obj %>' fields='postalBox'/></td>
    <td class='field-data' <%= gfla(obj, "postalBox") %>>
            <% if (Util.notEmpty(obj.getPostalBox(userLang))) { %>
            <%= obj.getPostalBox(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field zipCode textfieldEditor  <%= Util.isEmpty(obj.getZipCode()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(City.class, "zipCode", userLang) %><jalios:edit pub='<%= obj %>' fields='zipCode'/></td>
    <td class='field-data' <%= gfla(obj, "zipCode") %>>
            <% if (Util.notEmpty(obj.getZipCode())) { %>
            <%= obj.getZipCode() %>
            <% } %>
    </td>
  </tr>
  <tr class="field codesPostaux textareaEditor  <%= Util.isEmpty(obj.getCodesPostaux()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(City.class, "codesPostaux", userLang) %><jalios:edit pub='<%= obj %>' fields='codesPostaux'/></td>
    <td class='field-data' <%= gfla(obj, "codesPostaux") %>>
            <% if (Util.notEmpty(obj.getCodesPostaux())) { %>
            <%= obj.getCodesPostaux() %>
            <% } %>
    </td>
  </tr>
  <tr class="field phones textfieldEditor  <%= Util.isEmpty(obj.getPhones(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(City.class, "phones", userLang) %><jalios:edit pub='<%= obj %>' fields='phones'/></td>
    <td class='field-data' <%= gfla(obj, "phones") %>>
        <% if (Util.notEmpty(obj.getPhones(userLang))) { %>
            <ol>
            <jalios:foreach name="itString" type="String" array="<%= obj.getPhones(userLang) %>">
            <% if (Util.notEmpty(itString)) { %>
              <li>
              <%= itString %>
              </li>
            <% } %>
            </jalios:foreach>
            </ol>
        <% } %>
    </td>
  </tr>
  <tr class="field mails emailEditor  <%= Util.isEmpty(obj.getMails()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(City.class, "mails", userLang) %><jalios:edit pub='<%= obj %>' fields='mails'/></td>
    <td class='field-data' <%= gfla(obj, "mails") %>>
        <% if (Util.notEmpty(obj.getMails())) { %>
            <ol>
            <jalios:foreach name="itString" type="String" array="<%= obj.getMails() %>">
            <% if (Util.notEmpty(itString)) { %>
              <li>
              <a href='mailto:<%= itString %>'><%= itString %></a>
              </li>
            <% } %>
            </jalios:foreach>
            </ol>
        <% } %>
    </td>
  </tr>
  <tr class="field websites urlEditor  <%= Util.isEmpty(obj.getWebsites()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(City.class, "websites", userLang) %><jalios:edit pub='<%= obj %>' fields='websites'/></td>
    <td class='field-data' <%= gfla(obj, "websites") %>>
        <% if (Util.notEmpty(obj.getWebsites())) { %>
            <ol>
            <jalios:foreach name="itString" type="String" array="<%= obj.getWebsites() %>">
            <% if (Util.notEmpty(itString)) { %>
              <li>
              <a href='<%= itString %>'><%= itString %></a>
              </li>
            <% } %>
            </jalios:foreach>
            </ol>
        <% } %>
    </td>
  </tr>
  <tr class="field closenessCities linkEditor  <%= Util.isEmpty(obj.getClosenessCities()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(City.class, "closenessCities", userLang) %><jalios:edit pub='<%= obj %>' fields='closenessCities'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getClosenessCities())) { %>
            <ol>
              <jalios:foreach name="itData" type="generated.City" array="<%= obj.getClosenessCities() %>">
              <% if (itData != null && itData.canBeReadBy(loggedMember)) { %>
              <li>
              <jalios:link data='<%= itData %>'/>
              </li>
              <% } %>
              </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field epci categoryEditor  <%= Util.isEmpty(obj.getEpci(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(City.class, "epci", userLang) %><jalios:edit pub='<%= obj %>' fields='epci'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getEpci(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getEpci(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.category.toutesLesCommunesEPCI.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field epciWebsite urlEditor  <%= Util.isEmpty(obj.getEpciWebsite()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(City.class, "epciWebsite", userLang) %><jalios:edit pub='<%= obj %>' fields='epciWebsite'/></td>
    <td class='field-data' <%= gfla(obj, "epciWebsite") %>>
            <% if (Util.notEmpty(obj.getEpciWebsite())) { %>
            <a href='<%= obj.getEpciWebsite() %>' ><%= obj.getEpciWebsite()%></a>
            <% } %>
    </td>
  </tr>
  <tr class="field canton linkEditor  <%= Util.isEmpty(obj.getCanton()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(City.class, "canton", userLang) %><jalios:edit pub='<%= obj %>' fields='canton'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getCanton())) { %>
            <ol>
              <jalios:foreach name="itData" type="generated.Canton" array="<%= obj.getCanton() %>">
              <% if (itData != null && itData.canBeReadBy(loggedMember)) { %>
              <li>
              <jalios:link data='<%= itData %>'/>
              </li>
              <% } %>
              </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field delegation linkEditor  <%= Util.isEmpty(obj.getDelegation()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(City.class, "delegation", userLang) %><jalios:edit pub='<%= obj %>' fields='delegation'/></td>
    <td class='field-data' >
            <% if (obj.getDelegation() != null && obj.getDelegation().canBeReadBy(loggedMember)) { %>
            <jalios:link data='<%= obj.getDelegation() %>'/>
            <% } %>
    </td>
  </tr>
  <tr class="field cityFromTheSky urlEditor  <%= Util.isEmpty(obj.getCityFromTheSky()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(City.class, "cityFromTheSky", userLang) %><jalios:edit pub='<%= obj %>' fields='cityFromTheSky'/></td>
    <td class='field-data' <%= gfla(obj, "cityFromTheSky") %>>
            <% if (Util.notEmpty(obj.getCityFromTheSky())) { %>
            <a href='<%= obj.getCityFromTheSky() %>' ><%= obj.getCityFromTheSky()%></a>
            <% } %>
    </td>
  </tr>
  <tr class="field nomDesCommunesDeleguees textfieldEditor  <%= Util.isEmpty(obj.getNomDesCommunesDeleguees()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(City.class, "nomDesCommunesDeleguees", userLang) %><jalios:edit pub='<%= obj %>' fields='nomDesCommunesDeleguees'/></td>
    <td class='field-data' <%= gfla(obj, "nomDesCommunesDeleguees") %>>
        <% if (Util.notEmpty(obj.getNomDesCommunesDeleguees())) { %>
            <ol>
            <jalios:foreach name="itString" type="String" array="<%= obj.getNomDesCommunesDeleguees() %>">
            <% if (Util.notEmpty(itString)) { %>
              <li>
              <%= itString %>
              </li>
            <% } %>
            </jalios:foreach>
            </ol>
        <% } %>
    </td>
  </tr>
 
</table>
<jsp:include page="/front/doFullDisplayCommonFields.jsp" />
</div><%-- **********4A616C696F73204A434D53 *** SIGNATURE BOUNDARY * DO NOT EDIT ANYTHING BELOW THIS LINE *** --%><%
%><%-- MkMJr+7x2W3aeR3TnLS/pA== --%>