<%@ include file='/jcore/doInitPage.jspf' %>

<p class="h4-like" id="inp-rech" role="heading" aria-level="2"><%= glp("jcmsplugin.socle.recherche.motscles") %></p>
<%
   String formUid = ServletUtil.generateUniqueDOMId(request, "uid");
   %>
<form role="search" novalidate="true" method="get" name="queryForm" action="front/query/query.jsp">
   <div class="ds44-form__container">
      <div class="ds44-posRel">
         <label for="form-element-<%= formUid %>" class="ds44-formLabel"><span class="ds44-labelTypePlaceholder ds44-labelTypePlaceholderLarge"><span><%= glp("jcmsplugin.socle.recherche.votrerecherche") %><sup aria-hidden="true"><%= glp("jcmsplugin.socle.facette.asterisque") %></sup></span></span></label>
         <input type="text" id="form-element-<%= formUid %>" name="form-element-<%= formUid %>" class="ds44-inpLarge" title='<%= glp("jcmsplugin.socle.facette.champ-obligatoire.title", glp("jcmsplugin.socle.recherche.votrerecherche")) %>' required="" aria-describedby="inp-rech" data-bkp-tabindex="" data-bkp-aria-describedby="inp-rech"><button class="ds44-reset" type="button" data-bkp-tabindex=""><i class="icon icon-cross icon--sizeXL" aria-hidden="true"></i><span class="visually-hidden"><%= glp("jcmsplugin.socle.facette.effacer-contenu-champ", glp("jcmsplugin.socle.recherche.votrerecherche")) %></span></button>
      </div>
   </div>
   <button type="submit" class="ds44-btnStd ds44-btn--invert" title='<%= glp("jcmsplugin.socle.recherche.valider") %>' data-bkp-tabindex="">
   <span class="ds44-btnInnerText"><%= glp("jcmsplugin.socle.valider") %></span><i class="icon icon-long-arrow-right" aria-hidden="true"></i>
   </button>
</form>