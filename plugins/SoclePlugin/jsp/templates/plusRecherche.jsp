<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ page import="com.jalios.jcms.taglib.card.*" %><%
%><%@ include file='/jcore/media/mediaTemplateInit.jspf' %><%

if (data == null) {
  return;
}

Publication pub = (Publication) data;

//On ne gère pas les fileDocument, le contributeur passera par un contenu "Lien"
if(pub instanceof FileDocument){
  return;
}
%>

<jalios:select>
    <jalios:if predicate="<%= pub instanceof ListeDeContenus %>">
        <jalios:foreach name="itContent" type="Content" array="<%= ((ListeDeContenus) pub).getContenus() %>">
            <jalios:select>
                <jalios:if predicate="<%= itContent instanceof Lien %>">
                    <% Lien currentLien = (Lien) itContent; %>
                    <%@ include file="plusRechercheLien.jspf" %>
                </jalios:if>
                <jalios:if predicate="<%= ! (itContent instanceof FileDocument) %>">
                    <a class="ds44-arrowLink" title="<%= itContent.getTitle() %>" href="<%= itContent.getDisplayUrl(userLocale) %>"><%= itContent.getTitle() %><i class="icon icon-arrow-right"></i></a>
                </jalios:if>
            </jalios:select>
        </jalios:foreach>
    </jalios:if>
    
	<jalios:if predicate="<%= pub instanceof Lien %>">
	    <% Lien currentLien = (Lien) pub; %>
		<%@ include file="plusRechercheLien.jspf" %>
	</jalios:if>
	
	<jalios:default>
	    <a class="ds44-arrowLink" title="<%= pub.getTitle() %>" href="<%= pub.getDisplayUrl(userLocale) %>"><%= pub.getTitle() %><i class="icon icon-arrow-right"></i></a>
	</jalios:default>
</jalios:select>