<%@page import="java.util.HashSet"%><%
%><%@ include file='/jcore/doInitPage.jsp'%><% %>
<% response.setContentType("application/json"); %><%


Set<String> panierSet = (Set<String>) request.getSession().getAttribute("panier");


Publication pub = getPublicationParameter("pubId");
String pubIdString = "";

if(Util.notEmpty(pub)){
  pubIdString = pub.getId();
  if(Util.isEmpty(panierSet)) {
	  panierSet = new HashSet<String>();	  
	  panierSet.add(pubIdString);	  
  } else {
    if(panierSet.contains(pubIdString)) {
      panierSet.remove(pubIdString);
    } else {
      panierSet.add(pubIdString);
    }
  }
  
  session.setAttribute("panier", panierSet);
 
}


%>{
    "nbSelect": <%= panierSet != null ? panierSet.size() : 0 %>,
    "enabled":  <%= panierSet != null ? panierSet.contains(pubIdString) : false %>
}