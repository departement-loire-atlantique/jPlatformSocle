<%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ include file='/jcore/portal/doPortletParams.jspf' %><%

PortletConnexion box = (PortletConnexion) portlet;
PortalInterface loginPortal = box.getDisplayPortal() != null ? box.getDisplayPortal() : portal;

Publication obj = (Publication)request.getAttribute(PortalManager.PORTAL_PUBLICATION); 

String typeChamp = box.getTypeLogin();
boolean isChampEmail = typeChamp.equals("email") ? true : false;

// Initialisation des labels
String titreDuBloc = Util.notEmpty(box.getTitreDuBloc(userLang)) ? box.getTitreDuBloc(userLang) : glp("jcmsplugin.socle.form.login.legend");
String loginText = Util.notEmpty(box.getLoginText(userLang)) ? box.getLoginText(userLang) : isChampEmail ? glp("jcmsplugin.socle.faq.votre-email") : glp("jcmsplugin.socle.identifiant");
String passwordText = Util.notEmpty(box.getPasswordText(userLang)) ? box.getPasswordText(userLang) : glp("ui.fo.login.lbl.passwd");
String buttonText = Util.notEmpty(box.getButtonText(userLang)) ? box.getButtonText(userLang) : glp("jcmsplugin.socle.valider");

// Après connexion réussie, redirection vers URL / contenu paramétré ou page courante
String UrlRedirection = Util.notEmpty(box.getUrlRedirection()) ? box.getUrlRedirection() : Util.notEmpty(box.getContenuRedirection()) ? box.getContenuRedirection().getDisplayUrl(userLocale) : obj.getDisplayUrl(userLocale);

ControlSettings loginSettings = new TextFieldSettings().placeholder(box.getLoginText(userLang));
ControlSettings passwordSettings = new PasswordSettings().placeholder(box.getPasswordText(userLang));
ControlSettings persistentSettings = new EnumerateSettings().checkbox().multiple().enumValues("true").enumLabels("ui.fo.login.lbl.remember");

%>

<jsp:useBean id="formHandler" scope="page" class="com.jalios.jcms.handler.ResetPasswordHandler">
   <jsp:setProperty name="formHandler" property="request" value="<%= request %>"/>
   <jsp:setProperty name="formHandler" property="response" value="<%= response %>"/>
   <jsp:setProperty name="formHandler" property="*" />
</jsp:useBean>

<jalios:select>

    <jalios:if predicate="<%= formHandler.isResetFormDisplayed() %>">
    
       <%
       if (formHandler.validate()) {
           sendRedirect(UrlRedirection);
           return;
       }
       %>
    
        <div class="ds44-box ds44-theme mbm">
            <div class="ds44-innerBoxContainer">
	            <form class="form-horizontal login-form" action="plugins/SoclePlugin/jsp/facettes/displayResultDecodeParams.jsp" method="post" name="resetForm">
	               <fieldset>
	                    <legend class="ds44-box-heading ds44-mb-std"><%= glp("ui.fo.resetpass.reset.title") %></legend>
	                    
	                    <%@ include file='/plugins/SoclePlugin/jsp/doMessageBoxCustom.jspf' %>
	                    <p><%= glp("ui.fo.resetpass.reset.txt", encodeForHTML(formHandler.getMember().getFriendlyName()), encodeForHTML(formHandler.getMember().getLogin())) %></p>
	                    
	                    <div class="ds44-mb3">
                            <div class="ds44-form__container">
                            
                                <div class="ds44-posRel">
                                    <label for="password1" class="ds44-formLabel"><span class="ds44-labelTypePlaceholder"><span><%= glp("ui.fo.resetpass.reset.password1.placeholder") %><sup aria-hidden="true"><%= glp("jcmsplugin.socle.facette.asterisque") %></sup></span></span></label>                        
                                    <input type="password" id="password1" name="password1" class="ds44-inpStd" title='<%= glp("jcmsplugin.socle.facette.champ-obligatoire.title", glp("ui.fo.login.lbl.passwd")) %>'  required autocomplete="current-password"/><button class="ds44-reset" type="button"><i class="icon icon-cross icon--sizeL" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.facette.effacer-contenu-champ", glp("ui.fo.login.lbl.passwd")) %></span></button>                                     
                                </div>
                            </div>
                        </div>
                        
                        <div class="ds44-mb3">
                            <div class="ds44-form__container">
                            
                                <div class="ds44-posRel">
                                    <label for="password2" class="ds44-formLabel"><span class="ds44-labelTypePlaceholder"><span><%= glp("ui.fo.resetpass.reset.password2.placeholder") %><sup aria-hidden="true"><%= glp("jcmsplugin.socle.facette.asterisque") %></sup></span></span></label>                        
                                    <input type="password" id="password2" name="password2" class="ds44-inpStd" title='<%= glp("jcmsplugin.socle.facette.champ-obligatoire.title", glp("ui.fo.login.lbl.passwd")) %>'  required autocomplete="current-password"/><button class="ds44-reset" type="button"><i class="icon icon-cross icon--sizeL" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.facette.effacer-contenu-champ", glp("ui.fo.login.lbl.passwd")) %></span></button>                                     
                                </div>
                            </div>
                        </div>
                        
                        <input type="hidden" name="passwordResetToken" value="<%= encodeForHTMLAttribute(formHandler.getPasswordResetToken()) %>" data-technical-field/>
                        <input type='hidden' name="redirectUrl" value='<%= obj.getDisplayUrl(userLocale) %>' data-technical-field/>
                        <input type='hidden' name='redirect' value='<%= obj.getDisplayUrl(userLocale) %>' data-technical-field/>
                        <input type='hidden' name='jsp' value='<%= obj.getDisplayUrl(userLocale) %>' data-technical-field/>
                        <input type='hidden' name="opReset" value='true' data-technical-field/>
                        <input type="hidden" name="csrftoken" value="<%= HttpUtil.getCSRFToken(request) %>" data-technical-field>
                        
                        <button type='submit' name='opReset' value='<%= glp("ui.fo.resetpass.reset.btn.reset") %>' class="ds44-btnStd ds44-btn--invert ds44-bntFullw ds44-bntALeft ds44-mtb1" title='<%= glp("ui.fo.resetpass.request.btn.request") %> '>
                            <span class="ds44-btnInnerText"><%= glp("ui.fo.resetpass.reset.btn.reset") %></span><i class="icon icon-long-arrow-right" aria-hidden="true"></i>
                        </button>
	                      
	               </fieldset>
	            </form>
            </div>
        </div>
    
    </jalios:if>

	<jalios:if predicate='<%= Util.notEmpty(request.getParameter("forgotPass")) %>'>
	
	   <%
	   if (formHandler.validate()) {
		   sendRedirect(obj.getDisplayUrl(userLocale));
		   return;
	   }
	   %>
	
	   <div class="ds44-box ds44-theme mbm">
	       <div class="ds44-innerBoxContainer">
	           <form class="form-horizontal login-form" action="plugins/SoclePlugin/jsp/facettes/displayResultDecodeParams.jsp" method="post" name="requestResetForm">
	               <fieldset>
                        <legend class="ds44-box-heading ds44-mb-std"><%= glp("ui.fo.resetpass.request.title") %></legend>
                        
                        <%@ include file='/plugins/SoclePlugin/jsp/doMessageBoxCustom.jspf' %>                     
                        <p><%= glp("ui.fo.resetpass.request.txt") %></p>
                        
					    
					    <div class="ds44-mb3">                     
                            <div class="ds44-form__container">
                                <div class="ds44-posRel">
                                    <label for="forgot_mail" class="ds44-formLabel"><span class="ds44-labelTypePlaceholder"><span><%= glp("jcmsplugin.socle.faq.votre-email") %><sup aria-hidden="true"><%= glp("jcmsplugin.socle.facette.asterisque") %></sup></span></span></label>                   
                                    <input type="email" id="forgot_mail" name='email' class="ds44-inpStd" title='<%= glp("jcmsplugin.socle.facette.champ-obligatoire.title", glp("jcmsplugin.socle.faq.votre-email")) %>' required  autocomplete="email" aria-describedby="explanation-form-element-forgot_mail" /><button class="ds44-reset" type="button"><i class="icon icon-cross icon--sizeL" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.facette.effacer-contenu-champ", glp("jcmsplugin.socle.faq.votre-email")) %></span></button>                                
                                </div>
            
                                <div class="ds44-field-information" aria-live="polite">
                                    <ul class="ds44-field-information-list ds44-list">
                                        <li id="explanation-form-element-forgot_mail" class="ds44-field-information-explanation"><%= glp("jcmsplugin.socle.form.exemple.email") %></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        
                        <input type='hidden' name="redirectUrl" value='<%= obj.getDisplayUrl(userLocale) %>' data-technical-field/>
                        <input type='hidden' name='redirect' value='<%= obj.getDisplayUrl(userLocale) %>' data-technical-field/>
                        <input type='hidden' name='jsp' value='<%= obj.getDisplayUrl(userLocale) %>' data-technical-field/>
                        <input type='hidden' name="forgotPass" value='true' data-technical-field/>
                        <input type='hidden' name="opRequestReset" value='true' data-technical-field/>
                        <input type="hidden" name="csrftoken" value="<%= HttpUtil.getCSRFToken(request) %>" data-technical-field>
                        
                        <button type='submit' name='opRequestReset' value='<%= glp("ui.fo.resetpass.request.btn.request") %>' class="ds44-btnStd ds44-btn--invert ds44-bntFullw ds44-bntALeft ds44-mtb1" title='<%= glp("ui.fo.resetpass.request.btn.request") %> '>
                            <span class="ds44-btnInnerText"><%= glp("ui.fo.resetpass.request.btn.request") %></span><i class="icon icon-long-arrow-right" aria-hidden="true"></i>
                        </button>
                        
                   </fieldset>
	           </form>
	       </div>
	   </div>
	   
	</jalios:if>

    <jalios:default>
		<div class="ds44-box ds44-theme mbm">
		
			<div class="ds44-innerBoxContainer">
			    <form action='plugins/SoclePlugin/jsp/facettes/displayResultDecodeParams.jsp' method='post' name='login' class='form-horizontal login-form'>
			        <fieldset>
			            <legend class="ds44-box-heading ds44-mb-std"><%= titreDuBloc %></legend>
			            
			            <%@ include file='/plugins/SoclePlugin/jsp/doMessageBoxCustom.jspf' %>
			            
			            <jalios:if predicate='<%= Util.notEmpty(box.getIntroduction(userLang)) %>'>
			             <p><%= box.getIntroduction(userLang) %></p>
			            </jalios:if>
			            
			            <p><%= glp("jcmsplugin.socle.facette.champs-obligatoires") %></p>
			            
			            <jalios:include target="PORTLET_LOGIN_FORM_HEADER" targetContext="div" />
			            
			            <div class="ds44-mb3">                     
			                <div class="ds44-form__container">
				                <div class="ds44-posRel">
								    <label for="login" class="ds44-formLabel"><span class="ds44-labelTypePlaceholder"><span><%= loginText %><sup aria-hidden="true"><%= glp("jcmsplugin.socle.facette.asterisque") %></sup></span></span></label>				    
								    
								    <jalios:select>
								        <jalios:if predicate='<%= isChampEmail %>'>
                                            <input type="<%= typeChamp %>" id="login" name='<%= channel.getAuthMgr().getLoginParameter() %>' class="ds44-inpStd" title='<%= glp("jcmsplugin.socle.facette.champ-obligatoire.title", loginText) %>' required autocomplete="email" aria-describedby="explanation-form-element-login" />
                                        </jalios:if>
                                        <jalios:default>
                                            <input type="<%= typeChamp %>" id="login" name='<%= channel.getAuthMgr().getLoginParameter() %>' class="ds44-inpStd" title='<%= glp("jcmsplugin.socle.facette.champ-obligatoire.title", loginText) %>' required />
								        </jalios:default>
                                    </jalios:select>
								    
								    <button class="ds44-reset" type="button"><i class="icon icon-cross icon--sizeL" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.facette.effacer-contenu-champ", loginText) %></span></button>
								    								
								</div>
								
								<jalios:if predicate='<%= isChampEmail %>'>
	                                <div class="ds44-field-information" aria-live="polite">
	                                    <ul class="ds44-field-information-list ds44-list">
	                                        <li id="explanation-form-element-login" class="ds44-field-information-explanation"><%= glp("jcmsplugin.socle.form.exemple.email") %></li>
	                                    </ul>
	                                </div>
                                </jalios:if>
                                
			                </div>
			            </div>
			            
			            <div class="ds44-mb3">
			                <div class="ds44-form__container">
			                
			                    <div class="ds44-posRel">
								    <label for="password" class="ds44-formLabel"><span class="ds44-labelTypePlaceholder"><span><%= passwordText %><sup aria-hidden="true"><%= glp("jcmsplugin.socle.facette.asterisque") %></sup></span></span></label>					    
								    <input type="password" id="password" name="JCMS_password" class="ds44-inpStd" title='<%= glp("jcmsplugin.socle.facette.champ-obligatoire.title", glp("ui.fo.login.lbl.passwd")) %>'  required autocomplete="current-password"/><button class="ds44-reset" type="button"><i class="icon icon-cross icon--sizeL" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.facette.effacer-contenu-champ", passwordText) %></span></button>										
								</div>
			                </div>
			            </div>
			            
			            <div>
			                <div id="form-element-95779" data-name="form-element-95779" class="ds44-form__checkbox_container ds44-form__container" >
			                    <div class="ds44-form__container ds44-checkBox-radio_list ">
								    <input type="checkbox" id="name-check-form-element-95779-connect" name="<%= channel.getAuthMgr().getPersistentParameter() %>" value="true" class="ds44-checkbox"/><label for="name-check-form-element-95779-connect" class="ds44-boxLabel" id="name-check-label-form-element-95779-connect"><%= glp("jcmsplugin.socle.form.login.memoriser") %></label>					    									
								</div>
			                </div>
			            </div>
			            
			            <input type='hidden' name="redirectUrl" value='<%= obj.getDisplayUrl(userLocale) %>' data-technical-field/>
			            <input type='hidden' name='redirect' value='<%= UrlRedirection %>' data-technical-field/>
			            <input type='hidden' name='jsp' value='<%= obj.getDisplayUrl(userLocale) %>' data-technical-field/>
			            <input type="hidden" name="csrftoken" value="<%= HttpUtil.getCSRFToken(request) %>" data-technical-field>
			            
			            <button type='submit' name='<%= channel.getAuthMgr().getOpLoginParameter() %>' class="ds44-btnStd ds44-btn--invert ds44-bntFullw ds44-bntALeft ds44-mtb1" title='<%= glp("jcmsplugin.socle.form.login.valid-compte") %> '>
			                <span class="ds44-btnInnerText"><%= buttonText %></span><i class="icon icon-long-arrow-right" aria-hidden="true"></i>
			            </button>
			            
			            <p class="ds44-noMrg"><a href='<%= obj.getDisplayUrl(userLocale) + "?forgotPass=true" %>'><%= glp("jcmsplugin.socle.form.login.oublie-passe") %></a></p>
			        </fieldset>
			    </form>
			    
			    <jalios:include target="PORTLET_LOGIN_FORM_FOOTER" targetContext="div" />
			    
			</div>		
		</div>
	</jalios:default>
</jalios:select>

