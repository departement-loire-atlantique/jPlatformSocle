<%--
  @Summary: "Password Reset Request" form to ask for a new password, when the site is private
--%><%@ include file='/jcore/doInitPage.jspf' %>

<%

Publication redirectPub = channel.getPublication("c_1305010");
String redirectUrl = redirectPub.getDisplayUrl(userLocale);
      
      
String url = URLUtils.buildUrl(redirectUrl, request.getParameterMap());
      
sendRedirect(url);

%>
      
<%@ include file='/jcore/doFooter.jspf' %>
