<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %>
<%-- On génère une seule section, avec les différents contacts dedans --%>

<%
ListeDeContenus obj = (ListeDeContenus)request.getAttribute(PortalManager.PORTAL_PUBLICATION); 
String styleFond="";
String titreBloc = JcmsUtil.glp(userLang, "jcmsplugin.socle.titre.contacts");
boolean hasFond = false;

if (Util.notEmpty(obj.getLibelleTitre(userLang))) {
  titreBloc = obj.getLibelleTitre(userLang);
}

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
            <p role="heading" aria-level="2" class="ds44-box-heading"><%=titreBloc %></p>
	
		    <jalios:foreach name="itData" type="com.jalios.jcms.Content" array="<%= obj.getContenus() %>">
		        <jalios:if predicate="<%=itData != null && itData instanceof FicheLieu && itData.canBeReadBy(loggedMember)%>">
		            <% 
		            FicheLieu itDoc = (FicheLieu)itData;
		            %>
		            <jalios:media data='<%=itDoc %>' template='contact' />
		        </jalios:if>
		    </jalios:foreach>
    <jalios:if predicate="<%= hasFond %>">
            </div>
        </section>
    </jalios:if>	    
</jalios:if>