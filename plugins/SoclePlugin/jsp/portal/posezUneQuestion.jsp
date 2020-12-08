<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %><%

Category currentCategory = jcmsContext.getCurrentCategory();
if (currentCategory == null) {
	return;
}

//On cherche une PortletFAQ sur la Catégorie courante
PortletFaq portletFaq = SocleUtils.searchPortletFaq(currentCategory);
%>
<jalios:if predicate='<%= Util.notEmpty(portletFaq) %>'>

	<button class="ds44-btnStd ds44-btn--invert ds44-btnQuestion ds44-btn-fixed ds44-js-button-sticky" type="button" data-target="#navFAQ" data-js="ds44-modal">
        <span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.faq.poser-question") %></span><i class="icon icon-discussion icon--sizeL" aria-hidden="true"></i>
    </button>

	<section class="ds44-modal-container" id="navFAQ" aria-modal="true" aria-hidden="true" role="dialog">
	    <div class="ds44-modal-box ds44-whiteBG ds44-wave-grey">
	        <button class="ds44-btnOverlay--modale ds44-btnOverlay--closeOverlay" type="button" title="Fermer l'aide : Vous avez une question ?" data-js="ds44-modal-action-close">
	            <i class="icon icon-cross icon--xlarge" aria-hidden="true"></i><span class="ds44-btnInnerText--bottom"><%= glp("jcmsplugin.socle.fermer") %></span>
	        </button>
	        <div class="ds44-container-menuBackLink">
	            <p role="heading" aria-level="1" class="ds44-menuBackLink"><%= glp("jcmsplugin.socle.faq.vous-avez-question") %></p>
	        </div>
            <div class="ds44-flex-container ds44-flex-valign-center ds44-flex-align-center ds44-container-large ds44-tiny-to-med-atop">
                <div class="ds44--3xl-padding-t ds44--2xl-padding-b">
                    <% FaqAccueil obj = portletFaq.getFaq(); %>
                    <%@ include file='../../types/FaqAccueil/doFaqAccueilFullDisplayContent.jsp' %>
                </div>
            </div>
	    </div>
	</section>	

</jalios:if>


