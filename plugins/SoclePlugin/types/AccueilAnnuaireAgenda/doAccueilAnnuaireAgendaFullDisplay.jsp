<%@ page contentType="text/html; charset=UTF-8" %><%
%><%-- This file has been automatically generated. --%><%
%><%--
  @Summary: AccueilAnnuaireAgenda display page
  @Category: Generated
  @Author: JCMS Type Processor
  @Customizable: True
  @Requestable: True
--%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% AccueilAnnuaireAgenda obj = (AccueilAnnuaireAgenda)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%
%><%@ include file='/front/doFullDisplay.jspf' %>
<div class="fullDisplay AccueilAnnuaireAgenda <%= obj.canBeEditedFieldByField(loggedMember) ? "unitFieldEdition" : "" %>" itemscope="itemscope">
<%@ include file='/front/publication/doPublicationHeader.jspf' %>
<table class="fields">
  <tr class="field imageBandeau imageEditor  <%= Util.isEmpty(obj.getImageBandeau()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(AccueilAnnuaireAgenda.class, "imageBandeau", userLang) %><jalios:edit pub='<%= obj %>' fields='imageBandeau'/></td>
    <td class='field-data' <%= gfla(obj, "imageBandeau") %>>
            <% if (Util.notEmpty(obj.getImageBandeau())) { %>
            <img src='<%= Util.encodeUrl(obj.getImageBandeau()) %>' alt='' />
            <% } %>
    </td>
  </tr>
  <tr class="field imageCarree imageEditor  <%= Util.isEmpty(obj.getImageCarree()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(AccueilAnnuaireAgenda.class, "imageCarree", userLang) %><jalios:edit pub='<%= obj %>' fields='imageCarree'/></td>
    <td class='field-data' <%= gfla(obj, "imageCarree") %>>
            <% if (Util.notEmpty(obj.getImageCarree())) { %>
            <img src='<%= Util.encodeUrl(obj.getImageCarree()) %>' alt='' />
            <% } %>
    </td>
  </tr>
  <tr class="field imageMobile imageEditor  <%= Util.isEmpty(obj.getImageMobile()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(AccueilAnnuaireAgenda.class, "imageMobile", userLang) %><jalios:edit pub='<%= obj %>' fields='imageMobile'/></td>
    <td class='field-data' <%= gfla(obj, "imageMobile") %>>
            <% if (Util.notEmpty(obj.getImageMobile())) { %>
            <img src='<%= Util.encodeUrl(obj.getImageMobile()) %>' alt='' />
            <% } %>
    </td>
  </tr>
  <tr class="field copyright textfieldEditor  <%= Util.isEmpty(obj.getCopyright()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(AccueilAnnuaireAgenda.class, "copyright", userLang) %><jalios:edit pub='<%= obj %>' fields='copyright'/></td>
    <td class='field-data' <%= gfla(obj, "copyright") %>>
            <% if (Util.notEmpty(obj.getCopyright())) { %>
            <%= obj.getCopyright() %>
            <% } %>
    </td>
  </tr>
  <tr class="field legende textfieldEditor  <%= Util.isEmpty(obj.getLegende()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(AccueilAnnuaireAgenda.class, "legende", userLang) %><jalios:edit pub='<%= obj %>' fields='legende'/></td>
    <td class='field-data' <%= gfla(obj, "legende") %>>
            <% if (Util.notEmpty(obj.getLegende())) { %>
            <%= obj.getLegende() %>
            <% } %>
    </td>
  </tr>
  <tr class="field texteAlternatif textfieldEditor  <%= Util.isEmpty(obj.getTexteAlternatif()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(AccueilAnnuaireAgenda.class, "texteAlternatif", userLang) %><jalios:edit pub='<%= obj %>' fields='texteAlternatif'/></td>
    <td class='field-data' <%= gfla(obj, "texteAlternatif") %>>
            <% if (Util.notEmpty(obj.getTexteAlternatif())) { %>
            <%= obj.getTexteAlternatif() %>
            <% } %>
    </td>
  </tr>
  <tr class="field chapo textareaEditor  <%= Util.isEmpty(obj.getChapo()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(AccueilAnnuaireAgenda.class, "chapo", userLang) %><jalios:edit pub='<%= obj %>' fields='chapo'/></td>
    <td class='field-data' <%= gfla(obj, "chapo") %>>
            <% if (Util.notEmpty(obj.getChapo())) { %>
            <%= obj.getChapo() %>
            <% } %>
    </td>
  </tr>
  <tr class="field typeAnnuaire booleanEditor  ">
    <td class='field-label'><%= channel.getTypeFieldLabel(AccueilAnnuaireAgenda.class, "typeAnnuaire", userLang) %><jalios:edit pub='<%= obj %>' fields='typeAnnuaire'/></td>
    <td class='field-data' >
            <%= obj.getTypeAnnuaireLabel(userLang) %>
    </td>
  </tr>
  <tr class="field titreParagraphe textfieldEditor  <%= Util.isEmpty(obj.getTitreParagraphe()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(AccueilAnnuaireAgenda.class, "titreParagraphe", userLang) %><jalios:edit pub='<%= obj %>' fields='titreParagraphe'/></td>
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
    <td class='field-label'><%= channel.getTypeFieldLabel(AccueilAnnuaireAgenda.class, "contenuParagraphe", userLang) %><jalios:edit pub='<%= obj %>' fields='contenuParagraphe'/></td>
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
  <tr class="field soustitreRecherche textfieldEditor  <%= Util.isEmpty(obj.getSoustitreRecherche()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(AccueilAnnuaireAgenda.class, "soustitreRecherche", userLang) %><jalios:edit pub='<%= obj %>' fields='soustitreRecherche'/></td>
    <td class='field-data' <%= gfla(obj, "soustitreRecherche") %>>
            <% if (Util.notEmpty(obj.getSoustitreRecherche())) { %>
            <%= obj.getSoustitreRecherche() %>
            <% } %>
    </td>
  </tr>
  <tr class="field introRecherche textareaEditor  <%= Util.isEmpty(obj.getIntroRecherche()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(AccueilAnnuaireAgenda.class, "introRecherche", userLang) %><jalios:edit pub='<%= obj %>' fields='introRecherche'/></td>
    <td class='field-data' <%= gfla(obj, "introRecherche") %>>
            <% if (Util.notEmpty(obj.getIntroRecherche())) { %>
            <%= obj.getIntroRecherche() %>
            <% } %>
    </td>
  </tr>
  <tr class="field portletRecherche linkEditor  <%= Util.isEmpty(obj.getPortletRecherche()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(AccueilAnnuaireAgenda.class, "portletRecherche", userLang) %><jalios:edit pub='<%= obj %>' fields='portletRecherche'/></td>
    <td class='field-data' >
            <% if (obj.getPortletRecherche() != null && obj.getPortletRecherche().canBeReadBy(loggedMember)) { %>
            <jalios:link data='<%= obj.getPortletRecherche() %>'/>
            <% } %>
    </td>
  </tr>
  <tr class="field soustitreSelectionAgenda textfieldEditor  <%= Util.isEmpty(obj.getSoustitreSelectionAgenda()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(AccueilAnnuaireAgenda.class, "soustitreSelectionAgenda", userLang) %><jalios:edit pub='<%= obj %>' fields='soustitreSelectionAgenda'/></td>
    <td class='field-data' <%= gfla(obj, "soustitreSelectionAgenda") %>>
            <% if (Util.notEmpty(obj.getSoustitreSelectionAgenda())) { %>
            <%= obj.getSoustitreSelectionAgenda() %>
            <% } %>
    </td>
  </tr>
  <tr class="field introSelectionAgenda textareaEditor  <%= Util.isEmpty(obj.getIntroSelectionAgenda()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(AccueilAnnuaireAgenda.class, "introSelectionAgenda", userLang) %><jalios:edit pub='<%= obj %>' fields='introSelectionAgenda'/></td>
    <td class='field-data' <%= gfla(obj, "introSelectionAgenda") %>>
            <% if (Util.notEmpty(obj.getIntroSelectionAgenda())) { %>
            <%= obj.getIntroSelectionAgenda() %>
            <% } %>
    </td>
  </tr>
  <tr class="field alaUneAgenda linkEditor  <%= Util.isEmpty(obj.getAlaUneAgenda()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(AccueilAnnuaireAgenda.class, "alaUneAgenda", userLang) %><jalios:edit pub='<%= obj %>' fields='alaUneAgenda'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getAlaUneAgenda())) { %>
            <ol>
              <jalios:foreach name="itData" type="com.jalios.jcms.Content" array="<%= obj.getAlaUneAgenda() %>">
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
  <tr class="field carrouselAgenda linkEditor  <%= Util.isEmpty(obj.getCarrouselAgenda()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(AccueilAnnuaireAgenda.class, "carrouselAgenda", userLang) %><jalios:edit pub='<%= obj %>' fields='carrouselAgenda'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getCarrouselAgenda())) { %>
            <ol>
              <jalios:foreach name="itData" type="com.jalios.jcms.Content" array="<%= obj.getCarrouselAgenda() %>">
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
  <tr class="field titreEncadresLibres textfieldEditor  <%= Util.isEmpty(obj.getTitreEncadresLibres()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(AccueilAnnuaireAgenda.class, "titreEncadresLibres", userLang) %><jalios:edit pub='<%= obj %>' fields='titreEncadresLibres'/></td>
    <td class='field-data' <%= gfla(obj, "titreEncadresLibres") %>>
        <% if (Util.notEmpty(obj.getTitreEncadresLibres())) { %>
            <ol>
            <jalios:foreach name="itString" type="String" array="<%= obj.getTitreEncadresLibres() %>">
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
  <tr class="field contenusEncadresLibres wysiwygEditor  <%= Util.isEmpty(obj.getContenusEncadresLibres()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(AccueilAnnuaireAgenda.class, "contenusEncadresLibres", userLang) %><jalios:edit pub='<%= obj %>' fields='contenusEncadresLibres'/></td>
    <td class='field-data' <%= gfla(obj, "contenusEncadresLibres") %>>
        <% if (Util.notEmpty(obj.getContenusEncadresLibres())) { %>
            <ol>
            <jalios:foreach name="itString" type="String" array="<%= obj.getContenusEncadresLibres() %>">
            <% if (Util.notEmpty(itString)) { %>
              <li>
              <jalios:wysiwyg data='<%= obj %>' field='contenusEncadresLibres'><%= itString %></jalios:wysiwyg>
              </li>
            <% } %>
            </jalios:foreach>
            </ol>
        <% } %>
    </td>
  </tr>
  <tr class="field portletsEncadres linkEditor  <%= Util.isEmpty(obj.getPortletsEncadres()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(AccueilAnnuaireAgenda.class, "portletsEncadres", userLang) %><jalios:edit pub='<%= obj %>' fields='portletsEncadres'/></td>
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
  <tr class="field faq linkEditor  <%= Util.isEmpty(obj.getFaq()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(AccueilAnnuaireAgenda.class, "faq", userLang) %><jalios:edit pub='<%= obj %>' fields='faq'/></td>
    <td class='field-data' >
            <% if (obj.getFaq() != null && obj.getFaq().canBeReadBy(loggedMember)) { %>
            <jalios:link data='<%= obj.getFaq() %>'/>
            <% } %>
    </td>
  </tr>
  <tr class="field portletsBas linkEditor  <%= Util.isEmpty(obj.getPortletsBas()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(AccueilAnnuaireAgenda.class, "portletsBas", userLang) %><jalios:edit pub='<%= obj %>' fields='portletsBas'/></td>
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
    <td class='field-label'><%= channel.getTypeFieldLabel(AccueilAnnuaireAgenda.class, "categorieDeNavigation", userLang) %><jalios:edit pub='<%= obj %>' fields='categorieDeNavigation'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getCategorieDeNavigation(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getCategorieDeNavigation(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("j_5"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field miseEnAvant categoryEditor  <%= Util.isEmpty(obj.getMiseEnAvant(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(AccueilAnnuaireAgenda.class, "miseEnAvant", userLang) %><jalios:edit pub='<%= obj %>' fields='miseEnAvant'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getMiseEnAvant(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getMiseEnAvant(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("c_1154084"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
 
</table>
<jsp:include page="/front/doFullDisplayCommonFields.jsp" />
</div><%-- **********4A616C696F73204A434D53 *** SIGNATURE BOUNDARY * DO NOT EDIT ANYTHING BELOW THIS LINE *** --%><%
%><%-- U6HjJnnVxVJEMOluEdYL2w== --%>