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
  
  boolean multilingue = channel.getBooleanProperty("jcmsplugin.socle.multilingue", false);
  boolean displayVilleField = channel.getBooleanProperty("jcmsplugin.socle.contact.display.ville", false);
%>
<%-- Name ------------------------------------------------------------ --%>
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
 
<%-- FirstName ------------------------------------------------------------ --%>
<% String prenomLabel = glp("jcmsplugin.socle.prenom"); %>
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

<%-- Phone ------------------------------------------------------------ --%>
<jalios:if predicate='<%= userLang.equals("fr") %>'>
<%  String telephoneLabel = glp("jcmsplugin.socle.telephone");
    String telAutocompleteValue = multilingue ? "tel" : "tel-national";
%>
<div class="ds44-mb3">
    <div class="ds44-form__container">
        <div class="ds44-posRel">
            <label for="form-element-telephone" class="ds44-formLabel">
                <span class="ds44-labelTypePlaceholder"><span><%= telephoneLabel %></span></span>
            </label>
            <input type="text" id="form-element-telephone" name="telephone" class="ds44-inpStd" autocomplete="<%= telAutocompleteValue %>" aria-describedby="explanation-form-element-telephone">
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
</jalios:if>

<%-- Adresse ------------------------------------------------------------ --%>
<jalios:if predicate='<%= ! multilingue %>'>
	<% String adresseLabel = glp("jcmsplugin.socle.adresse"); %>
	<div class="ds44-mb3">
	    <div class="ds44-form__container">
	        <div class="ds44-posRel">
	            <label for="form-element-adresse" class="ds44-formLabel">
	                <span class="ds44-labelTypePlaceholder"><span><%= adresseLabel %></span></span>
	            </label>
	            <input type="text" id="form-element-adresse" name="adresse" class="ds44-inpStd" aria-describedby="explanation-form-element-adresse">
	            <button class="ds44-reset" type="button">
	                <i class="icon icon-cross icon--sizeL" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.facette.effacer-contenu-champ", adresseLabel) %></span>
	            </button>
	        </div>
	        <div class="ds44-field-information" aria-live="polite">
	            <ul class="ds44-field-information-list ds44-list">
	                <li id="explanation-form-element-adresse" class="ds44-field-information-explanation"><%= glp("jcmsplugin.socle.form.exemple.adresse") %></li>
	            </ul>
	        </div>
	    </div>
	</div>
</jalios:if>


<%-- complementDadresse ------------------------------------------------------------ --%>
<jalios:if predicate='<%= ! multilingue %>'>
	<% String complementDAdresseLabel = glp("jcmsplugin.socle.complement-adresse"); %>
	<div class="ds44-mb3">
	    <div class="ds44-form__container">
	        <div class="ds44-posRel">
	            <label for="form-element-complement-adresse" class="ds44-formLabel">
	                <span class="ds44-labelTypePlaceholder"><span><%= complementDAdresseLabel %></span></span>
	            </label>
	            <input type="text" id="form-element-complement-adresse" name="complementDadresse" class="ds44-inpStd" aria-describedby="explanation-form-element-complement-adresse">
	            <button class="ds44-reset" type="button">
	                <i class="icon icon-cross icon--sizeL" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.facette.effacer-contenu-champ", complementDAdresseLabel) %></span>
	            </button>
	        </div>
	        <div class="ds44-field-information" aria-live="polite">
	            <ul class="ds44-field-information-list ds44-list">
	                <li id="explanation-form-element-complement-adresse" class="ds44-field-information-explanation"><%= glp("jcmsplugin.socle.form.exemple.complement-adresse") %></li>
	            </ul>
	        </div>
	    </div>
	</div>
</jalios:if>

<%-- structure ------------------------------------------------------------ --%>
<jalios:if predicate='<%= multilingue && userLang.equals("fr") %>'>
    <% String structureLabel = glp("jcmsplugin.socle.structure"); %>
    <div class="ds44-mb3">
        <div class="ds44-form__container">
            <div class="ds44-posRel">
                <label for="form-element-structure" class="ds44-formLabel">
                    <span class="ds44-labelTypePlaceholder"><span><%= structureLabel %></span></span>
                </label>
                <input type="text" id="form-element-structure" name="structure" class="ds44-inpStd" aria-describedby="explanation-form-element-structure">
                <button class="ds44-reset" type="button">
                    <i class="icon icon-cross icon--sizeL" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.facette.effacer-contenu-champ", structureLabel) %></span>
                </button>
            </div>
            <div class="ds44-field-information" aria-live="polite">
                <ul class="ds44-field-information-list ds44-list">
                    <li id="explanation-form-element-structure" class="ds44-field-information-explanation"><%= glp("jcmsplugin.socle.form.exemple.structure") %></li>
                </ul>
            </div>
        </div>
    </div>
</jalios:if>

<%-- CodePostal ------------------------------------------------------------ --%>
<jalios:if predicate='<%= ! multilingue %>'>
	<% String codepostalLabel = glp("jcmsplugin.socle.code-postal"); %>
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
</jalios:if>

<%-- CodePostal ML (non obligatoire) -------------------------------------------------------- --%>
<jalios:if predicate='<%= multilingue && userLang.equals("fr") %>'>
    <% String codepostalLabel = glp("jcmsplugin.socle.code-postal"); %>
    <div class="ds44-mb3">
        <div class="ds44-form__container">
            <div class="ds44-posRel">
                <label for="form-element-codepostal" class="ds44-formLabel">
                    <span class="ds44-labelTypePlaceholder"><span><%= codepostalLabel %></span></span>
                </label>
                <input type="text" id="form-element-codepostal" name="codePostal" class="ds44-inpStd" title="<%= glp("jcmsplugin.socle.facette.champ-obligatoire.title", codepostalLabel) %>"
                    autocomplete="postal-code" aria-describedby="explanation-form-element-codepostal">
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
</jalios:if>

<%-- Ville ------------------------------------------------------------ --%>
<jalios:if predicate='<%= (multilingue && userLang.equals("fr")) || displayVilleField %>'>
    <% String villeLabel = glp("jcmsplugin.socle.ville"); %>
    <div class="ds44-form__container">
        <div class="ds44-posRel">
            <label for="form-element-ville" class="ds44-formLabel">
                <span class="ds44-labelTypePlaceholder">
                    <span class="ds44-labelTypePlaceholder"><%= villeLabel %></span>
                </span>
            </label>
            <input type="text" id="form-element-ville" name="ville" class="ds44-inpStd" autocomplete="address-level2" />
            <button class="ds44-reset" type="button">
                <i class="icon icon-cross icon--sizeL" aria-hidden="true"></i>
                <span class="visually-hidden">
                    <%= glp("jcmsplugin.socle.facette.effacer-contenu-champ", villeLabel) %>
                </span>
            </button> 
            
        </div>
    </div>
</jalios:if>

<jalios:if predicate='<%= multilingue %>'>
    <%-- Pays ------------------------------------------------------------ --%>
    <% String paysLabel = glp("jcmsplugin.socle.pays"); %>
    <div class="ds44-form__container">
        <div class="ds44-posRel">
            <label for="form-element-pays" class="ds44-formLabel">
                <span class="ds44-labelTypePlaceholder">
                    <span class="ds44-labelTypePlaceholder"><%= paysLabel %><sup aria-hidden="true">*</sup></span>
                </span>
            </label>
            <input type="text" id="form-element-pays" name="pays" class="ds44-inpStd" required
                   title='<%= glp("jcmsplugin.socle.faq.selectionner-pays") %>' autocomplete="country"/>
            <button class="ds44-reset" type="button">
                <i class="icon icon-cross icon--sizeL" aria-hidden="true"></i>
                <span class="visually-hidden">
                    <%= glp("jcmsplugin.socle.facette.effacer-contenu-champ", paysLabel) %>
                </span>
            </button> 
            
        </div>
    </div>
</jalios:if>

<%-- Sujet ------------------------------------------------------------ --%>
<% String sujetLabel = glp("jcmsplugin.socle.sujet"); %>
<%
TreeSet sujetCatSet = new TreeSet(Category.getOrderComparator(userLang));
sujetCatSet.addAll(formHandler.getSujetRoot().getChildrenSet());
%>
<div class="ds44-mb3">
	<div class="ds44-form__container">
		<div class="ds44-select__shape ds44-inpStd">
			<p class="ds44-selectLabel" aria-hidden="true"><%= sujetLabel %><sup aria-hidden="true">*</sup></p>
			<div id="sujet" data-name="sujet" class="ds44-js-select-standard ds44-selectDisplay" data-required="true"></div>
			<button type="button" id="button-form-element-sujet" class="ds44-btnIco ds44-posAbs ds44-posRi ds44-btnOpen" aria-expanded="false" title="<%= glp("jcmsplugin.socle.facette.champ-obligatoire.title", sujetLabel) %>"  ><i class="icon icon-down icon--sizeL" aria-hidden="true"></i><span id="button-message-form-element-sujet" class="visually-hidden"><%= sujetLabel %></span></button>
			<button class="ds44-reset" type="button"><i class="icon icon-cross icon--sizeL" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.facette.effacer-contenu-champ", sujetLabel) %></span></button>
		
		</div>
	
		<div class="ds44-select-container hidden">
			<div class="ds44-listSelect">
				<ul class="ds44-list" role="listbox" id="listbox-form-element-sujet" aria-labelledby="button-message-form-element-sujet"  aria-required="true">
					<jalios:foreach name="itCat" type="Category" collection="<%= sujetCatSet %>">
						<li class="ds44-select-list_elem" role="option" data-value="<%= itCat.getId() %>" id="form-element-sujet-<%= itCounter %>" tabindex="0">
							<%= itCat.getName(userLang) %>
						</li>
					</jalios:foreach>
				</ul>
			</div>
		</div>
	</div>
</div>
 
<%-- Message ------------------------------------------------------------ --%>
<% String messageLabel = glp("jcmsplugin.socle.votre-message"); %>
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
