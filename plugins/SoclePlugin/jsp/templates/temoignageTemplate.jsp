<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@page import="sun.awt.image.URLImageSource"%>
<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ include file='/jcore/media/mediaTemplateInit.jspf' %><%
%><%

if (data == null || ( !(data instanceof Video) && !(data instanceof FicheArticle))) {
  return;
}
Content obj = (Content) data;
String urlPub = obj.getDisplayUrl(userLocale);
String urlImage = "";
String titre = "";
String sousTitre = "";
boolean isVideo = data instanceof Video;


try {
  titre = (String) obj.getFieldValue("titreTemoignage");
} catch(Exception e) {}
try {
  sousTitre = (String) obj.getFieldValue("soustitreTemoignage");
} catch(Exception e) {}

try {
  urlImage = (String) obj.getFieldValue("imagePrincipale");
} catch(Exception e) {}

if (Util.notEmpty(urlImage)) {
  urlImage = SocleUtils.getUrlOfFormattedImageTemoignage(urlImage);
}
else{
  urlImage = "s.gif";
}
if (Util.isEmpty(titre)) {
  titre = obj.getTitle();
}
%>
<section class="ds44-box ds44-js-card ds44-card mbm">
    <div class="ds44-bgGray">
        <div class="ds44-posRel">
            <img src="<%=urlImage %>" alt="" class="ds44-box__img" />
            <jalios:if predicate="<%=isVideo %>">
                <span class="ds44-mediaIndicator"><i class="icon icon-play" aria-hidden="true"></i></span>
            </jalios:if>
        </div>
        <div class="ds44--m-padding">
            <p role="heading" aria-level="3"><a href="<%=urlPub %>"><%=titre%></a></p>
            <jalios:if predicate="<%=Util.notEmpty(sousTitre) %>">
                <h4 class="ds44-cardDate"><%=sousTitre%></h4>
            </jalios:if>
            <i class="icon icon-arrow-right ds44-cardArrow" aria-hidden="true"></i>
        </div>
    </div>
</section>