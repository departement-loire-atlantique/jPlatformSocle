<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %><%

Category currentCategory = jcmsContext.getCurrentCategory();
if (currentCategory == null || Util.notEmpty(request.getAttribute("noQuestionButton"))) {
    return;
}

//On cherche une PortletFAQ sur la Catégorie courante
PortletFaq portletFaq = SocleUtils.searchPortletFaq(currentCategory);
%>
<jalios:if predicate='<%= Util.notEmpty(portletFaq) %>'>

    <%-- On masque le bloc "poser un question" sur les Fiches aide et sur les petits écrans --%>
    <%
    String styleCss = " class=\"tiny-hidden\"";
    Publication pub = (Publication)request.getAttribute("publication");
    
    if (null != pub && !(pub instanceof FicheAide)) {
    styleCss = ""; 
    }
    %>
    
    <div<%= styleCss %>>

        <% 
            FaqAccueil obj = portletFaq.getFaq(); 
            String libelleBtn = obj.getLibelleDuBouton(userLang);
            if(Util.isEmpty(libelleBtn)) libelleBtn = glp("jcmsplugin.socle.faq.poser-question");
        %>
        <button class="ds44-btnStd ds44-btn--invert ds44-btnQuestion ds44-btn-fixed ds44-js-button-sticky" type="button" data-target="#navFAQ" data-js="ds44-modal">
            <span class="ds44-btnInnerText"><%= libelleBtn %></span><i class="icon icon-discussion icon--sizeL" aria-hidden="true"></i>
        </button>
    
        <section class="ds44-modal-container" id="navFAQ" aria-modal="true" aria-hidden="true" role="dialog">
            <div class="ds44-modal-box ds44-whiteBG ds44-wave-grey">
                <button class="ds44-btnOverlay--modale ds44-btnOverlay--closeOverlay" type="button" title='<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.ficheaide.fermer-aide.label", glp("jcmsplugin.socle.faq.vous-avez-question"))) %>' data-js="ds44-modal-action-close">
                    <i class="icon icon-cross icon--xlarge" aria-hidden="true"></i><span class="ds44-btnInnerText--bottom"><%= glp("jcmsplugin.socle.fermer") %></span>
                </button>
                <div class="ds44-container-menuBackLink">
                    <p role="heading" aria-level="1" class="ds44-menuBackLink"><%= glp("jcmsplugin.socle.faq.vous-avez-question") %></p>
                </div>
                <div class="ds44-flex-container ds44-flex-valign-center ds44-flex-align-center ds44-container-large ds44-tiny-to-med-atop">
                    <div class="ds44--3xl-padding-t ds44--2xl-padding-b">
                        <%@ include file='../../types/FaqAccueil/doFaqAccueilFullDisplayContent.jsp' %>
                    </div>
                </div>
            </div>
        </section>
        
    </div>

</jalios:if>


