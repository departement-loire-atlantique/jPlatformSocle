<%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ include file="/front/app/doAppCommon.jspf" %><%
%><%@ include file='/jcore/doHeader.jspf' %>
<%
String formUid = ServletUtil.generateUniqueDOMId(request, "uid");
%>
<main role="main" id="content">

    <section class="ds44-container-large">
       
        <div class="txtcenter ds44-lightBG ds44--l-padding-b ds44--xl-padding-t ">
            <h1 class="center"><%= glp("jcmsplugin.socle.recherche.resultats") %></h1>
        </div>                
        
        <div class="ds44-loader-text visually-hidden" tabindex="-1" aria-live="polite"></div>
		
		<div class="ds44-loader hidden">
		    <div class="ds44-loader-body">
		        <svg class="ds44-loader-circular" focusable="false" aria-hidden="true">
		            <circle class="ds44-loader-path" cx="30" cy="30" r="20" fill="none" stroke-width="5" stroke-miterlimit="10"></circle>
		        </svg>
		    </div>
		</div>
		
		<div class="ds44-facette">
			
            <div class="ds44-facette-body">
                <form data-is-ajax="true" data-auto-load="true" action="plugins/SoclePlugin/jsp/facettes/displaySearchResult.jsp">
                
                    <div class="ds44-facetteContainer ds44-bgDark ds44-flex-container ds44-medium-flex-col">
    
	                   <div class="ds44-fieldContainer ds44-fg1">	                                       
	                        <div class="ds44-form__container">		
								<div class="ds44-posRel">
								    <label for="form-element-<%= formUid %>" class="ds44-formLabel"><span class="ds44-labelTypePlaceholder ds44-labelTypePlaceholderLarge"><span><%= glp("jcmsplugin.socle.recherche.votrerecherche") %></span></span></label>								    
								    <input type="text" id="form-element-<%= formUid %>" name="searchtext" class="ds44-inpLarge" data-url="plugins/SoclePlugin/jsp/facettes/acSearchResult.jsp" role="combobox" aria-autocomplete="list" autocomplete="off" data-mode="free-text" title='<%= HttpUtil.encodeForHTML(glp("jcmsplugin.socle.recherche.motcle.title")) %>'  required=""  aria-describedby="titre1" /><button class="ds44-reset" type="button" ><i class="icon icon-cross icon--sizeXL" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.facette.effacer-contenu-champ", glp("jcmsplugin.socle.recherche.votrerecherche")) %></span></button>																							
								    <div class="ds44-autocomp-container hidden">
								        <div class="ds44-autocomp-list">
								            <ul class="ds44-list" role="listbox"></ul>
								        </div>
								    </div>
								</div>												
						   </div>
	                   </div>
 
                       <div class="ds44-fieldContainer ds44-small-fg1">
                            <button class="ds44-btnStd ds44-theme  ds44-btnStd--large" title="Lancer la recherche"><span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.rechercher") %></span><i class="icon icon-long-arrow-right" aria-hidden="true"></i></button>
					   </div>
					</div>
				</form>
			</div>
				
		    
		    
		</div>
	</section>				                    
       
       
    <section class="ds44-container-large">
        <div class="ds44-flex-container ds44-results ds44-results--empty">
            <div class="ds44-listResults ds44-innerBoxContainer ds44-innerBoxContainer--list">
                <div class="ds44-js-results-container">
                    <div class="ds44-js-results-card" data-url="plugins/SoclePlugin/jsp/facettes/displaySearchResult.jsp" aria-hidden="true"></div>
                    <div class="ds44-js-results-list">
                        <p id="ds44-results-new-search" class="h3-like mbs txtcenter center ds44--3xl-padding-t ds44--3xl-padding-b">
                            <span aria-level="2" role="heading"><%= glp("jcmsplugin.socle.faire.recherche") %></span>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </section>             
                    
                    

</main>
        


<%@ include file='/jcore/doFooter.jspf' %> 