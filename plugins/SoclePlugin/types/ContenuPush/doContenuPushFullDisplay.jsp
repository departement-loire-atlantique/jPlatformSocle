<%@ page contentType="text/html; charset=UTF-8" %><%
%><%-- This file has been automatically generated. --%><%
%><%--
  @Summary: ContenuPush display page
  @Category: Generated
  @Author: JCMS Type Processor
  @Customizable: True
  @Requestable: True
--%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% ContenuPush obj = (ContenuPush)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%
%><%@ include file='/front/doFullDisplay.jspf' %>
<div class="fullDisplay ContenuPush <%= obj.canBeEditedFieldByField(loggedMember) ? "unitFieldEdition" : "" %>" itemscope="itemscope">
<%@ include file='/front/publication/doPublicationHeader.jspf' %>
<table class="fields">
  <tr class="field soustitre wysiwygEditor  <%= Util.isEmpty(obj.getSoustitre()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(ContenuPush.class, "soustitre", userLang) %><jalios:edit pub='<%= obj %>' fields='soustitre'/></td>
    <td class='field-data' <%= gfla(obj, "soustitre") %>>
            <% if (Util.notEmpty(obj.getSoustitre())) { %>
            <jalios:wysiwyg data='<%= obj %>' field='soustitre'><%= obj.getSoustitre() %></jalios:wysiwyg>
            <% } %>
    </td>
  </tr>
  <tr class="field imagePush imageEditor  <%= Util.isEmpty(obj.getImagePush()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(ContenuPush.class, "imagePush", userLang) %><jalios:edit pub='<%= obj %>' fields='imagePush'/></td>
    <td class='field-data' <%= gfla(obj, "imagePush") %>>
            <% if (Util.notEmpty(obj.getImagePush())) { %>
            <img src='<%= Util.encodeUrl(obj.getImagePush()) %>' alt='' />
            <% } %>
    </td>
  </tr>
  <tr class="field imageColleeAuBord booleanEditor  ">
    <td class='field-label'><%= channel.getTypeFieldLabel(ContenuPush.class, "imageColleeAuBord", userLang) %><jalios:edit pub='<%= obj %>' fields='imageColleeAuBord'/></td>
    <td class='field-data' >
            <%= obj.getImageColleeAuBordLabel(userLang) %>
    </td>
  </tr>
  <tr class="field affichageDuLienBouton wysiwygEditor  <%= Util.isEmpty(obj.getAffichageDuLienBouton()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(ContenuPush.class, "affichageDuLienBouton", userLang) %><jalios:edit pub='<%= obj %>' fields='affichageDuLienBouton'/></td>
    <td class='field-data' <%= gfla(obj, "affichageDuLienBouton") %>>
            <% if (Util.notEmpty(obj.getAffichageDuLienBouton())) { %>
            <jalios:wysiwyg data='<%= obj %>' field='affichageDuLienBouton'><%= obj.getAffichageDuLienBouton() %></jalios:wysiwyg>            
            <% } %>
    </td>
  </tr>
 
</table>
<jsp:include page="/front/doFullDisplayCommonFields.jsp" />
</div><%-- **********4A616C696F73204A434D53 *** SIGNATURE BOUNDARY * DO NOT EDIT ANYTHING BELOW THIS LINE *** --%><%
%><%-- swK8DoT8G7d9WcZ5GqBJVA== --%>