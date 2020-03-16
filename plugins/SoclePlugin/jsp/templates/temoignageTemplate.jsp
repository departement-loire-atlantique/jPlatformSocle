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
String titleLien = "";
boolean isVideo = data instanceof Video;


try {
  titre = (String) obj.getFieldValue("titreTemoignage");
} catch(Exception e) {}
try {
  sousTitre = (String) obj.getFieldValue("soustitreTemoignage");
} catch(Exception e) {}
try {
  urlImage = (String) obj.getFieldValue("imageMobile");
} catch(Exception e) {}
if(Util.isEmpty(urlImage)){
	try {
	  urlImage = (String) obj.getFieldValue("imagePrincipale");
	  urlImage = ThumbnailTag.buildThumbnail(urlImage, 300, 260, urlImage);
	} catch(Exception e) {}
}
if (Util.isEmpty(urlImage)) {
  urlImage = "s.gif";
}
if (Util.isEmpty(titre)) {
  titre = obj.getTitle();
}

titleLien = titre;
if(isVideo){
  titleLien += " - "+JcmsUtil.glp(userLang, "jcmsplugin.socle.pageVideo");
}
%>
<section class="ds44-box">
    <div class="ds44-bgGray">
        <div class="ds44-posRel">
            <img src="<%=urlImage %>" alt="" class="ds44-box__img" />
            <jalios:if predicate="<%=isVideo %>">
                <span class="ds44-mediaIndicator"><i class="icon icon-play" aria-hidden="true"></i></span>
            </jalios:if>
        </div>
        <div class="ds44--m-padding">
            <p role="heading" aria-level="3"><a href="<%=urlPub %>" title="<%=HttpUtil.encodeForHTMLAttribute(titleLien)%>"><%=titre%></a></p>
            <jalios:if predicate="<%=Util.notEmpty(sousTitre) %>">
                <p class="ds44-cardDate"><%=sousTitre%></p>
            </jalios:if>
        </div>
    </div>
</section>