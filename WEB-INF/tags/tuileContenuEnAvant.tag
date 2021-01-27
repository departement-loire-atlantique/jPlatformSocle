<%@tag import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ taglib uri="jcms.tld" prefix="jalios" %>
<%@ tag pageEncoding="UTF-8" description="Tuile de slider"
    body-content="scriptless"
    import="com.jalios.jcms.Channel, com.jalios.util.Util, com.jalios.jcms.JcmsUtil, com.jalios.jcms.Content, com.jalios.jcms.Publication, java.util.Locale, java.text.SimpleDateFormat, java.util.Date, generated.Dossier"%>
<%@ attribute name="content" required="true" fragment="false"
    rtexprvalue="true" type="Content"
    description="Le contenu a afficher"%>
<%@ attribute name="isUnique" required="true" fragment="false"
    rtexprvalue="true" type="String"
    description="Indique si la tuile est unique"%>
<%@ attribute name="positionTitre" required="false" fragment="false"
    rtexprvalue="true" type="String"
    description="Position du bloc titre par dessus l'image"%>   
<%@ attribute name="customUrl" required="false" fragment="false"
    rtexprvalue="true" type="String"
    description="URL custom pour le lien"%>  
<%@ attribute name="isExterne" required="false" fragment="false"
    rtexprvalue="true" type="Boolean"
    description="Détermine si le lien est externe"%>

<%

    String userLang = Channel.getChannel().getCurrentJcmsContext().getUserLang();
    Locale userLocale = Channel.getChannel().getCurrentJcmsContext().getUserLocale();
    
    Publication pub = (Publication) content;

    String urlImage = "";
    String title = pub.getTitle();
    String subTitle = "";
    String location = "";
    
    if (Util.notEmpty(isUnique) && isUnique.equals("true")) {
      try {
        urlImage = (String) pub.getFieldValue("imageBandeau");
       } catch(Exception e) {}
       if (Util.isEmpty(urlImage)) {
        try {
         urlImage = (String) pub.getFieldValue("imageMobile");
        } catch(Exception e) {}
       }
       if (Util.isEmpty(urlImage)) {
        try {
         urlImage = (String) pub.getFieldValue("imagePrincipale");
        } catch(Exception e) {}
       }
    } else {
      try {
        urlImage = (String) pub.getFieldValue("imagePrincipale");
       } catch(Exception e) {}
       if (Util.isEmpty(urlImage)) {
        try {
         urlImage = (String) pub.getFieldValue("imageBandeau");
        } catch(Exception e) {}
       }
       if (Util.isEmpty(urlImage)) {
        try {
         urlImage = (String) pub.getFieldValue("imageMobile");
        } catch(Exception e) {}
       }
    }
    
    if (Util.isEmpty(urlImage)) {
     urlImage = "s.gif";
    } else {
      urlImage = SocleUtils.getUrlOfFormattedImageEnAvant(urlImage);
    }
    
    SimpleDateFormat sdf = new SimpleDateFormat(JcmsUtil.glp(userLang,"date-format"));
    
    try {
        subTitle = sdf.format((Date) pub.getFieldValue("dateActu"));
    } catch(Exception e) {}
    
    try {
        location = (String) pub.getFieldValue("lieu");
    } catch(Exception e) {}
    
    String linkUrl = pub.getDisplayUrl(userLocale);
    if (Util.notEmpty(customUrl)) {
      linkUrl = customUrl;
    }
    
    boolean displayTargetBlank = Util.notEmpty(isExterne) && isExterne;
    
    String titleUrl = "";
    
    String alt="";
    
%>
<% if (!Boolean.parseBoolean(isUnique)) { %>
<div class="col col-6">
<% } %>

<div class="ds44-card ds44-js-card ds44-legendeContainer ds44-container-imgRatio ds44-container-imgRatio--tuileMiseEnAvant">

    <img src="<%= urlImage %>" alt="<%= alt %>" class="ds44-w100 ds44-imgRatio" id="imageEnAvant_<%= pub.getId() %>">
    
    <jalios:if predicate="<%= Util.isEmpty(positionTitre) %>">
        <a href="<%= linkUrl %>"<% if (Util.notEmpty(titleUrl)) { %> title="<%= titleUrl %>" alt="<%= titleUrl %>"<% } if (displayTargetBlank) { %> target="_blank"<% } %>><%= pub.getTitle(userLang) %>>
    </jalios:if>

    <jalios:if predicate='<%= Util.notEmpty(positionTitre) %>'>
        <div class="ds44-theme ds44-innerBoxContainer ds44-blockAbsolute <%=positionTitre%>">
            <p role="heading" aria-level="3" class="ds44-card__title">
                <a href="<%= linkUrl %>" class="ds44-card__globalLink"<% if (Util.notEmpty(titleUrl)) { %> title="<%= titleUrl %>" <% } if (displayTargetBlank) { %> target="_blank"<% } %>><%= pub.getTitle(userLang) %></a></p>
            <% if (Util.notEmpty(subTitle)) { %>
            <p><%= subTitle %></p>
            <% } %>
            <jalios:if predicate="<%= pub instanceof Dossier %>">
	            <%
	            Dossier tmpDossier = (Dossier) pub;
	            %>
	            <jalios:if predicate="<%= Util.notEmpty(tmpDossier.getDate()) %>">
	                <p class='ds44-cardDate'>
	                     <span class="ds44-iconInnerText"><%= SocleUtils.formatDate("dd/MM/yy", tmpDossier.getDate()) %></span>
	                </p>
	            </jalios:if>
	        </jalios:if>
            <% if (Util.notEmpty(location)) { %>
            <p class="ds44-cardLocalisation">
                <i class="icon icon-marker" aria-hidden="true"></i>
                <span class="ds44-iconInnerText"><%= location %></span>
            </p> 
            <% } %>
        </div>
    </jalios:if>
    
    <jalios:if predicate="<%= Util.isEmpty(positionTitre) %>">
        </a>
    </jalios:if>
</div>
<% if (!Boolean.parseBoolean(isUnique)) { %>
</div>
<% } %>