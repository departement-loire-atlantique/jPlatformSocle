<%@ include file="/jcore/doInitPage.jspf" %>
<%@ include file="/jcore/portal/doPortletParams.jspf" %><%
%><%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%><%

PortletQueryForeach box = (PortletQueryForeach) portlet;  
String idResultInLine = "structureContactResult";
%>

<p class="ds44-box-heading"><%= glp("jcmsplugin.socle.structure.qui-contacter") %></p>

<p class="ds44-mtb2"><%= glp("jcmsplugin.socle.structure.description") %></p>

<form data-auto-load="true" action='plugins/SoclePlugin/jsp/facettes/displayResultDecodeParams.jsp' data-is-ajax='true' data-is-inline="true" data-result-destination='<%= "#" + idResultInLine %>'>   
 
 
	 <div class="ds44-facetteContainer ds44-flex-container ds44-medium-flex-col">
	    
	    <div class="ds44-fieldContainer ds44-fg1">
		    <div class="ds44-js-linked-fields ds44-js-masked-fields">                               

		        <ds:facetteAutoCompletion idFormElement='contact-structure' 
		                name="structure" 
		                request="<%= request %>" 
		                isFacetteObligatoire="true" 
		                dataMode="select-only" 
		                dataUrl='<%= "plugins/SoclePlugin/jsp/facettes/acSearchPublication.jsp?query=" + HttpUtil.encodeForURL(box.getQueries()[0]) %>'
		                label='<%= glp("jcmsplugin.socle.structure.nom") %>'
		                isLarge="false"/>           
		    </div>
	    </div>
    
    
        <div class="ds44-fieldContainer ds44-small-fg1">
		    <button class="ds44-btnStd ds44-btn--invert" title='<%= HttpUtil.encodeForHTMLAttribute(glp("jcmsplugin.socle.valider")) %>'>
		        <span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.valider") %></span><i class="icon icon-long-arrow-right" aria-hidden="true"></i>
		    </button> 
	    </div>
	    
	 </div> 
                                                    
    <input type="hidden" name="redirectUrl" value="plugins/SoclePlugin/jsp/facettes/displayContactStructure.jsp" data-technical-field />
                   
</form>

<div class="ds44-mtb2" id="<%= idResultInLine %>"></div>