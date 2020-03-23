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
boolean targetBlank=false;
String cible= "";
String title = "";

  try {
    urlImage = (String) pub.getFieldValue("imageMobile");
  } catch (Exception e) {}
  if (Util.isEmpty(urlImage)) {
    try {
      urlImage = (String) pub.getFieldValue("imagePrincipale");
    } catch (Exception e) {}
  }
  if (Util.isEmpty(urlImage)) {
    try {
      urlImage = (String) pub.getFieldValue("imageBandeau");
    } catch (Exception e) {}
  }
  if (Util.notEmpty(urlImage)) {
    urlImage = SocleUtils.getUrlOfFormattedImageMobile(urlImage);
  }

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
        fileSize = Util.formatFileSize(itDoc.getSize(), userLocale);
        urlPub = itDoc.getDownloadUrl();
        targetBlank = true;
      } else {
        urlPub = itLien.getLienSurContenu().getDisplayUrl(userLocale);
      }
    } else if (Util.notEmpty(itLien.getLienExterne())) {
      urlPub = itLien.getLienExterne();
      targetBlank = true;
    }
  }

  // Accessibilité : on n'affiche un "title" sur le lien que s'il s'ouvre dans une nouvelle fenêtre
  if (targetBlank) {
    cible = "target=\"_blank\" ";
    title = "title=\"" + pub.getTitle() + " " + glp("jcmsplugin.socle.accessibily.newTabLabel") + "\"";
  }
%>

<section class="ds44-card ds44-js-card ds44-card--verticalPicture ds44-darkContext">
    <picture class="ds44-container-imgRatio">
        <img class="ds44-imgRatio" src="<%= urlImage %>" alt=''>
    </picture>
    <div class="ds44-card__section">
        <p role="heading" aria-level="2" class="ds44-card__title">
            <a class="ds44-card__globalLink" href="<%= urlPub %>" <%=title%> <%=cible%>>
                <%= pub.getTitle() %>
            </a>
         </p>
    </div>
</section>