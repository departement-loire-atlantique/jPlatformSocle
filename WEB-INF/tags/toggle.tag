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
<button type="button" aria-controls="collapser-elem-<%=uid%>"	class="ds44-collapser_button" aria-expanded="false" role="heading" aria-level="3"><%=title%><i class="icon icon-down" aria-hidden="true"></i></button>
<div class="ds44-collapser_content" id="collapser-elem-<%=uid%>">
  <jsp:doBody/>
</div>