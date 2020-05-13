<%@tag import="com.jalios.jcms.context.JcmsContext"%>
<%@tag import="com.jalios.util.Browser"%>
<%@tag import="com.jalios.jcms.JcmsUtil"%>
<%@ taglib uri="jcms.tld" prefix="jalios" %>
<%@ tag 
    pageEncoding="UTF-8"
    description="Génère une boîte d'affichage de message." 
    body-content="tagdependent" 
    import="com.jalios.jcms.Channel,
            com.jalios.util.ServletUtil,
            com.jalios.jcms.JcmsUtil,
            com.jalios.util.Util,
            com.jalios.jcms.context.JcmsMessage,
            java.util.List"
%>
<%@ attribute name="msg"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Le message à afficher"
%>
<%@ attribute name="msgList"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="List<JcmsMessage>"
    description="La liste des messages à afficher"
%>
<%@ attribute name="title"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Le titre de la boîte"
%>
<%@ attribute name="css"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Les styles à appliquer"
%>
<%
String uid = ServletUtil.generateUniqueDOMId(request, "uid");
String userLang = Channel.getChannel().getCurrentJcmsContext().getUserLang();
%>

<div class="ds44-errorMsg-container" aria-live="polite">
    <jalios:if predicate='<%= Util.notEmpty(title) %>'>
        <p id="error-mgs" class="ds44-msgErrorText ds44-msgErrorInvalid" tabindex="-1">
            <i class="icon icon-attention icon--sizeM" aria-hidden="true"></i>
            <span class="ds44-iconInnerText ds44-errorLabel"><%= title %></span>
        </p>
    </jalios:if>
        
	<jalios:select>
		<jalios:if predicate='<%= Util.notEmpty(msg) %>'>
		  <%= msg %>
		</jalios:if>
		<jalios:if predicate='<%= Util.notEmpty(msgList) %>'>
			<ul class="ds44-errorList">
                <jalios:foreach name="itMessage" type="JcmsMessage" collection="<%= msgList %>">
                    <li><%= JcmsUtil.glp(userLang,itMessage.getMessage()) %></li>
			     </jalios:foreach>
			</ul>
		</jalios:if>
	</jalios:select>
        
</div>