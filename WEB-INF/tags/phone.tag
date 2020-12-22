<%@ taglib uri="jcms.tld" prefix="jalios" %>
<%@ tag 
    pageEncoding="UTF-8"
    description="Phone" 
    body-content="scriptless" 
    import="com.jalios.jcms.Channel, com.jalios.util.ServletUtil, com.jalios.util.Util, com.jalios.jcms.context.JcmsContext,
    com.jalios.util.Browser, com.jalios.jcms.JcmsUtil, com.jalios.jcms.HttpUtil"
%>
<%@ attribute name="number"
    required="true"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Numéro de téléphone"
%>
<%@ attribute name="pubTitle"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Le titre de la publication. Utilisé pour les stats"
%>
<%
String userLang = Channel.getChannel().getCurrentJcmsContext().getUserLang();
String statLabel = "null";
String statAttr = "";
if(null != pubTitle){
  statLabel = HttpUtil.encodeForHTMLAttribute(pubTitle);
}
statAttr = "data-statistic='{\"name\": \"declenche-evenement\",\"category\": \"BlocNousContacter\",\"action\": \"Téléphone\",\"label\": \"" + statLabel + "\"}'";

// On ne garde que les chiffres puis on sépare les paires par un espace
String displayedPhone = number.replaceAll("[^0-9-]","").replaceAll("..", "$0 ");
String linkPhone = "+33" + number.substring(1);

JcmsContext jcmsContext = Channel.getChannel().getCurrentJcmsContext();
%>
<jalios:if predicate='<%= ! jcmsContext.getBrowser().isSmallDevice() %>'>
	<%= displayedPhone %><br>
</jalios:if>
<jalios:if predicate='<%= jcmsContext.getBrowser().isSmallDevice() %>'>
	<a class="ds44-m-t-xl-noUnderline" href="tel:<%= linkPhone %>" title="<%= displayedPhone %>" <%= statAttr %>><%= displayedPhone %></a>
</jalios:if>
