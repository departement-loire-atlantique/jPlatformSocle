package fr.cg44.plugin.socle.policyfilter;

import org.apache.log4j.Logger;
import org.json.JSONObject;

import com.jalios.jcms.Data;
import com.jalios.jcms.policy.BasicChannelPolicyFilter;

import fr.cg44.plugin.socle.infolocale.InfolocaleEntityUtils;
import fr.cg44.plugin.socle.infolocale.RequestManager;
import generated.EvenementInfolocale;

/**
 * Mécanique qui permet d'avoir un EvenementInfolocale en fulldisplay
 * 
 * @author acemicka
 *
 */
public class InfoLocaleChannelPolicyFilter extends BasicChannelPolicyFilter {

  private static final Logger LOGGER = Logger.getLogger(InfoLocaleChannelPolicyFilter.class);

  @Override
  public Data getData(String id) {
    if (!id.startsWith("INFOLOC-")) {
      return null;
    }

    String idInfoLocale = id.replaceFirst("INFOLOC-", "");
    LOGGER.debug("Contenu infolocale : " + id);
    JSONObject jsonObject = RequestManager.getSingleEvent(idInfoLocale);
    EvenementInfolocale event = InfolocaleEntityUtils.createEvenementInfolocaleFromJsonItem(jsonObject);
    return event;
  }
}


