<%@ taglib prefix="ds" tagdir="/WEB-INF/tags" %><%
%><%@ taglib uri="jcms.tld" prefix="jalios" %><%
%><%@ tag 
    pageEncoding="UTF-8"
    description="Titre du header accueil delegation" 
    body-content="scriptless" 
    import="com.jalios.jcms.Channel, com.jalios.util.ServletUtil, com.jalios.util.Util, com.jalios.jcms.JcmsUtil, 
        com.jalios.jcms.taglib.ThumbnailTag, com.jalios.io.ImageFormat"
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
					<nav role="navigation" aria-label="Votre position"
						class="ds44-hide-mobile">
						<ul class="ds44-list ds44-breadcrumb ds44-text--colorInvert">
							<li class="ds44-breadcrumb_item"><a href="#"><i
									class="icon icon-home icon--medium" aria-hidden="true"></i><span
									class="visually-hidden">Accueil</span></a></li>
							<li class="ds44-breadcrumb_item"><a href="#">Précedent</a></li>
							<li class="ds44-breadcrumb_item"><a href="#">Précédent</a></li>
							<li class="ds44-breadcrumb_item" aria-current="location"><span>Ici</span></li>
						</ul>
					</nav>
					<h1 class="h1-like ds44-text--colorInvert" id="idTitre1">Titre
						de page avec image-bandeau</h1>
				</div>
			</div>
		</div>
		<div class="ds44-pageHeaderContainer__right">
			<section class="ds44-box ds44-bgGray">
				<div class="ds44-innerBoxContainer">
					<p role="heading" aria-level="2" class="ds44-box-heading">Le
						Département est présent près de chez vous</p>
					<hr>
					<img src="../../assets/images/deleg-st_nazaire.png" alt="">
					<p class="mts h4-like" role="heading" aria-level="3">Délégation
						de Saint-Nazaire</p>
					<p class="ds44-docListElem mtm">
						<i class="icon icon-marker ds44-docListIco" aria-hidden="true"></i>12,
						place Pierre Sémard<br>CS 30423<br>44616 Saint-Nazaire
						Cedex
					</p>
					<p class="ds44-docListElem mtm">
						<i class="icon icon-phone ds44-docListIco" aria-hidden="true"></i>02
						49 77 41 40
					</p>
					<p class="ds44-docListElem mtm">
						<i class="icon icon-mail ds44-docListIco" aria-hidden="true"></i><a
							href="mailto:contact@loire-atlantique.fr"
							aria-label="Contacter : Délégation Saint-Nazaire par mail - contact@loire-atlantique.fr">contact@loire-atlantique.fr</a>
					</p>
				</div>
			</section>
		</div>
	</div>

</section>