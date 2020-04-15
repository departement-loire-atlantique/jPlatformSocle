<%@tag import="com.jalios.jcms.context.JcmsContext"%>
<%@tag import="com.jalios.util.Browser"%>
<%@ taglib uri="jcms.tld" prefix="jalios" %>
<%@ tag 
    pageEncoding="UTF-8"
    description="Phone" 
    body-content="scriptless" 
    import="com.jalios.jcms.Channel, com.jalios.util.ServletUtil, com.jalios.util.Util"
%>
<%@ attribute name="number"
    required="true"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Numéro de téléphone"
%>
<%
// On ne garde que les chiffres puis on sépare les paires par un espace
String displayedPhone = number.replaceAll("[^0-9-]","").replaceAll("..", "$0 ");
String linkPhone = "+33" + number.substring(1);

JcmsContext jcmsContext = Channel.getChannel().getCurrentJcmsContext();
%>
<jalios:if predicate='<%= ! jcmsContext.getBrowser().isSmallDevice() %>'>
	<%= displayedPhone %><br>
</jalios:if>
<jalios:if predicate='<%= jcmsContext.getBrowser().isSmallDevice() %>'>
	<a class="ds44-m-t-xl-noUnderline" href="tel:<%= linkPhone %>" title="<%= displayedPhone %>"><%= displayedPhone %></a>
</jalios:if>
