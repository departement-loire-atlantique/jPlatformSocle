<%@tag import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ taglib prefix="ds" tagdir="/WEB-INF/tags" %><%
%><%@ taglib uri="jcms.tld" prefix="jalios" %><%
%><%@ tag 
    pageEncoding="UTF-8"
    description="Titre du header accueil delegation" 
    body-content="scriptless" 
    import="com.jalios.jcms.Channel, com.jalios.util.ServletUtil, com.jalios.util.Util, com.jalios.jcms.JcmsUtil, 
        com.jalios.jcms.taglib.ThumbnailTag, com.jalios.io.ImageFormat, generated.Delegation"
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
<%@ attribute name="mobileImagePath"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Le chemin du fichier image mobile"
%>
<%@ attribute name="alt"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Texte alternatif de l'image"
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
%>

<section class="ds44-container-large">

    <div class="ds44-pageHeaderContainer ds44-pageHeaderContainer--deuxCol">
        <div class="ds44-pageHeaderContainer__left">
            <picture class="ds44-pageHeaderContainer__pictureContainer">
            <img src="../../assets/images/header-page-carrefour.jpg" alt=""
                class="ds44-headerImg"> </picture>
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
                    <img src="../../assets/images/deleg-st_nazaire.png" alt="">
                    <p class="mts h4-like" role="heading" aria-level="3"><%= delegation.getTitle() %></p>
                    <p class="ds44-docListElem mtm">
                        <i class="icon icon-marker ds44-docListIco" aria-hidden="true"></i>
                        <%= SocleUtils.formatAddress(delegation.getStreet(), null, null, null, null, null, delegation.getPostalBox(), delegation.getZipCode(), delegation.getCity().getTitle(), null) %>
                    </p>
                    <% if (Util.notEmpty(delegation.getPhones())) { %>
                    <p class="ds44-docListElem mtm">
                        <i class="icon icon-phone ds44-docListIco" aria-hidden="true"></i>
                        <% for (String itPhone : delegation.getPhones()) { %>
                        <ds:phone number="<%= SocleUtils.cleanNumber(itPhone) %>"></ds:phone>
                        <% } %>
                    </p>
                    <% } %>
                    <% if (Util.notEmpty(delegation.getMails())) { %>
                    <p class="ds44-docListElem mtm">
                        <% for (String itMail : delegation.getMails()) { %>
                        <i class="icon icon-mail ds44-docListIco" aria-hidden="true"></i><a
                            href="mailto:<%= itMail %>"
                            aria-label='<%= JcmsUtil.glp(userLang, "jcmsplugin.socle.actuedu.contactmail.label", delegation.getTitle()) %> - <%= itMail %>'> <%= itMail %></a>
                        <% } %>
                    </p>
                    <% } %>
                </div>
            </section>
        </div>
    </div>

</section>