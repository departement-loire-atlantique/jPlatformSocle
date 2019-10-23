<%@ tag 
    pageEncoding="UTF-8"
    description="Simple collapser" 
    body-content="scriptless" 
    import="com.jalios.jcms.Channel, com.jalios.util.ServletUtil"
%>
<%@ attribute name="title"
    required="true"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Le libellé clicable du collapser"
%>
<% String uid = ServletUtil.generateUniqueDOMId(request, "uid"); %><%

%>
<button type="button" aria-controls="#collapser-elem-<%=uid%>"	class="ds44-collapser_button"><%=title%><i class="icon icon-down"></i></button>
<div class="ds44-collapser_content" id="collapser-elem-<%=uid%>" aria-expanded="false">
  <jsp:doBody/>
</div>