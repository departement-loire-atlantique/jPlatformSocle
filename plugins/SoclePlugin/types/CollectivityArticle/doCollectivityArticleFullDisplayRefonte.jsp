<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ page import="fr.cg44.plugin.seo.SEOUtils" %><%
%><%-- This file has been automatically generated. --%><%
%><%--
  @Summary: CollectivityArticle display page
  @Category: Generated
  @Author: JCMS Type Processor
  @Customizable: True
  @Requestable: True
--%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><%
CollectivityArticle obj = (CollectivityArticle)request.getAttribute(PortalManager.PORTAL_PUBLICATION);
boolean notEmptyFreePart = Util.notEmpty(obj.getFreePartContents());


%><%
%><%@ include file='/front/doFullDisplay.jspf' %>
<div class="fullDisplay CollectivityArticle container <%= obj.canBeEditedFieldByField(loggedMember) ? "unitFieldEdition" : "" %>" itemscope="itemscope">
<div class="row">
    <!-- Colonne principale -->
    <div class="col-md-7">
        <h1 class="publication-title" <%= gfla(obj, "title") %> itemprop="name"><%= obj.getTitle(userLang) %></h1>
        
        <% if (Util.notEmpty(obj.getSummary(userLang))) { %>
            <jalios:wiki><%= obj.getSummary(userLang) %></jalios:wiki>
        <% } %>
        
        <div>
            <% if (Util.notEmpty(obj.getDescription(userLang))) { %>
                <jalios:wysiwyg data='<%= obj %>' field='description'><%= obj.getDescription(userLang) %></jalios:wysiwyg>            
            <% } %>
        </div>
    </div>
    
    <!-- Colonne de droite -->        
    <div class="col-md-4 col-md-offset-1">
		<% if (Util.notEmpty(obj.getMainIllustration())) { %>
		  <div><img src='<%= Util.encodeUrl(obj.getMainIllustration()) %>' alt='' /></div>
		<% } %>   
		
		<% if (Util.notEmpty(obj.getMainIllustrationLegend(userLang))) { %>
            <div><%= obj.getMainIllustrationLegend(userLang) %></div>
        <% } %> 
            
        <% if (Util.notEmpty(obj.getMainIllustrationCopyright(userLang))) { %>
            <div><%= obj.getMainIllustrationCopyright(userLang) %></div>
        <% } %>
        
        
        <%// Partie Libre
          %><jalios:if predicate="<%= notEmptyFreePart %>"><%
              
              String[] freePartTitles = obj.getFreePartTitles();
              String[] freePartContents = obj.getFreePartContents();
          
            %><jalios:foreach array="<%= freePartContents %>" name="itContent" type="String" counter="itCounter"><%
             
              // Récupération du titre
              String title = "";
              if(Util.notEmpty(freePartTitles)) {
                try {
                  title = freePartTitles[itCounter - 1]; // Changement de titre si la case existe                         
                } catch(IndexOutOfBoundsException e) {
                  //Pas de traitement => Cela vient du fait que les groupes de listes ont des longueurs différentes
                }
              }             
             %>
             <div>
               <jalios:if predicate="<%= Util.notEmpty(title) %>"><h2><%= title %> <jalios:edit pub="<%= obj %>" fields="freePartTitles, freePartContents"/></h2></jalios:if>
               <jalios:if predicate="<%= Util.notEmpty(itContent) %>"><jalios:wysiwyg><%= itContent %></jalios:wysiwyg></jalios:if>
             </div>
           </jalios:foreach>
         </jalios:if>
        
    </div>
</div>



<table class="fields">


  <tr class="field description wysiwygEditor abstract <%= Util.isEmpty(obj.getDescription(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(CollectivityArticle.class, "description", userLang) %><jalios:edit pub='<%= obj %>' fields='description'/></td>
    <td class='field-data' <%= gfla(obj, "description") %>>
            
    </td>
  </tr>
  <tr class="field contactPartTitle textfieldEditor  <%= Util.isEmpty(obj.getContactPartTitle(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(CollectivityArticle.class, "contactPartTitle", userLang) %><jalios:edit pub='<%= obj %>' fields='contactPartTitle'/></td>
    <td class='field-data' <%= gfla(obj, "contactPartTitle") %>>
            <% if (Util.notEmpty(obj.getContactPartTitle(userLang))) { %>
            <%= obj.getContactPartTitle(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field placeContacts linkEditor  <%= Util.isEmpty(obj.getPlaceContacts()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(CollectivityArticle.class, "placeContacts", userLang) %><jalios:edit pub='<%= obj %>' fields='placeContacts'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getPlaceContacts())) { %>
            <ol>
              <jalios:foreach name="itData" type="generated.Place" array="<%= obj.getPlaceContacts() %>">
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
  <tr class="field contactsAdd wysiwygEditor  <%= Util.isEmpty(obj.getContactsAdd(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(CollectivityArticle.class, "contactsAdd", userLang) %><jalios:edit pub='<%= obj %>' fields='contactsAdd'/></td>
    <td class='field-data' <%= gfla(obj, "contactsAdd") %>>
            <% if (Util.notEmpty(obj.getContactsAdd(userLang))) { %>
            <jalios:wysiwyg data='<%= obj %>' field='contactsAdd'><%= obj.getContactsAdd(userLang) %></jalios:wysiwyg>            
            <% } %>
    </td>
  </tr>
  <tr class="field dga textfieldEditor  <%= Util.isEmpty(obj.getDga(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(CollectivityArticle.class, "dga", userLang) %><jalios:edit pub='<%= obj %>' fields='dga'/></td>
    <td class='field-data' <%= gfla(obj, "dga") %>>
            <% if (Util.notEmpty(obj.getDga(userLang))) { %>
            <%= obj.getDga(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field directionOrDelegation textfieldEditor  <%= Util.isEmpty(obj.getDirectionOrDelegation(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(CollectivityArticle.class, "directionOrDelegation", userLang) %><jalios:edit pub='<%= obj %>' fields='directionOrDelegation'/></td>
    <td class='field-data' <%= gfla(obj, "directionOrDelegation") %>>
            <% if (Util.notEmpty(obj.getDirectionOrDelegation(userLang))) { %>
            <%= obj.getDirectionOrDelegation(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field serviceOrAdministrativeHubOrUnit textfieldEditor  <%= Util.isEmpty(obj.getServiceOrAdministrativeHubOrUnit(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(CollectivityArticle.class, "serviceOrAdministrativeHubOrUnit", userLang) %><jalios:edit pub='<%= obj %>' fields='serviceOrAdministrativeHubOrUnit'/></td>
    <td class='field-data' <%= gfla(obj, "serviceOrAdministrativeHubOrUnit") %>>
            <% if (Util.notEmpty(obj.getServiceOrAdministrativeHubOrUnit(userLang))) { %>
            <%= obj.getServiceOrAdministrativeHubOrUnit(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field street textfieldEditor  <%= Util.isEmpty(obj.getStreet(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(CollectivityArticle.class, "street", userLang) %><jalios:edit pub='<%= obj %>' fields='street'/></td>
    <td class='field-data' <%= gfla(obj, "street") %>>
            <% if (Util.notEmpty(obj.getStreet(userLang))) { %>
            <%= obj.getStreet(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field postalBox textfieldEditor  <%= Util.isEmpty(obj.getPostalBox(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(CollectivityArticle.class, "postalBox", userLang) %><jalios:edit pub='<%= obj %>' fields='postalBox'/></td>
    <td class='field-data' <%= gfla(obj, "postalBox") %>>
            <% if (Util.notEmpty(obj.getPostalBox(userLang))) { %>
            <%= obj.getPostalBox(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field zipCode textfieldEditor  <%= Util.isEmpty(obj.getZipCode(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(CollectivityArticle.class, "zipCode", userLang) %><jalios:edit pub='<%= obj %>' fields='zipCode'/></td>
    <td class='field-data' <%= gfla(obj, "zipCode") %>>
            <% if (Util.notEmpty(obj.getZipCode(userLang))) { %>
            <%= obj.getZipCode(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field city linkEditor  <%= Util.isEmpty(obj.getCity()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(CollectivityArticle.class, "city", userLang) %><jalios:edit pub='<%= obj %>' fields='city'/></td>
    <td class='field-data' >
            <% if (obj.getCity() != null && obj.getCity().canBeReadBy(loggedMember)) { %>
            <jalios:link data='<%= obj.getCity() %>'/>
            <% } %>
    </td>
  </tr>
  <tr class="field phones textfieldEditor  <%= Util.isEmpty(obj.getPhones(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(CollectivityArticle.class, "phones", userLang) %><jalios:edit pub='<%= obj %>' fields='phones'/></td>
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
  <tr class="field fax textfieldEditor  <%= Util.isEmpty(obj.getFax(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(CollectivityArticle.class, "fax", userLang) %><jalios:edit pub='<%= obj %>' fields='fax'/></td>
    <td class='field-data' <%= gfla(obj, "fax") %>>
        <% if (Util.notEmpty(obj.getFax(userLang))) { %>
            <ol>
            <jalios:foreach name="itString" type="String" array="<%= obj.getFax(userLang) %>">
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
    <td class='field-label'><%= channel.getTypeFieldLabel(CollectivityArticle.class, "mails", userLang) %><jalios:edit pub='<%= obj %>' fields='mails'/></td>
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
    <td class='field-label'><%= channel.getTypeFieldLabel(CollectivityArticle.class, "websites", userLang) %><jalios:edit pub='<%= obj %>' fields='websites'/></td>
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
  <tr class="field placeMapListLabels textfieldEditor  <%= Util.isEmpty(obj.getPlaceMapListLabels(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(CollectivityArticle.class, "placeMapListLabels", userLang) %><jalios:edit pub='<%= obj %>' fields='placeMapListLabels'/></td>
    <td class='field-data' <%= gfla(obj, "placeMapListLabels") %>>
        <% if (Util.notEmpty(obj.getPlaceMapListLabels(userLang))) { %>
            <ol>
            <jalios:foreach name="itString" type="String" array="<%= obj.getPlaceMapListLabels(userLang) %>">
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
  <tr class="field redirecttomap linkEditor  <%= Util.isEmpty(obj.getRedirecttomap()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(CollectivityArticle.class, "redirecttomap", userLang) %><jalios:edit pub='<%= obj %>' fields='redirecttomap'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getRedirecttomap())) { %>
            <ol>
              <jalios:foreach name="itData" type="com.jalios.jcms.portlet.PortalElement" array="<%= obj.getRedirecttomap() %>">
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
  <tr class="field documentsPartTitle textfieldEditor  <%= Util.isEmpty(obj.getDocumentsPartTitle(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(CollectivityArticle.class, "documentsPartTitle", userLang) %><jalios:edit pub='<%= obj %>' fields='documentsPartTitle'/></td>
    <td class='field-data' <%= gfla(obj, "documentsPartTitle") %>>
            <% if (Util.notEmpty(obj.getDocumentsPartTitle(userLang))) { %>
            <%= obj.getDocumentsPartTitle(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field documents linkEditor  <%= Util.isEmpty(obj.getDocuments()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(CollectivityArticle.class, "documents", userLang) %><jalios:edit pub='<%= obj %>' fields='documents'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getDocuments())) { %>
            <ol>
              <jalios:foreach name="itData" type="com.jalios.jcms.FileDocument" array="<%= obj.getDocuments() %>">
              <% if (itData != null && itData.canBeReadBy(loggedMember)) { %>
              <li>
              <jalios:link data='<%= itData %>' params='details=true' ><jalios:fileicon doc='<%= itData %>' /></jalios:link>
              <jalios:link data='<%= itData %>'/>
              - <jalios:filesize doc='<%= itData %>'/>
              <jalios:pdf doc='<%= itData %>' />
              </li>
              <% } %>
              </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field webSitePartTitle textfieldEditor  <%= Util.isEmpty(obj.getWebSitePartTitle(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(CollectivityArticle.class, "webSitePartTitle", userLang) %><jalios:edit pub='<%= obj %>' fields='webSitePartTitle'/></td>
    <td class='field-data' <%= gfla(obj, "webSitePartTitle") %>>
            <% if (Util.notEmpty(obj.getWebSitePartTitle(userLang))) { %>
            <%= obj.getWebSitePartTitle(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field websiteNames textfieldEditor  <%= Util.isEmpty(obj.getWebsiteNames(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(CollectivityArticle.class, "websiteNames", userLang) %><jalios:edit pub='<%= obj %>' fields='websiteNames'/></td>
    <td class='field-data' <%= gfla(obj, "websiteNames") %>>
        <% if (Util.notEmpty(obj.getWebsiteNames(userLang))) { %>
            <ol>
            <jalios:foreach name="itString" type="String" array="<%= obj.getWebsiteNames(userLang) %>">
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
  <tr class="field websiteUrls urlEditor  <%= Util.isEmpty(obj.getWebsiteUrls()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(CollectivityArticle.class, "websiteUrls", userLang) %><jalios:edit pub='<%= obj %>' fields='websiteUrls'/></td>
    <td class='field-data' <%= gfla(obj, "websiteUrls") %>>
        <% if (Util.notEmpty(obj.getWebsiteUrls())) { %>
            <ol>
            <jalios:foreach name="itString" type="String" array="<%= obj.getWebsiteUrls() %>">
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
  <tr class="field helpPartTitle textfieldEditor  <%= Util.isEmpty(obj.getHelpPartTitle(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(CollectivityArticle.class, "helpPartTitle", userLang) %><jalios:edit pub='<%= obj %>' fields='helpPartTitle'/></td>
    <td class='field-data' <%= gfla(obj, "helpPartTitle") %>>
            <% if (Util.notEmpty(obj.getHelpPartTitle(userLang))) { %>
            <%= obj.getHelpPartTitle(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field helps linkEditor  <%= Util.isEmpty(obj.getHelps()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(CollectivityArticle.class, "helps", userLang) %><jalios:edit pub='<%= obj %>' fields='helps'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getHelps())) { %>
            <ol>
              <jalios:foreach name="itData" type="generated.Help" array="<%= obj.getHelps() %>">
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
  <tr class="field youtubeUrlPromo urlEditor  <%= Util.isEmpty(obj.getYoutubeUrlPromo()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(CollectivityArticle.class, "youtubeUrlPromo", userLang) %><jalios:edit pub='<%= obj %>' fields='youtubeUrlPromo'/></td>
    <td class='field-data' <%= gfla(obj, "youtubeUrlPromo") %>>
        <% if (Util.notEmpty(obj.getYoutubeUrlPromo())) { %>
            <ol>
            <jalios:foreach name="itString" type="String" array="<%= obj.getYoutubeUrlPromo() %>">
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
  <tr class="field dmCloudPromo textfieldEditor  <%= Util.isEmpty(obj.getDmCloudPromo()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(CollectivityArticle.class, "dmCloudPromo", userLang) %><jalios:edit pub='<%= obj %>' fields='dmCloudPromo'/></td>
    <td class='field-data' <%= gfla(obj, "dmCloudPromo") %>>
        <% if (Util.notEmpty(obj.getDmCloudPromo())) { %>
            <ol>
            <jalios:foreach name="itString" type="String" array="<%= obj.getDmCloudPromo() %>">
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
  <tr class="field mediaPromo linkEditor  <%= Util.isEmpty(obj.getMediaPromo()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(CollectivityArticle.class, "mediaPromo", userLang) %><jalios:edit pub='<%= obj %>' fields='mediaPromo'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getMediaPromo())) { %>
            <ol>
              <jalios:foreach name="itData" type="generated.CarouselElement" array="<%= obj.getMediaPromo() %>">
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
  <tr class="field topInsetPortlet linkEditor  <%= Util.isEmpty(obj.getTopInsetPortlet()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(CollectivityArticle.class, "topInsetPortlet", userLang) %><jalios:edit pub='<%= obj %>' fields='topInsetPortlet'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getTopInsetPortlet())) { %>
            <ol>
              <jalios:foreach name="itData" type="com.jalios.jcms.portlet.PortalElement" array="<%= obj.getTopInsetPortlet() %>">
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
  <tr class="field bottomInsetPortlet linkEditor  <%= Util.isEmpty(obj.getBottomInsetPortlet()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(CollectivityArticle.class, "bottomInsetPortlet", userLang) %><jalios:edit pub='<%= obj %>' fields='bottomInsetPortlet'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getBottomInsetPortlet())) { %>
            <ol>
              <jalios:foreach name="itData" type="com.jalios.jcms.portlet.PortalElement" array="<%= obj.getBottomInsetPortlet() %>">
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
 
</table>
<jsp:include page="/front/doFullDisplayCommonFields.jsp" />
</div>