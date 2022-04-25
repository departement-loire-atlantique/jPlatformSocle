<%@ page contentType="text/html; charset=UTF-8" %><%
%><%@page import="fr.cg44.plugin.socle.SocleUtils"%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%>


<%

EditAbonnementAlerteOffresDemploiHandler formhandler = new EditAbonnementAlerteOffresDemploiHandler();;
Category typeOffreRoot = formhandler.getTypeDoffreRoot();
Category domaineMetierRoot = formhandler.getDomaineMetierRoot();
Category categorieRoot = formhandler.getCategorieRoot();
Category filiereRoot = formhandler.getFiliereRoot();
Category delegationRoot = formhandler.getDelegationsRoot();

%>

<section class="ds44-box ds44-theme ds44-mb3">
<div class="ds44-innerBoxContainer">

<form data-is-ajax="true" data-is-inline="true" action="plugins/SoclePlugin/jsp/forms/sendAlerteEmploiDoubleOptin.jsp">

<div class="mtm">  
	<p role="heading" aria-level="2" class="ds44-box-heading"><%= glp("jcmsplugin.socle.alert-emploi.titre") %></p>
	<p class="ds44-textLegend--mentions ds44-mb2"><%= glp("jcmsplugin.socle.facette.champs-obligatoires") %></p>
</div>

<div class="mtm">   


<div class="ds44-form__container ds44-mb-std">

    <div class="ds44-posRel">
        <label for="alerte-emploi-mail" class="ds44-formLabel"><span class="ds44-labelTypePlaceholder"><span><%= glp("jcmsplugin.socle.faq.votre-email") %><sup aria-hidden="true">*</sup></span></span></label>
        
        <input type="email" id="alerte-emploi-mail" name="mail" class="ds44-inpStd" title='<%= encodeForHTMLAttribute(glp("jcmsplugin.socle.facette.champ-obligatoire.title",  glp("jcmsplugin.socle.faq.votre-email"))) %>'  required autocomplete="email" aria-describedby="explanation-alert-emploi-mail" /><button class="ds44-reset" type="button"><i class="icon icon-cross icon--sizeL" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.facette.effacer-contenu-champ", glp("jcmsplugin.socle.faq.votre-email")) %></span></button>
    </div>

    <div class="ds44-field-information" aria-live="polite">
        <ul class="ds44-field-information-list ds44-list">
            <li id="explanation-alert-emploi-mail" class="ds44-field-information-explanation"><%= glp("jcmsplugin.socle.form.exemple.email") %></li>
        </ul>
    </div>

</div>


<% 
    String rechercheId = "alerte-emploi";
    String dataUrl = "plugins/SoclePlugin/jsp/facettes/acSearchCommune.jsp";

%>

<ds:facetteAutoCompletion idFormElement='<%= ServletUtil.generateUniqueDOMId(request, glp("jcmsplugin.socle.facette.form-element")) %>' 
        name='<%= "commune" + glp("jcmsplugin.socle.facette.form-element") + "-" + rechercheId %>' 
        request="<%= request %>" 
        isFacetteObligatoire="<%= false %>" 
        dataMode="select-only" 
        dataUrl="<%= dataUrl %>" 
        label='<%= glp("jcmsplugin.socle.pdcv.votrecommune") %>'
        option=''
        isLarge='<%= false %>'/>
</div>



<div class="mtm">
	<div class="ds44-form__container">	    
		<div class="ds44-posRel">
		    <label for="form-elt-commune-hd" class="ds44-formLabel"><span class="ds44-labelTypePlaceholder"><span><%= glp("jcmsplugin.socle.alert-emploi.commune-hd") %></span></span></label>    
		    <input type="text" id="form-elt-commune-hd" name="<%= "communeHorsDept" + glp("jcmsplugin.socle.facette.form-element") %>" class="ds44-inpStd" title='<%= glp("jcmsplugin.socle.alert-emploi.commune-hd") %>' />    
		    <button class="ds44-reset" type="button"><i class="icon icon-cross icon--sizeL" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.facette.effacer-contenu-champ", glp("jcmsplugin.socle.alert-emploi.commune-hd")) %></span></button>
		</div>	
	</div>
</div>






<div class="mtm">                                      
    <%
    Set<Category> delegationCat = new TreeSet<Category>(Category.getDeepOrderComparator());
    delegationCat.addAll(delegationRoot.getChildrenSet());
    %>
    
    <h2 class="h4-like" id="titre-delegation"><%= glp("jcmsplugin.socle.alert-emploi.recherche") %></h2>

    <div id="form-element-delegation" data-name='<%= "delegation" + glp("jcmsplugin.socle.facette.form-element") %>' class="ds44-form__checkbox_container" data-required="true" >
        <p id="mandatory-message-form-element-delegation" class="ds44-mandatory_message"><%= glp("jcmsplugin.socle.pageutile.message-case") %></p>
		
		<ul class="ds44-list grid-12-small-1 mtm">	
					
			<li class="ds44-select-list_elem col-6 ds44-noMrg">                       
	            <div class="ds44-form__checkbox_container ds44-form__container">   
	                 <div class="ds44-form__container ds44-checkBox-radio_list ">
	                     <input required type="checkbox" id="name-check-form-element-toute" name='<%= "delegation" + glp("jcmsplugin.socle.facette.form-element") %>' value="toute" class="ds44-checkbox" aria-describedby="titre-delegation" /><label for="name-check-form-element-toute" class="ds44-boxLabel" id="name-check-label-form-element-toute"><%= glp("jcmsplugin.socle.alert-emploi.toute-loire") %></label> 
	                 </div>      
	             </div>                          
	        </li>            
				
	        <jalios:foreach collection="<%= delegationCat %>" name="itCat" type="Category">                        	            			                             
	            <li class="ds44-select-list_elem col-6 ds44-noMrg">  
	                <div class="ds44-form__checkbox_container ds44-form__container">             
			            <div class="ds44-form__container  ds44-checkBox-radio_list ">
			                <input type="checkbox" id="name-check-form-element-<%= itCat.getId() %>" name='<%= "delegation" + glp("jcmsplugin.socle.facette.form-element") %>' value="<%= itCat.getId() %>" class="ds44-checkbox" required  aria-describedby="mandatory-message-form-element-delegation titre-delegation" /><label for="name-check-form-element-<%= itCat.getId() %>" class="ds44-boxLabel" id="name-check-label-form-element-<%= itCat.getId() %>"><%= itCat.getName(userLang) %></label> 
			            </div>  
		            </div>
	            </li>                        			                             	                             		                                
	        </jalios:foreach>		
		</ul>		
    </div>
</div>


<button class="ds44-btnStd ds44-btn--invert" type="button" data-target="#overlay-test" data-js="ds44-modal"><span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.alert-emploi.carte-delegation") %></span></button>
    <section class="ds44-modal-container" id="overlay-test" aria-hidden="true" role="dialog" aria-modal="true" aria-labelledby="overlay-test-title">
        <div class="ds44-modal-box txtcenter">
            <button class="ds44-btnOverlay--modale ds44-btnOverlay--closeOverlay" type="button" title='<%= glp("jcmsplugin.socle.alert-emploi.ferme-modal", glp("jcmsplugin.socle.alert-emploi.carte-delegation")) %>' data-js="ds44-modal-action-close"><i class="icon icon-cross icon--xlarge" aria-hidden="true"></i><span class="ds44-btnInnerText--bottom"><%= glp("jcmsplugin.socle.fermer") %></span></button>
            <h1 id="overlay-test-title" class="h2-like"><%= glp("jcmsplugin.socle.alert-emploi.carte-delegation") %></h1>
            <div class="ds44-modal-gab">
                 <img
					  src='<%= channel.getProperty("jcmsplugin.socle.site.src.carte.pdcv") %>'
					  alt='<%= glp("jcmsplugin.socle.alert-emploi.carte-delegation") %>'
					  />
            </div>
        </div>
    </section>
    


<div class="mtm">                                      
    <%
    Set<Category> typeOffreCat = new TreeSet<Category>(Category.getDeepOrderComparator());
    typeOffreCat.addAll(typeOffreRoot.getChildrenSet());
    %>
    
    <h2 class="h4-like" id="titre-offre"><%= typeOffreRoot.getName(userLang) %></h2>
    <ul class="ds44-list grid-12-small-1 mtm">
        
        <jalios:foreach collection="<%= typeOffreCat %>" name="itCat" type="Category">                        
            <li class="ds44-select-list_elem col-6 ds44-noMrg">                       
                <div id="form-element-parution-<%= itCat.getId() %>" data-name='<%= "type" + glp("jcmsplugin.socle.facette.form-element") + itCat.getId() %>' class="ds44-form__checkbox_container ds44-form__container" >                                                                                                                
                    <div class="ds44-form__container ds44-checkBox-radio_list ">
                        <input type="checkbox" id="name-check-form-element-<%= itCat.getId() %>" name="form-element-<%= itCat.getId() %>" value="<%= itCat.getId() %>" class="ds44-checkbox" aria-describedby="titre-offre" /><label for="name-check-form-element-<%= itCat.getId() %>" class="ds44-boxLabel" id="name-check-label-form-element-<%= itCat.getId() %>"><%= itCat.getName(userLang) %></label> 
                    </div>      
                </div>                          
            </li>                        
        </jalios:foreach>
    
    </ul>
</div>



<div class="mtm">                                      
    <%
    Set<Category> domaineMetierCat = new TreeSet<Category>(Category.getDeepOrderComparator());
    domaineMetierCat.addAll(domaineMetierRoot.getChildrenSet());
    %>
    
    <h2 class="h4-like" id="titre-metier"><%= domaineMetierRoot.getName(userLang) %></h2>
    <ul class="ds44-list grid-12-small-1 mtm">
        
        <jalios:foreach collection="<%= domaineMetierCat %>" name="itCat" type="Category">                        
            <li class="ds44-select-list_elem col-6 ds44-noMrg">                       
                <div id="form-element-parution-<%= itCat.getId() %>" data-name='<%= "domaine" + glp("jcmsplugin.socle.facette.form-element") + itCat.getId() %>' class="ds44-form__checkbox_container ds44-form__container" >                                                                                                                
                    <div class="ds44-form__container ds44-checkBox-radio_list ">
                        <input type="checkbox" id="name-check-form-element-<%= itCat.getId() %>" name="form-element-<%= itCat.getId() %>" value="<%= itCat.getId() %>" class="ds44-checkbox" aria-describedby="titre-metier" /><label for="name-check-form-element-<%= itCat.getId() %>" class="ds44-boxLabel" id="name-check-label-form-element-<%= itCat.getId() %>"><%= itCat.getName(userLang) %></label> 
                    </div>      
                </div>                          
            </li>                        
        </jalios:foreach>
    
    </ul>
</div>


<div class="mtm">                                      
    <%
    Set<Category> categorieCat = new TreeSet<Category>(Category.getDeepOrderComparator());
    categorieCat.addAll(categorieRoot.getChildrenSet());
    %>
    
    <h2 class="h4-like" id="titre-categories"><%= categorieRoot.getName(userLang) %></h2>
    <ul class="ds44-list grid-12-small-1 mtm">
        
        <jalios:foreach collection="<%= categorieCat %>" name="itCat" type="Category">                        
            <li class="ds44-select-list_elem col-6 ds44-noMrg">                       
                <div id="form-element-parution-<%= itCat.getId() %>" data-name='<%= "categorie" + glp("jcmsplugin.socle.facette.form-element") + itCat.getId() %>' class="ds44-form__checkbox_container ds44-form__container" >                                                                                                                
                    <div class="ds44-form__container ds44-checkBox-radio_list ">
                        <input type="checkbox" id="name-check-form-element-<%= itCat.getId() %>" name="form-element-<%= itCat.getId() %>" value="<%= itCat.getId() %>" class="ds44-checkbox" aria-describedby="titre-categories" /><label for="name-check-form-element-<%= itCat.getId() %>" class="ds44-boxLabel" id="name-check-label-form-element-<%= itCat.getId() %>"><%= itCat.getName(userLang) %></label> 
                    </div>      
                </div>                          
            </li>                        
        </jalios:foreach>
    
    </ul>
</div>


<div class="mtm">                                      
    <%
    Set<Category> filiereCat = new TreeSet<Category>(Category.getDeepOrderComparator());
    filiereCat.addAll(filiereRoot.getChildrenSet());
    %>
    
    <h2 class="h4-like" id="titre-filiere"><%= filiereRoot.getName(userLang) %></h2>
    <ul class="ds44-list grid-12-small-1 mtm">
        
        <jalios:foreach collection="<%= filiereCat %>" name="itCat" type="Category">                        
            <li class="ds44-select-list_elem col-6 ds44-noMrg">                       
                <div id="form-element-parution-<%= itCat.getId() %>" data-name='<%= "filiere" + glp("jcmsplugin.socle.facette.form-element") + itCat.getId() %>' class="ds44-form__checkbox_container ds44-form__container" >                                                                                                                
                    <div class="ds44-form__container ds44-checkBox-radio_list ">
                        <input type="checkbox" id="name-check-form-element-<%= itCat.getId() %>" name="form-element-<%= itCat.getId() %>" value="<%= itCat.getId() %>" class="ds44-checkbox" aria-describedby="titre-filiere" /><label for="name-check-form-element-<%= itCat.getId() %>" class="ds44-boxLabel" id="name-check-label-form-element-<%= itCat.getId() %>"><%= itCat.getName(userLang) %></label> 
                    </div>      
                </div>                          
            </li>                        
        </jalios:foreach>
    
    </ul>
</div>


 
<button class="ds44-btnStd ds44-btn--invert ds44-w100 ds44-bntALeft" title='<%= encodeForHTMLAttribute(glp("jcmsplugin.socle.newletter.inscrire-recevoir")) %>' aria-describedby="valid-form-alerte-emploi">
    <span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.newletter.inscrire") %></span>
    <i class="icon icon-long-arrow-right" aria-hidden="true"></i>
</button>
  
  
<%
Publication rgpdPub = channel.getPublication(channel.getProperty("jcmsplugin.socle.form.contact.portlet-rgpd.id"));  
%>
<jalios:if predicate="<%= Util.notEmpty(rgpdPub) && (rgpdPub instanceof PortletWYSIWYG) %>">
    <div id="valid-form-alerte-emploi">
	    <jalios:wysiwyg css="ds44-wsg-smallText ds44-mt3">
	      <%= ((PortletWYSIWYG) rgpdPub).getWysiwyg() %>
	    </jalios:wysiwyg>
    </div>
</jalios:if>  
   
                
</form>



</div>
</section>