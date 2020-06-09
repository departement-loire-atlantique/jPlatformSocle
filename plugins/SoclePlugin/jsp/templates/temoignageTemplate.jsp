<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@page import="sun.awt.image.URLImageSource"%>
<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ include file='/jcore/media/mediaTemplateInit.jspf' %><%
%><%

if (data == null || ( !(data instanceof Video) && !(data instanceof FicheArticle) && !(data instanceof Lien))) {
  return;
}
Publication pub = (Publication) data;
%>
<%@include file="tuileCommon.jsp" %>
<%
String titre = "";
String sousTitre = "";
String texteAlternatif = "";
String altAttr = "";
boolean isVideo = data instanceof Video;


try {
  titre = (String) pub.getFieldValue("titreTemoignage");
} catch(Exception e) {}
try {
  sousTitre = (String) pub.getFieldValue("soustitreTemoignage");
} catch(Exception e) {}
try {
  texteAlternatif = (String) pub.getFieldValue("texteAlternatif");
} catch(Exception e) {}

try {
  urlImage = (String) pub.getFieldValue("imagePrincipale");
} catch(Exception e) {}

if (Util.notEmpty(urlImage)) {
  urlImage = SocleUtils.getUrlOfFormattedImageTemoignage(urlImage);
}
else{
  urlImage = "s.gif";
}
if (Util.isEmpty(titre)) {
  titre = pub.getTitle();
}
if(Util.notEmpty(texteAlternatif)){
	altAttr = " alt=\"" + HttpUtil.encodeForHTMLAttribute(texteAlternatif) +"\" ";
} else if (Util.notEmpty(titre)) {
	altAttr = " alt=\"" + HttpUtil.encodeForHTMLAttribute(titre) +"\" ";
}
%>
<section class="ds44-box ds44-js-card ds44-card mbm">
    <div class="ds44-bgGray">
        <div class="ds44-posRel">
            <img src="<%=urlImage %>" class="ds44-box__img" <%= altAttr %> />
            <jalios:if predicate="<%=isVideo %>">
                <span class="ds44-mediaIndicator"><i class="icon icon-play" aria-hidden="true"></i></span>
            </jalios:if>
        </div>
        <div class="ds44--m-padding">
            <h3 class="ds44-card__title"><a href="<%=urlPub %>" <%=titleAttr%> <%=targetAttr%>><%=titre%></a></h3>
            <jalios:if predicate="<%=Util.notEmpty(sousTitre) %>">
                <h4 class="ds44-cardDate ds44-card__title"><%=sousTitre%></h4>
            </jalios:if>
            <i class="icon icon-arrow-right ds44-cardArrow" aria-hidden="true"></i>
        </div>
    </div>
</section>