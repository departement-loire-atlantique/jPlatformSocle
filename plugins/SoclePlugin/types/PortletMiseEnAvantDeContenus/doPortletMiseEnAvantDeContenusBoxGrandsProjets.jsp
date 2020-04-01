<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ include file='/jcore/portal/doPortletParams.jspf' %><%
%><% PortletMiseEnAvantDeContenus box = (PortletMiseEnAvantDeContenus)portlet; %><%
List<Content> allContents = new ArrayList<>();
if (Util.notEmpty(box.getFirstPublications())) {
    allContents.addAll(Arrays.asList(box.getFirstPublications()));
}
%>

<%@ include file="/types/PortletQueryForeach/doQuery.jspf" %>
<%@ include file="/types/PortletQueryForeach/doSort.jspf" %>

<%
if (Util.notEmpty(collection)) {
    allContents.addAll(collection);
}

// On vide la liste des pub non autorisées, pour ne pas fausser le calcul.
DataSelector authorizedPubSelector = Publication.getAuthorizedSelector(loggedMember);
JcmsUtil.applyDataSelector(allContents, authorizedPubSelector);

// On calcule le nombre de pub dans chaque colonne.
int nbPub = allContents.size();
int nbPubCol1 = nbPub/2 + nbPub%2;
int nbPubCol2 = nbPub-nbPubCol1;

// Gestion du bouton
boolean isLienExterne = Util.isEmpty(box.getLienInterne());
String labelBouton = box.getLabelDuLien();
String urlBouton = "";
String targetAttr = "";
String titleAttr = "";

// Accessibilité : on place un attribut "title" sur le lien uniquement si le lien s'ouvre dans une nouvelle fenêtre
if(isLienExterne){
  urlBouton = box.getLienExterne();
  targetAttr = "target=\"_blank\" ";
  titleAttr = "title=\"" +  labelBouton + glp("jcmsplugin.socle.accessibily.newTabLabel")+"\"";
}
else{
  urlBouton = box.getLienInterne().getDisplayUrl(userLocale);  
}

%>

<section class="ds44-container-fluid ds44--xxl-padding-t ds44--p35b <%=Util.isEmpty(box.getSoustitre()) ? "ds44-mb2" : ""%>">
	<section class="ds44-container-large">
	    <div class="ds44-inner-container">
	        <div class="grid-12-small-1 ds44-flex-valign-center">
	        
	            <%-- Présentation de gauche --%>
				<div class="col-4 colFocusProjets mbm">
	                <jalios:if predicate='<%=Util.notEmpty(box.getTitreVisuel()) %>'>
	                    <h2 class="h2-like" id="idTitre2"><%= box.getTitreVisuel() %></h2>
				    </jalios:if>
				    <jalios:if predicate='<%=Util.notEmpty(box.getSoustitre()) %>'>
	                    <div class="ds44-introduction ds44-hide-tinyToLarge"><%= box.getSoustitre() %></div>
	                </jalios:if>
                    <%-- Bouton desktop --%>
                    <jalios:if predicate='<%=Util.notEmpty(box.getLabelDuLien()) %>'>
                        <a href="<%= urlBouton %>" <%= titleAttr %> <%= targetAttr %> class="ds44-btnStd ds44-btnStd--large ds44-hide-tiny-to-medium ds44-btnFullMobile"><span class="ds44-btnInnerText"><%= box.getLabelDuLien() %></span><i class="icon icon-long-arrow-right" aria-hidden="true"></i></a>
                    </jalios:if>
				</div>
				
				<%-- Tuiles --%>
				<div class="col-4 colFocusProjets">
					<jalios:foreach name="itContent" type="Content" collection="<%= allContents %>" max="<%= nbPubCol1 %>">
	                    <jalios:media data="<%= (Publication) itContent %>" template="tuileHorizontaleGrey"/>
					</jalios:foreach>
				</div>
				<jalios:if predicate='<%=nbPub > 1 %>'>
		            <div class="col-4 colFocusProjets">
		                <jalios:foreach name="itContent" type="Content" collection="<%= allContents %>" skip="<%= nbPubCol1 %>">
		                    <jalios:media data="<%= (Publication) itContent %>" template="tuileHorizontaleGrey"/>
		                </jalios:foreach>
		            </div>
                </jalios:if>
	            
	            <%-- Bouton mobile --%>
                <jalios:if predicate='<%=Util.notEmpty(box.getLabelDuLien()) %>'>
                    <a href="<%= urlBouton %>" <%= titleAttr %> <%= targetAttr %> class="ds44-btnStd ds44-show-tiny-to-medium ds44-show-mobile ds44-btnFullMobile"><span class="ds44-btnInnerText"><%= box.getLabelDuLien() %></span><i class="icon icon-long-arrow-right" aria-hidden="true"></i></a>
                </jalios:if>
	      </div>
	    </div>
	</section>
</section>