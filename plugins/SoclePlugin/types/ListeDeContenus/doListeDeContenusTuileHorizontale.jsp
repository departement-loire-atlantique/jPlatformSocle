<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/media/mediaTemplateInit.jspf' %>
<%

if (data == null) {
  return;
}

ListeDeContenus pub = (ListeDeContenus) data;
%>

<jalios:if predicate="<%=Util.notEmpty(pub.getContenus())%>">
    <jalios:if predicate="<%=Util.notEmpty(pub.getLibelleTitre(userLang))%>">
        <h2 class="h3-like"><%=pub.getLibelleTitre(userLang)%></h2>
	</jalios:if>
	<jalios:foreach name="itData" type="com.jalios.jcms.Content" array="<%= pub.getContenus() %>">
        <jalios:media data='<%=itData %>' template='tuileHorizontaleDark' />
    </jalios:foreach>
</jalios:if>