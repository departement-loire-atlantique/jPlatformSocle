<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ page import="com.jalios.jcms.taglib.card.*" %><%
%><%@ include file='/jcore/media/mediaTemplateInit.jspf' %><%

if (data == null) {
  return;
}

Publication pub = (Publication) data;

// On ne gère pas les fileDocument, le contributeur passera par un contenu "Lien"
if(pub instanceof FileDocument){
  return;
}
String urlImage = "";
String urlPub = pub.getDisplayUrl(userLocale);
boolean isLien = (pub instanceof Lien);
boolean isDoc = false;
String fileType = "";
String fileSize = "";
String fileInfos = "";
boolean targetBlank = false;
String targetAttr = "";
String titleAttr = "";
   
/* Le type de contenu "Lien" peut pointer vers une publication ou un site externe 
   Dans le cas d'une pub, si c'est un FileDoc alors on fait le lien direct sur le fichier,
   sinon on renvoie vers le contenu.
*/
if (isLien) {
  Lien itLien = (Lien) pub;
  if (Util.notEmpty(itLien.getLienSurContenu())) {
    if (itLien.getLienSurContenu() instanceof FileDocument) {
		isDoc = true;
		FileDocument itDoc = (FileDocument) itLien.getLienSurContenu();
		fileType = FileDocument.getExtension(itDoc.getFilename()).toUpperCase();
		fileSize = Util.formatFileSize(itDoc.getSize());
		fileInfos = " - " + fileSize + " - " + fileType;
		urlPub = itDoc.getDownloadUrl();
		targetBlank = true;
      }else{
        urlPub = itLien.getLienSurContenu().getDisplayUrl(userLocale);
      }
  }else if (Util.notEmpty(itLien.getLienExterne())) {
    urlPub = itLien.getLienExterne();
    targetBlank = true;
  }
}

// Accessibilité : on place un attribut "title" sur le lien uniquement si le lien s'ouvre dans une nouvelle fenêtre
if(targetBlank){
  targetAttr = "target=\"_blank\" ";
  titleAttr = "title=\"" +  pub.getTitle() + fileInfos + " " + glp("jcmsplugin.socle.accessibily.newTabLabel")+"\"";
  }

// Génération de la vignette
try {
  urlImage = (String) pub.getFieldValue("imageCarree");
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
 if (Util.isEmpty(urlImage)) {
     try {
      urlImage = (String) pub.getFieldValue("imageBandeau");
     } catch(Exception e) {}
 }
 if (Util.notEmpty(urlImage)) {
     urlImage = SocleUtils.getUrlOfFormattedImageCarree(urlImage);
 }
%>

<section class="ds44-card ds44-js-card ds44-card--horizontal">
    <div class="ds44-flex-container ds44-flex-valign-center">
        <jalios:if predicate="<%= Util.notEmpty(urlImage) %>">
            <div class="ds44-card__section--horizontal--img">
                <picture class="ds44-container-imgRatio ds44-container-imgRatio--carre">
                    <img class="ds44-imgRatio" src="<%= urlImage %>" alt=''>
                </picture>
            </div>
        </jalios:if>
        <div class="ds44-card__section--horizontal">
            <p class="ds44-card__title" role="heading" aria-level="3">
                <a class="ds44-card__globalLink" href="<%= urlPub %>" <%=titleAttr%> <%=targetAttr%>>
                    <%= pub.getTitle() %>
                </a>
            </p>
            <jalios:if predicate="<%= isDoc %>">
                <p class="ds44-cardFile"><%= fileType %> - <%= fileSize %></p>
            </jalios:if>
            <i class="icon icon-arrow-right ds44-cardArrow" aria-hidden="true"></i>
            <span class="visually-hidden">
                <%= pub.getTitle() %>
            </span>
        </div>
    </div>
</section>