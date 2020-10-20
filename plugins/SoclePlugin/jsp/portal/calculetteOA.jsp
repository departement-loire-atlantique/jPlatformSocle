<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file='/jcore/doInitPage.jspf' %>

<section id="sectionCalculette" class="ds44-contenuArticle">
    <div class="ds44-inner-container ds44-mtb3">
        <div class="ds44-grid12-offset-2">
                

			<section class="ds44-box ds44-theme ds44-mb3">
			    <div class="ds44-innerBoxContainer">
			        <template id="ds44-js-soa-template" class="hidden">
			            <div class="ds44-blocObligeAlim ds44-js-soa-item">
			                <fieldset>
			                    <legend role="heading" aria-level="3" class="h5-like"><%= glp("jcmsplugin.socle.calculetteOA.fieldset.legend") %><span class="ds44-js-soa-number"></span></legend>
			                    
			                    <div class="ds44-form__container">
			                        <div class="ds44-posRel">
			                            <label for="ds44-js-soa-template-field-1" class="ds44-formLabel"><span class="ds44-labelTypePlaceholder"><span><%= glp("jcmsplugin.socle.calculetteOA.revenubrut.label") %><sup aria-hidden="true">*</sup></span></span></label>
 			                            <input type="text" id="ds44-js-soa-template-field-1" name="ds44-js-soa-template-field-1" class="ds44-inpStd" title="<%= glp("jcmsplugin.socle.calculetteOA.revenubrut.title") %>" inputmode="numeric" pattern="[0-9]*" required   aria-describedby="explanation-ds44-js-soa-template-field-1" /><button class="ds44-reset" type="button"><i class="icon icon-cross icon--sizeL" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.facette.effacer-contenu-champ", glp("jcmsplugin.socle.calculetteOA.revenubrut.label")) %></span></button>
			                        </div>
			
			                        <div class="ds44-field-information" aria-live="polite">
			                            <ul class="ds44-field-information-list ds44-list">
			                                <li id="explanation-ds44-js-soa-template-field-1" class="ds44-field-information-explanation"><%= glp("jcmsplugin.socle.calculetteOA.revenubrut.info") %></li>
			                            </ul>
			                        </div>
			
			                    </div>
			
			
			                    <div class="ds44-form__container">
			                        <div class="ds44-select__shape ds44-inpStd">
			                            <p class="ds44-selectLabel" aria-hidden="true"><%= glp("jcmsplugin.socle.calculetteOA.partsfiscales.label") %><sup aria-hidden="true">*</sup></p>
			                            <div id="ds44-js-soa-template-field-2" data-name="ds44-js-soa-template-field-2" class="ds44-js-select-standard ds44-selectDisplay"  data-required="true"></div>
			                            <button type="button" id="button-ds44-js-soa-template-field-2" class="ds44-btnIco ds44-posAbs ds44-posRi ds44-btnOpen" aria-expanded="false" title="<%= glp("jcmsplugin.socle.calculetteOA.partsfiscales.title") %>"  aria-describedby="explanation-ds44-js-soa-template-field-2"><i class="icon icon-down icon--sizeL" aria-hidden="true"></i><span id="button-message-ds44-js-soa-template-field-2" class="visually-hidden"><%= glp("jcmsplugin.socle.calculetteOA.partsfiscales.title") %></span></button>
			                            <button class="ds44-reset" type="button"><i class="icon icon-cross icon--sizeL" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.facette.effacer-contenu-champ", glp("jcmsplugin.socle.calculetteOA.partsfiscales.label")) %></span></button>
			                        </div>
			
			                        <div class="ds44-select-container hidden">
			                            <div class="ds44-listSelect">
			                                <ul class="ds44-list" role="listbox" id="listbox-ds44-js-soa-template-field-2" aria-labelledby="button-message-ds44-js-soa-template-field-2" aria-required="true">
                                                <%
                                                // Génération de la liste du nb de parts fiscales (1 / 1.5 / 2 / 2.5 ... 15)
                                                float i = 1;
                                                float step = 0.5f;
                                                int max = channel.getIntegerProperty("jcmsplugin.socle.calculetteOA.partsMax",15);
                                                while(i <= max) { %>
					                               <li class="ds44-select-list_elem" data-value="<%= Float.toString(i).replaceAll("\\.0","") %>" tabindex="0"><%= Float.toString(i).replaceAll("\\.0","") %></li>
					                               <%
					                               i=i+step;
					                            } %>
			                                </ul>
			                            </div>
			                        </div>
			
			                        <div class="ds44-field-information" aria-live="polite">
			                            <ul class="ds44-field-information-list ds44-list">
			                                <li id="explanation-ds44-js-soa-template-field-2" class="ds44-field-information-explanation"><%= glp("jcmsplugin.socle.calculetteOA.partsfiscales.info") %></li>
			                            </ul>
			                        </div>
			
			
			                    </div>
			
			                </fieldset>
			            </div>
			        </template>
			

			        <p role="heading" aria-level="2" class="ds44-box-heading"><%= glp("jcmsplugin.socle.calculetteOA.titre") %></p>
			        <p class="ds44-textLegend--mentions ds44-mb2"><%= glp("jcmsplugin.socle.facette.champs-obligatoires") %></p>

			        <form id="ds44-js-soa-form" data-is-ajax="true">
			            <div id="ds44-js-soa-container"></div>
			            <div class="ds44-blocObligeAlim ds44--l-padding-tb">
			                <button type="button" id="ds44-js-soa-add" class="ds44-addObligeAlim ds44-mtb1 ds44-block" tabindex="0">
			                    <i class="icon icon-plus icon--sizeS" aria-hidden="true"></i><span class="ds44-iconInnerText"><%= glp("jcmsplugin.socle.calculetteOA.ajouter") %></span>
			                </button>
			                <button type="button" id="ds44-js-soa-delete" class="ds44-removeObligeAlim ds44-mtb1 ds44-none" tabindex="0">
			                    <i class="icon icon-minus icon--sizeS" aria-hidden="true"></i><span class="ds44-iconInnerText"><%= glp("jcmsplugin.socle.calculetteOA.supprimer") %></span>
			                </button>
			            </div>
			            <button class="ds44-btnStd ds44-btn--invert" type="submit" title="<%= glp("jcmsplugin.socle.calculetteOA.bouton.title") %>">
			                <span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.calculetteOA.bouton.label") %></span><i class="icon icon-long-arrow-right" aria-hidden="true"></i>
			            </button>
			        </form>
			
			        <div id="ds44-js-soa-results" class="hidden"></div>
			    </div>
			</section>
			
			<script>
			    window.FORM_OBLIGATION_ALIMENTAIRE = {
			        "threshold": <%= channel.getProperty("jcmsplugin.socle.calculetteOA.seuil") %>,
			        "delta": <%= channel.getProperty("jcmsplugin.socle.calculetteOA.demi-part") %>
			    }
			</script>

                
        </div>
    </div>
</section>
