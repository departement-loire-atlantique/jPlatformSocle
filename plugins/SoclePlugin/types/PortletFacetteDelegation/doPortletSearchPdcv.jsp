<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>

<%
PortletFacetteDelegation obj = (PortletFacetteDelegation)portlet;

String idFormElement = ServletUtil.generateUniqueDOMId(request, glp("jcmsplugin.socle.facette.form-element"));
String dataMode = "select-only";
String dataUrl = "plugins/SoclePlugin/jsp/facettes/acSearchCommune.jsp";
String name = "commune";
String label = Util.notEmpty(obj.getLabel()) ? obj.getLabel() : glp("jcmsplugin.socle.facette.commune.default-label");
String option = "";
TreeSet<Category> setRayons = new TreeSet<Category>();
%>

<section class="ds44-box ds44-theme ds44-mb3">
    <div class="ds44-innerBoxContainer">
        <p role="heading" aria-level="2" class="ds44-box-heading"><%= glp("jcmsplugin.socle.menu.pdcv") %></p>
        <form data-statistic="{&quot;name&quot;: &quot;declenche-evenement&quot;,&quot;category&quot;: &quot;Formulaire&quot;,&quot;action&quot;: &quot;Recherchez un contact&quot;,&quot;label&quot;: &quot;$commune|text&quot;}">
            <div class="ds44-js-linked-fields ds44-js-masked-fields">
                <%@ include file='/plugins/SoclePlugin/jsp/portlet/portletFacetteAutoCompletion.jspf' %>
                <ds:pdcvSearchFields idFormElement="<%= idFormElement %>"/>
            </div>
        </form>
    </div>
</section>