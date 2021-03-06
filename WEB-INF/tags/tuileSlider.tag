<%@tag import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ tag pageEncoding="UTF-8" description="Tuile de slider"
    body-content="scriptless"
    import="com.jalios.jcms.Channel, com.jalios.util.Util, com.jalios.jcms.Publication, java.util.Locale, java.text.SimpleDateFormat, java.util.Date"%>
<%@ attribute name="pub" required="true" fragment="false"
    rtexprvalue="true" type="Publication"
    description="La publication a afficher"%>
<%@ attribute name="theme" required="true" fragment="false"
    rtexprvalue="true" type="String"
    description="Le thème de la tuile"%>

<%

    String userLang = Channel.getChannel().getCurrentJcmsContext().getUserLang();
    Locale userLocale = Channel.getChannel().getCurrentJcmsContext().getUserLocale();
    
    String urlImage = "";
    String title = pub.getTitle();
    String subTitle = "";
    String location = "";
    
    try {
     urlImage = (String) pub.getFieldValue("imageMobile");
    } catch(Exception e) {}
    if (Util.isEmpty(urlImage)) {
     try {
      urlImage = (String) pub.getFieldValue("imageBandeau");
     } catch(Exception e) {}
    }
    if (Util.isEmpty(urlImage)) {
     try {
      urlImage = (String) pub.getFieldValue("imagePrincipale");
     } catch(Exception e) {}
    }
    if (Util.isEmpty(urlImage)) {
     urlImage = "s.gif";
    } else {
      urlImage = SocleUtils.getUrlOfFormattedImageMobile(urlImage);
    }
    
    SimpleDateFormat sdf = new SimpleDateFormat(glp("date-format"));
    
    try {
        subTitle = sdf.format((Date) pub.getFieldValue("dateActu"));
    } catch(Exception e) {}
    
    try {
        location = (String) pub.getFieldValue("lieu");
    } catch(Exception e) {}

%>

<li class="swiper-slide">
    <section
        class="ds44-card ds44-card--verticalPicture ds44-<%= theme %>">
        <% if (Util.notEmpty(urlImage)) { %>
            <a href="<%= pub.getDisplayUrl(userLocale) %>"><picture
                    class="ds44-container-imgRatio"> <img
                    src="<%= urlImage %>" alt="" class="ds44-imgRatio" /> </picture>
            </a>
        <% } %>
        <div class="ds44-card__section">
            <p role="heading" aria-level="2" class="ds44-card__title">
                <a href="<%= pub.getDisplayUrl(userLocale) %>"
                    class="ds44-card__globalLink"> <%= title %>
                </a>
            </p>
            <% if (Util.notEmpty(subTitle)) { %>
                <p><%= subTitle %></p>
            <% } %>
            <% if (Util.notEmpty(location)) { %>
                <p class="ds44-cardLocalisation">
                    <i class="icon icon-marker" aria-hidden="true"></i> <span
                        class="ds44-iconInnerText"><%= location %></span>
                </p>
            <% } %>
            <a href="<%= pub.getDisplayUrl(userLocale) %>"> <i
                class="icon icon-arrow-right ds44-cardArrow" aria-hidden="true"></i>
                <span class="visually-hidden"><%= title %></span>
            </a>
        </div>
    </section>
</li>