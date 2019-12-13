<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% FicheArticle obj = (FicheArticle)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%
%><%@ include file='/front/doFullDisplay.jspf' %>
<div class="fullDisplay FicheArticle <%= obj.canBeEditedFieldByField(loggedMember) ? "unitFieldEdition" : "" %>" itemscope="itemscope">
<%@ include file='/front/publication/doPublicationHeader.jspf' %>
<table class="fields">
  <tr class="field imagePrincipale imageEditor  <%= Util.isEmpty(obj.getImagePrincipale()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheArticle.class, "imagePrincipale", userLang) %><jalios:edit pub='<%= obj %>' fields='imagePrincipale'/></td>
    <td class='field-data' <%= gfla(obj, "imagePrincipale") %>>
            <% if (Util.notEmpty(obj.getImagePrincipale())) { %>
            <img src='<%= Util.encodeUrl(obj.getImagePrincipale()) %>' alt='' />
            <% } %>
    </td>
  </tr>
  <tr class="field imageBandeau imageEditor  <%= Util.isEmpty(obj.getImageBandeau()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheArticle.class, "imageBandeau", userLang) %><jalios:edit pub='<%= obj %>' fields='imageBandeau'/></td>
    <td class='field-data' <%= gfla(obj, "imageBandeau") %>>
            <% if (Util.notEmpty(obj.getImageBandeau())) { %>
            <img src='<%= Util.encodeUrl(obj.getImageBandeau()) %>' alt='' />
            <% } %>
    </td>
  </tr>
  <tr class="field imageCarree imageEditor  <%= Util.isEmpty(obj.getImageCarree()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheArticle.class, "imageCarree", userLang) %><jalios:edit pub='<%= obj %>' fields='imageCarree'/></td>
    <td class='field-data' <%= gfla(obj, "imageCarree") %>>
            <% if (Util.notEmpty(obj.getImageCarree())) { %>
            <img src='<%= Util.encodeUrl(obj.getImageCarree()) %>' alt='' />
            <% } %>
    </td>
  </tr>
  <tr class="field imageMobile imageEditor  <%= Util.isEmpty(obj.getImageMobile()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheArticle.class, "imageMobile", userLang) %><jalios:edit pub='<%= obj %>' fields='imageMobile'/></td>
    <td class='field-data' <%= gfla(obj, "imageMobile") %>>
            <% if (Util.notEmpty(obj.getImageMobile())) { %>
            <img src='<%= Util.encodeUrl(obj.getImageMobile()) %>' alt='' />
            <% } %>
    </td>
  </tr>
  <tr class="field copyright textfieldEditor  <%= Util.isEmpty(obj.getCopyright()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheArticle.class, "copyright", userLang) %><jalios:edit pub='<%= obj %>' fields='copyright'/></td>
    <td class='field-data' <%= gfla(obj, "copyright") %>>
            <% if (Util.notEmpty(obj.getCopyright())) { %>
            <%= obj.getCopyright() %>
            <% } %>
    </td>
  </tr>
  <tr class="field legende textfieldEditor  <%= Util.isEmpty(obj.getLegende()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheArticle.class, "legende", userLang) %><jalios:edit pub='<%= obj %>' fields='legende'/></td>
    <td class='field-data' <%= gfla(obj, "legende") %>>
            <% if (Util.notEmpty(obj.getLegende())) { %>
            <%= obj.getLegende() %>
            <% } %>
    </td>
  </tr>
  <tr class="field texteAlternatif textfieldEditor  <%= Util.isEmpty(obj.getTexteAlternatif()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheArticle.class, "texteAlternatif", userLang) %><jalios:edit pub='<%= obj %>' fields='texteAlternatif'/></td>
    <td class='field-data' <%= gfla(obj, "texteAlternatif") %>>
            <% if (Util.notEmpty(obj.getTexteAlternatif())) { %>
            <%= obj.getTexteAlternatif() %>
            <% } %>
    </td>
  </tr>
  <tr class="field videoPrincipale linkEditor  <%= Util.isEmpty(obj.getVideoPrincipale()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheArticle.class, "videoPrincipale", userLang) %><jalios:edit pub='<%= obj %>' fields='videoPrincipale'/></td>
    <td class='field-data' >
            <% if (obj.getVideoPrincipale() != null && obj.getVideoPrincipale().canBeReadBy(loggedMember)) { %>
            <jalios:link data='<%= obj.getVideoPrincipale() %>'/>
            <% } %>
    </td>
  </tr>
  <tr class="field chapo textareaEditor  <%= Util.isEmpty(obj.getChapo()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheArticle.class, "chapo", userLang) %><jalios:edit pub='<%= obj %>' fields='chapo'/></td>
    <td class='field-data' <%= gfla(obj, "chapo") %>>
            <% if (Util.notEmpty(obj.getChapo())) { %>
            <%= obj.getChapo() %>
            <% } %>
    </td>
  </tr>
  <tr class="field typeSimple booleanEditor  ">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheArticle.class, "typeSimple", userLang) %><jalios:edit pub='<%= obj %>' fields='typeSimple'/></td>
    <td class='field-data' >
            <%= obj.getTypeSimpleLabel(userLang) %>
    </td>
  </tr>
  <tr class="field titreParagraphe textfieldEditor  <%= Util.isEmpty(obj.getTitreParagraphe()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheArticle.class, "titreParagraphe", userLang) %><jalios:edit pub='<%= obj %>' fields='titreParagraphe'/></td>
    <td class='field-data' <%= gfla(obj, "titreParagraphe") %>>
        <% if (Util.notEmpty(obj.getTitreParagraphe())) { %>
            <ol>
            <jalios:foreach name="itString" type="String" array="<%= obj.getTitreParagraphe() %>">
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
  <tr class="field contenuParagraphe wysiwygEditor  <%= Util.isEmpty(obj.getContenuParagraphe()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheArticle.class, "contenuParagraphe", userLang) %><jalios:edit pub='<%= obj %>' fields='contenuParagraphe'/></td>
    <td class='field-data' <%= gfla(obj, "contenuParagraphe") %>>
        <% if (Util.notEmpty(obj.getContenuParagraphe())) { %>
            <ol>
            <jalios:foreach name="itString" type="String" array="<%= obj.getContenuParagraphe() %>">
            <% if (Util.notEmpty(itString)) { %>
              <li>
              <jalios:wysiwyg data='<%= obj %>' field='contenuParagraphe'><%= itString %></jalios:wysiwyg>
              </li>
            <% } %>
            </jalios:foreach>
            </ol>
        <% } %>
    </td>
  </tr>
  <tr class="field titreOnglet textfieldEditor  <%= Util.isEmpty(obj.getTitreOnglet()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheArticle.class, "titreOnglet", userLang) %><jalios:edit pub='<%= obj %>' fields='titreOnglet'/></td>
    <td class='field-data' <%= gfla(obj, "titreOnglet") %>>
        <% if (Util.notEmpty(obj.getTitreOnglet())) { %>
            <ol>
            <jalios:foreach name="itString" type="String" array="<%= obj.getTitreOnglet() %>">
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
  <tr class="field contenuOnglet wysiwygEditor  <%= Util.isEmpty(obj.getContenuOnglet()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheArticle.class, "contenuOnglet", userLang) %><jalios:edit pub='<%= obj %>' fields='contenuOnglet'/></td>
    <td class='field-data' <%= gfla(obj, "contenuOnglet") %>>
        <% if (Util.notEmpty(obj.getContenuOnglet())) { %>
            <ol>
            <jalios:foreach name="itString" type="String" array="<%= obj.getContenuOnglet() %>">
            <% if (Util.notEmpty(itString)) { %>
              <li>
              <jalios:wysiwyg data='<%= obj %>' field='contenuOnglet'><%= itString %></jalios:wysiwyg>
              </li>
            <% } %>
            </jalios:foreach>
            </ol>
        <% } %>
    </td>
  </tr>
  <tr class="field titreEncadreLibre textfieldEditor  <%= Util.isEmpty(obj.getTitreEncadreLibre()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheArticle.class, "titreEncadreLibre", userLang) %><jalios:edit pub='<%= obj %>' fields='titreEncadreLibre'/></td>
    <td class='field-data' <%= gfla(obj, "titreEncadreLibre") %>>
        <% if (Util.notEmpty(obj.getTitreEncadreLibre())) { %>
            <ol>
            <jalios:foreach name="itString" type="String" array="<%= obj.getTitreEncadreLibre() %>">
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
  <tr class="field contenuEncadreLibre wysiwygEditor  <%= Util.isEmpty(obj.getContenuEncadreLibre()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheArticle.class, "contenuEncadreLibre", userLang) %><jalios:edit pub='<%= obj %>' fields='contenuEncadreLibre'/></td>
    <td class='field-data' <%= gfla(obj, "contenuEncadreLibre") %>>
        <% if (Util.notEmpty(obj.getContenuEncadreLibre())) { %>
            <ol>
            <jalios:foreach name="itString" type="String" array="<%= obj.getContenuEncadreLibre() %>">
            <% if (Util.notEmpty(itString)) { %>
              <li>
              <jalios:wysiwyg data='<%= obj %>' field='contenuEncadreLibre'><%= itString %></jalios:wysiwyg>
              </li>
            <% } %>
            </jalios:foreach>
            </ol>
        <% } %>
    </td>
  </tr>
  <tr class="field portletsEncadres linkEditor  <%= Util.isEmpty(obj.getPortletsEncadres()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheArticle.class, "portletsEncadres", userLang) %><jalios:edit pub='<%= obj %>' fields='portletsEncadres'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getPortletsEncadres())) { %>
            <ol>
              <jalios:foreach name="itData" type="com.jalios.jcms.portlet.PortalElement" array="<%= obj.getPortletsEncadres() %>">
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
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheArticle.class, "categorieDeNavigation", userLang) %><jalios:edit pub='<%= obj %>' fields='categorieDeNavigation'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getCategorieDeNavigation(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getCategorieDeNavigation(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.category.categorieDeNavigation.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field miseEnAvant categoryEditor  <%= Util.isEmpty(obj.getMiseEnAvant(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheArticle.class, "miseEnAvant", userLang) %><jalios:edit pub='<%= obj %>' fields='miseEnAvant'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getMiseEnAvant(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getMiseEnAvant(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.miseEnAvant.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field besoins categoryEditor  <%= Util.isEmpty(obj.getBesoins(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheArticle.class, "besoins", userLang) %><jalios:edit pub='<%= obj %>' fields='besoins'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getBesoins(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getBesoins(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.category.thematiquesBesoins.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field publics categoryEditor  <%= Util.isEmpty(obj.getPublics(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheArticle.class, "publics", userLang) %><jalios:edit pub='<%= obj %>' fields='publics'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getPublics(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getPublics(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.category.publicVise.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field annuaires categoryEditor  <%= Util.isEmpty(obj.getAnnuaires(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheArticle.class, "annuaires", userLang) %><jalios:edit pub='<%= obj %>' fields='annuaires'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getAnnuaires(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getAnnuaires(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("p1_1043453"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field communes linkEditor  <%= Util.isEmpty(obj.getCommunes()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheArticle.class, "communes", userLang) %><jalios:edit pub='<%= obj %>' fields='communes'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getCommunes())) { %>
            <ol>
              <jalios:foreach name="itData" type="generated.City" array="<%= obj.getCommunes() %>">
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
  <tr class="field delegations categoryEditor  <%= Util.isEmpty(obj.getDelegations(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheArticle.class, "delegations", userLang) %><jalios:edit pub='<%= obj %>' fields='delegations'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getDelegations(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getDelegations(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.category.delegations.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field epci categoryEditor  <%= Util.isEmpty(obj.getEpci(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheArticle.class, "epci", userLang) %><jalios:edit pub='<%= obj %>' fields='epci'/></td>
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
  <tr class="field toutesLesCommunesDuDepartement booleanEditor  ">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheArticle.class, "toutesLesCommunesDuDepartement", userLang) %><jalios:edit pub='<%= obj %>' fields='toutesLesCommunesDuDepartement'/></td>
    <td class='field-data' >
            <%= obj.getToutesLesCommunesDuDepartementLabel(userLang) %>
    </td>
  </tr>
  <tr class="field cantons linkEditor  <%= Util.isEmpty(obj.getCantons()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheArticle.class, "cantons", userLang) %><jalios:edit pub='<%= obj %>' fields='cantons'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getCantons())) { %>
            <ol>
              <jalios:foreach name="itData" type="generated.Canton" array="<%= obj.getCantons() %>">
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