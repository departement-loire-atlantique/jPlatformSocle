<%@ taglib uri="jcms.tld" prefix="jalios" %>
<%@ tag 
    pageEncoding="UTF-8"
    description="Titre du header sans image" 
    body-content="scriptless" 
    import="com.jalios.jcms.Channel, com.jalios.util.ServletUtil, com.jalios.util.Util"
%>
<%@ attribute name="title"
    required="true"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Le titre affiché sur l'image"
%>
<%@ attribute name="breadcrumb"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="Boolean"
    description="Indique si le fil d'ariane doit être affiché"
%>
<%@ attribute name="date"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="La date à afficher (si renseignée)"
%>

<% String uid = ServletUtil.generateUniqueDOMId(request, "uid"); %>

<div class="ds44-alternate-container">
	<div class="ds44--xl-padding-t pbs large-w66 mauto">
        <jalios:if predicate='<%=breadcrumb && Util.notEmpty(Channel.getChannel().getProperty("jcmsplugin.socle.portlet.filariane.id")) %>'>
            <jalios:include id='<%=Channel.getChannel().getProperty("jcmsplugin.socle.portlet.filariane.id") %>'/>
        </jalios:if>
	    <h1 class="h1-like mbm mtm" id="idTitre1"><%=title %></h1>
	    <jalios:if predicate='<%=Util.notEmpty(date) %>'>
	       <p class="ds44-textLegend">Publié le <%=date%></p>
	    </jalios:if>
	</div>
</div>