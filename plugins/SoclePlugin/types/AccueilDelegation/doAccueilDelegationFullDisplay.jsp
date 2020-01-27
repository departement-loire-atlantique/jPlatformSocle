<%@ page contentType="text/html; charset=UTF-8" %><%
%><%-- This file has been automatically generated. --%><%
%><%--
  @Summary: AccueilDelegation display page
  @Category: Generated
  @Author: JCMS Type Processor
  @Customizable: True
  @Requestable: True
--%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% AccueilDelegation obj = (AccueilDelegation)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%
%><%@ include file='/front/doFullDisplay.jspf' %>
<div class="fullDisplay AccueilDelegation <%= obj.canBeEditedFieldByField(loggedMember) ? "unitFieldEdition" : "" %>" itemscope="itemscope">
<%@ include file='/front/publication/doPublicationHeader.jspf' %>
<table class="fields">
  <tr class="field imagePrincipale imageEditor  <%= Util.isEmpty(obj.getImagePrincipale()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(AccueilDelegation.class, "imagePrincipale", userLang) %><jalios:edit pub='<%= obj %>' fields='imagePrincipale'/></td>
    <td class='field-data' <%= gfla(obj, "imagePrincipale") %>>
            <% if (Util.notEmpty(obj.getImagePrincipale())) { %>
            <img src='<%= Util.encodeUrl(obj.getImagePrincipale()) %>' alt='' />
            <% } %>
    </td>
  </tr>
  <tr class="field imageCarree imageEditor  <%= Util.isEmpty(obj.getImageCarree()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(AccueilDelegation.class, "imageCarree", userLang) %><jalios:edit pub='<%= obj %>' fields='imageCarree'/></td>
    <td class='field-data' <%= gfla(obj, "imageCarree") %>>
            <% if (Util.notEmpty(obj.getImageCarree())) { %>
            <img src='<%= Util.encodeUrl(obj.getImageCarree()) %>' alt='' />
            <% } %>
    </td>
  </tr>
  <tr class="field imageMobile imageEditor  <%= Util.isEmpty(obj.getImageMobile()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(AccueilDelegation.class, "imageMobile", userLang) %><jalios:edit pub='<%= obj %>' fields='imageMobile'/></td>
    <td class='field-data' <%= gfla(obj, "imageMobile") %>>
            <% if (Util.notEmpty(obj.getImageMobile())) { %>
            <img src='<%= Util.encodeUrl(obj.getImageMobile()) %>' alt='' />
            <% } %>
    </td>
  </tr>
  <tr class="field copyright textfieldEditor  <%= Util.isEmpty(obj.getCopyright()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(AccueilDelegation.class, "copyright", userLang) %><jalios:edit pub='<%= obj %>' fields='copyright'/></td>
    <td class='field-data' <%= gfla(obj, "copyright") %>>
            <% if (Util.notEmpty(obj.getCopyright())) { %>
            <%= obj.getCopyright() %>
            <% } %>
    </td>
  </tr>
  <tr class="field legende textfieldEditor  <%= Util.isEmpty(obj.getLegende()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(AccueilDelegation.class, "legende", userLang) %><jalios:edit pub='<%= obj %>' fields='legende'/></td>
    <td class='field-data' <%= gfla(obj, "legende") %>>
            <% if (Util.notEmpty(obj.getLegende())) { %>
            <%= obj.getLegende() %>
            <% } %>
    </td>
  </tr>
  <tr class="field texteAlternatif textfieldEditor  <%= Util.isEmpty(obj.getTexteAlternatif()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(AccueilDelegation.class, "texteAlternatif", userLang) %><jalios:edit pub='<%= obj %>' fields='texteAlternatif'/></td>
    <td class='field-data' <%= gfla(obj, "texteAlternatif") %>>
            <% if (Util.notEmpty(obj.getTexteAlternatif())) { %>
            <%= obj.getTexteAlternatif() %>
            <% } %>
    </td>
  </tr>
  <tr class="field delegation linkEditor  <%= Util.isEmpty(obj.getDelegation()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(AccueilDelegation.class, "delegation", userLang) %><jalios:edit pub='<%= obj %>' fields='delegation'/></td>
    <td class='field-data' >
            <% if (obj.getDelegation() != null && obj.getDelegation().canBeReadBy(loggedMember)) { %>
            <jalios:link data='<%= obj.getDelegation() %>'/>
            <% } %>
    </td>
  </tr>
  <tr class="field imageCarte imageEditor  <%= Util.isEmpty(obj.getImageCarte()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(AccueilDelegation.class, "imageCarte", userLang) %><jalios:edit pub='<%= obj %>' fields='imageCarte'/></td>
    <td class='field-data' <%= gfla(obj, "imageCarte") %>>
            <% if (Util.notEmpty(obj.getImageCarte())) { %>
            <img src='<%= Util.encodeUrl(obj.getImageCarte()) %>' alt='' />
            <% } %>
    </td>
  </tr>
  <tr class="field titreAnnuaire textfieldEditor  <%= Util.isEmpty(obj.getTitreAnnuaire()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(AccueilDelegation.class, "titreAnnuaire", userLang) %><jalios:edit pub='<%= obj %>' fields='titreAnnuaire'/></td>
    <td class='field-data' <%= gfla(obj, "titreAnnuaire") %>>
            <% if (Util.notEmpty(obj.getTitreAnnuaire())) { %>
            <%= obj.getTitreAnnuaire() %>
            <% } %>
    </td>
  </tr>
  <tr class="field introAnnuaire textareaEditor  <%= Util.isEmpty(obj.getIntroAnnuaire()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(AccueilDelegation.class, "introAnnuaire", userLang) %><jalios:edit pub='<%= obj %>' fields='introAnnuaire'/></td>
    <td class='field-data' <%= gfla(obj, "introAnnuaire") %>>
            <% if (Util.notEmpty(obj.getIntroAnnuaire())) { %>
            <%= obj.getIntroAnnuaire() %>
            <% } %>
    </td>
  </tr>
  <tr class="field portletRecherche linkEditor  <%= Util.isEmpty(obj.getPortletRecherche()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(AccueilDelegation.class, "portletRecherche", userLang) %><jalios:edit pub='<%= obj %>' fields='portletRecherche'/></td>
    <td class='field-data' >
            <% if (obj.getPortletRecherche() != null && obj.getPortletRecherche().canBeReadBy(loggedMember)) { %>
            <jalios:link data='<%= obj.getPortletRecherche() %>'/>
            <% } %>
    </td>
  </tr>
  <tr class="field titreActus textfieldEditor  <%= Util.isEmpty(obj.getTitreActus()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(AccueilDelegation.class, "titreActus", userLang) %><jalios:edit pub='<%= obj %>' fields='titreActus'/></td>
    <td class='field-data' <%= gfla(obj, "titreActus") %>>
            <% if (Util.notEmpty(obj.getTitreActus())) { %>
            <%= obj.getTitreActus() %>
            <% } %>
    </td>
  </tr>
  <tr class="field introActus textareaEditor  <%= Util.isEmpty(obj.getIntroActus()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(AccueilDelegation.class, "introActus", userLang) %><jalios:edit pub='<%= obj %>' fields='introActus'/></td>
    <td class='field-data' <%= gfla(obj, "introActus") %>>
            <% if (Util.notEmpty(obj.getIntroActus())) { %>
            <%= obj.getIntroActus() %>
            <% } %>
    </td>
  </tr>
  <tr class="field alaUne linkEditor  <%= Util.isEmpty(obj.getAlaUne()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(AccueilDelegation.class, "alaUne", userLang) %><jalios:edit pub='<%= obj %>' fields='alaUne'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getAlaUne())) { %>
            <ol>
              <jalios:foreach name="itData" type="com.jalios.jcms.Content" array="<%= obj.getAlaUne() %>">
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
  <tr class="field carrouselActualites linkEditor  <%= Util.isEmpty(obj.getCarrouselActualites()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(AccueilDelegation.class, "carrouselActualites", userLang) %><jalios:edit pub='<%= obj %>' fields='carrouselActualites'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getCarrouselActualites())) { %>
            <ol>
              <jalios:foreach name="itData" type="com.jalios.jcms.Content" array="<%= obj.getCarrouselActualites() %>">
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
  <tr class="field titreAgenda textfieldEditor  <%= Util.isEmpty(obj.getTitreAgenda()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(AccueilDelegation.class, "titreAgenda", userLang) %><jalios:edit pub='<%= obj %>' fields='titreAgenda'/></td>
    <td class='field-data' <%= gfla(obj, "titreAgenda") %>>
            <% if (Util.notEmpty(obj.getTitreAgenda())) { %>
            <%= obj.getTitreAgenda() %>
            <% } %>
    </td>
  </tr>
  <tr class="field introAgenda textareaEditor  <%= Util.isEmpty(obj.getIntroAgenda()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(AccueilDelegation.class, "introAgenda", userLang) %><jalios:edit pub='<%= obj %>' fields='introAgenda'/></td>
    <td class='field-data' <%= gfla(obj, "introAgenda") %>>
            <% if (Util.notEmpty(obj.getIntroAgenda())) { %>
            <%= obj.getIntroAgenda() %>
            <% } %>
    </td>
  </tr>
  <tr class="field portletRechercheAgenda linkEditor  <%= Util.isEmpty(obj.getPortletRechercheAgenda()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(AccueilDelegation.class, "portletRechercheAgenda", userLang) %><jalios:edit pub='<%= obj %>' fields='portletRechercheAgenda'/></td>
    <td class='field-data' >
            <% if (obj.getPortletRechercheAgenda() != null && obj.getPortletRechercheAgenda().canBeReadBy(loggedMember)) { %>
            <jalios:link data='<%= obj.getPortletRechercheAgenda() %>'/>
            <% } %>
    </td>
  </tr>
  <tr class="field portletCarrouselAgenda linkEditor  <%= Util.isEmpty(obj.getPortletCarrouselAgenda()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(AccueilDelegation.class, "portletCarrouselAgenda", userLang) %><jalios:edit pub='<%= obj %>' fields='portletCarrouselAgenda'/></td>
    <td class='field-data' >
            <% if (obj.getPortletCarrouselAgenda() != null && obj.getPortletCarrouselAgenda().canBeReadBy(loggedMember)) { %>
            <jalios:link data='<%= obj.getPortletCarrouselAgenda() %>'/>
            <% } %>
    </td>
  </tr>
  <tr class="field portletsBas linkEditor  <%= Util.isEmpty(obj.getPortletsBas()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(AccueilDelegation.class, "portletsBas", userLang) %><jalios:edit pub='<%= obj %>' fields='portletsBas'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getPortletsBas())) { %>
            <ol>
              <jalios:foreach name="itData" type="com.jalios.jcms.portlet.PortalElement" array="<%= obj.getPortletsBas() %>">
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
  <tr class="field categorieDeNavigation categoryEditor  <%= Util.isEmpty(obj.getCategorieDeNavigation(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(AccueilDelegation.class, "categorieDeNavigation", userLang) %><jalios:edit pub='<%= obj %>' fields='categorieDeNavigation'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getCategorieDeNavigation(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getCategorieDeNavigation(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("lch_1209223"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field miseEnAvant categoryEditor  <%= Util.isEmpty(obj.getMiseEnAvant(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(AccueilDelegation.class, "miseEnAvant", userLang) %><jalios:edit pub='<%= obj %>' fields='miseEnAvant'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getMiseEnAvant(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getMiseEnAvant(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("lch_1209315"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
 
</table>
<jsp:include page="/front/doFullDisplayCommonFields.jsp" />
</div><%-- **********4A616C696F73204A434D53 *** SIGNATURE BOUNDARY * DO NOT EDIT ANYTHING BELOW THIS LINE *** --%><%
%><%-- Fsus1hUHBtwrnQUn1uJ36g== --%>