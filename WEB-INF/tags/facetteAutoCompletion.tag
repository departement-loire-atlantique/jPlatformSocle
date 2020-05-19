<%@ taglib prefix="ds" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="jcms.tld" prefix="jalios" %>
<%@ tag 
	pageEncoding="UTF-8"
	description="Facette catégorie sans container" 
	body-content="scriptless" 
	import="com.jalios.jcms.Channel, 
			com.jalios.util.Util, 
			com.jalios.jcms.JcmsUtil, 
			com.jalios.jcms.Category, 
			java.util.Set,
			generated.AbstractPortletFacette" 
%>
<%@ attribute name="isFacetteObligatoire" 
		required="true" 
		fragment="false" 
		rtexprvalue="true" 
		type="Boolean" 
		description="Est-ce que la facette est obligatoire" 
%>
<%@ attribute name="idFormElement" 
		required="true" 
		fragment="false" 
		rtexprvalue="true" 
		type="String" 
		description="Id de la facette" 
%>
<%@ attribute name="dataMode" 
		required="true" 
		fragment="false" 
		rtexprvalue="true" 
		type="String" 
		description="Choisir entre select-only (le champ n'est rempli qu'avec une option d'autocompletion) et free-text" 
%>
<%@ attribute name="dataUrl" 
		required="true" 
		fragment="false" 
		rtexprvalue="true" 
		type="String" 
		description="URL ou on recupere les valeurs d'autocompletion" 
%>
<%@ attribute name="name" 
		required="true" 
		fragment="false" 
		rtexprvalue="true" 
		type="String" 
		description="Type de la facette principale" 
%>
<%@ attribute name="label" 
		required="true" 
		fragment="false" 
		rtexprvalue="true" 
		type="String" 
		description="Label de la facette" 
%>
<%@ attribute name="title" 
        required="false" 
        fragment="false" 
        rtexprvalue="true" 
        type="String" 
        description="Le contenu de l'attribut title" 
%>
<%@ attribute name="option" 
		required="false" 
		fragment="false" 
		rtexprvalue="true" 
		type="String" 
		description="Champ lie de la facette, choisir entre 'limitrophe', 'epci', 'rayon' et 'adresse'" 
%>
<%@ attribute name="setRayons" 
		required="false" 
		fragment="false" 
		rtexprvalue="true" 
		type="Set<Category>" 
		description="Set contenant la liste des rayons a afficher dans le champ lie rayon" 
%>
<%@ attribute name="request" 
		required="true" 
		fragment="false" 
		rtexprvalue="true" 
		type="HttpServletRequest" 
		description="La requete http actuelle" 
%>
<%@ attribute name="isLarge" 
		required="false" 
		fragment="false" 
		rtexprvalue="true" 
		type="Boolean" 
		description="Est ce que le champ doit etre large" 
%>
<%@ attribute name="autourMoi" 
		required="false" 
		fragment="false" 
		rtexprvalue="true" 
		type="Boolean" 
		description="Est ce que le champ adresse peut-etre rempli par geolocalisation" 
%>
<% 
	String userLang = Channel.getChannel().getCurrentJcmsContext().getUserLang();
	String styleChamps = Util.notEmpty(request.getAttribute("showFiltres")) && (Boolean)request.getAttribute("showFiltres") || (Util.notEmpty(isLarge) && !isLarge) ? "Std" : "Large"; 
	String styleChamps2 = styleChamps.equalsIgnoreCase("large") ? "Large" : "";
	String styleChamps3 = styleChamps.equalsIgnoreCase("large") ? "large" : "sizeL";
%>

<jalios:if predicate='<%= Util.notEmpty(option) %>'>

	<jalios:if predicate='<%= option.equalsIgnoreCase("limitrophe") || option.equalsIgnoreCase("epci") || option.equalsIgnoreCase("rayon") || option.equalsIgnoreCase("adresse") %>'>

		<%
			String titleAttr = JcmsUtil.glp(userLang, "jcmsplugin.socle.selectionner") + " " + label + " - ";
			if(option.equalsIgnoreCase("rayon")) {
				titleAttr += JcmsUtil.glp(userLang, "jcmsplugin.socle.facette.rayon.label");
			} else {
				titleAttr += JcmsUtil.glp(userLang, "jcmsplugin.socle.facette.maj-sous-theme.label")+" ";
				if(option.equalsIgnoreCase("limitrophe")) {
					titleAttr += JcmsUtil.glp(userLang, "jcmsplugin.socle.facette.commune-limitrophe.label")+" ";
				} else if(option.equalsIgnoreCase("epci")) {
					titleAttr += JcmsUtil.glp(userLang, "jcmsplugin.socle.facette.epci.label")+" ";
				} else if(option.equalsIgnoreCase("adresse")) {
					titleAttr += JcmsUtil.glp(userLang, "jcmsplugin.socle.facette.adresse.default-label")+" ";
				}
				titleAttr += JcmsUtil.glp(userLang, "jcmsplugin.socle.facette.tri-alphabetique.label");
			}
			titleAttr += " - "+JcmsUtil.glp(userLang, "jcmsplugin.socle.obligatoire");
		%>

		<div class="ds44-fieldContainer ds44-champsLies ds44-js-linked-fields">
			<div class="ds44-form__container">


				<label for='<%= idFormElement %>' class="ds44-formLabel"> 
					<span class='<%= "ds44-labelTypePlaceholder ds44-labelTypePlaceholder" + styleChamps2 %>'> 
						<span> 
							<%= label %><%= isFacetteObligatoire ? "<sup aria-hidden=\"true\">*</sup>" : "" %>
						</span>
					</span>
				</label>
				<% 
					String styleCss = "ds44-inp" + styleChamps;
					if(name.equalsIgnoreCase("adresse")) {
						if(Util.notEmpty(autourMoi) && autourMoi) {
							styleCss += " ds44-autocomp--location";
						}
						styleCss += " ds44-js-field-address";
					}
				%>
				<input type="text" id='<%= idFormElement %>' class='<%= styleCss %>' <%= name.equalsIgnoreCase("adresse") ? "type='text'" : "" %>
						name='<%= idFormElement %>' 
						role="combobox" aria-autocomplete="list" 
						autocomplete="off" 
						aria-expanded="false" 
						data-url='<%= dataUrl %>'
						title='<%= titleAttr %>' 
						data-mode='<%= dataMode %>' 
						<%= isFacetteObligatoire ? "required" : ""%> 
						aria-owns='<%= "owned_listbox_" + idFormElement %>'
						<%= ! name.equalsIgnoreCase("adresse") ? "aria-activedescendant=\'selected_option_" + idFormElement + "\'" : "" %> />
				<button class="ds44-reset" type="button" style="display: none;">
					<i class="icon icon-cross icon--<%= styleChamps3 %>" aria-hidden="true"></i> 
					<span class="visually-hidden"><%= JcmsUtil.glp(userLang, "jcmsplugin.socle.facette.effacer-contenu-champ", label) %></span>
				</button>

				<jalios:if predicate='<%= name.equalsIgnoreCase("adresse") && Util.notEmpty(autourMoi) && autourMoi %>'>

					<button class="ds44-location" title="<%= JcmsUtil.glp(userLang, "jcmsplugin.socle.facette.localisation.title", label)%>">
						<i class="icon icon-position icon--large" aria-hidden="true"></i> <span class="visually-hidden"><%= JcmsUtil.glp(userLang, "jcmsplugin.socle.facette.localisation.label")%></span>
					</button>

				</jalios:if>

				<div class="ds44-autocomp-container hidden" aria-hidden="true">
					<jalios:if predicate='<%= name.equalsIgnoreCase("adresse") %>'>
						<div class="ds44-autocomp-list">
							<ul class="ds44-list" role="listbox" id="owned_listbox_idponkzq8kog"></ul>
						</div>
					</jalios:if>
					<jalios:if predicate='<%= ! name.equalsIgnoreCase("adresse") %>'>
						<div class="ds44-autocomp-buttons ds44-flex-container" aria-hidden="true">
							<button class="ds44-btnStd ds44-bgGray ds44-btnStd--plat ds44-fg1" type="button" data-value="allCity"
								data-text='<%=JcmsUtil.glp(userLang, "jcmsplugin.socle.facette.all-commune.label")%>'
								aria-label='<%=JcmsUtil.glp(userLang, "jcmsplugin.socle.facette.select-all-commune.label")%>' aria-hidden="true" tabindex="-1">
								<%=JcmsUtil.glp(userLang, "jcmsplugin.socle.facette.all-commune.label")%>
							</button>
							<button class="ds44-btnStd ds44-bgGray ds44-btnStd--plat ds44-fg1 ds44-border-left--light selected_option" type="button" data-value="aroundMe"
								data-text='<%=JcmsUtil.glp(userLang, "jcmsplugin.socle.facette.autour-moi.label")%>'
								aria-label='<%=JcmsUtil.glp(userLang, "jcmsplugin.socle.facette.select-autour-moi.label")%>' id='<%="selected_option_" + idFormElement%>'
								aria-selected="true" aria-pressed="true" aria-hidden="true" tabindex="-1">
								<span class="ds44-btnInnerText" aria-hidden="true"><%=JcmsUtil.glp(userLang, "jcmsplugin.socle.facette.autour-moi.label")%></span> <i
									class="icon icon-position icon--sizeM" aria-hidden="true"></i>
							</button>
						</div>
						<div class="ds44-autocomp-list" aria-hidden="true">
							<ul class="ds44-list" role="listbox" id='<%="owned_listbox_" + idFormElement%>' aria-hidden="true"></ul>
						</div>
					</jalios:if>
				</div>
			</div>

			<jalios:if predicate='<%= option.equalsIgnoreCase("limitrophe") || option.equalsIgnoreCase("epci") %>'>

				<% 
					String dataUrlOption = "";
					String labelOption = "";
					if(option.equalsIgnoreCase("limitrophe")) {
						dataUrlOption = "plugins/SoclePlugin/jsp/facettes/searchCommuneLimit.jsp";
						labelOption = JcmsUtil.glp(userLang, "jcmsplugin.socle.facette.commune-limitrophe.label");
					} else if(option.equalsIgnoreCase("epci")) {
						dataUrlOption = "plugins/SoclePlugin/jsp/facettes/searchCommuneEpci.jsp";
						labelOption = JcmsUtil.glp(userLang, "jcmsplugin.socle.facette.epci.label");
					}
				%>

				<div class="ds44-form__container">

					<div class='ds44-select__shape <%= "ds44-inp" + styleChamps %> ds44-inputDisabled'>
						<p class="ds44-selectLabel" aria-hidden="true">
							<%= labelOption %><%= isFacetteObligatoire ? "<sup aria-hidden=\"true\">*</sup>" : "" %>
						</p>
						<div id='<%= idFormElement %>' class="ds44-js-select-checkbox ds44-selectDisplay" 
								data-name='<%= idFormElement %>'
								data-url='<%= dataUrlOption %>' 
								<%= (Boolean)(request.getAttribute("isFilter")) ? "data-auto-submit=\"true\"" : "" %>>
						</div>
						<button class="ds44-reset" type="button">
							<i class="icon icon-cross icon--sizeXL" aria-hidden="true"></i>
							<span class="visually-hidden"><%= JcmsUtil.glp(userLang, "jcmsplugin.socle.facette.effacer-contenu-champ", labelOption) %></span>
						</button>
						<button id="button-<%= idFormElement %>" class="ds44-btnIco ds44-posAbs ds44-posRi ds44-btnOpen" 
								type="button" 
								aria-expanded="false" 
								title='<%= labelOption + " - " + JcmsUtil.glp(userLang, "jcmsplugin.socle.obligatoire") %>'
								aria-disabled="true">
							<i class="icon icon-down icon--sizeL" aria-hidden="true"></i>
							<span id='<%= "button-message-"+idFormElement %>' class="visually-hidden"><%= labelOption %></span>
						</button>
					</div>

					<div class="ds44-select-container hidden">
						<div class="ds44-flex-container ds44--m-padding">
							<button class="ds44-btnStd ds44-bgGray ds44-btnStd--plat ds44-fg1" type="button" 
									aria-describedby="button-message-<%= idFormElement %>"
									data-bkp-tabindex="" 
									tabindex="-1">
								<span class="ds44-btnInnerText"><%= JcmsUtil.glp(userLang, "jcmsplugin.socle.tout-cocher") %></span>
								<i class="icon icon-check icon--medium" aria-hidden="true"></i>
							</button>
							<button class="ds44-btnStd ds44-bgGray ds44-btnStd--plat ds44-fg1 ds44-border-left--light" 
									type="button"
									aria-describedby="button-message-<%= idFormElement %>" 
									data-bkp-tabindex="" 
									tabindex="-1">
								<span class="ds44-btnInnerText"><%= JcmsUtil.glp(userLang, "jcmsplugin.socle.tout-decocher") %></span>
								<i class="icon icon-cross icon--medium" aria-hidden="true"></i>
							</button>
						</div>
						<div class="ds44-listSelect">
							<ul class="ds44-list" id="listbox-<%= idFormElement %>"></ul>
						</div>
						<button type="button" class="ds44-fullWBtn ds44-btnSelect ds44-theme" 
								title='<%= JcmsUtil.glp(userLang, "jcmsplugin.socle.facette.cat-lie.valider-selection.label", labelOption) %>'
								data-bkp-tabindex="" 
								tabindex="-1">
							<span class="ds44-btnInnerText"><%= JcmsUtil.glp(userLang, "jcmsplugin.socle.valider") %></span>
							<i class="icon icon-long-arrow-right ds44-noLineH" aria-hidden="true"></i>
						</button>
					</div>
				</div>

			</jalios:if>

			<jalios:if predicate='<%= option.equalsIgnoreCase("rayon") %>'>

				<div class="ds44-form__container">

					<div class='ds44-select__shape <%= "ds44-inp" + styleChamps %> ds44-inputDisabled'>
						<p class="ds44-selectLabel" aria-hidden="true">
							<%= JcmsUtil.glp(userLang, "jcmsplugin.socle.facette.rayon.label") %><%= isFacetteObligatoire ? "<sup aria-hidden=\"true\">*</sup>" : "" %>
						</p>
						<input class="ds44-input-value" type="hidden" value="">
						<div id='<%= idFormElement %>' class="ds44-js-select-standard ds44-selectDisplay" name="<%= idFormElement %>"></div>
						<button class="ds44-reset" type="button" style="display: none;">
							<i class="icon icon-cross icon--sizeXL" aria-hidden="true"></i>
							<span class="visually-hidden">
								<%= JcmsUtil.glp(userLang, "jcmsplugin.socle.facette.effacer-contenu-champ", JcmsUtil.glp(userLang, "jcmsplugin.socle.facette.rayon.label")) %>
							</span>
						</button>
						<button id="button-<%= idFormElement %>" class="ds44-btnIco ds44-posAbs ds44-posRi ds44-btnOpen" 
								type="button"
								aria-expanded="false" 
								title='<%= JcmsUtil.glp(userLang, "jcmsplugin.socle.facette.rayon.label") + " - " + JcmsUtil.glp(userLang, "jcmsplugin.socle.obligatoire") %>'>
							<i class="icon icon-down icon--sizeXL" aria-hidden="true"></i>
							<span id='<%= "button-message-"+idFormElement %>' class="visually-hidden">
								<%= JcmsUtil.glp(userLang, "jcmsplugin.socle.facette.rayon.label") %>
							</span>
						</button>
					</div>
	
					<div class="ds44-select-container hidden" data-bkp-aria-hidden="" aria-hidden="true">
						<div class="ds44-listSelect">
							<ul class="ds44-list" role="listbox" 
									id='<%= "listbox-"+idFormElement %>' 
									aria-labelledby='<%= "button-message-"+idFormElement %>' 
									aria-required="true">
								<jalios:if predicate="<%= Util.notEmpty(setRayons) %>">
									<jalios:foreach name="itCat" type="Category" collection='<%= setRayons %>'>
										<li class="ds44-select-list_elem" role="option" 
												data-value='<%= itCat.getName() %>' 
												tabindex="0">
											<%= itCat.getName() %>
										</li>
									</jalios:foreach>
								</jalios:if>
							</ul>
						</div>
					</div>

				</div>

			</jalios:if>

			<jalios:if predicate='<%= option.equalsIgnoreCase("adresse") %>'>

				<%
					String titleOption = JcmsUtil.glp(userLang, "jcmsplugin.socle.selectionner") + " " + label + " - " + JcmsUtil.glp(userLang, "jcmsplugin.socle.obligatoire");
					String dataUrlOption = Channel.getChannel().getProperty("$jcmsplugin.socle.autocompletion.adresse.url");
				%>

				<div class="ds44-form__container">
					<div class="ds44-posRel">
					   <label for='<%= "option-" + idFormElement %>' class="ds44-formLabel ds44-inputDisabled">
							<span class='<%= "ds44-labelTypePlaceholder ds44-labelTypePlaceholder" + styleChamps2 %>'>
								<span>
									<%= JcmsUtil.glp(userLang, "jcmsplugin.socle.facette.adresse.default-label") %><%= isFacetteObligatoire ? "<sup aria-hidden=\"true\">*</sup>" : "" %>
								</span>
							</span> 
						</label>
						<input type="text" id='<%= idFormElement %>' class='<%= "ds44-inp" + styleChamps %> ds44-js-field-address' 
								name='<%= idFormElement %>'
								role="combobox" 
								aria-autocomplete="list" 
								autocomplete="off"
								aria-expanded="false"
								data-url='<%= dataUrlOption %>' 
								title='<%= titleOption %>'
								data-mode="select-only" 
								required="" 
								aria-owns='<%= "owned_listbox_"+idFormElement %>' 
								readonly="true" 
								aria-readonly="true">
						<button class="ds44-reset" type="button" style="display: none;">
							<i class="icon icon-cross icon--<%= styleChamps3 %>" aria-hidden="true"></i>
							<span class="visually-hidden">
								<%= JcmsUtil.glp(userLang, "jcmsplugin.socle.facette.effacer-contenu-champ", JcmsUtil.glp(userLang, "jcmsplugin.socle.facette.adresse.default-label")) %>
							</span>
						</button>

						<div class="ds44-autocomp-container hidden" aria-hidden="true">
							<div class="ds44-autocomp-list" aria-hidden="true">
								<ul class="ds44-list" role="listbox" id='<%= "owned_listbox_"+idFormElement %>' aria-hidden="true"></ul>
							</div>
						</div>					
					</div>
				</div>

			</jalios:if>

		</div>

	</jalios:if>
	
</jalios:if>

<jalios:if predicate='<%= Util.isEmpty(option) %>'>

	<div class="ds44-form__container">
			<label for='<%= idFormElement %>' class="ds44-formLabel">
		        <span class='<%= "ds44-labelTypePlaceholder ds44-labelTypePlaceholder" + styleChamps2 %>'>
					<span>
						<%= label %><%= isFacetteObligatoire ? "<sup aria-hidden=\"true\">*</sup>" : "" %>
					</span>
				</span>
			</label>
			
			<input type="text" id='<%= idFormElement %>' class='<%= "ds44-inp" + styleChamps %>' role="combobox" 
					name='<%= name %>'
					aria-autocomplete="list" 
					autocomplete="off" 
					data-url='<%= dataUrl %>' 
					data-mode='<%= dataMode %>'
					title='<%= title %>' 
					<%= isFacetteObligatoire ? "required aria-required=\"true\"" : ""%> />

			<button class="ds44-reset" type="button">
				<i class="icon icon-cross icon--<%= styleChamps3 %>" aria-hidden="true"></i>
				<span class="visually-hidden"><%= JcmsUtil.glp(userLang, "jcmsplugin.socle.facette.effacer-contenu-champ", label) %></span>
			</button>

			<div class="ds44-autocomp-container hidden">
				<div class="ds44-autocomp-list">
					<ul class="ds44-list" role="listbox"></ul>
				</div>
			</div>
		
	</div>

</jalios:if>