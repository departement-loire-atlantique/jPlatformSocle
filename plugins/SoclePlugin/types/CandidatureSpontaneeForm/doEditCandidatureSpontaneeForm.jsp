<%-- This file has been automatically generated. --%>
<%--
  @Summary: CandidatureSpontaneeForm content editor
  @Category: Generated
  @Author: JCMS Type Processor 
  @Customizable: True
  @Requestable: False 
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %>
<% 
  EditCandidatureSpontaneeFormHandler formHandler = (EditCandidatureSpontaneeFormHandler)request.getAttribute("formHandler");
  ServletUtil.backupAttribute(pageContext, "classBeingProcessed");
  request.setAttribute("classBeingProcessed", generated.CandidatureSpontaneeForm.class);
%>

<%-- NatureRecherche ------------------------------------------------------------ --%>
<% String natureRechercheLabel = channel.getTypeFieldLabel(CandidatureSpontaneeForm.class, "natureRecherche", userLang);%>
<%
TreeSet natureRechercheCatSet = new TreeSet(Category.getOrderComparator(userLang));
natureRechercheCatSet.addAll(formHandler.getNatureRechercheRoot().getChildrenSet());
%>
<div class="ds44-mb3">
    <div class="ds44-form__container">
        <div class="ds44-select__shape ds44-inpStd">
            <p id="label-form-element-nature" class="ds44-selectLabel" aria-hidden="true"><%= natureRechercheLabel %><sup aria-hidden="true">*</sup></p>
            <input class="ds44-input-value" type="hidden"><div id="natureRecherche" data-name="natureRecherche" class="ds44-js-select-radio ds44-selectDisplay" data-required="true"></div>
            <button class="ds44-reset" type="button" aria-describedby="label-form-element-nature">
                <i class="icon icon-cross icon--sizeL" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.facette.effacer-contenu-champ", natureRechercheLabel) %></span>
            </button>
            <button type="button" id="button-form-element-sujet" class="ds44-btnIco ds44-posAbs ds44-posRi ds44-btnOpen" aria-expanded="false" title="<%= glp("jcmsplugin.socle.facette.champ-obligatoire.title", natureRechercheLabel) %>"><i class="icon icon--sizeL icon-down" aria-hidden="true"></i><span id="button-message-form-element-sujet" class="visually-hidden"><%= natureRechercheLabel %></span></button>
        </div>

        <div class="ds44-select-container hidden" aria-hidden="true">
            <div class="ds44-listSelect">
                <ul class="ds44-list" id="listbox-form-element-sujet">
                   <jalios:foreach name="itCat" type="Category" collection="<%= natureRechercheCatSet %>">
                       <li class="ds44-select-list_elem selected_option">
                        <div class="ds44-form__container ds44-checkBox-radio_list ">
                            <input type="radio" name="natureRecherche" value="<%= itCat.getId() %>" id="form-element-sujet-<%= itCounter %>" class="ds44-radio"><label id="label-form-element-sujet-<%= itCounter %>" for="form-element-sujet-<%= itCounter %>" class="ds44-radioLabel"><%= itCat.getName() %></label>
                        </div>
                        </li>
                    </jalios:foreach>
                </ul>
            </div>
            <button type="button" class="ds44-fullWBtn ds44-btnSelect ds44-theme" title="<%= glp("jcmsplugin.socle.facette.cat-lie.valider-selection.label", natureRechercheLabel) %>"><span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.valider") %></span><i class="icon icon-long-arrow-right ds44-noLineH" aria-hidden="true"></i></button>
        </div>
    </div>
</div>

<%-- Nom ------------------------------------------------------------ --%>
<% String nomLabel = channel.getTypeFieldLabel(CandidatureSpontaneeForm.class, "nom", userLang);%>
<div class="ds44-mb3">
    <div class="ds44-form__container">
        <div class="ds44-posRel">
            <label id="label-form-element-nom" for="form-element-nom" class="ds44-formLabel">
              <span class="ds44-labelTypePlaceholder"><span><%= nomLabel %><sup aria-hidden="true">*</sup></span></span>
            </label>
            <input type="text" id="form-element-nom" name="nom"
                class="ds44-inpStd" title="<%= glp("jcmsplugin.socle.facette.champ-obligatoire.title", nomLabel) %>"
                required="" autocomplete="family-name">
            <button class="ds44-reset" type="button" aria-describedby="label-form-element-nom">
                <i class="icon icon-cross icon--sizeL" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.facette.effacer-contenu-champ", nomLabel) %></span>
            </button>
        </div>
    </div>
</div>
 
<%-- Prenom ------------------------------------------------------------ --%>
<% String prenomLabel = channel.getTypeFieldLabel(CandidatureSpontaneeForm.class, "prenom", userLang);%>
<div class="ds44-mb3">
    <div class="ds44-form__container">
        <div class="ds44-posRel">
            <label id="label-form-element-prenom" for="form-element-prenom" class="ds44-formLabel">
              <span class="ds44-labelTypePlaceholder"><span><%= prenomLabel %><sup aria-hidden="true">*</sup></span></span>
            </label>
            <input type="text" id="form-element-prenom" name="prenom" class="ds44-inpStd" title="<%= glp("jcmsplugin.socle.facette.champ-obligatoire.title", prenomLabel) %>"
                required="" autocomplete="given-name">
            <button class="ds44-reset" type="button" aria-describedby="label-form-element-prenom">
                <i class="icon icon-cross icon--sizeL" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.facette.effacer-contenu-champ", prenomLabel) %></span>
            </button>
        </div>
    </div>
</div>
 
<%-- Mail ------------------------------------------------------------ --%>
<% String mailLabel = channel.getTypeFieldLabel(CandidatureSpontaneeForm.class, "mail", userLang);%>
<div class="ds44-mb3">
    <div class="ds44-form__container">
        <div class="ds44-posRel">
            <label id="label-form-element-mail" for="form-element-mail" class="ds44-formLabel">
                <span class="ds44-labelTypePlaceholder"><span><%= mailLabel %><sup aria-hidden="true">*</sup></span></span>
            </label>
            <input type="email" id="form-element-mail" name="mail" class="ds44-inpStd" title="<%= glp("jcmsplugin.socle.facette.champ-obligatoire.title", mailLabel) %>"
                required="" autocomplete="email" aria-describedby="explanation-form-element-mail">
            <button class="ds44-reset" type="button" aria-describedby="label-form-element-mail">
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
<% String telephoneLabel = channel.getTypeFieldLabel(CandidatureSpontaneeForm.class, "telephone", userLang);%>
<div class="ds44-mb3">
    <div class="ds44-form__container">
        <div class="ds44-posRel">
            <label id="label-form-element-telephone" for="form-element-telephone" class="ds44-formLabel">
                <span class="ds44-labelTypePlaceholder"><span><%= telephoneLabel %><sup aria-hidden="true">*</sup></span></span>
            </label>
            <input type="text" id="form-element-telephone" name="telephone" class="ds44-inpStd" title="<%= glp("jcmsplugin.socle.facette.champ-obligatoire.title", telephoneLabel) %>"
                autocomplete="tel" aria-describedby="explanation-form-element-telephone">
            <button class="ds44-reset" type="button" aria-describedby="label-form-element-telephone">
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
<% String codepostalLabel = channel.getTypeFieldLabel(CandidatureSpontaneeForm.class, "codePostal", userLang);%>
<div class="ds44-mb3">
    <div class="ds44-form__container">
        <div class="ds44-posRel">
            <label id="label-form-element-codepostal" for="form-element-codepostal" class="ds44-formLabel">
                <span class="ds44-labelTypePlaceholder"><span><%= codepostalLabel %><sup aria-hidden="true">*</sup></span></span>
            </label>
            <input type="text" id="form-element-codepostal" name="codePostal" class="ds44-inpStd" title="<%= glp("jcmsplugin.socle.facette.champ-obligatoire.title", codepostalLabel) %>"
                autocomplete="postal-code" aria-describedby="explanation-form-element-codepostal">
            <button class="ds44-reset" type="button" aria-describedby="label-form-element-codepostal">
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
 
<%-- CurriculumVitae ------------------------------------------------------------ --%>
<% String cvLabel = channel.getTypeFieldLabel(CandidatureSpontaneeForm.class, "curriculumVitae", userLang);%>
<div class="ds44-mb3">
	<div class="ds44-form__container">
		<div class="ds44-posRel">
            <label id="label-form-element-cv" for="form-element-cv" class="ds44-formLabel">
                <span class="ds44-labelTypePlaceholder"><span><%= cvLabel %><sup aria-hidden="true">*</sup></span></span>
		    </label>
		    
		    <div class="ds44-file__shape ds44-inpStd">
		        <input type="file" id="form-element-cv" name="curriculumVitae" title="<%= glp("jcmsplugin.socle.facette.champ-obligatoire.title", cvLabel) %>" data-file-extensions="doc,docx,pdf" required   aria-describedby="explanation-form-element-cv"  />
		        <div id="file-display-form-element-cv" class="ds44-fileDisplay"></div>
		    </div>
		    <button class="ds44-reset" type="button" aria-describedby="label-form-element-cv">
		      <i class="icon icon-cross icon--sizeL" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.facette.effacer-contenu-champ", cvLabel) %></span>
            </button>
		
		    <span class="ds44-file" aria-hidden="true"><i class="icon icon-directory icon--medium" aria-hidden="true"></i></span>
		
		</div>
	
	    <div class="ds44-field-information" aria-live="polite">
	        <ul class="ds44-field-information-list ds44-list">
	            <li id="explanation-form-element-cv" class="ds44-field-information-explanation"><%= glp("jcmsplugin.socle.form.exemple.formats") %></li>
	        </ul>
	    </div>
	
	</div>
</div>
 
<%-- LettreMotivation ------------------------------------------------------------ --%>
<% String lettreLabel = channel.getTypeFieldLabel(CandidatureSpontaneeForm.class, "lettreMotivation", userLang);%>
<div class="ds44-mb3">
    <div class="ds44-form__container">
        <div class="ds44-posRel">
            <label id="label-form-element-lettre" for="form-element-lettre" class="ds44-formLabel">
                <span class="ds44-labelTypePlaceholder"><span><%= lettreLabel %><sup aria-hidden="true">*</sup></span></span>
            </label>
            
            <div class="ds44-file__shape ds44-inpStd">
                <input type="file" id="form-element-lettre" name="lettreMotivation" title="<%= glp("jcmsplugin.socle.facette.champ-obligatoire.title", lettreLabel) %>" data-file-extensions="doc,docx,pdf" required aria-describedby="explanation-form-element-lettre"  />
                <div id="file-display-form-element-lettre" class="ds44-fileDisplay"></div>
            </div>
            <button class="ds44-reset" type="button" aria-describedby="label-form-element-lettre">
              <i class="icon icon-cross icon--sizeL" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.facette.effacer-contenu-champ", lettreLabel) %></span>
            </button>
        
            <span class="ds44-file" aria-hidden="true"><i class="icon icon-directory icon--medium" aria-hidden="true"></i></span>
        
        </div>
    
        <div class="ds44-field-information" aria-live="polite">
            <ul class="ds44-field-information-list ds44-list">
                <li id="explanation-form-element-lettre" class="ds44-field-information-explanation"><%= glp("jcmsplugin.socle.form.exemple.formats") %></li>
            </ul>
        </div>
    
    </div>
</div>
 
<%-- PieceComplementaire1 ------------------------------------------------------------ --%>
<% String complementLabel1 = channel.getTypeFieldLabel(CandidatureSpontaneeForm.class, "pieceComplementaire1", userLang);%>
<div class="ds44-mb3">
    <div class="ds44-form__container">
        <div class="ds44-posRel">
            <label id="label-form-element-complement1" for="form-element-complement1" class="ds44-formLabel">
                <span class="ds44-labelTypePlaceholder"><span><%= complementLabel1 %><sup aria-hidden="true">*</sup></span></span>
            </label>
            
            <div class="ds44-file__shape ds44-inpStd">
                <input type="file" id="form-element-complement1" name="pieceComplementaire1" title="<%= glp("jcmsplugin.socle.facette.champ-obligatoire.title", complementLabel1) %>" data-file-extensions="doc,docx,pdf" aria-describedby="explanation-form-element-complement1"  />
                <div id="file-display-form-element-complement1" class="ds44-fileDisplay"></div>
            </div>
            <button class="ds44-reset" type="button" aria-describedby="label-form-element-complement1">
              <i class="icon icon-cross icon--sizeL" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.facette.effacer-contenu-champ", complementLabel1) %></span>
            </button>
        
            <span class="ds44-file" aria-hidden="true"><i class="icon icon-directory icon--medium" aria-hidden="true"></i></span>
        
        </div>
    
        <div class="ds44-field-information" aria-live="polite">
            <ul class="ds44-field-information-list ds44-list">
                <li id="explanation-form-element-complement1" class="ds44-field-information-explanation"><%= glp("jcmsplugin.socle.form.exemple.types-docs") %> <%= glp("jcmsplugin.socle.form.exemple.formats") %></li>
            </ul>
        </div>
    
    </div>
</div>

<%-- PieceComplementaire2 ------------------------------------------------------------ --%>
<% String complementLabel2 = channel.getTypeFieldLabel(CandidatureSpontaneeForm.class, "pieceComplementaire2", userLang);%>
<div class="ds44-mb3">
    <div class="ds44-form__container">
        <div class="ds44-posRel">
            <label id="label-form-element-complement1" for="form-element-complement2" class="ds44-formLabel">
                <span class="ds44-labelTypePlaceholder"><span><%= complementLabel2 %><sup aria-hidden="true">*</sup></span></span>
            </label>
            
            <div class="ds44-file__shape ds44-inpStd">
                <input type="file" id="form-element-complement2" name="pieceComplementaire2" title="<%= glp("jcmsplugin.socle.facette.champ-obligatoire.title", complementLabel2) %>" data-file-extensions="doc,docx,pdf" aria-describedby="explanation-form-element-complement2"  />
                <div id="file-display-form-element-complement2" class="ds44-fileDisplay"></div>
            </div>
            <button class="ds44-reset" type="button" aria-describedby="label-form-element-complement2">
              <i class="icon icon-cross icon--sizeL" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.facette.effacer-contenu-champ", complementLabel2) %></span>
            </button>
        
            <span class="ds44-file" aria-hidden="true"><i class="icon icon-directory icon--medium" aria-hidden="true"></i></span>
        
        </div>
    
        <div class="ds44-field-information" aria-live="polite">
            <ul class="ds44-field-information-list ds44-list">
                <li id="explanation-form-element-complement2" class="ds44-field-information-explanation"><%= glp("jcmsplugin.socle.form.exemple.types-docs") %> <%= glp("jcmsplugin.socle.form.exemple.formats") %></li>
            </ul>
        </div>
    
    </div>
</div>

<%-- PieceComplementaire3 ------------------------------------------------------------ --%>
<% String complementLabel3 = channel.getTypeFieldLabel(CandidatureSpontaneeForm.class, "pieceComplementaire3", userLang);%>
<div class="ds44-mb3">
    <div class="ds44-form__container">
        <div class="ds44-posRel">
            <label id="label-form-element-complement3" for="form-element-complement3" class="ds44-formLabel">
                <span class="ds44-labelTypePlaceholder"><span><%= complementLabel3 %><sup aria-hidden="true">*</sup></span></span>
            </label>
            
            <div class="ds44-file__shape ds44-inpStd">
                <input type="file" id="form-element-complement3" name="pieceComplementaire3" title="<%= glp("jcmsplugin.socle.facette.champ-obligatoire.title", complementLabel3) %>" data-file-extensions="doc,docx,pdf" aria-describedby="explanation-form-element-complement3"  />
                <div id="file-display-form-element-complement3" class="ds44-fileDisplay"></div>
            </div>
            <button class="ds44-reset" type="button" aria-describedby="label-form-element-complement3">
              <i class="icon icon-cross icon--sizeL" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.facette.effacer-contenu-champ", complementLabel3) %></span>
            </button>
        
            <span class="ds44-file" aria-hidden="true"><i class="icon icon-directory icon--medium" aria-hidden="true"></i></span>
        
        </div>
    
        <div class="ds44-field-information" aria-live="polite">
            <ul class="ds44-field-information-list ds44-list">
                <li id="explanation-form-element-complement3" class="ds44-field-information-explanation"><%= glp("jcmsplugin.socle.form.exemple.types-docs") %> <%= glp("jcmsplugin.socle.form.exemple.formats") %></li>
            </ul>
        </div>
    
    </div>
</div>
<button
    class="jcms-js-submit ds44-btnStd ds44-btn--invert ds44-bntFullw ds44-bntALeft"
    title="<%= glp("jcmsplugin.socle.form.valider-envoi") %>">
    <span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.valider") %></span><i
        class="icon icon-long-arrow-right" aria-hidden="true"></i>
</button>
 
<%
{ 
  TreeSet  removedCatSet = new TreeSet(); 
  Category itRemoveCat = null;
  itRemoveCat = channel.getCategory("$jcmsplugin.socle.emploiStage.typeOffre.root");
  if (itRemoveCat != null){ removedCatSet.add(itRemoveCat);  }
  request.setAttribute("CandidatureSpontaneeForm.removedCatSet", removedCatSet);
}  
%>
<jalios:include target="EDIT_PUB_MAINTAB" targetContext="div" />
<jalios:include jsp="/jcore/doEditExtraData.jsp" />
<% ServletUtil.restoreAttribute(pageContext , "classBeingProcessed"); %>