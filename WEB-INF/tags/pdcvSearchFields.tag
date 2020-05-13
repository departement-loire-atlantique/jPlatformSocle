<%@ taglib uri="jcms.tld" prefix="jalios" %>
<%@ tag 
    pageEncoding="UTF-8"
    description="Card" 
    body-content="scriptless" 
    import="com.jalios.jcms.Channel, com.jalios.util.ServletUtil, com.jalios.util.Util, com.jalios.jcms.JcmsUtil"
%>
<%@ attribute name="idFormElement"
    required="true"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="ID HTML du formulaire"
%>

<%
String userLang = Channel.getChannel().getCurrentJcmsContext().getUserLang();
String uid = ServletUtil.generateUniqueDOMId(request, "uid");
%>
        
        <div class="ds44-form__container hidden">
            <div class="ds44-posRel">
                <label for="adresse-<%= idFormElement %>" class="ds44-formLabel--external"><span class="ds44-labelTypePlaceholder"><%= JcmsUtil.glp(userLang,"jcmsplugin.socle.menu.pdcv.ajouterAdresse") %><sup aria-hidden="true"><%= JcmsUtil.glp(userLang,"jcmsplugin.socle.facette.asterisque") %></sup></span></label>
                
                <input class="ds44-input-value" type="hidden" value=""><input class="ds44-input-metadata" type="hidden" value=""><input type="text" id="adresse-<%= idFormElement %>" name="adresse" class="ds44-inpStd ds44-js-field-address" role="combobox" aria-autocomplete="list" autocomplete="off" aria-expanded="false" title='<%= JcmsUtil.glp(userLang,"jcmsplugin.socle.menu.pdcv.ajouterAdresse") %> - <%= JcmsUtil.glp(userLang,"jcmsplugin.socle.obligatoire") %>' data-url='<%= Channel.getChannel().getProperty("$jcmsplugin.socle.autocompletion.adresse.url") %>' data-mode="select-only" required="" placeholder='<%= JcmsUtil.glp(userLang,"jcmsplugin.socle.menu.pdcv.votreAdresse") %>' aria-owns="owned_listbox_id<%= uid %>"><button class="ds44-reset" type="button" style="display: none;"><i class="icon icon-cross icon--sizeL" aria-hidden="true"></i><span class="visually-hidden"><%= JcmsUtil.glp(userLang,"jcmsplugin.socle.facette.effacer-contenu-champ", JcmsUtil.glp(userLang,"jcmsplugin.socle.menu.pdcv.ajouterAdresse")) %></span></button>
                
                <div class="ds44-autocomp-container hidden" aria-hidden="true">
                    <div class="ds44-autocomp-list">
                        <ul class="ds44-list" role="listbox" id="owned_listbox_id<%= uid %>"></ul>
                    </div>
                </div>
            </div>
                
            <div class="ds44-errorMsg-container hidden" aria-live="polite"></div>
        </div>
