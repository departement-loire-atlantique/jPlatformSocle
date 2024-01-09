<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %>

<!-- todo : email contact form archeo -->
<% String formAction = "plugins/ArchivesPlugin/jsp/formContactArcheo/checkContactForm.jsp"; %>

<div class="ds44-loader-text visually-hidden" tabindex="-1" aria-live="polite"></div>
<div class="ds44-loader hidden">
    <div class="ds44-loader-body">
        <svg class="ds44-loader-circular" focusable="false" aria-hidden="true">
            <circle class="ds44-loader-path" cx="30" cy="30" r="20" fill="none" stroke-width="5" stroke-miterlimit="10"></circle>
        </svg>
    </div>
</div>

<article class="ds44-container-large ds44-mtb5">
    <div class="ds44-inner-container ds44-grid12-offset-1">
        <p class="ds44-textLegend ds44-textLegend--mentions"><%= glp("jcmsplugin.socle.facette.champs-obligatoires") %></p>
        <form data-is-ajax='true' data-is-inline="true" data-empty-after-submit="true" action='<%= formAction %>' method="post">
            
            <!-- todo : html contact form archeo -->
            <%@ include file='doEditRechercheJugementFormFields.jspf' %>       

            <div class="txtcenter ds44-mt-std">
                <button class="ds44-btnStd" title="<%= glp("jcmsplugin.archives.form.boutonEnvoi.title") %>">
                    <span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.envoyer") %></span>
                    <i class="icon icon-long-arrow-right" aria-hidden="true"></i>
                </button>
            </div>
        </form>

    </div>
</article>

 

 





