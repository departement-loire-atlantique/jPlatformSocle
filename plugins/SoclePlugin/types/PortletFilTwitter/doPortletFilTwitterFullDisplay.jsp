<%@page import="fr.cg44.plugin.socle.twitter.EmojiTwitter"%>
<%@page import="twitter4j.conf.ConfigurationBuilder"%>
<%@page import="twitter4j.Twitter"%>
<%@page import="twitter4j.TwitterFactory"%>
<%@page import="twitter4j.Query"%>
<%@page import="twitter4j.QueryResult"%>
<%@page import="twitter4j.Status"%>
<%@page import="twitter4j.TwitterException"%>
<%@ include file='/jcore/doInitPage.jsp' %><%
%><%@ include file='/jcore/portal/doPortletParams.jsp' %><%

PortletFilTwitter box = (PortletFilTwitter) portlet;  

// Configuration de la portlet pour les accès à l'API twitter
ConfigurationBuilder cb = new ConfigurationBuilder();
cb.setOAuthConsumerKey(box.getConsumerKey());
cb.setOAuthConsumerSecret(box.getConsumerSecret());
cb.setOAuthAccessToken(box.getAccessToken());
cb.setOAuthAccessTokenSecret(box.getAccessTokenSecret());
cb.setHttpReadTimeout(channel.getIntegerProperty("jcmsplugin.socle.portlet-twitter.timeout", 60000));
cb.setHttpRetryCount(channel.getIntegerProperty("jcmsplugin.socle.portlet-twitter.retry", 0));

// Tweet sur 140 ou 280 caractères
cb.setTweetModeExtended(box.getTexteEtendu());
Twitter twitter = new TwitterFactory(cb.build()).getInstance();
// Requête de recherche sur Twitter
Query query = new Query(box.getRequeteTwitter());
query.setCount(2);
List<Status> tweets = null;
// Si twitter répond bien
boolean isTwitterOk = false;
// Si le cache est activé (Attention le cache est en commun entre toutes les portlets twitter - donc si cache activé, il ne faut qu'une portlet twitter ou avoir la meme requete sur toutes les portlets)
boolean hasCache = box.getActiverCache();
// Durée du cache en minutes
int cacheTime = box.getDureeDuCacheEnMinutes();
%>

<%
try {

  // Utilise le cache
  Date currentDate = new Date();
  if (hasCache && EmojiTwitter.getTweetsCache() != null && EmojiTwitter.getCacheDate() != null
      && currentDate.getTime() - EmojiTwitter.getCacheDate().getTime() < (cacheTime * 60000)) {
    tweets = EmojiTwitter.getTweetsCache();
  } else {
    // Récupère les résultats de la recherche Twitter 
    QueryResult result = twitter.search(query);
    tweets = result.getTweets();
    // Ajoute en cache
    if (hasCache) {
      EmojiTwitter.setTweetsCache(new ArrayList(tweets));
      EmojiTwitter.setCacheDate(currentDate);
    }
  }
  if (tweets.size() == 0) {
    request.setAttribute("ShowPortalElement", Boolean.FALSE);
    return;
  }
  isTwitterOk = true;
} catch (TwitterException e) {
  logger.warn("Erreur sur le fil twitter", e);
} catch (IllegalStateException e) {
  logger.warn("Erreur sur la requete du fil twitter", e);
}
%>	
			 	
<jalios:if predicate="<%= isTwitterOk %>">

<section class="ds44-container-fluid mtm mbm">
    <section class="ds44-container-large">


    <div class="ds44-box ds44-theme ds44-bgTriangle-left">
        <div class="ds44-flex-container ds44-flex-container--colMed ds44-flex-container--colMed--colRev">
            <p class="ds44-boxPushContent--fluid ds44-boxPushPic--horizontal" aria-level="2" role="heading">
                <a href="<%= box.getLienTwitter() %>" target="_blank" class="ds44-rsLink" title='<%= box.getLibelleTwitter(userLang) %> - <%= HttpUtil.encodeForHTMLAttribute(box.getTitreTwitter(userLang)) %> <%= glp("jcmsplugin.socle.accessibily.newTabLabel") %>'>
                    <i class="icon icon-twitter icon--xlarge ds44-mr1 ds44-mtb1" aria-hidden="true"></i>
                    <span class="p-medium ds44-mtb1"><%= box.getLibelleTwitter(userLang) %></span></a>
            </p>
            
            <ul class="ds44-boxPushContent ds44-boxPushContent--fluid ds44-list ds44-noMrg">
                <jalios:foreach collection="<%= tweets %>" name="itTweet" type="Status" max="2">
					<li class="ds44-contentPushH">
					  <p class="ds44--l-padding-lr ds44--m-padding-tb">
					    <span class="p-light ds44-block"><strong>Il y a <jalios:duration begin="<%= itTweet.getCreatedAt() %>" end="<%= new Date() %>" round="<%= true %>" /></strong></span>
					    <a href="<%= EmojiTwitter.getTweetUrl(itTweet) %>" target="_blank" title='<%= glp("jcmsplugin.socle.lien.site.nouvelonglet", EmojiTwitter.parse(EmojiTwitter.removeURL(itTweet))) %>'>
					      <span class="ds44-block"><%= EmojiTwitter.parse(EmojiTwitter.removeURL(itTweet)) %></span>
					    </a>
					  </p>
					</li>
                </jalios:foreach>
            </ul>
        </div>
    </div>


        </section>
    </section>		
</jalios:if>
