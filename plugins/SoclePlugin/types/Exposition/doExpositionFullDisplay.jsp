<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% Exposition obj = (Exposition)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%
%><%@ include file='/front/doFullDisplay.jspf' %>
<div class="fullDisplay Exposition <%= obj.canBeEditedFieldByField(loggedMember) ? "unitFieldEdition" : "" %>" itemscope="itemscope">
<%@ include file='/front/publication/doPublicationHeader.jspf' %>
<table class="fields">
  <tr class="field soustitre textfieldEditor  <%= Util.isEmpty(obj.getSoustitre(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(Exposition.class, "soustitre", userLang) %><jalios:edit pub='<%= obj %>' fields='soustitre'/></td>
    <td class='field-data' <%= gfla(obj, "soustitre") %>>
            <% if (Util.notEmpty(obj.getSoustitre(userLang))) { %>
            <%= obj.getSoustitre(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field imagePrincipale imageEditor  <%= Util.isEmpty(obj.getImagePrincipale(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(Exposition.class, "imagePrincipale", userLang) %><jalios:edit pub='<%= obj %>' fields='imagePrincipale'/></td>
    <td class='field-data' <%= gfla(obj, "imagePrincipale") %>>
            <% if (Util.notEmpty(obj.getImagePrincipale(userLang))) { %>
            <img src='<%= Util.encodeUrl(obj.getImagePrincipale(userLang)) %>' alt='' />
            <% } %>
    </td>
  </tr>
  <tr class="field imageMobile imageEditor  <%= Util.isEmpty(obj.getImageMobile(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(Exposition.class, "imageMobile", userLang) %><jalios:edit pub='<%= obj %>' fields='imageMobile'/></td>
    <td class='field-data' <%= gfla(obj, "imageMobile") %>>
            <% if (Util.notEmpty(obj.getImageMobile(userLang))) { %>
            <img src='<%= Util.encodeUrl(obj.getImageMobile(userLang)) %>' alt='' />
            <% } %>
    </td>
  </tr>
  <tr class="field texteAlternatif textfieldEditor  <%= Util.isEmpty(obj.getTexteAlternatif(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(Exposition.class, "texteAlternatif", userLang) %><jalios:edit pub='<%= obj %>' fields='texteAlternatif'/></td>
    <td class='field-data' <%= gfla(obj, "texteAlternatif") %>>
            <% if (Util.notEmpty(obj.getTexteAlternatif(userLang))) { %>
            <%= obj.getTexteAlternatif(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field titreIntro textfieldEditor  <%= Util.isEmpty(obj.getTitreIntro(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(Exposition.class, "titreIntro", userLang) %><jalios:edit pub='<%= obj %>' fields='titreIntro'/></td>
    <td class='field-data' <%= gfla(obj, "titreIntro") %>>
            <% if (Util.notEmpty(obj.getTitreIntro(userLang))) { %>
            <%= obj.getTitreIntro(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field chapo textareaEditor  <%= Util.isEmpty(obj.getChapo(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(Exposition.class, "chapo", userLang) %><jalios:edit pub='<%= obj %>' fields='chapo'/></td>
    <td class='field-data' <%= gfla(obj, "chapo") %>>
            <% if (Util.notEmpty(obj.getChapo(userLang))) { %>
            <%= obj.getChapo(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field contenuIntro wysiwygEditor  <%= Util.isEmpty(obj.getContenuIntro(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(Exposition.class, "contenuIntro", userLang) %><jalios:edit pub='<%= obj %>' fields='contenuIntro'/></td>
    <td class='field-data' <%= gfla(obj, "contenuIntro") %>>
            <% if (Util.notEmpty(obj.getContenuIntro(userLang))) { %>
            <jalios:wysiwyg data='<%= obj %>' field='contenuIntro'><%= obj.getContenuIntro(userLang) %></jalios:wysiwyg>            
            <% } %>
    </td>
  </tr>
  <tr class="field titreInfosPratiques textfieldEditor  <%= Util.isEmpty(obj.getTitreInfosPratiques(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(Exposition.class, "titreInfosPratiques", userLang) %><jalios:edit pub='<%= obj %>' fields='titreInfosPratiques'/></td>
    <td class='field-data' <%= gfla(obj, "titreInfosPratiques") %>>
            <% if (Util.notEmpty(obj.getTitreInfosPratiques(userLang))) { %>
            <%= obj.getTitreInfosPratiques(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field titreHoraires textfieldEditor  <%= Util.isEmpty(obj.getTitreHoraires(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(Exposition.class, "titreHoraires", userLang) %><jalios:edit pub='<%= obj %>' fields='titreHoraires'/></td>
    <td class='field-data' <%= gfla(obj, "titreHoraires") %>>
            <% if (Util.notEmpty(obj.getTitreHoraires(userLang))) { %>
            <%= obj.getTitreHoraires(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field horaires wysiwygEditor  <%= Util.isEmpty(obj.getHoraires(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(Exposition.class, "horaires", userLang) %><jalios:edit pub='<%= obj %>' fields='horaires'/></td>
    <td class='field-data' <%= gfla(obj, "horaires") %>>
            <% if (Util.notEmpty(obj.getHoraires(userLang))) { %>
            <jalios:wysiwyg data='<%= obj %>' field='horaires'><%= obj.getHoraires(userLang) %></jalios:wysiwyg>            
            <% } %>
    </td>
  </tr>
  <tr class="field titreTarifs textfieldEditor  <%= Util.isEmpty(obj.getTitreTarifs(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(Exposition.class, "titreTarifs", userLang) %><jalios:edit pub='<%= obj %>' fields='titreTarifs'/></td>
    <td class='field-data' <%= gfla(obj, "titreTarifs") %>>
            <% if (Util.notEmpty(obj.getTitreTarifs(userLang))) { %>
            <%= obj.getTitreTarifs(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field tarifs wysiwygEditor  <%= Util.isEmpty(obj.getTarifs(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(Exposition.class, "tarifs", userLang) %><jalios:edit pub='<%= obj %>' fields='tarifs'/></td>
    <td class='field-data' <%= gfla(obj, "tarifs") %>>
            <% if (Util.notEmpty(obj.getTarifs(userLang))) { %>
            <jalios:wysiwyg data='<%= obj %>' field='tarifs'><%= obj.getTarifs(userLang) %></jalios:wysiwyg>            
            <% } %>
    </td>
  </tr>
  <tr class="field titreContacts textfieldEditor  <%= Util.isEmpty(obj.getTitreContacts(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(Exposition.class, "titreContacts", userLang) %><jalios:edit pub='<%= obj %>' fields='titreContacts'/></td>
    <td class='field-data' <%= gfla(obj, "titreContacts") %>>
            <% if (Util.notEmpty(obj.getTitreContacts(userLang))) { %>
            <%= obj.getTitreContacts(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field contactsEtReservation wysiwygEditor  <%= Util.isEmpty(obj.getContactsEtReservation(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(Exposition.class, "contactsEtReservation", userLang) %><jalios:edit pub='<%= obj %>' fields='contactsEtReservation'/></td>
    <td class='field-data' <%= gfla(obj, "contactsEtReservation") %>>
            <% if (Util.notEmpty(obj.getContactsEtReservation(userLang))) { %>
            <jalios:wysiwyg data='<%= obj %>' field='contactsEtReservation'><%= obj.getContactsEtReservation(userLang) %></jalios:wysiwyg>            
            <% } %>
    </td>
  </tr>
  <tr class="field urlReservation urlEditor  <%= Util.isEmpty(obj.getUrlReservation(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(Exposition.class, "urlReservation", userLang) %><jalios:edit pub='<%= obj %>' fields='urlReservation'/></td>
    <td class='field-data' <%= gfla(obj, "urlReservation") %>>
            <% if (Util.notEmpty(obj.getUrlReservation(userLang))) { %>
            <a href='<%= obj.getUrlReservation(userLang) %>' ><%= obj.getUrlReservation(userLang)%></a>
            <% } %>
    </td>
  </tr>
  <tr class="field texteAlternatifReservation textfieldEditor  <%= Util.isEmpty(obj.getTexteAlternatifReservation(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(Exposition.class, "texteAlternatifReservation", userLang) %><jalios:edit pub='<%= obj %>' fields='texteAlternatifReservation'/></td>
    <td class='field-data' <%= gfla(obj, "texteAlternatifReservation") %>>
            <% if (Util.notEmpty(obj.getTexteAlternatifReservation(userLang))) { %>
            <%= obj.getTexteAlternatifReservation(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field titreInfosLibres textfieldEditor  <%= Util.isEmpty(obj.getTitreInfosLibres(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(Exposition.class, "titreInfosLibres", userLang) %><jalios:edit pub='<%= obj %>' fields='titreInfosLibres'/></td>
    <td class='field-data' <%= gfla(obj, "titreInfosLibres") %>>
            <% if (Util.notEmpty(obj.getTitreInfosLibres(userLang))) { %>
            <%= obj.getTitreInfosLibres(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field contenuInfosLibres wysiwygEditor  <%= Util.isEmpty(obj.getContenuInfosLibres(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(Exposition.class, "contenuInfosLibres", userLang) %><jalios:edit pub='<%= obj %>' fields='contenuInfosLibres'/></td>
    <td class='field-data' <%= gfla(obj, "contenuInfosLibres") %>>
            <% if (Util.notEmpty(obj.getContenuInfosLibres(userLang))) { %>
            <jalios:wysiwyg data='<%= obj %>' field='contenuInfosLibres'><%= obj.getContenuInfosLibres(userLang) %></jalios:wysiwyg>            
            <% } %>
    </td>
  </tr>
  <tr class="field details wysiwygEditor  <%= Util.isEmpty(obj.getDetails(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(Exposition.class, "details", userLang) %><jalios:edit pub='<%= obj %>' fields='details'/></td>
    <td class='field-data' <%= gfla(obj, "details") %>>
            <% if (Util.notEmpty(obj.getDetails(userLang))) { %>
            <jalios:wysiwyg data='<%= obj %>' field='details'><%= obj.getDetails(userLang) %></jalios:wysiwyg>            
            <% } %>
    </td>
  </tr>
  <tr class="field lienVersPortletsBas linkEditor  <%= Util.isEmpty(obj.getLienVersPortletsBas()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(Exposition.class, "lienVersPortletsBas", userLang) %><jalios:edit pub='<%= obj %>' fields='lienVersPortletsBas'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getLienVersPortletsBas())) { %>
            <ol>
              <jalios:foreach name="itData" type="com.jalios.jcms.portlet.PortalElement" array="<%= obj.getLienVersPortletsBas() %>">
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
  <tr class="field details2 wysiwygEditor  <%= Util.isEmpty(obj.getDetails2(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(Exposition.class, "details2", userLang) %><jalios:edit pub='<%= obj %>' fields='details2'/></td>
    <td class='field-data' <%= gfla(obj, "details2") %>>
            <% if (Util.notEmpty(obj.getDetails2(userLang))) { %>
            <jalios:wysiwyg data='<%= obj %>' field='details2'><%= obj.getDetails2(userLang) %></jalios:wysiwyg>            
            <% } %>
    </td>
  </tr>
 
</table>
<jsp:include page="/front/doFullDisplayCommonFields.jsp" />
</div>