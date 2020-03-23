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
%>