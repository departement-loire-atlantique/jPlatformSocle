<%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ include file='/jcore/portal/doPortletParams.jspf' %><%

PortletLogin box = (PortletLogin) portlet;
PortalInterface loginPortal = box.getDisplayPortal() != null ? box.getDisplayPortal() : portal;

Publication obj = (Publication)request.getAttribute(PortalManager.PORTAL_PUBLICATION); 


ControlSettings loginSettings = new TextFieldSettings().placeholder(box.getLoginText(userLang));
ControlSettings passwordSettings = new PasswordSettings().placeholder(box.getPasswordText(userLang));
ControlSettings persistentSettings = new EnumerateSettings().checkbox().multiple().enumValues("true").enumLabels("ui.fo.login.lbl.remember");

%>



<div class="ds44-box ds44-theme mbm">

<div class="ds44-innerBoxContainer">
    <form action='plugins/SoclePlugin/jsp/facettes/displayResultDecodeParams.jsp' method='post' name='login' class='form-horizontal login-form'>
        <fieldset>
            <legend class="ds44-box-heading ds44-mb-std">Vous avez déjà  un compte, connectez-vous</legend>
            
            <%@ include file='/jcore/doMessageBox.jspf' %>
            
            <p><%= glp("jcmsplugin.socle.facette.champs-obligatoires") %></p>
            
            <jalios:include target="PORTLET_LOGIN_FORM_HEADER" targetContext="div" />
            
            <div class="ds44-mb3">                     
                <div class="ds44-form__container">
	                <div class="ds44-posRel">
					    <label for=login class="ds44-formLabel"><span class="ds44-labelTypePlaceholder"><span>Courriel<sup aria-hidden="true">*</sup></span></span></label>				    
					    <input type="email" id="login" name='<%= channel.getAuthMgr().getLoginParameter() %>' class="ds44-inpStd" title="Courriel - obligatoire"     aria-describedby="explanation-form-element-17658" /><button class="ds44-reset" type="button"><i class="icon icon-cross icon--sizeL" aria-hidden="true"></i><span class="visually-hidden">Effacer le contenu saisi dans le champ : Courriel</span></button>								
					</div>

                    <div class="ds44-field-information" aria-live="polite">
				        <ul class="ds44-field-information-list ds44-list">
				            <li id="explanation-form-element-17658" class="ds44-field-information-explanation">Exemple : monadresse@mail.com</li>
				        </ul>
				    </div>
                </div>
            </div>
            
            
            <div class="ds44-mb3">
                <div class="ds44-form__container">
                
                    <div class="ds44-posRel">
					    <label for="password" class="ds44-formLabel"><span class="ds44-labelTypePlaceholder"><span>Mot de passe<sup aria-hidden="true">*</sup></span></span></label>					    
					    <input type="text" id="password" name="JCMS_password" class="ds44-inpStd" title="Mot de passe - obligatoire"  required    /><button class="ds44-reset" type="button"><i class="icon icon-cross icon--sizeL" aria-hidden="true"></i><span class="visually-hidden">Effacer le contenu saisi dans le champ : Mot de passe</span></button>										
					</div>
                </div>
            </div>
            
            
            <div>
                <div id="form-element-95779" data-name="form-element-95779" class="ds44-form__checkbox_container ds44-form__container" >
                    <div class="ds44-form__container ds44-checkBox-radio_list ">
					    <input type="checkbox" id="name-check-form-element-95779-connect" name="form-element-95779" value="connect" class="ds44-checkbox"     /><label for="name-check-form-element-95779-connect" class="ds44-boxLabel" id="name-check-label-form-element-95779-connect">Rester connecté</label>					    									
					</div>
                </div>
            </div>
            
            
            
            <input type='hidden' name="redirectUrl" value='<%= obj.getDisplayUrl(userLocale) %>' data-technical-field/>
            <input type='hidden' name='redirect' value='<%= obj.getDisplayUrl(userLocale) %>' data-technical-field/>
            <input type='hidden' name='jsp' value='<%= obj.getDisplayUrl(userLocale) %>' data-technical-field/>
            <input type="hidden" name="csrftoken" value="<%= HttpUtil.getCSRFToken(request) %>" data-technical-field>
            
            
            
            <button type='submit' name='<%= channel.getAuthMgr().getOpLoginParameter() %>' class="ds44-btnStd ds44-btn--invert ds44-bntFullw ds44-bntALeft ds44-mtb1" title="Valider l'accès à  votre compte">
                <span class="ds44-btnInnerText">Valider</span><i class="icon icon-long-arrow-right" aria-hidden="true"></i>
            </button>
            
<!--             <p class="ds44-noMrg"><a href="#">Mot de passe oublié ?</a></p> -->
        </fieldset>
    </form>
    
    <jalios:include target="PORTLET_LOGIN_FORM_FOOTER" targetContext="div" />
    
</div>

</div>


