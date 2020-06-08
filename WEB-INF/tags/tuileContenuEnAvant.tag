<%@tag import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ taglib uri="jcms.tld" prefix="jalios" %>
<%@ tag pageEncoding="UTF-8" description="Tuile de slider"
    body-content="scriptless"
    import="com.jalios.jcms.Channel, com.jalios.util.Util, com.jalios.jcms.Content, com.jalios.jcms.Publication, java.util.Locale, java.text.SimpleDateFormat, java.util.Date"%>
<%@ attribute name="content" required="true" fragment="false"
    rtexprvalue="true" type="Content"
    description="Le contenu a afficher"%>
<%@ attribute name="isUnique" required="true" fragment="false"
    rtexprvalue="true" type="String"
    description="Indique si la tuile est unique"%>
<%@ attribute name="positionTitre" required="false" fragment="false"
    rtexprvalue="true" type="String"
    description="Position du bloc titre par dessus l'image"%>    

<%

    String userLang = Channel.getChannel().getCurrentJcmsContext().getUserLang();
    Locale userLocale = Channel.getChannel().getCurrentJcmsContext().getUserLocale();
    
    Publication itPub = (Publication) content;

    String urlImage = "";
    String title = itPub.getTitle();
    String subTitle = "";
    String location = "";
    
    try {
     urlImage = (String) itPub.getFieldValue("imageBandeau");
    } catch(Exception e) {}
    if (Util.isEmpty(urlImage)) {
     try {
      urlImage = (String) itPub.getFieldValue("imagePrincipale");
     } catch(Exception e) {}
    }
    if (Util.isEmpty(urlImage)) {
     try {
      urlImage = (String) itPub.getFieldValue("imageMobile");
     } catch(Exception e) {}
    }
    if (Util.isEmpty(urlImage)) {
     urlImage = "s.gif";
    } else {
      urlImage = SocleUtils.getUrlOfFormattedImageBandeau(urlImage);
    }
    
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
    
    try {
        subTitle = sdf.format((Date) itPub.getFieldValue("dateActu"));
    } catch(Exception e) {}
    
    try {
        location = (String) itPub.getFieldValue("lieu");
    } catch(Exception e) {}


%>
<% if (!Boolean.parseBoolean(isUnique)) { %>
<div class="col col-6">
<% } %>
<div class="ds44-card ds44-legendeContainer ds44-container-imgRatio ds44-container-imgRatio--tuileMiseEnAvant">
    <a href="<%= itPub.getDisplayUrl(userLocale) %>">
        <img src="<%= urlImage %>" alt="" class="ds44-w100 ds44-imgRatio" id="imageEnAvant_<%= itPub.getId() %>">
    </a>
    <jalios:if predicate='<%= Util.notEmpty(positionTitre) %>'>
	    <div class="ds44-theme ds44-innerBoxContainer ds44-blockAbsolute <%=positionTitre%>">
		    <p role="heading" aria-level="3" class="ds44-card__title"><a href="<%= itPub.getDisplayUrl(userLocale) %>" class="ds44-card__globalLink"><%= itPub.getTitle() %></a></p>
		    <% if (Util.notEmpty(subTitle)) { %>
		    <p><%= subTitle %></p>
		    <% } %>
		    <% if (Util.notEmpty(location)) { %>
		    <p class="ds44-cardLocalisation">
		        <i class="icon icon-marker" aria-hidden="true"></i>
		        <span class="ds44-iconInnerText"><%= location %></span>
		    </p>
		    <% } %>
	    </div>
    </jalios:if>
</div>
<% if (!Boolean.parseBoolean(isUnique)) { %>
</div>
<% } %>