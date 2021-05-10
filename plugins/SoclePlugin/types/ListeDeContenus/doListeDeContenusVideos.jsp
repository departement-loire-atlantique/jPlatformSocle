<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %>
<%
ListeDeContenus obj = (ListeDeContenus)request.getAttribute(PortalManager.PORTAL_PUBLICATION); 
String styleFond="";
boolean hasFond = false;

if (Util.notEmpty(obj.getStyleDeFond()) && !obj.getStyleDeFond().equals("none")) {
	hasFond = true;
	styleFond = obj.getStyleDeFond();
}
%>

<jalios:if predicate="<%=Util.notEmpty(obj.getContenus())%>">

    <jalios:if predicate="<%= hasFond %>">
        <section class="ds44-box mtm <%=styleFond%>">
            <div class="ds44-innerBoxContainer">
    </jalios:if>

    <jalios:if predicate="<%=Util.notEmpty(obj.getLibelleTitre(userLang)) %>">
        <p role="heading" aria-level="2" class="ds44-box-heading"><%=obj.getLibelleTitre(userLang) %></p>
    </jalios:if>
    
	<ul class="ds44-list">
	
	    <jalios:foreach name="itData" type="com.jalios.jcms.Content" array="<%= obj.getContenus() %>">
	        <jalios:if predicate="<%=itData != null && itData instanceof Video && itData.canBeReadBy(loggedMember)%>">
	            <% Video itDoc = (Video)itData; %>
                <li class="mts">
                    <jalios:include pub="<%= itData %>" usage="embed"/>
                </li>	            
	        </jalios:if>
	    </jalios:foreach>

    </ul>
    
    <jalios:if predicate="<%= hasFond %>">
            </div>
        </section>
    </jalios:if>    

</jalios:if>