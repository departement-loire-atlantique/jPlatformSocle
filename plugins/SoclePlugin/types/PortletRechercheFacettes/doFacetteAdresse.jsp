<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jspf' %>


<%
  String lng = getStringParameter("lng", "", ".*");
  String lat = getStringParameter("lat", "", ".*");
  String rayon = getAlphaNumParameter("rayon", "");
%>

 longitude : <input type="text" name="lng" value="<%= lng %>">
 latitude : <input type="text" name="lat" value="<%= lat %>">    
 rayon : <input type="text" name="rayon" value="<%= rayon %>">