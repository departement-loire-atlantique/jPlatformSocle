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
String displayedPhone = number.replaceAll("..", "$0 ");
String linkPhone = "+33" + number.substring(1);
%>
<a class="ds44-m-t-xl-noUnderline" href="tel:<%= linkPhone %>" title="<%= displayedPhone %>"><%= displayedPhone %></a>