<%@tag import="com.jalios.jcms.context.JcmsContext"%>
<%@tag import="com.jalios.util.Browser"%>
<%@tag import="com.jalios.jcms.JcmsUtil"%>
<%@ taglib uri="jcms.tld" prefix="jalios" %>
<%@ tag 
    pageEncoding="UTF-8"
    description="Génère une boîte d'affichage de message." 
    body-content="scriptless" 
    import="com.jalios.jcms.Channel,
            com.jalios.util.ServletUtil,
            com.jalios.jcms.JcmsUtil,
            com.jalios.util.Util,
            com.jalios.jcms.context.JcmsMessage,
            java.util.List"
%>
<%@ attribute name="title"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Le titre de la boîte"
%>
<%@ attribute name="msgList"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="List<JcmsMessage>"
    description="La liste des messages à afficher"
%>
<%@ attribute name="type"
    required="true"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Le type de message : information ou error"
%>
<%
String uid = ServletUtil.generateUniqueDOMId(request, "uid");
String userLang = Channel.getChannel().getCurrentJcmsContext().getUserLang();
String styleIcon = "icon-attention";

if("success".equals(type)){
	styleIcon = "icon-check";
}

%>
<div class="ds44-msg-container <%= type %>" aria-live="polite">
    <jalios:if predicate='<%= Util.notEmpty(title) %>'>
        <p id="formMsg_<%= uid %>" class="ds44-message-text">
            <i class="icon <%= styleIcon %> icon--sizeM" aria-hidden="true"></i>
            <span class="ds44-iconInnerText"><%= title %></span>
        </p>
    </jalios:if>
        
	<jalios:if predicate='<%= Util.notEmpty(msgList) %>'>
		<ul class="ds44-errorList">
               <jalios:foreach name="itMessage" type="JcmsMessage" collection="<%= msgList %>">
                   <li><%= JcmsUtil.glp(userLang,itMessage.getMessage()) %></li>
		     </jalios:foreach>
		</ul>
	</jalios:if>
        
</div>