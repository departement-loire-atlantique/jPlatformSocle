<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% AbonnementMailjet obj = (AbonnementMailjet)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %>


<section class="ds44-box ds44-theme ds44-mb3">
    <div class="ds44-innerBoxContainer">
        <p role="heading" aria-level="2" class="ds44-box-heading"><%= obj.getTitle(userLang) %></p>
        <jalios:wysiwyg><%= obj.getDescription(userLang) %></jalios:wysiwyg>
        
        <form data-is-ajax="true" data-is-inline="true" action="plugins/SoclePlugin/jsp/forms/sendNewletterDoubleOptin.jsp">
           
			<div class="ds44-form__container">   
			
				<div class="ds44-posRel">				  
				   <label for="newletters-mail" class="ds44-formLabel"><span class="ds44-labelTypePlaceholder"><span><%= glp("jcmsplugin.socle.faq.votre-email") %><sup aria-hidden="true">*</sup></span></span></label>                       
                   <input type="email" id="newletters-mail" name="newletters-mail" class="ds44-inpStd" title='<%= encodeForHTMLAttribute(glp("jcmsplugin.socle.facette.champ-obligatoire.title",  glp("jcmsplugin.socle.faq.votre-email"))) %>'  required autocomplete="email"   aria-describedby="explanation-newletters-mail titre-modale-newsletter" /><button class="ds44-reset" type="button"><i class="icon icon-cross icon--sizeL" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.facette.effacer-contenu-champ", glp("jcmsplugin.socle.faq.votre-email")) %></span></button>                                    				
				</div>
				
				<div class="ds44-field-information" aria-live="polite">
                    <ul class="ds44-field-information-list ds44-list">
                        <li id="explanation-newletters-mail" class="ds44-field-information-explanation"><%= glp("jcmsplugin.socle.form.exemple.email") %></li>
                    </ul>
                </div>
				
			</div>
                
            <input type="hidden" name='<%= "id-list" + glp("jcmsplugin.socle.facette.form-element") %>' value='<%= obj.getIdListeDeContact() %>' data-technical-field />
            <input type="hidden" name='<%= "nom-list" + glp("jcmsplugin.socle.facette.form-element") %>' value='<%= obj.getNomDeLaListe(userLang) %>' data-technical-field />
        
            <button class="ds44-btnStd ds44-btn--invert ds44-w100 ds44-bntALeft" title='<%= encodeForHTMLAttribute(glp("jcmsplugin.socle.newletter.inscrire-recevoir")) %>' aria-describedby="valid-form">
                <span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.newletter.inscrire") %></span>
                <i class="icon icon-long-arrow-right" aria-hidden="true"></i>
            </button>
            
        </form>
        
        <% Data newsletterWysiwyg = channel.getData(channel.getProperty("jcmsplugin.socle.form.newsletter.portlet-rgpd.id")); %>
        <jalios:if predicate='<%= Util.notEmpty(newsletterWysiwyg) && newsletterWysiwyg instanceof PortletWYSIWYG %>'>
          <jalios:wysiwyg css="ds44-textLegend--mentions mtm"><%= ((PortletWYSIWYG) newsletterWysiwyg).getWysiwyg() %></jalios:wysiwyg>
        </jalios:if>
        
    </div>
</section>