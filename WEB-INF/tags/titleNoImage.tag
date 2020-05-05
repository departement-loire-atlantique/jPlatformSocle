<%@ taglib uri="jcms.tld" prefix="jalios" %>
<%@ tag 
    pageEncoding="UTF-8"
    description="Titre du header sans image" 
    body-content="scriptless" 
    import="com.jalios.jcms.Channel, com.jalios.util.ServletUtil, com.jalios.util.Util"
%>
<%@ attribute name="title"
    required="true"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Le titre du bloc gris"
%>
<%@ attribute name="subtitle"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Le sous-titre du bloc gris"
%>
<%@ attribute name="coloredSection"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Le contenu devant s'afficher dans la section de couleur"
%>
<%@ attribute name="breadcrumb"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="Boolean"
    description="Indique si le fil d'ariane doit être affiché"
%>
<%@ attribute name="date"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="La date à afficher (si renseignée)"
%>

<% String uid = ServletUtil.generateUniqueDOMId(request, "uid"); %>

<div class="ds44-lightBG ds44-posRel">
    <%-- BOUTON RETOUR --%>
    <%--
    <a href="#" class="ds44-btnStd ds44-btnStd--retourPage" title="Retour à la la liste des lieux"><i class="icon icon-long-arrow-left" aria-hidden="true"></i><span class="ds44-btnInnerText">Retour à la liste</span></a>
     --%>
    <%-- FIN BOUTON--%>
    <div class="ds44-inner-container ds44--xl-padding-t ds44--m-padding-b ds44-tablette-reduced-pt">
        <div class="ds44-grid12-offset-2">
            <div class="ds44-tablette-reduced-mt">
                <%-- FIL ARIANE --%>
		        <jalios:if predicate='<%=breadcrumb && Util.notEmpty(Channel.getChannel().getProperty("jcmsplugin.socle.portlet.filariane.id")) %>'>
		            <jalios:include id='<%=Channel.getChannel().getProperty("jcmsplugin.socle.portlet.filariane.id") %>'/>
		        </jalios:if>        
            </div>
      
            <h1 class="h1-like mbs mts" id="idTitre_<%= uid %>"><%= title %></h1>
            
            <jalios:if predicate="<%= Util.notEmpty(subtitle) %>">
                <h2 id="idSousTitre_<%= uid %>" class="h2-like"><%= subtitle %></h2>
            </jalios:if>

    </div>
  </div>
</div>

<jalios:if predicate="<%= Util.notEmpty(coloredSection) %>">
<div class="ds44-img50 ds44--l-padding-tb">
  <div class="ds44-inner-container">
    <div class="ds44-grid12-offset-1">
      <section class="ds44-box ds44-theme">
        <div class="ds44-innerBoxContainer">

            <%-- Contenu bloc coloré --%>
            <%= coloredSection %>
            <%-- fin bloc coloré --%>

        </div>
      </section>
    </div>
  </div>
</div>
</jalios:if>