<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jspf' %>


<%
  String commune = getAlphaNumParameter("commune", "");
%>

commune : <input type="text" name="commune" value="<%= commune %>">