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
  <tr class="field chapo wysiwygEditor  <%= Util.isEmpty(obj.getChapo(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheArticle.class, "chapo", userLang) %><jalios:edit pub='<%= obj %>' fields='chapo'/></td>
    <td class='field-data' <%= gfla(obj, "chapo") %>>
            <% if (Util.notEmpty(obj.getChapo(userLang))) { %>
            <jalios:wysiwyg data='<%= obj %>' field='chapo'><%= obj.getChapo(userLang) %></jalios:wysiwyg>            
            <% } %>
    </td>
  </tr>
  <tr class="field typeSimple booleanEditor  ">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheArticle.class, "typeSimple", userLang) %><jalios:edit pub='<%= obj %>' fields='typeSimple'/></td>
    <td class='field-data' >
            <%= obj.getTypeSimpleLabel(userLang) %>
    </td>
  </tr>
  <tr class="field encadresCommuns booleanEditor  ">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheArticle.class, "encadresCommuns", userLang) %><jalios:edit pub='<%= obj %>' fields='encadresCommuns'/></td>
    <td class='field-data' >
            <%= obj.getEncadresCommunsLabel(userLang) %>
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
  <tr class="field titreParagrapheOnglet_1 textfieldEditor  <%= Util.isEmpty(obj.getTitreParagrapheOnglet_1()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheArticle.class, "titreParagrapheOnglet_1", userLang) %><jalios:edit pub='<%= obj %>' fields='titreParagrapheOnglet_1'/></td>
    <td class='field-data' <%= gfla(obj, "titreParagrapheOnglet_1") %>>
        <% if (Util.notEmpty(obj.getTitreParagrapheOnglet_1())) { %>
            <ol>
            <jalios:foreach name="itString" type="String" array="<%= obj.getTitreParagrapheOnglet_1() %>">
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
  <tr class="field contenuParagrapheOnglet_1 wysiwygEditor  <%= Util.isEmpty(obj.getContenuParagrapheOnglet_1()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheArticle.class, "contenuParagrapheOnglet_1", userLang) %><jalios:edit pub='<%= obj %>' fields='contenuParagrapheOnglet_1'/></td>
    <td class='field-data' <%= gfla(obj, "contenuParagrapheOnglet_1") %>>
        <% if (Util.notEmpty(obj.getContenuParagrapheOnglet_1())) { %>
            <ol>
            <jalios:foreach name="itString" type="String" array="<%= obj.getContenuParagrapheOnglet_1() %>">
            <% if (Util.notEmpty(itString)) { %>
              <li>
              <jalios:wysiwyg data='<%= obj %>' field='contenuParagrapheOnglet_1'><%= itString %></jalios:wysiwyg>
              </li>
            <% } %>
            </jalios:foreach>
            </ol>
        <% } %>
    </td>
  </tr>
  <tr class="field titreEncadreLibre_1 textfieldEditor  <%= Util.isEmpty(obj.getTitreEncadreLibre_1()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheArticle.class, "titreEncadreLibre_1", userLang) %><jalios:edit pub='<%= obj %>' fields='titreEncadreLibre_1'/></td>
    <td class='field-data' <%= gfla(obj, "titreEncadreLibre_1") %>>
        <% if (Util.notEmpty(obj.getTitreEncadreLibre_1())) { %>
            <ol>
            <jalios:foreach name="itString" type="String" array="<%= obj.getTitreEncadreLibre_1() %>">
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
  <tr class="field contenuEncadreLibre_1 wysiwygEditor  <%= Util.isEmpty(obj.getContenuEncadreLibre_1()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheArticle.class, "contenuEncadreLibre_1", userLang) %><jalios:edit pub='<%= obj %>' fields='contenuEncadreLibre_1'/></td>
    <td class='field-data' <%= gfla(obj, "contenuEncadreLibre_1") %>>
        <% if (Util.notEmpty(obj.getContenuEncadreLibre_1())) { %>
            <ol>
            <jalios:foreach name="itString" type="String" array="<%= obj.getContenuEncadreLibre_1() %>">
            <% if (Util.notEmpty(itString)) { %>
              <li>
              <jalios:wysiwyg data='<%= obj %>' field='contenuEncadreLibre_1'><%= itString %></jalios:wysiwyg>
              </li>
            <% } %>
            </jalios:foreach>
            </ol>
        <% } %>
    </td>
  </tr>
  <tr class="field portletsEncadres_1 linkEditor  <%= Util.isEmpty(obj.getPortletsEncadres_1()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheArticle.class, "portletsEncadres_1", userLang) %><jalios:edit pub='<%= obj %>' fields='portletsEncadres_1'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getPortletsEncadres_1())) { %>
            <ol>
              <jalios:foreach name="itData" type="com.jalios.jcms.portlet.PortalElement" array="<%= obj.getPortletsEncadres_1() %>">
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
  <tr class="field titreParagrapheOnglet_2 textfieldEditor  <%= Util.isEmpty(obj.getTitreParagrapheOnglet_2()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheArticle.class, "titreParagrapheOnglet_2", userLang) %><jalios:edit pub='<%= obj %>' fields='titreParagrapheOnglet_2'/></td>
    <td class='field-data' <%= gfla(obj, "titreParagrapheOnglet_2") %>>
        <% if (Util.notEmpty(obj.getTitreParagrapheOnglet_2())) { %>
            <ol>
            <jalios:foreach name="itString" type="String" array="<%= obj.getTitreParagrapheOnglet_2() %>">
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
  <tr class="field contenuParagrapheOnglet_2 wysiwygEditor  <%= Util.isEmpty(obj.getContenuParagrapheOnglet_2()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheArticle.class, "contenuParagrapheOnglet_2", userLang) %><jalios:edit pub='<%= obj %>' fields='contenuParagrapheOnglet_2'/></td>
    <td class='field-data' <%= gfla(obj, "contenuParagrapheOnglet_2") %>>
        <% if (Util.notEmpty(obj.getContenuParagrapheOnglet_2())) { %>
            <ol>
            <jalios:foreach name="itString" type="String" array="<%= obj.getContenuParagrapheOnglet_2() %>">
            <% if (Util.notEmpty(itString)) { %>
              <li>
              <jalios:wysiwyg data='<%= obj %>' field='contenuParagrapheOnglet_2'><%= itString %></jalios:wysiwyg>
              </li>
            <% } %>
            </jalios:foreach>
            </ol>
        <% } %>
    </td>
  </tr>
  <tr class="field titreEncadreLibre_2 textfieldEditor  <%= Util.isEmpty(obj.getTitreEncadreLibre_2()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheArticle.class, "titreEncadreLibre_2", userLang) %><jalios:edit pub='<%= obj %>' fields='titreEncadreLibre_2'/></td>
    <td class='field-data' <%= gfla(obj, "titreEncadreLibre_2") %>>
        <% if (Util.notEmpty(obj.getTitreEncadreLibre_2())) { %>
            <ol>
            <jalios:foreach name="itString" type="String" array="<%= obj.getTitreEncadreLibre_2() %>">
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
  <tr class="field contenuEncadreLibre_2 wysiwygEditor  <%= Util.isEmpty(obj.getContenuEncadreLibre_2()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheArticle.class, "contenuEncadreLibre_2", userLang) %><jalios:edit pub='<%= obj %>' fields='contenuEncadreLibre_2'/></td>
    <td class='field-data' <%= gfla(obj, "contenuEncadreLibre_2") %>>
        <% if (Util.notEmpty(obj.getContenuEncadreLibre_2())) { %>
            <ol>
            <jalios:foreach name="itString" type="String" array="<%= obj.getContenuEncadreLibre_2() %>">
            <% if (Util.notEmpty(itString)) { %>
              <li>
              <jalios:wysiwyg data='<%= obj %>' field='contenuEncadreLibre_2'><%= itString %></jalios:wysiwyg>
              </li>
            <% } %>
            </jalios:foreach>
            </ol>
        <% } %>
    </td>
  </tr>
  <tr class="field portletsEncadres_2 linkEditor  <%= Util.isEmpty(obj.getPortletsEncadres_2()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheArticle.class, "portletsEncadres_2", userLang) %><jalios:edit pub='<%= obj %>' fields='portletsEncadres_2'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getPortletsEncadres_2())) { %>
            <ol>
              <jalios:foreach name="itData" type="com.jalios.jcms.portlet.PortalElement" array="<%= obj.getPortletsEncadres_2() %>">
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
  <tr class="field titreParagrapheOnglet_3 textfieldEditor  <%= Util.isEmpty(obj.getTitreParagrapheOnglet_3()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheArticle.class, "titreParagrapheOnglet_3", userLang) %><jalios:edit pub='<%= obj %>' fields='titreParagrapheOnglet_3'/></td>
    <td class='field-data' <%= gfla(obj, "titreParagrapheOnglet_3") %>>
        <% if (Util.notEmpty(obj.getTitreParagrapheOnglet_3())) { %>
            <ol>
            <jalios:foreach name="itString" type="String" array="<%= obj.getTitreParagrapheOnglet_3() %>">
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
  <tr class="field contenuParagrapheOnglet_3 wysiwygEditor  <%= Util.isEmpty(obj.getContenuParagrapheOnglet_3()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheArticle.class, "contenuParagrapheOnglet_3", userLang) %><jalios:edit pub='<%= obj %>' fields='contenuParagrapheOnglet_3'/></td>
    <td class='field-data' <%= gfla(obj, "contenuParagrapheOnglet_3") %>>
        <% if (Util.notEmpty(obj.getContenuParagrapheOnglet_3())) { %>
            <ol>
            <jalios:foreach name="itString" type="String" array="<%= obj.getContenuParagrapheOnglet_3() %>">
            <% if (Util.notEmpty(itString)) { %>
              <li>
              <jalios:wysiwyg data='<%= obj %>' field='contenuParagrapheOnglet_3'><%= itString %></jalios:wysiwyg>
              </li>
            <% } %>
            </jalios:foreach>
            </ol>
        <% } %>
    </td>
  </tr>
  <tr class="field titreEncadreLibre_3 textfieldEditor  <%= Util.isEmpty(obj.getTitreEncadreLibre_3()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheArticle.class, "titreEncadreLibre_3", userLang) %><jalios:edit pub='<%= obj %>' fields='titreEncadreLibre_3'/></td>
    <td class='field-data' <%= gfla(obj, "titreEncadreLibre_3") %>>
        <% if (Util.notEmpty(obj.getTitreEncadreLibre_3())) { %>
            <ol>
            <jalios:foreach name="itString" type="String" array="<%= obj.getTitreEncadreLibre_3() %>">
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
  <tr class="field contenuEncadreLibre_3 wysiwygEditor  <%= Util.isEmpty(obj.getContenuEncadreLibre_3()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheArticle.class, "contenuEncadreLibre_3", userLang) %><jalios:edit pub='<%= obj %>' fields='contenuEncadreLibre_3'/></td>
    <td class='field-data' <%= gfla(obj, "contenuEncadreLibre_3") %>>
        <% if (Util.notEmpty(obj.getContenuEncadreLibre_3())) { %>
            <ol>
            <jalios:foreach name="itString" type="String" array="<%= obj.getContenuEncadreLibre_3() %>">
            <% if (Util.notEmpty(itString)) { %>
              <li>
              <jalios:wysiwyg data='<%= obj %>' field='contenuEncadreLibre_3'><%= itString %></jalios:wysiwyg>
              </li>
            <% } %>
            </jalios:foreach>
            </ol>
        <% } %>
    </td>
  </tr>
  <tr class="field portletsEncadres_3 linkEditor  <%= Util.isEmpty(obj.getPortletsEncadres_3()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheArticle.class, "portletsEncadres_3", userLang) %><jalios:edit pub='<%= obj %>' fields='portletsEncadres_3'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getPortletsEncadres_3())) { %>
            <ol>
              <jalios:foreach name="itData" type="com.jalios.jcms.portlet.PortalElement" array="<%= obj.getPortletsEncadres_3() %>">
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
  <tr class="field titreParagrapheOnglet_4 textfieldEditor  <%= Util.isEmpty(obj.getTitreParagrapheOnglet_4()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheArticle.class, "titreParagrapheOnglet_4", userLang) %><jalios:edit pub='<%= obj %>' fields='titreParagrapheOnglet_4'/></td>
    <td class='field-data' <%= gfla(obj, "titreParagrapheOnglet_4") %>>
        <% if (Util.notEmpty(obj.getTitreParagrapheOnglet_4())) { %>
            <ol>
            <jalios:foreach name="itString" type="String" array="<%= obj.getTitreParagrapheOnglet_4() %>">
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
  <tr class="field contenuParagrapheOnglet_4 wysiwygEditor  <%= Util.isEmpty(obj.getContenuParagrapheOnglet_4()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheArticle.class, "contenuParagrapheOnglet_4", userLang) %><jalios:edit pub='<%= obj %>' fields='contenuParagrapheOnglet_4'/></td>
    <td class='field-data' <%= gfla(obj, "contenuParagrapheOnglet_4") %>>
        <% if (Util.notEmpty(obj.getContenuParagrapheOnglet_4())) { %>
            <ol>
            <jalios:foreach name="itString" type="String" array="<%= obj.getContenuParagrapheOnglet_4() %>">
            <% if (Util.notEmpty(itString)) { %>
              <li>
              <jalios:wysiwyg data='<%= obj %>' field='contenuParagrapheOnglet_4'><%= itString %></jalios:wysiwyg>
              </li>
            <% } %>
            </jalios:foreach>
            </ol>
        <% } %>
    </td>
  </tr>
  <tr class="field titreEncadreLibre_4 textfieldEditor  <%= Util.isEmpty(obj.getTitreEncadreLibre_4()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheArticle.class, "titreEncadreLibre_4", userLang) %><jalios:edit pub='<%= obj %>' fields='titreEncadreLibre_4'/></td>
    <td class='field-data' <%= gfla(obj, "titreEncadreLibre_4") %>>
        <% if (Util.notEmpty(obj.getTitreEncadreLibre_4())) { %>
            <ol>
            <jalios:foreach name="itString" type="String" array="<%= obj.getTitreEncadreLibre_4() %>">
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
  <tr class="field contenuEncadreLibre_4 wysiwygEditor  <%= Util.isEmpty(obj.getContenuEncadreLibre_4()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheArticle.class, "contenuEncadreLibre_4", userLang) %><jalios:edit pub='<%= obj %>' fields='contenuEncadreLibre_4'/></td>
    <td class='field-data' <%= gfla(obj, "contenuEncadreLibre_4") %>>
        <% if (Util.notEmpty(obj.getContenuEncadreLibre_4())) { %>
            <ol>
            <jalios:foreach name="itString" type="String" array="<%= obj.getContenuEncadreLibre_4() %>">
            <% if (Util.notEmpty(itString)) { %>
              <li>
              <jalios:wysiwyg data='<%= obj %>' field='contenuEncadreLibre_4'><%= itString %></jalios:wysiwyg>
              </li>
            <% } %>
            </jalios:foreach>
            </ol>
        <% } %>
    </td>
  </tr>
  <tr class="field portletsEncadres_4 linkEditor  <%= Util.isEmpty(obj.getPortletsEncadres_4()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheArticle.class, "portletsEncadres_4", userLang) %><jalios:edit pub='<%= obj %>' fields='portletsEncadres_4'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getPortletsEncadres_4())) { %>
            <ol>
              <jalios:foreach name="itData" type="com.jalios.jcms.portlet.PortalElement" array="<%= obj.getPortletsEncadres_4() %>">
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
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichearticle.annuaires.root"), " > ", true, userLang) %></a><% } %></li>
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
  <tr class="field toutesLesCommunesDuDepartement booleanEditor  ">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheArticle.class, "toutesLesCommunesDuDepartement", userLang) %><jalios:edit pub='<%= obj %>' fields='toutesLesCommunesDuDepartement'/></td>
    <td class='field-data' >
            <%= obj.getToutesLesCommunesDuDepartementLabel(userLang) %>
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