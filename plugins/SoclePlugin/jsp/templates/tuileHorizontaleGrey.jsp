<%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ page import="com.jalios.jcms.taglib.card.*" %><%
%><%@ include file='/jcore/media/mediaTemplateInit.jspf' %><%

if (data == null) {
  return;
}

Publication pub = (Publication) data;

String urlImage = "";

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
   
   String urlPub = pub.getDisplayUrl(userLocale);
   boolean isFileDoc = (pub instanceof FileDocument);
   
   if (isFileDoc) {
       FileDocument itDoc = (FileDocument) pub;
       urlPub = itDoc.getDownloadUrl();
   }

%>

<section class="ds44-card ds44-js-card ds44-card--horizontal">
    <div class="ds44-flex-container ds44-flex-valign-center">
        <jalios:if predicate="<%= Util.notEmpty(urlImage) %>">
            <div class="ds44-card__section--horizontal--img">
                <picture class="ds44-container-imgRatio ds44-container-imgRatio--carre">
                    <img class="ds44-imgRatio" src="<%= urlImage %>" alt='<%= glp("jcmsplugin.socle.illustration") %>'>
                </picture>
            </div>
        </jalios:if>
        <div class="ds44-card__section--horizontal">
            <p class="ds44-card__title" role="heading" aria-level="3">
                <a class="ds44-card__globalLink" href="<%= urlPub %>" title="<%= pub.getTitle() %>" <%= isFileDoc ? "target=\"_blank\"" : "" %>>
                    <%= pub.getTitle() %>
                </a>
            </p>
            <jalios:if predicate="<%= isFileDoc %>">
                <%
                FileDocument itDoc = (FileDocument) pub;
                // Récupérer l'extension du fichier
                String fileType = FileDocument.getExtension(itDoc.getFilename()).toUpperCase();
                // Récupérer la taille du fichier
                String fileSize = Util.formatFileSize(itDoc.getSize(), userLocale);
                %>
                <p class="ds44-cardFile"><%= fileType %> - <%= fileSize %></p>
            </jalios:if>
            <i class="icon icon-arrow-right ds44-cardArrow" aria-hidden="true"></i>
            <span class="visually-hidden">
                <%= pub.getTitle() %>
            </span>
        </div>
    </div>
</section>