<%@ page contentType="text/html; charset=UTF-8" %><%
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
  <tr class="field serviceDuDepartement booleanEditor  ">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "serviceDuDepartement", userLang) %><jalios:edit pub='<%= obj %>' fields='serviceDuDepartement'/></td>
    <td class='field-data' >
            <%= obj.getServiceDuDepartementLabel(userLang) %>
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
  <tr class="field imagePrincipale imageEditor  <%= Util.isEmpty(obj.getImagePrincipale(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "imagePrincipale", userLang) %><jalios:edit pub='<%= obj %>' fields='imagePrincipale'/></td>
    <td class='field-data' <%= gfla(obj, "imagePrincipale") %>>
            <% if (Util.notEmpty(obj.getImagePrincipale(userLang))) { %>
            <img src='<%= Util.encodeUrl(obj.getImagePrincipale(userLang)) %>' alt='' />
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
  <tr class="field enBref textareaEditor  <%= Util.isEmpty(obj.getEnBref(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "enBref", userLang) %><jalios:edit pub='<%= obj %>' fields='enBref'/></td>
    <td class='field-data' <%= gfla(obj, "enBref") %>>
            <% if (Util.notEmpty(obj.getEnBref(userLang))) { %>
            <%= obj.getEnBref(userLang) %>
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
  <tr class="field cs textfieldEditor  <%= Util.isEmpty(obj.getCs(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "cs", userLang) %><jalios:edit pub='<%= obj %>' fields='cs'/></td>
    <td class='field-data' <%= gfla(obj, "cs") %>>
            <% if (Util.notEmpty(obj.getCs(userLang))) { %>
            <%= obj.getCs(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field cedex textfieldEditor  <%= Util.isEmpty(obj.getCedex(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "cedex", userLang) %><jalios:edit pub='<%= obj %>' fields='cedex'/></td>
    <td class='field-data' <%= gfla(obj, "cedex") %>>
            <% if (Util.notEmpty(obj.getCedex(userLang))) { %>
            <%= obj.getCedex(userLang) %>
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
  <tr class="field besoins categoryEditor  <%= Util.isEmpty(obj.getBesoins(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "besoins", userLang) %><jalios:edit pub='<%= obj %>' fields='besoins'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getBesoins(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getBesoins(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.besoins.root"), " > ", true, userLang) %></a><% } %></li>
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
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.delegations.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field communesDintervention linkEditor  <%= Util.isEmpty(obj.getCommunesDintervention()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "communesDintervention", userLang) %><jalios:edit pub='<%= obj %>' fields='communesDintervention'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getCommunesDintervention())) { %>
            <ol>
              <jalios:foreach name="itData" type="generated.City" array="<%= obj.getCommunesDintervention() %>">
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
  <tr class="field toutesLesCommunesDuDepartement enumerateEditor  <%= Util.isEmpty(obj.getToutesLesCommunesDuDepartement()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "toutesLesCommunesDuDepartement", userLang) %><jalios:edit pub='<%= obj %>' fields='toutesLesCommunesDuDepartement'/></td>
    <td class='field-data' <%= gfla(obj, "toutesLesCommunesDuDepartement") %>>
            <% if (Util.notEmpty(obj.getToutesLesCommunesDuDepartement())) { %>
            <%= obj.getToutesLesCommunesDuDepartementLabel(obj.getToutesLesCommunesDuDepartement(), userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field toutesLesCommunesEPCI categoryEditor  <%= Util.isEmpty(obj.getToutesLesCommunesEPCI(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "toutesLesCommunesEPCI", userLang) %><jalios:edit pub='<%= obj %>' fields='toutesLesCommunesEPCI'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getToutesLesCommunesEPCI(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getToutesLesCommunesEPCI(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.toutesLesCommunesEPCI.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field canton linkEditor  <%= Util.isEmpty(obj.getCanton()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "canton", userLang) %><jalios:edit pub='<%= obj %>' fields='canton'/></td>
    <td class='field-data' >
            <% if (obj.getCanton() != null && obj.getCanton().canBeReadBy(loggedMember)) { %>
            <jalios:link data='<%= obj.getCanton() %>'/>
            <% } %>
    </td>
  </tr>
  <tr class="field typeDacces enumerateEditor  <%= Util.isEmpty(obj.getTypeDacces()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "typeDacces", userLang) %><jalios:edit pub='<%= obj %>' fields='typeDacces'/></td>
    <td class='field-data' <%= gfla(obj, "typeDacces") %>>
        <% if (Util.notEmpty(obj.getTypeDacces())) { %>
            <ol>
            <jalios:foreach name="itString" type="String" array="<%= obj.getTypeDacces() %>">
            <% if (Util.notEmpty(itString)) { %>
              <li>
            <%= obj.getTypeDaccesLabel(itString, userLang) %>
              </li>
            <% } %>
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
  <tr class="field publicVise categoryEditor  <%= Util.isEmpty(obj.getPublicVise(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "publicVise", userLang) %><jalios:edit pub='<%= obj %>' fields='publicVise'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getPublicVise(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getPublicVise(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.publicVise.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
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
  <tr class="field enDetails wysiwygEditor  <%= Util.isEmpty(obj.getEnDetails(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "enDetails", userLang) %><jalios:edit pub='<%= obj %>' fields='enDetails'/></td>
    <td class='field-data' <%= gfla(obj, "enDetails") %>>
            <% if (Util.notEmpty(obj.getEnDetails(userLang))) { %>
            <jalios:wysiwyg data='<%= obj %>' field='enDetails'><%= obj.getEnDetails(userLang) %></jalios:wysiwyg>            
            <% } %>
    </td>
  </tr>
  <tr class="field video linkEditor  <%= Util.isEmpty(obj.getVideo()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "video", userLang) %><jalios:edit pub='<%= obj %>' fields='video'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getVideo())) { %>
            <ol>
              <jalios:foreach name="itData" type="generated.VideoChapitree" array="<%= obj.getVideo() %>">
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
  <tr class="field deficiencePsychiqueEtMaladieMent categoryEditor  <%= Util.isEmpty(obj.getDeficiencePsychiqueEtMaladieMent(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "deficiencePsychiqueEtMaladieMent", userLang) %><jalios:edit pub='<%= obj %>' fields='deficiencePsychiqueEtMaladieMent'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getDeficiencePsychiqueEtMaladieMent(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getDeficiencePsychiqueEtMaladieMent(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.deficiencePsychiqueEtMaladieMent.root"), " > ", true, userLang) %></a><% } %></li>
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
  <tr class="field batimentDeficiencePsychiqueEtMal categoryEditor  <%= Util.isEmpty(obj.getBatimentDeficiencePsychiqueEtMal(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "batimentDeficiencePsychiqueEtMal", userLang) %><jalios:edit pub='<%= obj %>' fields='batimentDeficiencePsychiqueEtMal'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getBatimentDeficiencePsychiqueEtMal(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getBatimentDeficiencePsychiqueEtMal(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.batimentDeficiencePsychiqueEtMal.root"), " > ", true, userLang) %></a><% } %></li>
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
  <tr class="field sonette booleanEditor  ">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "sonette", userLang) %><jalios:edit pub='<%= obj %>' fields='sonette'/></td>
    <td class='field-data' >
            <%= obj.getSonetteLabel(userLang) %>
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
  <tr class="field accueilDeficiencePsychiqueEtMala categoryEditor  <%= Util.isEmpty(obj.getAccueilDeficiencePsychiqueEtMala(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "accueilDeficiencePsychiqueEtMala", userLang) %><jalios:edit pub='<%= obj %>' fields='accueilDeficiencePsychiqueEtMala'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getAccueilDeficiencePsychiqueEtMala(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getAccueilDeficiencePsychiqueEtMala(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.accueilDeficiencePsychiqueEtMala.root"), " > ", true, userLang) %></a><% } %></li>
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
  <tr class="field bureauDeficiencePsychiqueEtMalad categoryEditor  <%= Util.isEmpty(obj.getBureauDeficiencePsychiqueEtMalad(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "bureauDeficiencePsychiqueEtMalad", userLang) %><jalios:edit pub='<%= obj %>' fields='bureauDeficiencePsychiqueEtMalad'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getBureauDeficiencePsychiqueEtMalad(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getBureauDeficiencePsychiqueEtMalad(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.bureauDeficiencePsychiqueEtMalad.root"), " > ", true, userLang) %></a><% } %></li>
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
  <tr class="field salleDeReunionDeficiencePsychiqu categoryEditor  <%= Util.isEmpty(obj.getSalleDeReunionDeficiencePsychiqu(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "salleDeReunionDeficiencePsychiqu", userLang) %><jalios:edit pub='<%= obj %>' fields='salleDeReunionDeficiencePsychiqu'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getSalleDeReunionDeficiencePsychiqu(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getSalleDeReunionDeficiencePsychiqu(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.fichelieu.salleDeReunionDeficiencePsychiqu.root"), " > ", true, userLang) %></a><% } %></li>
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
  <tr class="field rampeAmovible categoryEditor  <%= Util.isEmpty(obj.getRampeAmovible(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(FicheLieu.class, "rampeAmovible", userLang) %><jalios:edit pub='<%= obj %>' fields='rampeAmovible'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getRampeAmovible(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getRampeAmovible(loggedMember) %>" type="Category" name="itCategory" >
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
</div>