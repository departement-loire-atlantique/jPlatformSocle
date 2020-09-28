<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>
<%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ page import="com.jalios.jcms.taglib.card.*" %><%
%><%@ include file='/jcore/media/mediaTemplateInit.jspf' %><%
%><%

if (data == null) {
  return;
}

Show pub = (Show) data;

String uid = ServletUtil.generateUniqueDOMId(request, "uid");
String image = "";

// Catégories thématiques
Set<Category> thematiqueCats = new TreeSet<Category>(new Category.DeepOrderComparator());
thematiqueCats.addAll(pub.getCategorie(loggedMember));

// Compagnie
List<String> listeTroupe  = new ArrayList<String>();

if(Util.notEmpty(pub.getTroupe())) {
  listeTroupe.add(pub.getTroupe().getTitle());
}
if(Util.notEmpty(pub.getOtherTroupe())) {
  listeTroupe.add(pub.getOtherTroupe());
}

%>

<section class="ds44-card ds44-js-card ds44-card--contact ds44-box ds44-bgGray ">
     
   
    <div class="ds44-card__section">
        <div class="ds44-innerBoxContainer">
            <p role="heading" aria-level="2" class="h4-like ds44-cardTitle" id="titreTuileFicheAide_<%= uid %>">
                <a href="<%= pub.getDisplayUrl(userLocale) %>" class="ds44-card__globalLink"><%= pub.getTitle() %></a>
            </p>
            
            <hr class="mbs" aria-hidden="true">
            
            <%-- Thématiques --%>
            <jalios:if predicate='<%= Util.notEmpty(thematiqueCats) %>'>
                <p class="ds44-docListElem mts"><i class="icon icon-tag ds44-docListIco" aria-hidden="true"></i><%= Util.join(thematiqueCats, ", ") %></p>
            </jalios:if>
                        
            <%-- Compagnie --%>
            <jalios:if predicate='<%= Util.notEmpty(pub.getTroupe()) || Util.notEmpty(pub.getOtherTroupe()) %>'>
                <p class="ds44-docListElem mts"><i class="icon icon-user-group ds44-docListIco" aria-hidden="true"></i><strong><%= glp("jcmsplugin.socle.show.compagnie") %> : </strong><%= Util.join(listeTroupe, " / ") %></p>
            </jalios:if>
            
            <%-- Date de création --%>
            <jalios:if predicate='<%= Util.notEmpty(pub.getCreationDate()) %>'>
                <p class="ds44-docListElem mts"><i class="icon icon-date ds44-docListIco" aria-hidden="true"></i><strong><%= glp("jcmsplugin.socle.show.date-creation") %> : </strong><%= pub.getCreationDate() %></p>
            </jalios:if>            

        </div>

        <i class="icon icon-arrow-right ds44-cardArrow" aria-hidden="true"></i>

    </div>
</section>