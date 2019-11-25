<%@ taglib uri="jcms.tld" prefix="jalios" %>
<%@ tag 
    pageEncoding="UTF-8"
    description="Card" 
    body-content="scriptless" 
    import="com.jalios.jcms.Channel, com.jalios.util.ServletUtil, com.jalios.util.Util"
%>
<%@ attribute name="title"
    required="true"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Le titre de la carte"
%>
<%@ attribute name="imagePath"
    required="true"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Le chemin du fichier image"
%>
<%@ attribute name="alt"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Le texte alternatif de l'image"
%>
<%@ attribute name="link"
    required="true"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Le lien à appliquer sur la carte"
%>
<%@ attribute name="subtitle"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Le sous-titre de la carte"
%>
<%@ attribute name="localisation"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Informations de localisation"
%>
<%@ attribute name="fileType"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Le type de fichier (dans le cas d'un document)"
%>
<%@ attribute name="fileSize"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="La taille du fichier"
%>
<%@ attribute name="format"
    required="true"
    fragment="false"
    rtexprvalue="true"
    type="String"
    description="Le format de la carte (horizontal ou vertical)"
%>
<%@ attribute name="dark"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="Boolean"
    description="Indique si la carte s'affiche sur fond sombre"
%>
<%@ attribute name="newTab"
    required="false"
    fragment="false"
    rtexprvalue="true"
    type="Boolean"
    description="Indique si le lien sur la carte s'ouvre dans un nouvel onglet"
%>
<%
String uid = ServletUtil.generateUniqueDOMId(request, "uid"); %><%
String darkValue="";
String newTabValue="";
String altValue=Util.notEmpty(alt) ? alt : "";


if(dark==true)   {darkValue="ds44-darkContext";}
if(newTab==true) {newTabValue="target=\"_blank\"";}
%>
<!-- Mise en buffer des données communes aux différents gabarits -->
<jalios:buffer name="bottomCard">
	<p role="heading" aria-level="2" class="ds44-card__title">
	    <a href="<%= link %>" class="ds44-card__globalLink" title="<%=title %>" <%=newTabValue%>><%=title%></a>
	</p>
	<jalios:if predicate="<%=Util.notEmpty(subtitle)%>">
	    <p><%=subtitle%></p>
	</jalios:if>        
	<jalios:if predicate="<%=Util.notEmpty(fileType) && Util.notEmpty(fileSize)%>">
	    <p class="ds44-cardFile"><%=fileType%> - <%= fileSize %></p>
	</jalios:if>
	<i class="icon icon-arrow-right ds44-cardArrow" aria-hidden="true"></i>
</jalios:buffer>

<jalios:select>
    <jalios:if predicate='<%="horizontal".equals(format) %>'>
		 <section class="ds44-card ds44-card--horizontal <%=darkValue%>">
            <div class="ds44-flex-container ds44-flex-valign-center">
	            <jalios:if predicate='<%=Util.notEmpty(imagePath) %>'>
	                <picture class="ds44-cardPicture">
	                    <jalios:thumbnail path="<%=imagePath%>" width="140" height="140" css="ds44-card__img" square="true" format="jpeg" alt="<%= altValue%>"></jalios:thumbnail>
	                </picture>
	            </jalios:if>
			    <div class="ds44-card__section--horizontal">
                    <%=bottomCard %>
			    </div>
		  </div>
		</section>    
    </jalios:if>
    
    <jalios:default>
		<section class="ds44-card ds44-card--verticalPicture <%=darkValue%>">
	        <jalios:if predicate='<%=Util.notEmpty(imagePath) %>'>
	            <picture>
                    <img src="<%=imagePath%>" alt="<%=altValue%>" />
	            </picture>
	        </jalios:if>
		    <div class="ds44-card__section">
                <%=bottomCard %>
		    </div>
		</section>    
    </jalios:default>    
</jalios:select>