<%@page import="fr.cg44.plugin.socle.infolocale.util.InfolocaleUtil"%>
<%@page import="fr.cg44.plugin.socle.infolocale.entities.DateInfolocale"%>
<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% EvenementInfolocale obj = (EvenementInfolocale)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%
DateInfolocale currentDisplayedDate = InfolocaleUtil.getClosestDate(itEvent);

String urlPhoto = "";
String legend = "";
String credit = "";

if (Util.notEmpty(itEvent.getPhotos()) && itEvent.getPhotos().length > 0) {
  urlPhoto = itEvent.getPhotos()[0].getPath();
  legend = itEvent.getPhotos()[0].getLegend();
  credit = itEvent.getPhotos()[0].getCredit();
}

String labelLegendCopyright = legend;
if (Util.notEmpty(legend) && Util.notEmpty(credit)) {
  labelLegendCopyright += " " + glp("jcmsplugin.socle.symbol.copyright") + " ";
}
labelLegendCopyright += credit;
%>

<%-- TODO : le fil d'ariane, somewhere --%>

<main role="main" id="content">
   <article class="ds44-container-large">
      <div class="ds44-lightBG ds44-posRel">
         <%-- TODO : bouton retour --%>
         <a href="#" class="ds44-btnStd ds44-btnStd--retourPage" title="Retour à la la liste des lieux"><i class="icon icon-long-arrow-left" aria-hidden="true"></i><span class="ds44-btnInnerText">Retour à la liste</span></a>
         <div class="ds44-inner-container ds44--xl-padding-t ds44--m-padding-b ds44-mobile-reduced-pt">
            <div class="ds44-grid12-offset-2">
                <%-- TODO : titre ou titre libre (pris en prio) --%>
               <h1 class="h1-like mbl mts ds44-mobile-reduced-mb ds44-mobile-reduced-mt">Coquillages et crustacés</h1>
            </div>
         </div>
      </div>
      <div class="ds44-img50 ds44-img50--event">
         <div class="ds44-inner-container">
            <div class="ds44-grid12-offset-1">
               <div class="ds44-theme ds44-flex-valign-center ds44-flex-container ds44-fse ds44--l-padding ">
                  <span class="ds44-docListElem h4-like ds44-inlineBlock">
                    <i class="icon icon-date icon--sizeM ds44-docListIco ds44-posTop7" aria-hidden="true"></i>
                    <jalios:select>
		                <jalios:if predicate="<%= InfolocaleUtil.infolocaleDateIsSingleDay(currentDisplayedDate) %>">
		                    <%= InfolocaleUtil.getDayOfMonthLabel(currentDisplayedDate.getDebut()) %> <%= InfolocaleUtil.getMonthLabel(currentDisplayedDate.getDebut(), false) %>
		                </jalios:if>
		                <jalios:default>
		                    <%= InfolocaleUtil.getDayOfMonthLabel(currentDisplayedDate.getDebut()) %> <%= InfolocaleUtil.getMonthLabel(currentDisplayedDate.getDebut(), false) %>
		                    -
		                    <%= InfolocaleUtil.getDayOfMonthLabel(currentDisplayedDate.getFin()) %> <%= InfolocaleUtil.getMonthLabel(currentDisplayedDate.getFin(), false) %>
		                </jalios:default>
		            </jalios:select>
                  </span>
                  <%-- TODO : type d'événement --%>
                  <span class="ds44-docListElem"><i class="icon icon-tag ds44-docListIco" aria-hidden="true"></i>Balade en nature</span>
                  <jalios:if predicate="<%= Util.notEmpty(obj.getLieu()) && Util.notEmpty(obj.getLieu().getCommune()) %>">
                  <span class="ds44-docListElem"><i class="icon icon-marker ds44-docListIco" aria-hidden="true"></i><%= obj.getLieu().getCommune().getNom() %></span>
                  </jalios:if>
                  <jalios:if predicate="<%= Util.notEmpty(currentDisplayedDate.getHoraire()) %>">
                  <span class="ds44-docListElem"><i class="icon icon-time ds44-docListIco" aria-hidden="true"></i><%= currentDisplayedDate.getHoraire() %></span>
                  </jalios:if>
               </div>
            </div>
         </div>
      </div>
      <section class="ds44-contenuArticle" id="sectionPicture">
         <div class="ds44-inner-container ds44-mtb5">
            <div class="ds44-grid12-offset-1">
               <div class="grid-2-small-1">
                  <div class="col mrl mbs">
                     <figure class="ds44-legendeContainer ds44-container-imgRatio" role="figure" aria-label="<%= labelLegendCopyright %>">
                        <img src="<%= urlPhoto %>" alt="" class="ds44-w100 ds44-imgRatio">
                        <figcaption class="ds44-imgCaption"><%= labelLegendCopyright %></figcaption>
                     </figure>
                  </div>
                  <div class="col mll mbs">
                     <%-- TODO : introduction --%>
                     <p class="ds44-introduction">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam luctus eget libero sed accumsan. Sed mi quam, tempor non orci sit amet, accumsan rhoncus dolor. Curabitur pulvinar vestibulum hendrerit accumsan rhoncus dolor. Curabitur pulvinar vestibulum hendrerit.</p>
                  </div>
               </div>
            </div>
         </div>
      </section>
      <section class="ds44-contenuArticle" id="section1">
         <div class="ds44-inner-container ds44-mtb3">
            <div class="ds44-grid12-offset-2">
               <div class="ds44-negativeOffset-2 ds44-mtb3">
                  <iframe style="width: 100%; height: 480px; border: none;" class="ds44-hiddenPrint" title="Accès à la vidéo : [Titre de la vidéo]" src="https://www.youtube.com/embed/uuFamoYN3Ew?enablejsapi=1&amp;frameborder=0&amp;html5=1&amp;origin=http://localhost:8080&amp;rel=0" allowfullscreen=""></iframe>
                  <p>
                     <a href="#" target="_blank" title="Transcription textuelle de la vidéo : [titre de la vidéo] - nouvelle fenêtre">Transcription textuelle de la vidéo</a>
                  </p>
               </div>
               <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam luctus eget libero sed accumsan. Sed mi quam, tempor non orci sit amet, accumsan rhoncus dolor. Curabitur pulvinar vestibulum hendrerit accumsan rhoncus dolor. Curabitur pulvinar vestibulum hendrerit.</p>
               <p>
                  <strong>Mention libre</strong> consectetur adipiscing elit. Sed mi quam, tempor non orci sit amet, accumsan rhoncus dolor. Curabitur pulvinar vestibulum hendrerit.
               </p>
            </div>
         </div>
      </section>
      <section class="ds44-contenuArticle" id="section2">
         <div class="ds44-inner-container">
            <div class="ds44-grid12-offset-2">
               <div class="grid-2-small-1">
                  <div class="col">
                     <div class="ds44-mb3">
                        <h2 class="h3-like" id="idTitre-list2">Tarifs :</h2>
                        <ul class="ds44-uList">
                           <li>Normal : 8€</li>
                           <li>Réduit : 5€</li>
                           <li><span class="ds44-wsg-exergue">GRATUIT
                              </span>
                           </li>
                        </ul>
                     </div>
                     <div class="ds44-mb3">
                        <h2 class="h3-like" id="idTitre-list4">Adresse :</h2>
                        <div class="ds44-ml1">
                           <p class="ds44-docListElem mtm">
                              <i class="icon icon-marker ds44-docListIco" aria-hidden="true"></i>Manoir de Brehet<br>route de Guérande<br>LA TURBALLE
                           </p>
                           <p class="ds44-docListElem mts">
                              <i class="icon icon-directions ds44-docListIco" aria-hidden="true"></i><a href="#" title="Comment se rendre à : Manoir de Brehet route de Guérande LA TURBALLE">S'y rendre ?</a>
                           </p>
                        </div>
                     </div>
                     <div>
                        <h2 class="h3-like" id="idTitre-list2">Public :</h2>
                        <ul class="ds44-uList">
                           <li>Bébés</li>
                           <li>Enfants (à partir de 8 ans)</li>
                           <li>Adulte</li>
                           <li>Sénior</li>
                           <li>Tout public</li>
                        </ul>
                     </div>
                  </div>
                  <div class="col ds44--xl-padding-l">
                     <div class="ds44-mb3">
                        <h2 class="h3-like" id="idTitre-list3">Contacts et réservation :</h2>
                        <div class="ds44-ml1">
                           <p class="ds44-docListElem mtm">
                              <i class="icon icon-phone ds44-docListIco" aria-hidden="true"></i>02 41 39 21 13
                           </p>
                           <p class="ds44-docListElem mts">
                              <i class="icon icon-mail ds44-docListIco" aria-hidden="true"></i><a href="#mailto:contact@loire-atlantique.fr" aria-label="Contacter [Nom du lieu] par mail : contact@loire-atlantique.fr">Contacter par mail</a>
                           </p>
                           <p class="ds44-docListElem mts">
                              <i class="icon icon-link ds44-docListIco" aria-hidden="true"></i><a href="https://www.loire-atlantique.fr" title="Site internet :  – nouvelle fenêtre" target="_blank">Site internet</a>
                           </p>
                           <p class="ds44-docListElem mts">
                              <i class="icon icon-right ds44-docListIco" aria-hidden="true"></i>Date limite de réservation : 30 juillet 2019
                           </p>
                           <p class="ds44-docListElem mts">
                              <i class="icon icon-right ds44-docListIco" aria-hidden="true"></i>COMPLET
                           </p>
                           <p>
                              <a class="ds44-btnStd ds44-btn--invert" title="Réserver : Coquillages et crustacés"><span class="ds44-btnInnerText">Réserver</span><i class="icon icon-long-arrow-right" aria-hidden="true"></i></a>
                           </p>
                        </div>
                     </div>
                     <div class="ds44-mb3">
                        <h2 class="h3-like" id="idTitre-list3">Accessibilité :</h2>
                        <div class="ds44-ml1">
                           <p class="ds44-docListElem mtm">
                              <i class="icon icon-handicap-visuel ds44-docListIco" aria-hidden="true"></i>Handicap visuel
                           </p>
                           <p class="ds44-docListElem mts">
                              <i class="icon icon-handicap-moteur ds44-docListIco" aria-hidden="true"></i>Handicap moteur
                           </p>
                           <p class="ds44-docListElem mts">
                              <i class="icon icon-handicap-mental ds44-docListIco" aria-hidden="true"></i>Handicap intellectuel
                           </p>
                           <p class="ds44-docListElem mts">
                              <i class="icon icon-handicap-auditif ds44-docListIco" aria-hidden="true"></i>Handicap auditif
                           </p>
                        </div>
                     </div>
                     <div>
                        <h2 class="h3-like" id="idTitre-list2">Langues :</h2>
                        <ul class="ds44-uList">
                           <li>Anglais</li>
                           <li>Espagnol</li>
                        </ul>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </section>
      <section class="ds44-contenuArticle" id="section3">
         <div class="ds44-inner-container ds44-mtb3">
            <div class="ds44-grid12-offset-2">
               <div class="ds44-wsg-encadreContour">
                  <p role="heading" aria-level="2" class="h2-like">Pour aller plus loin</p>
                  <p class="ds44-docListElem">
                     <i class="icon icon-file ds44-docListIco" aria-hidden="true"></i><a href="#" title="Dossier de presse coquillages et crustacés 2019 - PDF - 71,5 Ko - nouvelle fenêtre">Dossier de presse coquillages et crustacés 2019</a><span class="ds44-cardFile">PDF - 71,5 Ko</span>
                  </p>
                  <a class="ds44-btnStd ds44-btn--invert mts" title="Visiter le site internet : www.nomdusite.com - nouvelle fenêtre" target="_blank"><span class="ds44-btnInnerText">www.nomdusite.com</span><i class="icon icon-long-arrow-right" aria-hidden="true"></i></a>
               </div>
            </div>
         </div>
      </section>
      <section class="ds44-partage ds44-flex-container ds44-flex-align-center pal ds44-mb35">
         <h2 class="h4-like" id="idPartageRS">Partagez cette page :</h2>
         <ul class="ds44-list ds44-flex-container ds44-flex-align-center ds44-fse">
            <li><a href="#" target="_blank" class="ds44-rsLink" title="Partager cette page sur Facebook - nouvelle fenêtre" data-statistic="{&quot;name&quot;: &quot;declenche-evenement&quot;,&quot;category&quot;: &quot;Partage page&quot;,&quot;action&quot;: &quot;Facebook&quot;}"><i class="icon icon-facebook icon--sizeL" aria-hidden="true"></i><span class="visually-hidden">Partager cette page sur Facebook</span></a></li>
            <li><a href="#" target="_blank" class="ds44-rsLink" title="Partager cette page sur Twitter - nouvelle fenêtre" data-statistic="{&quot;name&quot;: &quot;declenche-evenement&quot;,&quot;category&quot;: &quot;Partage page&quot;,&quot;action&quot;: &quot;Twitter&quot;}"><i class="icon icon-twitter icon--sizeL" aria-hidden="true"></i><span class="visually-hidden">Partager cette page sur Twitter</span></a></li>
            <li><a href="#" target="_blank" class="ds44-rsLink" title="Partager cette page sur Linkedin - nouvelle fenêtre" data-statistic="{&quot;name&quot;: &quot;declenche-evenement&quot;,&quot;category&quot;: &quot;Partage page&quot;,&quot;action&quot;: &quot;Linkedin&quot;}"><i class="icon icon-linkedin icon--sizeL" aria-hidden="true"></i><span class="visually-hidden">Partager cette page sur Linkedin</span></a></li>
            <li><a href="#" target="_blank" class="ds44-rsLink" title="Contacter le Département de Loire-Atlantique - nouvelle fenêtre" data-statistic="{&quot;name&quot;: &quot;declenche-evenement&quot;,&quot;category&quot;: &quot;Partage page&quot;,&quot;action&quot;: &quot;Loire-Atlantique&quot;}"><i class="icon icon-mail icon--sizeL" aria-hidden="true"></i><span class="visually-hidden">Contacter Le Département de Loire-Atlantique</span></a></li>
         </ul>
      </section>
   </article>
</main>

