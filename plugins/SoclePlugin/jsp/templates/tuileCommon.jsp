<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%
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
String titleAttr = ""; // code HTML de l'attribut "title"
String titleValue = ""; // valeur de l'attribut "title"
String styleContext= Util.notEmpty(request.getParameter("context")) ? "ds44-darkContext" : "";
boolean isSmall = Util.notEmpty(request.getParameter("size")) ? true : false;
boolean isExtraSmall = (Util.notEmpty(request.getParameter("size")) && request.getParameter("size").equals("extrasmall")) ? true : false;
boolean colorTheme = Util.notEmpty(request.getParameter("colorTheme")) ? true : false;
String paddingVignette = (Util.notEmpty(request.getParameter("padding")) && request.getParameter("padding").equals("small")) ? "ds44--s-padding" : "";
String styleVignette = "";
boolean isInSixPanelsContext = Util.notEmpty(request.getParameter("cssSix")) ? true : false;
boolean isLargeTuile = Util.notEmpty(request.getParameter("largePic")) ? true : false;
String subTitle = "";
String location = "";
boolean isDossier = pub instanceof Dossier;

if(isExtraSmall){
  styleVignette = "--dim80";
}else if(isSmall){
  styleVignette = "--dim110";
}
   
/* Le type de contenu "Lien" peut pointer vers une publication ou un site externe 
   Dans le cas d'une pub, si c'est un FileDoc alors on fait le lien direct sur le fichier,
   sinon on renvoie vers le contenu.
*/
if (isLien) {
  Lien itLien = (Lien) pub;
  if (Util.notEmpty(itLien.getLienInterne())) {
    if (itLien.getLienInterne() instanceof FileDocument) {
		isDoc = true;
		FileDocument itDoc = (FileDocument) itLien.getLienInterne();
		fileType = FileDocument.getExtension(itDoc.getFilename()).toUpperCase();
		fileSize = Util.formatFileSize(itDoc.getSize());
		urlPub = itDoc.getDownloadUrl();
		targetBlank = true;
		titleValue = glp("jcmsplugin.socle.lien.document.nouvelonglet", itLien.getTitle(), fileSize, fileType);
      }else{
        urlPub = itLien.getLienInterne().getDisplayUrl(userLocale);
      }
  }else if (Util.notEmpty(itLien.getLienExterne())) {
    urlPub = itLien.getLienExterne();
    targetBlank = true;
    titleValue = glp("jcmsplugin.socle.lien.site.nouvelonglet", itLien.getTitle());
  }
}

/*  Accessibilité : on place un attribut "title" sur le lien uniquement si il s'ouvre dans une nouvelle fenêtre
    Si lien externe : "Site web  : [Nom du lieu/établissement/entité/site web...] - nouvelle fenêtre"
    Si doc : "[Titre du contenu] + poids + format - nouvelle fenêtre" 
*/
if(targetBlank){
  targetAttr = glp("jcmsplugin.socle.targetblank");
  titleAttr = " title=\"" + HttpUtil.encodeForHTMLAttribute(titleValue) +"\" ";
  }
%>