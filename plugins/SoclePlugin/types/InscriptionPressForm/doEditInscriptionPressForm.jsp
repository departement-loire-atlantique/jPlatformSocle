<%-- This file has been automatically generated. --%>
<%--
  @Summary: InscriptionPressForm content editor
  @Category: Generated
  @Author: JCMS Type Processor 
  @Customizable: True
  @Requestable: False 
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %>
<% 
  EditInscriptionPressFormHandler formHandler = (EditInscriptionPressFormHandler)request.getAttribute("formHandler");
  ServletUtil.backupAttribute(pageContext, "classBeingProcessed");
  request.setAttribute("classBeingProcessed", generated.InscriptionPressForm.class);
  
  boolean multilingue = channel.getBooleanProperty("jcmsplugin.socle.multilingue", false);
%>

<%-- Nom ------------------------------------------------------------ --%>
<% String nomLabel = glp("jcmsplugin.socle.nom"); %>
<div class="ds44-mb3">
    <div class="ds44-form__container">
        <div class="ds44-posRel">
            <label for="form-element-nom" class="ds44-formLabel">
              <span class="ds44-labelTypePlaceholder"><span><%= nomLabel %><sup aria-hidden="true">*</sup></span></span>
            </label>
            <input type="text" id="form-element-nom" name="nom"
                class="ds44-inpStd" title="<%= glp("jcmsplugin.socle.facette.champ-obligatoire.title", nomLabel) %>"
                required autocomplete="family-name">
            <button class="ds44-reset" type="button">
                <i class="icon icon-cross icon--sizeL" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.facette.effacer-contenu-champ", nomLabel) %></span>
            </button>
        </div>
    </div>
</div>
 
<%-- Prenom ------------------------------------------------------------ --%>
<% String prenomLabel = glp("jcmsplugin.socle.prenom"); %>
<div class="ds44-mb3">
    <div class="ds44-form__container">
        <div class="ds44-posRel">
            <label for="form-element-prenom" class="ds44-formLabel">
              <span class="ds44-labelTypePlaceholder"><span><%= prenomLabel %><sup aria-hidden="true">*</sup></span></span>
            </label>
            <input type="text" id="form-element-prenom" name="prenom" class="ds44-inpStd" title="<%= glp("jcmsplugin.socle.facette.champ-obligatoire.title", prenomLabel) %>"
                 autocomplete="given-name">
            <button class="ds44-reset" type="button">
                <i class="icon icon-cross icon--sizeL" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.facette.effacer-contenu-champ", prenomLabel) %></span>
            </button>
        </div>
    </div>
</div>
 
<%-- Mail ------------------------------------------------------------ --%>
<% String mailLabel = glp("jcmsplugin.socle.mail"); %>
<div class="ds44-mb3">
    <div class="ds44-form__container">
        <div class="ds44-posRel">
            <label for="form-element-mail" class="ds44-formLabel">
                <span class="ds44-labelTypePlaceholder"><span><%= mailLabel %><sup aria-hidden="true">*</sup></span></span>
            </label>
            <input type="email" id="form-element-mail" name="mail" class="ds44-inpStd" title="<%= glp("jcmsplugin.socle.facette.champ-obligatoire.title", mailLabel) %>"
                required autocomplete="email" aria-describedby="explanation-form-element-mail">
            <button class="ds44-reset" type="button">
                <i class="icon icon-cross icon--sizeL" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.facette.effacer-contenu-champ", mailLabel) %></span>
            </button>
        </div>
        <div class="ds44-field-information" aria-live="polite">
            <ul class="ds44-field-information-list ds44-list">
                <li id="explanation-form-element-mail" class="ds44-field-information-explanation"><%= glp("jcmsplugin.socle.form.exemple.email") %></li>
            </ul>
        </div>
    </div>
</div>

<%-- Telephone ------------------------------------------------------------ --%>
<%  String telephoneLabel = glp("jcmsplugin.socle.telephone");
    String telAutocompleteValue = multilingue ? "tel" : "tel-national";
%>
<div class="ds44-mb3">
    <div class="ds44-form__container">
        <div class="ds44-posRel">
            <label for="form-element-telephone" class="ds44-formLabel">
                <span class="ds44-labelTypePlaceholder"><span><%= telephoneLabel %><sup aria-hidden="true">*</sup></span></span>
            </label>
            <input type="text" id="form-element-telephone" name="telephone" class="ds44-inpStd" required autocomplete="<%= telAutocompleteValue %>" aria-describedby="explanation-form-element-telephone">
            <button class="ds44-reset" type="button">
                <i class="icon icon-cross icon--sizeL" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.facette.effacer-contenu-champ", telephoneLabel) %></span>
            </button>
        </div>
        <div class="ds44-field-information" aria-live="polite">
            <ul class="ds44-field-information-list ds44-list">
                <li id="explanation-form-element-telephone" class="ds44-field-information-explanation"><%= glp("jcmsplugin.socle.form.exemple.tel") %></li>
            </ul>
        </div>
    </div>
</div>

<%-- media ------------------------------------------------------------ --%>
<% String mediaLabel = glp("jcmsplugin.socle.media"); %>
<div class="ds44-mb3">
    <div class="ds44-form__container">
        <div class="ds44-posRel">
            <label for="form-element-media" class="ds44-formLabel">
                <span class="ds44-labelTypePlaceholder"><span><%= mediaLabel %></span></span>
            </label>
            <input type="text" id="form-element-media" name="media" class="ds44-inpStd" aria-describedby="explanation-form-element-media">
            <button class="ds44-reset" type="button">
                <i class="icon icon-cross icon--sizeL" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.facette.effacer-contenu-champ", mediaLabel) %></span>
            </button>
        </div>
        <div class="ds44-field-information" aria-live="polite">
            <ul class="ds44-field-information-list ds44-list">
                <li id="explanation-form-element-media" class="ds44-field-information-explanation"><%= glp("jcmsplugin.socle.form.exemple.type-media") %></li>
            </ul>
        </div>
    </div>
</div>
 
<%
{ 
  TreeSet  removedCatSet = new TreeSet(); 
  Category itRemoveCat = null;
  request.setAttribute("InscriptionPressForm.removedCatSet", removedCatSet);
}  
%>

<button
    class="jcms-js-submit ds44-btnStd ds44-btn--invert ds44-bntFullw ds44-bntALeft"
    title="Valider l'envoi de votre demande">
    <span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.valider") %></span><i
        class="icon icon-long-arrow-right" aria-hidden="true"></i>
</button>
 
<jalios:include target="EDIT_PUB_MAINTAB" targetContext="div" />
<jalios:include jsp="/jcore/doEditExtraData.jsp" />

