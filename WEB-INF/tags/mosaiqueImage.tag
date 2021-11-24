<%@tag import="com.jalios.jcms.context.JcmsContext"%>
<%@tag import="com.jalios.util.Browser"%>
<%@ taglib uri="jcms.tld" prefix="jalios" %>
<%@ tag 
    pageEncoding="UTF-8"
    description="Image de mozaïque" 
    body-content="scriptless" 
    import="java.text.SimpleDateFormat, com.jalios.jcms.Channel, com.jalios.util.Util, com.jalios.jcms.JcmsUtil, com.jalios.jcms.context.JcmsJspContext, fr.cg44.plugin.socle.SocleUtils"
%>
<%@ attribute name="image"
    required="true"
    fragment="false"
    rtexprvalue="true"
    type="generated.CarouselElement"
    description="Image affichée"
%>
<%@ attribute name="style"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Style additionnel"
%>
<%@ attribute name="hasPopin"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="Boolean"
    description="Style additionnel"
%>
<%
	String userLang = Channel.getChannel().getCurrentJcmsContext().getUserLang();
	JcmsJspContext jcmsContext = (JcmsJspContext) request.getAttribute("jcmsContext");
	
	SimpleDateFormat sdfTuiles = new SimpleDateFormat("yyyy/MM");
	
	String legend = image.getImageLegend(userLang);
	String copyright = image.getImageCopyright(userLang);
	
	Boolean hasFigcaption = Util.notEmpty(legend) || Util.notEmpty(copyright);
	
	String alt = SocleUtils.getAltTextFromPub(image);
	    
	String figcaption = Util.notEmpty(legend) ? legend + " " : "";
	
	if (Util.isEmpty(alt)) { // s'assurer d'éviter d'avoir "alt = null"
	    alt = figcaption;
	}
	
    if(Util.notEmpty(copyright)) figcaption += JcmsUtil.glp(userLang, "jcmsplugin.socle.symbol.copyright") + " " + copyright;
    
    if (Util.isEmpty(alt)) { // s'il n'y a pas eu de légende, on indique le copyright. Demande d'accessibilité quelques peu étrange, vu que le alt ne décrit plus l'image...
        alt = figcaption;
    }
	
%>
<jalios:buffer name="btnImage">
	<jalios:if predicate="<%= hasPopin %>">
		<button type="button">
	</jalios:if>
			<img src="<%= SocleUtils.getUrlImageElementCarousel(image, userLang, jcmsContext) %>" alt="<%= JcmsUtil.glp(userLang, "jcmsplugin.socle.mosaique.btn.label", JcmsUtil.glp(userLang, "jcmsplugin.socle.mosaique.popin.title")) %>" class="ds44-imgRatio is-height-set">
	<jalios:if predicate="<%= hasPopin %>">
		</button>
	</jalios:if>
</jalios:buffer>


<jalios:if predicate="<%=hasFigcaption%>">
	<figure class="ds44-legendeContainer ds44-container-imgRatio ds44-container-imgZoom <%= style %>" data-target="#overlay-mosaique" data-js="ds44-modal" 
			role="figure" aria-label="<%=figcaption%>">
		<%= btnImage %>
		<figcaption class="ds44-imgCaption">
			<%=figcaption%>
		</figcaption>
	</figure>
</jalios:if>

<jalios:if predicate="<%=!hasFigcaption%>">
	<div class="ds44-legendeContainer ds44-container-imgRatio ds44-container-imgZoom <%= style %>" data-target="#overlay-mosaique" data-js="ds44-modal"
			role="figure" aria-label="<%=image.getTitle(userLang, false)%>">
		<%= btnImage %>
	</div>
</jalios:if>
