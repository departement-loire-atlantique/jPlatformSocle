<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %>

<%
String formAction = "plugins/SoclePlugin/jsp/forms/checkPageUtile.jsp";
%>

<div class="ds44-loader-text visually-hidden" tabindex="-1" aria-live="polite"></div>
<div class="ds44-loader hidden">
    <div class="ds44-loader-body">
        <svg class="ds44-loader-circular" focusable="false" aria-hidden="true">
            <circle class="ds44-loader-path" cx="30" cy="30" r="20" fill="none" stroke-width="5" stroke-miterlimit="10"></circle>
        </svg>
    </div>
</div>
<section class="ds44-container-fluid ds44-lightBG ds44-wave-white ds44--xxl-padding-tb">
    <header class="txtcenter ds44--xl-padding-b">
        <h2 class="h2-like"><%= glp("jcmsplugin.socle.pageutile.titre") %></h2>
    </header>
    <div class="ds44-inner-container ds44-grid12-offset-1">
        <div class="ds44-choiceYN txtcenter ds44--m-padding-t ds44--xl-padding-b js-tabs">
            <button class="ds44-btnStd js-tablist__link" type="button" aria-pressed="false" aria-label='<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.pageutile.oui")) %>' data-href="#ds44-choiceY" data-statistic='{"name": "declenche-evenement","category": "Avis page","action": "Oui"}'><span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.oui") %></span><i class="icon icon-like icon--sizeL" aria-hidden="true"></i></button>
            <button class="ds44-btnStd js-tablist__link" type="button" aria-pressed="false" aria-label='<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.pageutile.non")) %>' data-href="#ds44-choiceN" data-statistic='{"name": "declenche-evenement","category": "Avis page","action": "Non"}'><span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.non") %></span><i class="icon icon-dislike icon--sizeL" aria-hidden="true"></i></button>
        </div>
        <div id="ds44-choiceY" class="hidden">
            <form data-is-ajax='true' data-is-inline="true" action='<%= formAction %>' >
                <div class="grid-1-small-1 ds44-box">
                    <div>
                        <p id="form-bloc-utils-Y" tabindex="-1"><%= glp("jcmsplugin.socle.pageutile.merci") %></p>
                        <div class="ds44-form__container">
							<div class="ds44-posRel">
							    <label for="commentaire-oui" class="ds44-formLabel"><span class="ds44-labelTypePlaceholder"><span><%= glp("jcmsplugin.socle.pageutile.commentaire") %></span></span></label>
							    <textarea rows="5" cols="1" id="commentaire-oui" name="commentaire" class="ds44-inpStd"></textarea>
							</div>
						</div>
						<div class="ds44-form__container">
							<div class="ds44-posRel">
							    <label for="email-oui" class="ds44-formLabel"><span class="ds44-labelTypePlaceholder"><span><%= glp("jcmsplugin.socle.pageutile.email") %></span></span></label>
							    <input id="email-oui" name="email" type="text" class="form-control control-email form-control-value ds44-inpStd"/>
							</div>
                        </div>
                        
                    </div>
                    <div class="txtcenter ds44-mt-std">
                        <button class="ds44-btnStd" title='<%= glp("jcmsplugin.socle.pageutile.envoyer-commentaire.utile") %>'>
                            <span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.envoyer") %></span>
                            <i class="icon icon-long-arrow-right" aria-hidden="true"></i>
                        </button>
                    </div>
                </div>
                
                <input type="hidden" name="utile" value="true" data-technical-field/>
		        <input type="hidden" name="id" value='<%= request.getParameter("id") %>' data-technical-field />
		        <input type="hidden" name="url" value='<%= ServletUtil.getUrl(request) %>' data-technical-field />
                
            </form>
            <p class="ds44-keyboard-show"><a href="#ds44-choiceY"><%= glp("jcmsplugin.socle.pageutile.retour-oui") %></a></p>
        </div>
        <div id="ds44-choiceN" class="hidden">
            <form data-is-ajax='true' data-is-inline="true" action='<%= formAction %>' data-statistic='{"name": "declenche-evenement","category": "Formulaire","action": "Avis page négatif","label": "$bloc-utile-informations-questions|text"}'>
                <div class="grid-2-small-1 ds44-box">
                    <div class="col">
                        <p id="bloc-utile-informations" class="h4-like" aria-level="3" role="heading" tabindex="-1"><%= glp("jcmsplugin.socle.pageutile.motif-non.titre") %></p>
						<div id="form-element-65721" data-name="bloc-utile-informations-questions" class="ds44-form__checkbox_container ds44-form__container" data-required="true">
					        <p id="mandatory-message-form-element-65721" class="ds44-mandatory_message"><%= glp("jcmsplugin.socle.pageutile.message-case") %></p>
					
							<div class="ds44-form__container ds44-checkBox-radio_list ">
							    <input type="checkbox" id="name-check-form-element-65721-1" name="bloc-utile-informations-questions" value="pasAssezComplet" class="ds44-checkbox" required aria-describedby="mandatory-message-form-element-65721 bloc-utile-informations" /><label for="name-check-form-element-65721-1" class="ds44-boxLabel" id="name-check-label-form-element-65721-1"><%= glp("jcmsplugin.socle.pageutile.pas-assez-complet") %></label>
							</div>
							
							<div class="ds44-form__container ds44-checkBox-radio_list ">
							    <input type="checkbox" id="name-check-form-element-65721-2" name="bloc-utile-informations-questions" value="tropComplique" class="ds44-checkbox" required aria-describedby="mandatory-message-form-element-65721 bloc-utile-informations" /><label for="name-check-form-element-65721-2" class="ds44-boxLabel" id="name-check-label-form-element-65721-2"><%= glp("jcmsplugin.socle.pageutile.trop-complique") %></label>
							</div>
							
							<div class="ds44-form__container ds44-checkBox-radio_list ">
							    <input type="checkbox" id="name-check-form-element-65721-3" name="bloc-utile-informations-questions" value="tropLong" class="ds44-checkbox" required aria-describedby="mandatory-message-form-element-65721 bloc-utile-informations" /><label for="name-check-form-element-65721-3" class="ds44-boxLabel" id="name-check-label-form-element-65721-3"><%= glp("jcmsplugin.socle.pageutile.trop-a-lire") %></label>
							</div>
						</div>
                    </div>
                    <div class="col ds44--xl-padding-l">
                        <p id="form-bloc-utils-N"><%= glp("jcmsplugin.socle.pageutile.aide-ameliorer") %></p>
						<div class="ds44-form__container">
							<div class="ds44-posRel">
							    <label for="commentaire-non" class="ds44-formLabel"><span class="ds44-labelTypePlaceholder"><span><%= glp("jcmsplugin.socle.pageutile.commentaire") %></span></span></label>
							    <textarea rows="5" cols="1" id="commentaire-non" name="commentaire" class="ds44-inpStd" aria-describedby="form-bloc-utils-N"></textarea>
							</div>
						</div>
						<div class="ds44-form__container">
							<div class="ds44-posRel">
							    <label for="email-non" class="ds44-formLabel"><span class="ds44-labelTypePlaceholder"><span><%= glp("jcmsplugin.socle.pageutile.email") %></span></span></label>
							    <input id="email-non" name="email" type="text" class="form-control control-email form-control-value ds44-inpStd"/>
							</div>
                        </div>
                    </div>
                </div>
                <div class="txtcenter ds44-mt-std">
                    <button class="ds44-btnStd" title='<%= glp("jcmsplugin.socle.pageutile.envoyer-commentaire.inutile") %>'>
                        <span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.envoyer") %></span>
                        <i class="icon icon-long-arrow-right" aria-hidden="true"></i>
                    </button>
                </div>
                
                <input type="hidden" name="utile" value="false" data-technical-field/>
                <input type="hidden" name="id" value='<%= request.getParameter("id") %>' data-technical-field />
                <input type="hidden" name="url" value='<%= ServletUtil.getUrl(request) %>' data-technical-field />

                
            </form>
            <p class="ds44-keyboard-show"><a href="#ds44-choiceN"><%= glp("jcmsplugin.socle.pageutile.retour-non") %></a></p>
        </div>
    </div>
</section>
