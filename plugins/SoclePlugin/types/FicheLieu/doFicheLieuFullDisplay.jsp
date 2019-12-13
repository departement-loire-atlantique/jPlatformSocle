<%@ page contentType="text/html; charset=UTF-8" %><%
%><%-- This file has been automatically generated. --%><%
%><%--
  @Summary: FicheLieu display page
  @Category: Generated
  @Author: JCMS Type Processor
  @Customizable: True
  @Requestable: True
--%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% FicheLieu obj = (FicheLieu)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%
%><%@ include file='/front/doFullDisplay.jspf' %>
<div class="fullDisplay FicheLieu <%= obj.canBeEditedFieldByField(loggedMember) ? "unitFieldEdition" : "" %>" itemscope="itemscope">
<%@ include file='/front/publication/doPublicationHeader.jspf' %>
<table class="fields">
  <tr class="field idReferentiel textfieldEditor  <%= Util.isEmpty(obj.getIdReferentiel(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "idReferentiel", userLang) %><jalios:edit pub='<%= obj %>' fields='idReferentiel'/></td>
    <td class='field-data' <%= gfla(obj, "idReferentiel") %>>
            <% if (Util.notEmpty(obj.getIdReferentiel(userLang))) { %>
            <%= obj.getIdReferentiel(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field soustitre textfieldEditor  <%= Util.isEmpty(obj.getSoustitre(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "soustitre", userLang) %><jalios:edit pub='<%= obj %>' fields='soustitre'/></td>
    <td class='field-data' <%= gfla(obj, "soustitre") %>>
            <% if (Util.notEmpty(obj.getSoustitre(userLang))) { %>
            <%= obj.getSoustitre(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field imagePrincipale imageEditor  <%= Util.isEmpty(obj.getImagePrincipale(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "imagePrincipale", userLang) %><jalios:edit pub='<%= obj %>' fields='imagePrincipale'/></td>
    <td class='field-data' <%= gfla(obj, "imagePrincipale") %>>
            <% if (Util.notEmpty(obj.getImagePrincipale(userLang))) { %>
            <img src='<%= Util.encodeUrl(obj.getImagePrincipale(userLang)) %>' alt='' />
            <% } %>
    </td>
  </tr>
  <tr class="field imageCarree imageEditor  <%= Util.isEmpty(obj.getImageCarree()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "imageCarree", userLang) %><jalios:edit pub='<%= obj %>' fields='imageCarree'/></td>
    <td class='field-data' <%= gfla(obj, "imageCarree") %>>
            <% if (Util.notEmpty(obj.getImageCarree())) { %>
            <img src='<%= Util.encodeUrl(obj.getImageCarree()) %>' alt='' />
            <% } %>
    </td>
  </tr>
  <tr class="field imageMobile imageEditor  <%= Util.isEmpty(obj.getImageMobile()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "imageMobile", userLang) %><jalios:edit pub='<%= obj %>' fields='imageMobile'/></td>
    <td class='field-data' <%= gfla(obj, "imageMobile") %>>
            <% if (Util.notEmpty(obj.getImageMobile())) { %>
            <img src='<%= Util.encodeUrl(obj.getImageMobile()) %>' alt='' />
            <% } %>
    </td>
  </tr>
  <tr class="field copyright textfieldEditor  <%= Util.isEmpty(obj.getCopyright(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "copyright", userLang) %><jalios:edit pub='<%= obj %>' fields='copyright'/></td>
    <td class='field-data' <%= gfla(obj, "copyright") %>>
            <% if (Util.notEmpty(obj.getCopyright(userLang))) { %>
            <%= obj.getCopyright(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field legende textfieldEditor  <%= Util.isEmpty(obj.getLegende(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "legende", userLang) %><jalios:edit pub='<%= obj %>' fields='legende'/></td>
    <td class='field-data' <%= gfla(obj, "legende") %>>
            <% if (Util.notEmpty(obj.getLegende(userLang))) { %>
            <%= obj.getLegende(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field texteAlternatif textfieldEditor  <%= Util.isEmpty(obj.getTexteAlternatif(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "texteAlternatif", userLang) %><jalios:edit pub='<%= obj %>' fields='texteAlternatif'/></td>
    <td class='field-data' <%= gfla(obj, "texteAlternatif") %>>
            <% if (Util.notEmpty(obj.getTexteAlternatif(userLang))) { %>
            <%= obj.getTexteAlternatif(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field chapo wysiwygEditor  <%= Util.isEmpty(obj.getChapo(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "chapo", userLang) %><jalios:edit pub='<%= obj %>' fields='chapo'/></td>
    <td class='field-data' <%= gfla(obj, "chapo") %>>
            <% if (Util.notEmpty(obj.getChapo(userLang))) { %>
            <jalios:wysiwyg data='<%= obj %>' field='chapo'><%= obj.getChapo(userLang) %></jalios:wysiwyg>            
            <% } %>
    </td>
  </tr>
  <tr class="field etageCouloirEscalier textfieldEditor  <%= Util.isEmpty(obj.getEtageCouloirEscalier(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "etageCouloirEscalier", userLang) %><jalios:edit pub='<%= obj %>' fields='etageCouloirEscalier'/></td>
    <td class='field-data' <%= gfla(obj, "etageCouloirEscalier") %>>
            <% if (Util.notEmpty(obj.getEtageCouloirEscalier(userLang))) { %>
            <%= obj.getEtageCouloirEscalier(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field entreeBatimentImmeuble textfieldEditor  <%= Util.isEmpty(obj.getEntreeBatimentImmeuble(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "entreeBatimentImmeuble", userLang) %><jalios:edit pub='<%= obj %>' fields='entreeBatimentImmeuble'/></td>
    <td class='field-data' <%= gfla(obj, "entreeBatimentImmeuble") %>>
            <% if (Util.notEmpty(obj.getEntreeBatimentImmeuble(userLang))) { %>
            <%= obj.getEntreeBatimentImmeuble(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field ndeVoie textfieldEditor  <%= Util.isEmpty(obj.getNdeVoie(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "ndeVoie", userLang) %><jalios:edit pub='<%= obj %>' fields='ndeVoie'/></td>
    <td class='field-data' <%= gfla(obj, "ndeVoie") %>>
            <% if (Util.notEmpty(obj.getNdeVoie(userLang))) { %>
            <%= obj.getNdeVoie(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field libelleDeVoie textfieldEditor  <%= Util.isEmpty(obj.getLibelleDeVoie(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "libelleDeVoie", userLang) %><jalios:edit pub='<%= obj %>' fields='libelleDeVoie'/></td>
    <td class='field-data' <%= gfla(obj, "libelleDeVoie") %>>
            <% if (Util.notEmpty(obj.getLibelleDeVoie(userLang))) { %>
            <%= obj.getLibelleDeVoie(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field lieudit textfieldEditor  <%= Util.isEmpty(obj.getLieudit(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "lieudit", userLang) %><jalios:edit pub='<%= obj %>' fields='lieudit'/></td>
    <td class='field-data' <%= gfla(obj, "lieudit") %>>
            <% if (Util.notEmpty(obj.getLieudit(userLang))) { %>
            <%= obj.getLieudit(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field codePostal textfieldEditor  <%= Util.isEmpty(obj.getCodePostal(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "codePostal", userLang) %><jalios:edit pub='<%= obj %>' fields='codePostal'/></td>
    <td class='field-data' <%= gfla(obj, "codePostal") %>>
            <% if (Util.notEmpty(obj.getCodePostal(userLang))) { %>
            <%= obj.getCodePostal(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field commune linkEditor  <%= Util.isEmpty(obj.getCommune()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "commune", userLang) %><jalios:edit pub='<%= obj %>' fields='commune'/></td>
    <td class='field-data' >
            <% if (obj.getCommune() != null && obj.getCommune().canBeReadBy(loggedMember)) { %>
            <jalios:link data='<%= obj.getCommune() %>'/>
            <% } %>
    </td>
  </tr>
  <tr class="field planDacces linkEditor  <%= Util.isEmpty(obj.getPlanDacces(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "planDacces", userLang) %><jalios:edit pub='<%= obj %>' fields='planDacces'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getPlanDacces(userLang))) { %>
            <ol>
              <jalios:foreach name="itData" type="com.jalios.jcms.FileDocument" array="<%= obj.getPlanDacces(userLang) %>">
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
  <tr class="field libelleAutreAdresse textfieldEditor  <%= Util.isEmpty(obj.getLibelleAutreAdresse(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "libelleAutreAdresse", userLang) %><jalios:edit pub='<%= obj %>' fields='libelleAutreAdresse'/></td>
    <td class='field-data' <%= gfla(obj, "libelleAutreAdresse") %>>
            <% if (Util.notEmpty(obj.getLibelleAutreAdresse(userLang))) { %>
            <%= obj.getLibelleAutreAdresse(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field etageCouloirEscalier2 textfieldEditor  <%= Util.isEmpty(obj.getEtageCouloirEscalier2(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "etageCouloirEscalier2", userLang) %><jalios:edit pub='<%= obj %>' fields='etageCouloirEscalier2'/></td>
    <td class='field-data' <%= gfla(obj, "etageCouloirEscalier2") %>>
            <% if (Util.notEmpty(obj.getEtageCouloirEscalier2(userLang))) { %>
            <%= obj.getEtageCouloirEscalier2(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field entreeBatimentImmeuble2 textfieldEditor  <%= Util.isEmpty(obj.getEntreeBatimentImmeuble2(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "entreeBatimentImmeuble2", userLang) %><jalios:edit pub='<%= obj %>' fields='entreeBatimentImmeuble2'/></td>
    <td class='field-data' <%= gfla(obj, "entreeBatimentImmeuble2") %>>
            <% if (Util.notEmpty(obj.getEntreeBatimentImmeuble2(userLang))) { %>
            <%= obj.getEntreeBatimentImmeuble2(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field ndeVoie2 textfieldEditor  <%= Util.isEmpty(obj.getNdeVoie2(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "ndeVoie2", userLang) %><jalios:edit pub='<%= obj %>' fields='ndeVoie2'/></td>
    <td class='field-data' <%= gfla(obj, "ndeVoie2") %>>
            <% if (Util.notEmpty(obj.getNdeVoie2(userLang))) { %>
            <%= obj.getNdeVoie2(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field libelleDeVoie2 textfieldEditor  <%= Util.isEmpty(obj.getLibelleDeVoie2(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "libelleDeVoie2", userLang) %><jalios:edit pub='<%= obj %>' fields='libelleDeVoie2'/></td>
    <td class='field-data' <%= gfla(obj, "libelleDeVoie2") %>>
            <% if (Util.notEmpty(obj.getLibelleDeVoie2(userLang))) { %>
            <%= obj.getLibelleDeVoie2(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field lieudit2 textfieldEditor  <%= Util.isEmpty(obj.getLieudit2(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "lieudit2", userLang) %><jalios:edit pub='<%= obj %>' fields='lieudit2'/></td>
    <td class='field-data' <%= gfla(obj, "lieudit2") %>>
            <% if (Util.notEmpty(obj.getLieudit2(userLang))) { %>
            <%= obj.getLieudit2(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field codePostal2 textfieldEditor  <%= Util.isEmpty(obj.getCodePostal2(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "codePostal2", userLang) %><jalios:edit pub='<%= obj %>' fields='codePostal2'/></td>
    <td class='field-data' <%= gfla(obj, "codePostal2") %>>
            <% if (Util.notEmpty(obj.getCodePostal2(userLang))) { %>
            <%= obj.getCodePostal2(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field cs2 textfieldEditor  <%= Util.isEmpty(obj.getCs2(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "cs2", userLang) %><jalios:edit pub='<%= obj %>' fields='cs2'/></td>
    <td class='field-data' <%= gfla(obj, "cs2") %>>
            <% if (Util.notEmpty(obj.getCs2(userLang))) { %>
            <%= obj.getCs2(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field cedex2 textfieldEditor  <%= Util.isEmpty(obj.getCedex2(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "cedex2", userLang) %><jalios:edit pub='<%= obj %>' fields='cedex2'/></td>
    <td class='field-data' <%= gfla(obj, "cedex2") %>>
            <% if (Util.notEmpty(obj.getCedex2(userLang))) { %>
            <%= obj.getCedex2(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field commune2 linkEditor  <%= Util.isEmpty(obj.getCommune2()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "commune2", userLang) %><jalios:edit pub='<%= obj %>' fields='commune2'/></td>
    <td class='field-data' >
            <% if (obj.getCommune2() != null && obj.getCommune2().canBeReadBy(loggedMember)) { %>
            <jalios:link data='<%= obj.getCommune2() %>'/>
            <% } %>
    </td>
  </tr>
  <tr class="field telephone textfieldEditor  <%= Util.isEmpty(obj.getTelephone(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "telephone", userLang) %><jalios:edit pub='<%= obj %>' fields='telephone'/></td>
    <td class='field-data' <%= gfla(obj, "telephone") %>>
        <% if (Util.notEmpty(obj.getTelephone(userLang))) { %>
            <ol>
            <jalios:foreach name="itString" type="String" array="<%= obj.getTelephone(userLang) %>">
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
  <tr class="field email emailEditor  <%= Util.isEmpty(obj.getEmail(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "email", userLang) %><jalios:edit pub='<%= obj %>' fields='email'/></td>
    <td class='field-data' <%= gfla(obj, "email") %>>
        <% if (Util.notEmpty(obj.getEmail(userLang))) { %>
            <ol>
            <jalios:foreach name="itString" type="String" array="<%= obj.getEmail(userLang) %>">
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
  <tr class="field siteInternet urlEditor  <%= Util.isEmpty(obj.getSiteInternet(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "siteInternet", userLang) %><jalios:edit pub='<%= obj %>' fields='siteInternet'/></td>
    <td class='field-data' <%= gfla(obj, "siteInternet") %>>
        <% if (Util.notEmpty(obj.getSiteInternet(userLang))) { %>
            <ol>
            <jalios:foreach name="itString" type="String" array="<%= obj.getSiteInternet(userLang) %>">
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
  <tr class="field plusDeDetailInterne linkEditor  <%= Util.isEmpty(obj.getPlusDeDetailInterne()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "plusDeDetailInterne", userLang) %><jalios:edit pub='<%= obj %>' fields='plusDeDetailInterne'/></td>
    <td class='field-data' >
            <% if (obj.getPlusDeDetailInterne() != null && obj.getPlusDeDetailInterne().canBeReadBy(loggedMember)) { %>
            <jalios:link data='<%= obj.getPlusDeDetailInterne() %>'/>
            <% } %>
    </td>
  </tr>
  <tr class="field plusDeDetailExterne urlEditor  <%= Util.isEmpty(obj.getPlusDeDetailExterne(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "plusDeDetailExterne", userLang) %><jalios:edit pub='<%= obj %>' fields='plusDeDetailExterne'/></td>
    <td class='field-data' <%= gfla(obj, "plusDeDetailExterne") %>>
            <% if (Util.notEmpty(obj.getPlusDeDetailExterne(userLang))) { %>
            <a href='<%= obj.getPlusDeDetailExterne(userLang) %>' ><%= obj.getPlusDeDetailExterne(userLang)%></a>
            <% } %>
    </td>
  </tr>
  <tr class="field typeDacces categoryEditor  <%= Util.isEmpty(obj.getTypeDacces(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "typeDacces", userLang) %><jalios:edit pub='<%= obj %>' fields='typeDacces'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getTypeDacces(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getTypeDacces(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.typeAcces.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field complementTypeDacces textfieldEditor  <%= Util.isEmpty(obj.getComplementTypeDacces(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "complementTypeDacces", userLang) %><jalios:edit pub='<%= obj %>' fields='complementTypeDacces'/></td>
    <td class='field-data' <%= gfla(obj, "complementTypeDacces") %>>
            <% if (Util.notEmpty(obj.getComplementTypeDacces(userLang))) { %>
            <%= obj.getComplementTypeDacces(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field pourQui wysiwygEditor  <%= Util.isEmpty(obj.getPourQui(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "pourQui", userLang) %><jalios:edit pub='<%= obj %>' fields='pourQui'/></td>
    <td class='field-data' <%= gfla(obj, "pourQui") %>>
            <% if (Util.notEmpty(obj.getPourQui(userLang))) { %>
            <jalios:wysiwyg data='<%= obj %>' field='pourQui'><%= obj.getPourQui(userLang) %></jalios:wysiwyg>            
            <% } %>
    </td>
  </tr>
  <tr class="field modalitesDaccueil wysiwygEditor  <%= Util.isEmpty(obj.getModalitesDaccueil(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "modalitesDaccueil", userLang) %><jalios:edit pub='<%= obj %>' fields='modalitesDaccueil'/></td>
    <td class='field-data' <%= gfla(obj, "modalitesDaccueil") %>>
            <% if (Util.notEmpty(obj.getModalitesDaccueil(userLang))) { %>
            <jalios:wysiwyg data='<%= obj %>' field='modalitesDaccueil'><%= obj.getModalitesDaccueil(userLang) %></jalios:wysiwyg>            
            <% } %>
    </td>
  </tr>
  <tr class="field horairesEtAcces wysiwygEditor  <%= Util.isEmpty(obj.getHorairesEtAcces(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "horairesEtAcces", userLang) %><jalios:edit pub='<%= obj %>' fields='horairesEtAcces'/></td>
    <td class='field-data' <%= gfla(obj, "horairesEtAcces") %>>
            <% if (Util.notEmpty(obj.getHorairesEtAcces(userLang))) { %>
            <jalios:wysiwyg data='<%= obj %>' field='horairesEtAcces'><%= obj.getHorairesEtAcces(userLang) %></jalios:wysiwyg>            
            <% } %>
    </td>
  </tr>
  <tr class="field transportsEnCommun wysiwygEditor  <%= Util.isEmpty(obj.getTransportsEnCommun(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "transportsEnCommun", userLang) %><jalios:edit pub='<%= obj %>' fields='transportsEnCommun'/></td>
    <td class='field-data' <%= gfla(obj, "transportsEnCommun") %>>
            <% if (Util.notEmpty(obj.getTransportsEnCommun(userLang))) { %>
            <jalios:wysiwyg data='<%= obj %>' field='transportsEnCommun'><%= obj.getTransportsEnCommun(userLang) %></jalios:wysiwyg>            
            <% } %>
    </td>
  </tr>
  <tr class="field parkings wysiwygEditor  <%= Util.isEmpty(obj.getParkings(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "parkings", userLang) %><jalios:edit pub='<%= obj %>' fields='parkings'/></td>
    <td class='field-data' <%= gfla(obj, "parkings") %>>
            <% if (Util.notEmpty(obj.getParkings(userLang))) { %>
            <jalios:wysiwyg data='<%= obj %>' field='parkings'><%= obj.getParkings(userLang) %></jalios:wysiwyg>            
            <% } %>
    </td>
  </tr>
  <tr class="field description wysiwygEditor  <%= Util.isEmpty(obj.getDescription(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "description", userLang) %><jalios:edit pub='<%= obj %>' fields='description'/></td>
    <td class='field-data' <%= gfla(obj, "description") %>>
            <% if (Util.notEmpty(obj.getDescription(userLang))) { %>
            <jalios:wysiwyg data='<%= obj %>' field='description'><%= obj.getDescription(userLang) %></jalios:wysiwyg>            
            <% } %>
    </td>
  </tr>
  <tr class="field video linkEditor  <%= Util.isEmpty(obj.getVideo()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "video", userLang) %><jalios:edit pub='<%= obj %>' fields='video'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getVideo())) { %>
            <ol>
              <jalios:foreach name="itData" type="generated.Video" array="<%= obj.getVideo() %>">
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
  <tr class="field autresLieuxAssocies linkEditor  <%= Util.isEmpty(obj.getAutresLieuxAssocies()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "autresLieuxAssocies", userLang) %><jalios:edit pub='<%= obj %>' fields='autresLieuxAssocies'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getAutresLieuxAssocies())) { %>
            <ol>
              <jalios:foreach name="itData" type="generated.FicheLieu" array="<%= obj.getAutresLieuxAssocies() %>">
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
  <tr class="field portletBas linkEditor  <%= Util.isEmpty(obj.getPortletBas()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "portletBas", userLang) %><jalios:edit pub='<%= obj %>' fields='portletBas'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getPortletBas())) { %>
            <ol>
              <jalios:foreach name="itData" type="com.jalios.jcms.portlet.PortalElement" array="<%= obj.getPortletBas() %>">
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
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "categorieDeNavigation", userLang) %><jalios:edit pub='<%= obj %>' fields='categorieDeNavigation'/></td>
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
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "miseEnAvant", userLang) %><jalios:edit pub='<%= obj %>' fields='miseEnAvant'/></td>
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
  <tr class="field serviceDuDepartement booleanEditor  ">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "serviceDuDepartement", userLang) %><jalios:edit pub='<%= obj %>' fields='serviceDuDepartement'/></td>
    <td class='field-data' >
            <%= obj.getServiceDuDepartementLabel(userLang) %>
    </td>
  </tr>
  <tr class="field statut categoryEditor  <%= Util.isEmpty(obj.getStatut(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "statut", userLang) %><jalios:edit pub='<%= obj %>' fields='statut'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getStatut(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getStatut(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.statut.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field typeDeLieu categoryEditor  <%= Util.isEmpty(obj.getTypeDeLieu(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "typeDeLieu", userLang) %><jalios:edit pub='<%= obj %>' fields='typeDeLieu'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getTypeDeLieu(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getTypeDeLieu(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.typeLieu.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field besoins categoryEditor  <%= Util.isEmpty(obj.getBesoins(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "besoins", userLang) %><jalios:edit pub='<%= obj %>' fields='besoins'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getBesoins(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getBesoins(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.category.besoins.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field publics categoryEditor  <%= Util.isEmpty(obj.getPublics(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "publics", userLang) %><jalios:edit pub='<%= obj %>' fields='publics'/></td>
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
  <tr class="field communes linkEditor  <%= Util.isEmpty(obj.getCommunes()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "communes", userLang) %><jalios:edit pub='<%= obj %>' fields='communes'/></td>
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
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "delegations", userLang) %><jalios:edit pub='<%= obj %>' fields='delegations'/></td>
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
  <tr class="field toutesLesCommunesDuDepartement booleanEditor  ">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "toutesLesCommunesDuDepartement", userLang) %><jalios:edit pub='<%= obj %>' fields='toutesLesCommunesDuDepartement'/></td>
    <td class='field-data' >
            <%= obj.getToutesLesCommunesDuDepartementLabel(userLang) %>
    </td>
  </tr>
  <tr class="field epci categoryEditor  <%= Util.isEmpty(obj.getEpci(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "epci", userLang) %><jalios:edit pub='<%= obj %>' fields='epci'/></td>
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
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "cantons", userLang) %><jalios:edit pub='<%= obj %>' fields='cantons'/></td>
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
  <tr class="field arretsDeTransportsEnCommunAccess booleanEditor  ">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "arretsDeTransportsEnCommunAccess", userLang) %><jalios:edit pub='<%= obj %>' fields='arretsDeTransportsEnCommunAccess'/></td>
    <td class='field-data' >
            <%= obj.getArretsDeTransportsEnCommunAccessLabel(userLang) %>
    </td>
  </tr>
  <tr class="field presenceDunePlacePMRSurLespacePu booleanEditor  ">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "presenceDunePlacePMRSurLespacePu", userLang) %><jalios:edit pub='<%= obj %>' fields='presenceDunePlacePMRSurLespacePu'/></td>
    <td class='field-data' >
            <%= obj.getPresenceDunePlacePMRSurLespacePuLabel(userLang) %>
    </td>
  </tr>
  <tr class="field presenceDunePlacePMRDansLERP booleanEditor  ">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "presenceDunePlacePMRDansLERP", userLang) %><jalios:edit pub='<%= obj %>' fields='presenceDunePlacePMRDansLERP'/></td>
    <td class='field-data' >
            <%= obj.getPresenceDunePlacePMRDansLERPLabel(userLang) %>
    </td>
  </tr>
  <tr class="field handicapAuditif categoryEditor  <%= Util.isEmpty(obj.getHandicapAuditif(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "handicapAuditif", userLang) %><jalios:edit pub='<%= obj %>' fields='handicapAuditif'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getHandicapAuditif(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getHandicapAuditif(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.handicapAuditif.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field handicapMoteur categoryEditor  <%= Util.isEmpty(obj.getHandicapMoteur(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "handicapMoteur", userLang) %><jalios:edit pub='<%= obj %>' fields='handicapMoteur'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getHandicapMoteur(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getHandicapMoteur(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.handicapMoteur.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field handicapVisuel categoryEditor  <%= Util.isEmpty(obj.getHandicapVisuel(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "handicapVisuel", userLang) %><jalios:edit pub='<%= obj %>' fields='handicapVisuel'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getHandicapVisuel(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getHandicapVisuel(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.handicapVisuel.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field handicapMental categoryEditor  <%= Util.isEmpty(obj.getHandicapMental(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "handicapMental", userLang) %><jalios:edit pub='<%= obj %>' fields='handicapMental'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getHandicapMental(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getHandicapMental(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.handicapMental.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field deficiencePsychique categoryEditor  <%= Util.isEmpty(obj.getDeficiencePsychique(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "deficiencePsychique", userLang) %><jalios:edit pub='<%= obj %>' fields='deficiencePsychique'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getDeficiencePsychique(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getDeficiencePsychique(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.deficiencePsychique.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field batimentHandicapAuditif categoryEditor  <%= Util.isEmpty(obj.getBatimentHandicapAuditif(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "batimentHandicapAuditif", userLang) %><jalios:edit pub='<%= obj %>' fields='batimentHandicapAuditif'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getBatimentHandicapAuditif(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getBatimentHandicapAuditif(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.batimentHandicapAuditif.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field batimentHandicapMoteur categoryEditor  <%= Util.isEmpty(obj.getBatimentHandicapMoteur(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "batimentHandicapMoteur", userLang) %><jalios:edit pub='<%= obj %>' fields='batimentHandicapMoteur'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getBatimentHandicapMoteur(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getBatimentHandicapMoteur(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.batimentHandicapMoteur.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field batimentHandicapVisuel categoryEditor  <%= Util.isEmpty(obj.getBatimentHandicapVisuel(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "batimentHandicapVisuel", userLang) %><jalios:edit pub='<%= obj %>' fields='batimentHandicapVisuel'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getBatimentHandicapVisuel(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getBatimentHandicapVisuel(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.batimentHandicapVisuel.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field batimentHandicapMental categoryEditor  <%= Util.isEmpty(obj.getBatimentHandicapMental(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "batimentHandicapMental", userLang) %><jalios:edit pub='<%= obj %>' fields='batimentHandicapMental'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getBatimentHandicapMental(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getBatimentHandicapMental(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.batimentHandicapMental.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field batimentDeficiencePsychique categoryEditor  <%= Util.isEmpty(obj.getBatimentDeficiencePsychique(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "batimentDeficiencePsychique", userLang) %><jalios:edit pub='<%= obj %>' fields='batimentDeficiencePsychique'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getBatimentDeficiencePsychique(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getBatimentDeficiencePsychique(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.batimentDeficiencePsychique.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field visiophone booleanEditor  ">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "visiophone", userLang) %><jalios:edit pub='<%= obj %>' fields='visiophone'/></td>
    <td class='field-data' >
            <%= obj.getVisiophoneLabel(userLang) %>
    </td>
  </tr>
  <tr class="field sonnette booleanEditor  ">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "sonnette", userLang) %><jalios:edit pub='<%= obj %>' fields='sonnette'/></td>
    <td class='field-data' >
            <%= obj.getSonnetteLabel(userLang) %>
    </td>
  </tr>
  <tr class="field signaletiqueDirectionnelle booleanEditor  ">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "signaletiqueDirectionnelle", userLang) %><jalios:edit pub='<%= obj %>' fields='signaletiqueDirectionnelle'/></td>
    <td class='field-data' >
            <%= obj.getSignaletiqueDirectionnelleLabel(userLang) %>
    </td>
  </tr>
  <tr class="field entreeDePlainpied booleanEditor  ">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "entreeDePlainpied", userLang) %><jalios:edit pub='<%= obj %>' fields='entreeDePlainpied'/></td>
    <td class='field-data' >
            <%= obj.getEntreeDePlainpiedLabel(userLang) %>
    </td>
  </tr>
  <tr class="field portesAutomatiques booleanEditor  ">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "portesAutomatiques", userLang) %><jalios:edit pub='<%= obj %>' fields='portesAutomatiques'/></td>
    <td class='field-data' >
            <%= obj.getPortesAutomatiquesLabel(userLang) %>
    </td>
  </tr>
  <tr class="field rampeFixe booleanEditor  ">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "rampeFixe", userLang) %><jalios:edit pub='<%= obj %>' fields='rampeFixe'/></td>
    <td class='field-data' >
            <%= obj.getRampeFixeLabel(userLang) %>
    </td>
  </tr>
  <tr class="field rampeAmovible booleanEditor  ">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "rampeAmovible", userLang) %><jalios:edit pub='<%= obj %>' fields='rampeAmovible'/></td>
    <td class='field-data' >
            <%= obj.getRampeAmovibleLabel(userLang) %>
    </td>
  </tr>
  <tr class="field ascenseurMontecharge booleanEditor  ">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "ascenseurMontecharge", userLang) %><jalios:edit pub='<%= obj %>' fields='ascenseurMontecharge'/></td>
    <td class='field-data' >
            <%= obj.getAscenseurMontechargeLabel(userLang) %>
    </td>
  </tr>
  <tr class="field presenceDePersonnelALaccueil booleanEditor  ">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "presenceDePersonnelALaccueil", userLang) %><jalios:edit pub='<%= obj %>' fields='presenceDePersonnelALaccueil'/></td>
    <td class='field-data' >
            <%= obj.getPresenceDePersonnelALaccueilLabel(userLang) %>
    </td>
  </tr>
  <tr class="field personnelDaccueilFormeAuxDiffere booleanEditor  ">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "personnelDaccueilFormeAuxDiffere", userLang) %><jalios:edit pub='<%= obj %>' fields='personnelDaccueilFormeAuxDiffere'/></td>
    <td class='field-data' >
            <%= obj.getPersonnelDaccueilFormeAuxDiffereLabel(userLang) %>
    </td>
  </tr>
  <tr class="field personnelDaccueilFormeALaLangueD booleanEditor  ">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "personnelDaccueilFormeALaLangueD", userLang) %><jalios:edit pub='<%= obj %>' fields='personnelDaccueilFormeALaLangueD'/></td>
    <td class='field-data' >
            <%= obj.getPersonnelDaccueilFormeALaLangueDLabel(userLang) %>
    </td>
  </tr>
  <tr class="field siOuiHorairesDePresence textareaEditor  <%= Util.isEmpty(obj.getSiOuiHorairesDePresence(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "siOuiHorairesDePresence", userLang) %><jalios:edit pub='<%= obj %>' fields='siOuiHorairesDePresence'/></td>
    <td class='field-data' <%= gfla(obj, "siOuiHorairesDePresence") %>>
            <% if (Util.notEmpty(obj.getSiOuiHorairesDePresence(userLang))) { %>
            <%= obj.getSiOuiHorairesDePresence(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field accueilHandicapAuditif categoryEditor  <%= Util.isEmpty(obj.getAccueilHandicapAuditif(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "accueilHandicapAuditif", userLang) %><jalios:edit pub='<%= obj %>' fields='accueilHandicapAuditif'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getAccueilHandicapAuditif(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getAccueilHandicapAuditif(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.accueilHandicapAuditif.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field accueilHandicapMoteur categoryEditor  <%= Util.isEmpty(obj.getAccueilHandicapMoteur(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "accueilHandicapMoteur", userLang) %><jalios:edit pub='<%= obj %>' fields='accueilHandicapMoteur'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getAccueilHandicapMoteur(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getAccueilHandicapMoteur(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.accueilHandicapMoteur.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field accueilHandicapVisuel categoryEditor  <%= Util.isEmpty(obj.getAccueilHandicapVisuel(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "accueilHandicapVisuel", userLang) %><jalios:edit pub='<%= obj %>' fields='accueilHandicapVisuel'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getAccueilHandicapVisuel(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getAccueilHandicapVisuel(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.accueilHandicapVisuel.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field accueilHandicapMental categoryEditor  <%= Util.isEmpty(obj.getAccueilHandicapMental(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "accueilHandicapMental", userLang) %><jalios:edit pub='<%= obj %>' fields='accueilHandicapMental'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getAccueilHandicapMental(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getAccueilHandicapMental(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.accueilHandicapMental.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field accueilDeficiencePsychique categoryEditor  <%= Util.isEmpty(obj.getAccueilDeficiencePsychique(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "accueilDeficiencePsychique", userLang) %><jalios:edit pub='<%= obj %>' fields='accueilDeficiencePsychique'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getAccueilDeficiencePsychique(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getAccueilDeficiencePsychique(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.accueilDeficiencePsychique.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field sanitairesHandicapAuditif categoryEditor  <%= Util.isEmpty(obj.getSanitairesHandicapAuditif(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "sanitairesHandicapAuditif", userLang) %><jalios:edit pub='<%= obj %>' fields='sanitairesHandicapAuditif'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getSanitairesHandicapAuditif(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getSanitairesHandicapAuditif(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.sanitairesHandicapAuditif.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field sanitairesHandicapMoteur categoryEditor  <%= Util.isEmpty(obj.getSanitairesHandicapMoteur(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "sanitairesHandicapMoteur", userLang) %><jalios:edit pub='<%= obj %>' fields='sanitairesHandicapMoteur'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getSanitairesHandicapMoteur(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getSanitairesHandicapMoteur(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.sanitairesHandicapMoteur.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field sanitairesHandicapVisuel categoryEditor  <%= Util.isEmpty(obj.getSanitairesHandicapVisuel(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "sanitairesHandicapVisuel", userLang) %><jalios:edit pub='<%= obj %>' fields='sanitairesHandicapVisuel'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getSanitairesHandicapVisuel(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getSanitairesHandicapVisuel(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.sanitairesHandicapVisuel.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field sanitairesHandicapMental categoryEditor  <%= Util.isEmpty(obj.getSanitairesHandicapMental(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "sanitairesHandicapMental", userLang) %><jalios:edit pub='<%= obj %>' fields='sanitairesHandicapMental'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getSanitairesHandicapMental(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getSanitairesHandicapMental(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.sanitairesHandicapMental.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field sanitairesDeficiencePsychique categoryEditor  <%= Util.isEmpty(obj.getSanitairesDeficiencePsychique(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "sanitairesDeficiencePsychique", userLang) %><jalios:edit pub='<%= obj %>' fields='sanitairesDeficiencePsychique'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getSanitairesDeficiencePsychique(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getSanitairesDeficiencePsychique(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.sanitairesHandicapPsychique.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field salleDattenteHandicapAuditif categoryEditor  <%= Util.isEmpty(obj.getSalleDattenteHandicapAuditif(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "salleDattenteHandicapAuditif", userLang) %><jalios:edit pub='<%= obj %>' fields='salleDattenteHandicapAuditif'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getSalleDattenteHandicapAuditif(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getSalleDattenteHandicapAuditif(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.salleDattenteHandicapAuditif.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field salleDattenteHandicapMoteur categoryEditor  <%= Util.isEmpty(obj.getSalleDattenteHandicapMoteur(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "salleDattenteHandicapMoteur", userLang) %><jalios:edit pub='<%= obj %>' fields='salleDattenteHandicapMoteur'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getSalleDattenteHandicapMoteur(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getSalleDattenteHandicapMoteur(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.salleDattenteHandicapMoteur.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field salleDattenteHandicapVisuel categoryEditor  <%= Util.isEmpty(obj.getSalleDattenteHandicapVisuel(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "salleDattenteHandicapVisuel", userLang) %><jalios:edit pub='<%= obj %>' fields='salleDattenteHandicapVisuel'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getSalleDattenteHandicapVisuel(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getSalleDattenteHandicapVisuel(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.salleDattenteHandicapVisuel.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field salleDattenteHandicapMental categoryEditor  <%= Util.isEmpty(obj.getSalleDattenteHandicapMental(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "salleDattenteHandicapMental", userLang) %><jalios:edit pub='<%= obj %>' fields='salleDattenteHandicapMental'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getSalleDattenteHandicapMental(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getSalleDattenteHandicapMental(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.salleDattenteHandicapMental.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field salleDattenteDeficiencePsychique categoryEditor  <%= Util.isEmpty(obj.getSalleDattenteDeficiencePsychique(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "salleDattenteDeficiencePsychique", userLang) %><jalios:edit pub='<%= obj %>' fields='salleDattenteDeficiencePsychique'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getSalleDattenteDeficiencePsychique(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getSalleDattenteDeficiencePsychique(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.salleDattenteDeficiencePsychique.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field bureauHandicapAuditif categoryEditor  <%= Util.isEmpty(obj.getBureauHandicapAuditif(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "bureauHandicapAuditif", userLang) %><jalios:edit pub='<%= obj %>' fields='bureauHandicapAuditif'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getBureauHandicapAuditif(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getBureauHandicapAuditif(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.bureauHandicapAuditif.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field bureauHandicapMoteur categoryEditor  <%= Util.isEmpty(obj.getBureauHandicapMoteur(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "bureauHandicapMoteur", userLang) %><jalios:edit pub='<%= obj %>' fields='bureauHandicapMoteur'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getBureauHandicapMoteur(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getBureauHandicapMoteur(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.bureauHandicapMoteur.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field bureauHandicapVisuel categoryEditor  <%= Util.isEmpty(obj.getBureauHandicapVisuel(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "bureauHandicapVisuel", userLang) %><jalios:edit pub='<%= obj %>' fields='bureauHandicapVisuel'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getBureauHandicapVisuel(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getBureauHandicapVisuel(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.bureauHandicapVisuel.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field bureauHandicapMental categoryEditor  <%= Util.isEmpty(obj.getBureauHandicapMental(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "bureauHandicapMental", userLang) %><jalios:edit pub='<%= obj %>' fields='bureauHandicapMental'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getBureauHandicapMental(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getBureauHandicapMental(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.bureauHandicapMental.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field bureauDeficiencePsychique categoryEditor  <%= Util.isEmpty(obj.getBureauDeficiencePsychique(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "bureauDeficiencePsychique", userLang) %><jalios:edit pub='<%= obj %>' fields='bureauDeficiencePsychique'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getBureauDeficiencePsychique(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getBureauDeficiencePsychique(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.bureauDeficiencePsychique.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field salleDeReunionHandicapAuditif categoryEditor  <%= Util.isEmpty(obj.getSalleDeReunionHandicapAuditif(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "salleDeReunionHandicapAuditif", userLang) %><jalios:edit pub='<%= obj %>' fields='salleDeReunionHandicapAuditif'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getSalleDeReunionHandicapAuditif(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getSalleDeReunionHandicapAuditif(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.salleDeReunionHandicapAuditif.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field salleDeReunionHandicapMoteur categoryEditor  <%= Util.isEmpty(obj.getSalleDeReunionHandicapMoteur(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "salleDeReunionHandicapMoteur", userLang) %><jalios:edit pub='<%= obj %>' fields='salleDeReunionHandicapMoteur'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getSalleDeReunionHandicapMoteur(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getSalleDeReunionHandicapMoteur(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.salleDeReunionHandicapMoteur.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field salleDeReunionHandicapVisuel categoryEditor  <%= Util.isEmpty(obj.getSalleDeReunionHandicapVisuel(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "salleDeReunionHandicapVisuel", userLang) %><jalios:edit pub='<%= obj %>' fields='salleDeReunionHandicapVisuel'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getSalleDeReunionHandicapVisuel(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getSalleDeReunionHandicapVisuel(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.salleDeReunionHandicapVisuel.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field salleDeReunionHandicapMental categoryEditor  <%= Util.isEmpty(obj.getSalleDeReunionHandicapMental(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "salleDeReunionHandicapMental", userLang) %><jalios:edit pub='<%= obj %>' fields='salleDeReunionHandicapMental'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getSalleDeReunionHandicapMental(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getSalleDeReunionHandicapMental(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.salleDeReunionHandicapMental.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field salleDeReunionDeficiencePsychique categoryEditor  <%= Util.isEmpty(obj.getSalleDeReunionDeficiencePsychique(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "salleDeReunionDeficiencePsychique", userLang) %><jalios:edit pub='<%= obj %>' fields='salleDeReunionDeficiencePsychique'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getSalleDeReunionDeficiencePsychique(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getSalleDeReunionDeficiencePsychique(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.salleDeReunionDeficiencePsychique.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field planningDeMiseEnAccessibiliteDuS textfieldEditor  <%= Util.isEmpty(obj.getPlanningDeMiseEnAccessibiliteDuS(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "planningDeMiseEnAccessibiliteDuS", userLang) %><jalios:edit pub='<%= obj %>' fields='planningDeMiseEnAccessibiliteDuS'/></td>
    <td class='field-data' <%= gfla(obj, "planningDeMiseEnAccessibiliteDuS") %>>
            <% if (Util.notEmpty(obj.getPlanningDeMiseEnAccessibiliteDuS(userLang))) { %>
            <%= obj.getPlanningDeMiseEnAccessibiliteDuS(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field boucleInductionMagnetiqueAccueil categoryEditor  <%= Util.isEmpty(obj.getBoucleInductionMagnetiqueAccueil(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "boucleInductionMagnetiqueAccueil", userLang) %><jalios:edit pub='<%= obj %>' fields='boucleInductionMagnetiqueAccueil'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getBoucleInductionMagnetiqueAccueil(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getBoucleInductionMagnetiqueAccueil(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.boucleInductionMagnetiqueAccueil.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field boucleInductionMagnetiqueReunion categoryEditor  <%= Util.isEmpty(obj.getBoucleInductionMagnetiqueReunion(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "boucleInductionMagnetiqueReunion", userLang) %><jalios:edit pub='<%= obj %>' fields='boucleInductionMagnetiqueReunion'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getBoucleInductionMagnetiqueReunion(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getBoucleInductionMagnetiqueReunion(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.boucleInductionMagnetiqueReunion.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field ascenseur categoryEditor  <%= Util.isEmpty(obj.getAscenseur(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "ascenseur", userLang) %><jalios:edit pub='<%= obj %>' fields='ascenseur'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getAscenseur(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getAscenseur(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.ascenseur.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field rampeFixeAccessibilite categoryEditor  <%= Util.isEmpty(obj.getRampeFixeAccessibilite(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "rampeFixeAccessibilite", userLang) %><jalios:edit pub='<%= obj %>' fields='rampeFixeAccessibilite'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getRampeFixeAccessibilite(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getRampeFixeAccessibilite(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.rampeFixe.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field rampeAmovibleAccessibilite categoryEditor  <%= Util.isEmpty(obj.getRampeAmovibleAccessibilite(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "rampeAmovibleAccessibilite", userLang) %><jalios:edit pub='<%= obj %>' fields='rampeAmovibleAccessibilite'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getRampeAmovibleAccessibilite(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getRampeAmovibleAccessibilite(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.rampeAmovible.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field informationsComplementaires wysiwygEditor  <%= Util.isEmpty(obj.getInformationsComplementaires(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "informationsComplementaires", userLang) %><jalios:edit pub='<%= obj %>' fields='informationsComplementaires'/></td>
    <td class='field-data' <%= gfla(obj, "informationsComplementaires") %>>
            <% if (Util.notEmpty(obj.getInformationsComplementaires(userLang))) { %>
            <jalios:wysiwyg data='<%= obj %>' field='informationsComplementaires'><%= obj.getInformationsComplementaires(userLang) %></jalios:wysiwyg>            
            <% } %>
    </td>
  </tr>
 
</table>
<jsp:include page="/front/doFullDisplayCommonFields.jsp" />
</div><%-- **********4A616C696F73204A434D53 *** SIGNATURE BOUNDARY * DO NOT EDIT ANYTHING BELOW THIS LINE *** --%><%
%><%-- XpOG6jtQZCg9u4KfudihVw== --%>