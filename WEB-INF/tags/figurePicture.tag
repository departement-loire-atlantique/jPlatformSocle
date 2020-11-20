<%@ taglib uri="jcms.tld" prefix="jalios" %>
<%@ tag 
    pageEncoding="UTF-8"
    description="Génère le bloc html figure avec les images associées" 
    body-content="scriptless" 
    import="com.jalios.jcms.Channel, com.jalios.util.ServletUtil, com.jalios.util.Util,
        com.jalios.jcms.JcmsUtil, com.jalios.jcms.HttpUtil, fr.cg44.plugin.socle.SocleUtils, com.jalios.jcms.Publication"
%>
<%@ attribute name="pub"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="Publication"
    description="La publication dont on récupère l'image"
%>
<%@ attribute name="image"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="L'URL de l'image à afficher"
%>
<%@ attribute name="imageMobile"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="L'URL de l'image mobile"
%>
<%@ attribute name="width"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="Integer"
    description="La largeur de l'image"
%>
<%@ attribute name="height"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="Integer"
    description="La hauteur de l'image"
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
    description="Le copyright de l'image"
%>
<%@ attribute name="alt"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Le texte alternatif de l'image"
%>
<%@ attribute name="ariaLabel"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Le champ aria-label du bloc Picture"
%>
<%@ attribute name="figureCss"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Classes CSS du bloc Figure"
%>
<%@ attribute name="pictureCss"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Classes CSS du bloc Picture"
%>
<%@ attribute name="imgCss"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Classes CSS du bloc Img"
%>
<%@ attribute name="format"
    required="true"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Le format de l'image principale"
%>

<%

if (Util.isEmpty(pub) && Util.isEmpty(image)) {
  return;
}

ariaLabel = HttpUtil.encodeForHTMLAttribute(ariaLabel);
legend = HttpUtil.encodeForHTMLAttribute(legend);
boolean hasFigcaption = Util.notEmpty(legend) || Util.notEmpty(copyright);
String userLang = Channel.getChannel().getCurrentUserLang();
String uid = ServletUtil.generateUniqueDOMId(request, "uid");

String formattedImagePath = "";
String formattedMobilePath = "";

switch(format) {

	case "principale" :
	  if (Util.isEmpty(image)) image = SocleUtils.getImagePrincipale(pub);
	  formattedImagePath = SocleUtils.getUrlOfFormattedImagePrincipale(image);
	  break;
	
	case "bandeau" :
	  if (Util.isEmpty(image)) image = SocleUtils.getImageBandeau(pub);
	  formattedImagePath = SocleUtils.getUrlOfFormattedImageBandeau(image);
	  break;
	
	case "carree" :
	  if (Util.isEmpty(image)) image = SocleUtils.getImageCarree(pub);
	  formattedImagePath = SocleUtils.getUrlOfFormattedImageCarree(image);
	  break;
	
	case "mobile" :
	  if (Util.isEmpty(image)) image = SocleUtils.getImageMobile(pub);
	  formattedImagePath = SocleUtils.getUrlOfFormattedImageMobile(image);
	  break;
	
	case "carouselFull" :
	  if (Util.isEmpty(image)) image = SocleUtils.getImagePrincipale(pub);
	  formattedImagePath = SocleUtils.getUrlOfFormattedImageCarouselAccueilFull(image);
	  break;
	
	case "carouselMobile" :
	  if (Util.isEmpty(image)) image = SocleUtils.getImageMobile(pub);
	  formattedImagePath = SocleUtils.getUrlOfFormattedImageCarouselAccueilMobile(image);
	  break;
	
	case "carouselCarree" :
	  if (Util.isEmpty(image)) image = SocleUtils.getImageCarree(pub);
	  formattedImagePath = SocleUtils.getUrlOfFormattedImageCarouselAccueilCarree(image);
	  break;
	  
	case "carrousel" :
	  if (Util.isEmpty(image)) image = SocleUtils.getImagePrincipale(pub);
	  formattedImagePath = SocleUtils.getUrlOfFormattedImageCarrousel(image);
	  break;
	  
	case "custom" :
      if (Util.isEmpty(image)) image = SocleUtils.getImagePrincipale(pub);
      formattedImagePath = SocleUtils.generateVignette(image, width, height);
      break;
      
	case "unchanged" :
	    formattedImagePath = image;
	    break;
	
	default :
	  if (Util.isEmpty(image)) image = SocleUtils.getImagePrincipale(pub);
	  formattedImagePath = SocleUtils.getUrlOfFormattedImagePrincipale(image);
}

if (format.equals("principale") || format.equals("bandeau") ||format.equals("carree") ||format.equals("mobile")) {
  formattedMobilePath = SocleUtils.getUrlOfFormattedImageMobile(imageMobile);

  if (Util.isEmpty(formattedMobilePath)) {
    formattedMobilePath = SocleUtils.getUrlOfFormattedImageMobile(image);
  }
} else if (format.equals("carouselFull") ||format.equals("carouselMobile") ||format.equals("carouselCarree")) {
  formattedMobilePath = SocleUtils.getUrlOfFormattedImageCarouselAccueilMobile(imageMobile);

  if (Util.isEmpty(formattedMobilePath)) {
    formattedMobilePath = SocleUtils.getUrlOfFormattedImageCarouselAccueilMobile(image);
  }
} else {
  // défaut 
  formattedMobilePath = SocleUtils.getUrlOfFormattedImageMobile(imageMobile);

  if (Util.isEmpty(formattedMobilePath)) {
    formattedMobilePath = SocleUtils.getUrlOfFormattedImageMobile(image);
  }
}

if(Util.isEmpty(alt)) {
  alt = Util.notEmpty(legend) ? legend : JcmsUtil.glp(userLang, "jcmsplugin.socle.illustration");
}
alt = HttpUtil.encodeForHTMLAttribute(alt);

String label = ariaLabel;
if (Util.isEmpty(label) && Util.notEmpty(legend) || Util.notEmpty(copyright)) {
  label = legend;
  if (Util.notEmpty(copyright)) {
    label += " ";
    label += JcmsUtil.glp(userLang, "jcmsplugin.socle.symbol.copyright") + " " + copyright;
  }
}
else {
  label = alt;
}



%>
<jalios:if predicate="<%= Util.notEmpty(formattedImagePath) %>">
	<figure role="figure" <%= Util.isEmpty(figureCss) ? "" : "class='" + figureCss + "'" %> aria-label="<%= Util.isEmpty(label) ? pub.getTitle() : label %>">
	    <picture class="<%= pictureCss %>">
	        <jalios:if predicate="<%= Util.notEmpty(formattedMobilePath) %>">
	            <source media="(max-width: 36em)" srcset="<%=formattedMobilePath%>">
	        </jalios:if>
	        <source media="(min-width: 36em)" srcset="<%=formattedImagePath%>">
	        <img src="<%=formattedImagePath%>" alt="<%= Util.isEmpty(alt) ? pub.getTitle() : alt %>" class="<%= imgCss %>" id="<%=uid%>"/>
	    </picture>
	    
	    <jalios:if predicate="<%= hasFigcaption%>">
	        <figcaption class="ds44-imgCaption">
	            <jalios:if predicate="<%= Util.notEmpty(legend)%>">
	                <%=legend%>
	            </jalios:if>
	            <jalios:if predicate="<%= Util.notEmpty(copyright)%>">
	                <%= JcmsUtil.glp(userLang, "jcmsplugin.socle.symbol.copyright") %> <%=copyright%>
	            </jalios:if>
	        </figcaption>
	    </jalios:if>
	</figure>
</jalios:if>
