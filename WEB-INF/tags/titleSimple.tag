<%@ taglib prefix="ds" tagdir="/WEB-INF/tags" %><%
%><%@ taglib uri="jcms.tld" prefix="jalios" %><%
%><%@ tag 
    pageEncoding="UTF-8"
    description="Titre du header simple" 
    body-content="scriptless" 
    import="com.jalios.jcms.Channel, com.jalios.util.ServletUtil, com.jalios.util.Util, com.jalios.jcms.JcmsUtil"
%>
<%@ attribute name="title"
    required="true"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Le titre affiché sur l'image"
%>
<%@ attribute name="imagePath"
    required="true"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Le chemin du fichier image"
%>
<%@ attribute name="mobileImagePath"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Le chemin du fichier image mobile"
%>
<%@ attribute name="legend"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Légende de l'image"
%>
<%@ attribute name="copyright"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Copyright de l'image"
%>
<%@ attribute name="date"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Date de publication"
%>
<%@ attribute name="breadcrumb"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="Boolean"
    description="Indique si le fil d'ariane doit être affiché"
%>
<%@ attribute name="userLang"
    required="true"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="La valeur de userLang pour la bonne traduction du label"
%>

<% String uid = ServletUtil.generateUniqueDOMId(request, "uid"); %>

<div class="ds44-alternate-container">
    <div class="ds44--xl-padding-t pbs large-w66 mauto">
        <jalios:if predicate='<%=breadcrumb && Util.notEmpty(Channel.getChannel().getProperty("jcmsplugin.socle.portlet.filariane.id")) %>'>
	        <jalios:include id='<%=Channel.getChannel().getProperty("jcmsplugin.socle.portlet.filariane.id") %>'/>
        </jalios:if>
        <h1 class="h1-like mbm mtm" id="titreActualite"><%=title%></h1>
        <jalios:if predicate="<%= Util.notEmpty(date) %>">
            <p class="ds44-textLegend"><%= JcmsUtil.glp(userLang, "jcmsplugin.socle.publiele", date) %></p>
        </jalios:if>
    </div>
</div>
<jalios:if predicate="<%=Util.notEmpty(imagePath)%>">
<% if (Util.isEmpty(mobileImagePath)) mobileImagePath = imagePath; %>
    <div class="ds44-alternate-container ds44-img50">
        <div class="large-w75 mauto">
            <picture class="ds44-legendeContainer ds44-container-imgRatio">
		        <jalios:if predicate="<%= Util.notEmpty(imagePath) %>">
		            <source media="(max-width: 36em)" srcset="<%=mobileImagePath%>">
		            <source media="(min-width: 36em)" srcset="<%=imagePath%>">
		            <img src="<%=imagePath%>" alt="" class="ds44-headerImg" id="<%=uid%>"/>
		        </jalios:if>
		        
		        <jalios:if predicate="<%= Util.notEmpty(legend) || Util.notEmpty(copyright)%>">
		            <span class="ds44-imgCaption" aria-describedby="<%=uid%>">
		                <jalios:if predicate="<%= Util.notEmpty(legend)%>">
		                    <%=legend%>
		                </jalios:if>
		                <jalios:if predicate="<%= Util.notEmpty(copyright)%>">
		                    © <%=copyright%>
		                </jalios:if>
		            </span>
		        </jalios:if>            
		    </picture>
        </div>
    </div>
</jalios:if>