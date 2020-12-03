<%@ taglib prefix="ds" tagdir="/WEB-INF/tags" %><%
%><%@ taglib uri="jcms.tld" prefix="jalios" %><%
%><%@ tag 
    pageEncoding="UTF-8"
    description="Titre du header accueil delegation" 
    body-content="scriptless" 
    import="com.jalios.jcms.Channel, com.jalios.util.ServletUtil, com.jalios.util.Util, com.jalios.jcms.JcmsUtil, fr.cg44.plugin.socle.SocleUtils,
        com.jalios.jcms.taglib.ThumbnailTag, com.jalios.io.ImageFormat, generated.Delegation, com.jalios.jcms.Publication"
%>
<%@ attribute name="pub"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="Publication"
    description="La publication dont on récupère l'image"
%>
<%@ attribute name="title"
    required="true"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Le titre affiché sur l'image"
%>
<%@ attribute name="imagePath"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Le chemin du fichier image"
%>
<%@ attribute name="legend"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Légende de l'image"
%>
<%@ attribute name="copyright"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Copyright de l'image"
%>
<%@ attribute name="mobileImagePath"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Le chemin du fichier image mobile"
%>
<%@ attribute name="cartePath"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Le chemin du fichier carte"
%>
<%@ attribute name="alt"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Texte alternatif de l'image"
%>
<%@ attribute name="breadcrumb"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="Boolean"
    description="Indique si le fil d'ariane doit être affiché"
%>
<%@ attribute name="delegation"
    required="true"
    fragment="false"
    rtexprvalue="true"
    type="Delegation"
    description="L'objet en cours d'affichage"
%>

<%
String userLang = Channel.getChannel().getCurrentJcmsContext().getUserLang();
String uid = ServletUtil.generateUniqueDOMId(request, "uid");
boolean hasFigcaption = Util.notEmpty(legend) || Util.notEmpty(copyright);

String formattedImagePath = SocleUtils.getUrlOfFormattedImageBandeau(imagePath);
String formattedMobilePath = SocleUtils.getUrlOfFormattedImageMobile(mobileImagePath);;
if (Util.isEmpty(formattedMobilePath)) {
  formattedMobilePath = SocleUtils.getUrlOfFormattedImageMobile(imagePath);
}

String altTxt = SocleUtils.getAltTextFromPub(pub);
%>

<section class="ds44-container-large">

    <div class="ds44-pageHeaderContainer ds44-pageHeaderContainer--deuxCol">
        <div class="ds44-pageHeaderContainer__left">
            <picture class="ds44-pageHeaderContainer__pictureContainer">
                <jalios:if predicate="<%= Util.notEmpty(formattedMobilePath) %>">
                    <source media="(max-width: 36em)" srcset="<%=formattedMobilePath%>">
                </jalios:if>
                <source media="(min-width: 36em)" srcset="<%=formattedImagePath%>">
                <img src="<%=formattedImagePath%>" alt="<%= altTxt %>" class="ds44-headerImg" id="<%=uid%>"/>
            </picture>
            <jalios:if predicate="<%= hasFigcaption%>">
                <figcaption class="ds44-imgCaption">
                    <jalios:if predicate="<%= Util.notEmpty(legend)%>">
                        <%=legend%>
                    </jalios:if>
                    <jalios:if predicate="<%= Util.notEmpty(copyright)%>">
                        © <%=copyright%>
                    </jalios:if>
                </figcaption>
            </jalios:if>
            <div class="ds44-titleContainer">
                <div class="ds44-alphaGradient ds44-alphaGradient--header">
                    <jalios:if predicate='<%=breadcrumb && Util.notEmpty(Channel.getChannel().getProperty("jcmsplugin.socle.portlet.filariane.id")) %>'>
                        <%request.setAttribute("textColor","invert"); %>
                        <jalios:include id='<%=Channel.getChannel().getProperty("jcmsplugin.socle.portlet.filariane.id") %>'/>
                    </jalios:if>
                    <h1 class="h1-like ds44-text--colorInvert" id="idTitre1"><%= title %></h1>
                </div>
            </div>
        </div>
        <div class="ds44-pageHeaderContainer__right">
            <section class="ds44-box ds44-bgGray">
                <div class="ds44-innerBoxContainer">
                    <p role="heading" aria-level="2" class="ds44-box-heading"><%= JcmsUtil.glp(userLang, "jcmsplugin.socle.label.departementPdcv") %></p>
                    <hr>
                    <img src="<%= cartePath %>" alt="<%= altTxt %>">
                    <p class="mts h4-like" role="heading" aria-level="3"><%= delegation.getTitle() %></p>
                    <% String adresse = SocleUtils.formatAdresseEcrire(delegation); %>
                    <jalios:if predicate="<%= Util.notEmpty(adresse) %>">
                    <p class="ds44-docListElem mtm">
                        <i class="icon icon-marker ds44-docListIco" aria-hidden="true"></i>
                        <%= adresse %>
                    </p>
                    </jalios:if>
                    <jalios:if predicate="<%= Util.notEmpty(delegation.getTelephone())%>">
                    <p class="ds44-docListElem mtm">
                        <i class="icon icon-phone ds44-docListIco" aria-hidden="true"></i>
                        <% for (String itPhone : delegation.getTelephone()) { %>
                        <ds:phone number="<%= SocleUtils.cleanNumber(itPhone) %>"></ds:phone>
                        <% } %>
                    </p>
                    </jalios:if>
                    <jalios:if predicate="<%= Util.notEmpty(delegation.getEmail()) %>">
                    <p class="ds44-docListElem mtm">
                        <% for (String itMail : delegation.getEmail()) { %>
                        <i class="icon icon-mail ds44-docListIco" aria-hidden="true"></i><a
                            href="mailto:<%= itMail %>"
                            title='<%= JcmsUtil.glp(userLang, "jcmsplugin.socle.actuedu.contactmail.label", delegation.getTitle()) %> - <%= itMail %>'> <%= itMail %></a>
                        <% } %>
                    </p>
                    </jalios:if>
                </div>
            </section>
        </div>
    </div>

</section>