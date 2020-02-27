<%@ tag pageEncoding="UTF-8" description="Tuile de slider"
    body-content="scriptless"
    import="com.jalios.jcms.Channel, com.jalios.util.Util, com.jalios.jcms.Content, com.jalios.jcms.Publication, java.util.Locale"%>
<%@ attribute name="content" required="true" fragment="false"
    rtexprvalue="true" type="Content"
    description="Le contenu a afficher"%>
<%@ attribute name="isUnique" required="true" fragment="false"
    rtexprvalue="true" type="String"
    description="Indique si la tuile est unique"%>

<%

    String userLang = Channel.getChannel().getCurrentJcmsContext().getUserLang();
    Locale userLocale = Channel.getChannel().getCurrentJcmsContext().getUserLocale();
    
    Publication itPub = (Publication) content;

    String urlImage = "";
    String title = itPub.getTitle();
    String subTitle = "";
    String location = "";
    
    try {
     urlImage = (String) itPub.getFieldValue("imagePrincipale");
    } catch(Exception e) {}
    if (Util.isEmpty(urlImage)) {
     try {
      urlImage = (String) itPub.getFieldValue("imageBandeau");
     } catch(Exception e) {}
    }
    if (Util.isEmpty(urlImage)) {
     try {
      urlImage = (String) itPub.getFieldValue("imageMobile");
     } catch(Exception e) {}
    }
    if (Util.isEmpty(urlImage)) {
     urlImage = "s.gif";
    }
    
    // TODO : subTitle
    
    // TODO : location
    
    String subTitle = "";
    
    if (itPub instanceof FicheActu) {
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            subTitle = sdf.parse((Date) itPub.getFieldValue("dateActu"));
        } catch(Exception e) {}
    }


%>
<% if (!Boolean.parseBoolean(isUnique)) { %>
<div class="col col-6">
<% } %>
<div class="ds44-card ds44-legendeContainer ds44-container-imgRatio ds44-container-imgRatio--tuileMiseEnAvant">
    <a href="<%= itPub.getDisplayUrl(userLocale) %>" tabindex="-1" aria-hidden="true">
        <img src="<%= urlImage %>" alt="" class="ds44-w100 ds44-imgRatio" id="imageEnAvant_<%= itPub.getId() %>">
    </a>
    <div class="ds44-theme ds44-innerBoxContainer ds44-blockAbsolute ds44-blockAbsolute--bl">
    <p role="heading" aria-level="2" class="ds44-card__title"><a href="<%= itPub.getDisplayUrl(userLocale) %>" class="ds44-card__globalLink"><%= itPub.getTitle() %></a></p>
    <% if (Util.notEmpty(subTitle)) { %>
    <p><%= subTitle %></p>
    <% } %>
    </div>
</div>
<% if (!Boolean.parseBoolean(isUnique)) { %>
</div>
<% } %>