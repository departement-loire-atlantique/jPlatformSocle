<%@ include file="/jcore/doInitPage.jspf" %>
<%@ include file="/jcore/portal/doPortletParams.jspf" %><%
%><%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%><%

PortletQueryForeach box = (PortletQueryForeach) portlet;  
String idResultInLine = "structureContactResult";
%>


<form data-auto-load="true" action='plugins/SoclePlugin/jsp/facettes/displayResultDecodeParams.jsp' data-is-ajax='true' data-is-inline="true" data-result-destination='<%= "#" + idResultInLine %>'>   
                                  
    <div class="ds44-js-linked-fields ds44-js-masked-fields">                               
        <%-- Commune --%>
        <ds:facetteAutoCompletion idFormElement='contact-structure' 
                name="structure" 
                request="<%= request %>" 
                isFacetteObligatoire="true" 
                dataMode="select-only" 
                dataUrl="plugins/SoclePlugin/jsp/facettes/acSearchPublication.jsp" 
                label='<%= glp("jcmsplugin.socle.structure.nom") %>'
                isLarge="false"/>           
    </div>

    <button class="ds44-btnStd ds44-btn--invert" title='<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.valider")) %>'>
        <span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.valider") %></span><i class="icon icon-long-arrow-right" aria-hidden="true"></i>
    </button>  
                                                    
    <input type="hidden" name="redirectUrl" value="plugins/SoclePlugin/jsp/facettes/displayContactStructure.jsp" data-technical-field />
                   
</form>

<div id="<%= idResultInLine %>"></div>