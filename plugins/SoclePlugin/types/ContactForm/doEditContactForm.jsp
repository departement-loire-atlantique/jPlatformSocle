<%-- This file has been automatically generated. --%>
<%--
  @Summary: ContactForm content editor
  @Category: Generated
  @Author: JCMS Type Processor 
  @Customizable: True
  @Requestable: False 
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %>
<% 
  EditContactFormHandler formHandler = (EditContactFormHandler)request.getAttribute("formHandler");
  ServletUtil.backupAttribute(pageContext, "classBeingProcessed");
  request.setAttribute("classBeingProcessed", generated.ContactForm.class);
%>
<%-- Name ------------------------------------------------------------ --%>
<% String nomLabel = channel.getTypeFieldLabel(ContactForm.class, "nom", userLang);%>
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
 
<%-- FirstName ------------------------------------------------------------ --%>
<% String prenomLabel = channel.getTypeFieldLabel(ContactForm.class, "prenom", userLang);%>
<div class="ds44-mb3">
    <div class="ds44-form__container">
        <div class="ds44-posRel">
            <label for="form-element-prenom" class="ds44-formLabel">
              <span class="ds44-labelTypePlaceholder"><span><%= prenomLabel %><sup aria-hidden="true">*</sup></span></span>
            </label>
            <input type="text" id="form-element-prenom" name="prenom" class="ds44-inpStd" title="<%= glp("jcmsplugin.socle.facette.champ-obligatoire.title", prenomLabel) %>"
                required autocomplete="given-name">
            <button class="ds44-reset" type="button">
                <i class="icon icon-cross icon--sizeL" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.facette.effacer-contenu-champ", prenomLabel) %></span>
            </button>
        </div>
    </div>
</div>
 
<%-- Mail ------------------------------------------------------------ --%>
<% String mailLabel = channel.getTypeFieldLabel(ContactForm.class, "mail", userLang);%>
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

<%-- Phone ------------------------------------------------------------ --%>
<% String telephoneLabel = channel.getTypeFieldLabel(ContactForm.class, "telephone", userLang);%>
<div class="ds44-mb3">
    <div class="ds44-form__container">
        <div class="ds44-posRel">
            <label for="form-element-telephone" class="ds44-formLabel">
                <span class="ds44-labelTypePlaceholder"><span><%= telephoneLabel %></span></span>
            </label>
            <input type="text" id="form-element-telephone" name="telephone" class="ds44-inpStd" autocomplete="tel-national" aria-describedby="explanation-form-element-telephone">
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
 
<%-- CodePostal ------------------------------------------------------------ --%>
<% String codepostalLabel = channel.getTypeFieldLabel(ContactForm.class, "codePostal", userLang);%>
<div class="ds44-mb3">
    <div class="ds44-form__container">
        <div class="ds44-posRel">
            <label for="form-element-codepostal" class="ds44-formLabel">
                <span class="ds44-labelTypePlaceholder"><span><%= codepostalLabel %><sup aria-hidden="true">*</sup></span></span>
            </label>
            <input type="text" id="form-element-codepostal" name="codePostal" class="ds44-inpStd" title="<%= glp("jcmsplugin.socle.facette.champ-obligatoire.title", codepostalLabel) %>"
                required autocomplete="postal-code" aria-describedby="explanation-form-element-codepostal">
            <button class="ds44-reset" type="button">
                <i class="icon icon-cross icon--sizeL" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.facette.effacer-contenu-champ", codepostalLabel) %></span>
            </button>
        </div>
        <div class="ds44-field-information" aria-live="polite">
            <ul class="ds44-field-information-list ds44-list">
                <li id="explanation-form-element-codepostal" class="ds44-field-information-explanation"><%= glp("jcmsplugin.socle.form.exemple.codepostal") %></li>
            </ul>
        </div>
    </div>
</div>

<%-- Sujet ------------------------------------------------------------ --%>
<% String sujetLabel = channel.getTypeFieldLabel(ContactForm.class, "sujet", userLang);%>
<%
TreeSet sujetCatSet = new TreeSet(Category.getOrderComparator(userLang));
sujetCatSet.addAll(formHandler.getSujetRoot().getChildrenSet());
%>
<div class="ds44-mb3">
    <div class="ds44-form__container">
		<div class="ds44-select__shape ds44-inpStd">
		    <p class="ds44-selectLabel" aria-hidden="true"><%= sujetLabel %><sup aria-hidden="true">*</sup></p>
		    <input class="ds44-input-value" type="hidden"><div id="sujet" data-name="sujet" class="ds44-js-select-radio ds44-selectDisplay" data-required="true"></div>
		    <button class="ds44-reset" type="button"><i class="icon icon-cross icon--sizeL" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.facette.effacer-contenu-champ", sujetLabel) %></span></button>
		    <button type="button" id="button-form-element-sujet" class="ds44-btnIco ds44-posAbs ds44-posRi ds44-btnOpen" aria-expanded="false" title="<%= glp("jcmsplugin.socle.facette.champ-obligatoire.title", sujetLabel) %>"><i class="icon icon--sizeL icon-down" aria-hidden="true"></i><span id="button-message-form-element-sujet" class="visually-hidden"><%= sujetLabel %></span></button>
		</div>

	    <div class="ds44-select-container hidden" aria-hidden="true">
	        <div class="ds44-listSelect">
	            <ul class="ds44-list" id="listbox-form-element-sujet">
	               <jalios:foreach name="itCat" type="Category" collection="<%= sujetCatSet %>">
	                   <li class="ds44-select-list_elem selected_option">
						<div class="ds44-form__container ds44-checkBox-radio_list ">
						    <input type="radio" name="sujet" value="<%= itCat.getId() %>" id="form-element-sujet-<%= itCounter %>" class="ds44-radio"><label id="label-form-element-sujet-<%= itCounter %>" for="form-element-sujet-<%= itCounter %>" class="ds44-radioLabel"><%= itCat.getName() %></label>
						</div>
                        </li>
	                </jalios:foreach>
	            </ul>
	        </div>
	        <button type="button" class="ds44-fullWBtn ds44-btnSelect ds44-theme" title="<%= glp("jcmsplugin.socle.facette.cat-lie.valider-selection.label", sujetLabel) %>"><span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.valider") %></span><i class="icon icon-long-arrow-right ds44-noLineH" aria-hidden="true"></i></button>
	    </div>
    </div>
</div>
 
<%-- Message ------------------------------------------------------------ --%>
<% String messageLabel = channel.getTypeFieldLabel(ContactForm.class, "message", userLang);%>
<div class="ds44-mb3">
	<div class="ds44-form__container">
		<div class="ds44-posRel">
            <label for="form-element-message" class="ds44-formLabel">
                <span class="ds44-labelTypePlaceholder"><span><%= messageLabel %><sup aria-hidden="true">*</sup></span></span>
            </label>
			<textarea rows="5" cols="1" id="form-element-message" name="message" class="ds44-inpStd" title="<%= glp("jcmsplugin.socle.facette.champ-obligatoire.title", messageLabel) %>" required></textarea>
		</div>
	</div>
</div>



<button
    class="jcms-js-submit ds44-btnStd ds44-btn--invert ds44-bntFullw ds44-bntALeft"
    title="Valider l'envoi de votre demande">
    <span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.valider") %></span><i
        class="icon icon-long-arrow-right" aria-hidden="true"></i>
</button>



 
<%
{ 
 TreeSet  removedCatSet = new TreeSet(); 
 Category itRemoveCat = null;
 itRemoveCat = channel.getCategory("$jcmsplugin.socle.form.contactform.sujet.root");
 if (itRemoveCat != null){ removedCatSet.add(itRemoveCat);  }
 request.setAttribute("ContactForm.removedCatSet", removedCatSet);
}   
%>
<jalios:include target="EDIT_PUB_MAINTAB" targetContext="div" />
<jalios:include jsp="/jcore/doEditExtraData.jsp" />