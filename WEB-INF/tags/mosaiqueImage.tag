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
%>
<jalios:buffer name="btnImage">
	<jalios:if predicate="<%= hasPopin %>">
		<button type="button" title='<%= JcmsUtil.glp(userLang, "jcmsplugin.socle.mozaique.btn.label", JcmsUtil.glp(userLang, "jcmsplugin.socle.mozaique.popin.title")) %>'>
			<img src="<%= SocleUtils.getUrlImageElementCarousel(image, userLang, jcmsContext) %>" <% if (!hasFigcaption) { %>alt=""<% } %> class="ds44-imgRatio is-height-set">
		</button>
	</jalios:if>
	
	<jalios:if predicate="<%= !hasPopin %>">
		<img src="<%= SocleUtils.getUrlImageElementCarousel(image, userLang, jcmsContext) %>" <% if (hasFigcaption) { %>alt=""<% } %> class="ds44-imgRatio is-height-set">
	</jalios:if>
</jalios:buffer>


<jalios:if predicate="<%=hasFigcaption%>">
	<%
		String figcaption = Util.notEmpty(legend) ? legend + " " : "";
		if(Util.notEmpty(copyright)) figcaption += JcmsUtil.glp(userLang, "jcmsplugin.socle.symbol.copyright") + " " + copyright;
	%>
	<figure class="ds44-legendeContainer ds44-container-imgRatio ds44-container-imgZoom " data-target="#overlay-mosaique" data-js="ds44-modal" 
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
