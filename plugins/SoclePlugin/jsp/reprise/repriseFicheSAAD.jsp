<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@page import="com.jalios.jcms.handler.QueryHandler"%>
<%@page import="java.io.IOException"%>
<%
  
%><%@ include file="/jcore/doInitPage.jsp"%>
<%
  if (!isAdmin) {
    sendForbidden(request, response);
    return;
  }
%>
<%@ include file='/admin/doAdminHeader.jspf'%>

<div class="page-header">
	<h1>Reprise des fiches SAAD</h1>
</div>


<h3>Reprise des fiches SAAD</h3>
<form>
	<input type="hidden" name="reprise" value="true"> <input
		class="btn btn-danger modal confirm" type="submit"
		value="Lancer la reprise" />
</form>


<%
  if (getBooleanParameter("reprise", false)) {

    QueryHandler qh = new QueryHandler();
    qh.setExactType(true);
    qh.setTypes(SAAD.class.getSimpleName());
    qh.setCheckPstatus(false);
    QueryResultSet result = qh.getResultSet();

    for (Publication itPub : result) {

      SAAD itSAAD = (SAAD) itPub;

        Set<Category> categories = new HashSet<Category>();
        categories.addAll(itSAAD.getCategorySet());
        
        
        FicheSAAD itFiche = new FicheSAAD();

        itFiche.setTitle(itSAAD.getTitle());

        itFiche.setAdresse(itSAAD.getAdresse().replaceAll("\r\n","<br>"));
        itFiche.setTelephone(itSAAD.getTelephone());
        itFiche.setAdresseMail(itSAAD.getAdresseMail());
        itFiche.setSiteInternet(itSAAD.getSiteInternet());
        itFiche.setDescriptif(itSAAD.getDescriptif());
        
        //logger.warn(itPub.getId() + " / " + itPub.getTitle() + " / " + itSAAD.getSurToutLeDepartement());
        if(! itSAAD.getSurToutLeDepartement()){
          itFiche.setCommunes(itSAAD.getCommunes());
        }
        
        itFiche.setToutesLesCommunesDuDepartement(itSAAD.getSurToutLeDepartement());
        
        // Renseigne la nouvelle catégorie de navigation
        categories.add(channel.getCategory("p2_1032980"));

        // Reprise de toutes les catÃ©gories
        itFiche.setCategorySet(categories);
        
        
        // extradata : on ne récupère que la première valeur de long/lat.
        itFiche.setExtraData("extra.FicheSAAD.plugin.tools.geolocation.longitude", itSAAD.getExtraData("extra.SAAD.plugin.tools.geolocation.longitude").split("_")[0]);
        itFiche.setExtraData("extra.FicheSAAD.plugin.tools.geolocation.latitude", itSAAD.getExtraData("extra.SAAD.plugin.tools.geolocation.latitude").split("_")[0]);

        // refferer : les liens vers les SAAD doivent pointer vers les Fiche SAAD. 
        /* NOTE 10/04/2020 : pas de referrer trouvés. On ne gère pas cet aspect.
        if(Util.notEmpty(itSAAD.getAllReferrerSet())){
        	logger.warn(itSAAD.getAllReferrerSet()+"\r\n");
        }
        */
        
        // meta donnÃ© et Ã©criture
        itFiche.setAuthor(itSAAD.getAuthor());
        itFiche.performCreate(itSAAD.getAuthor());

    }

  }
%>


<%@ include file='/admin/doAdminFooter.jspf'%>
