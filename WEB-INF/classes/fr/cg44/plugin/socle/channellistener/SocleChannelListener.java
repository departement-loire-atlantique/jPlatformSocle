package fr.cg44.plugin.socle.channellistener;

import static com.jalios.jcms.Channel.getChannel;

import java.text.ParseException;

import org.apache.log4j.Logger;

import com.jalios.jcms.Channel;
import com.jalios.jcms.ChannelListener;
import com.jalios.jcms.Group;
import com.jalios.jcms.JcmsUtil;
import com.jalios.jcms.Member;
import com.jalios.jdring.AlarmEntry;
import com.jalios.jdring.AlarmManager;
import com.jalios.jdring.PastDateException;
import com.jalios.util.JProperties;
import com.jalios.util.Util;

import fr.cg44.plugin.socle.SocleConstants;
import fr.cg44.plugin.socle.alarmlistener.InfolocaleTokenAlarmListener;
import fr.cg44.plugin.socle.infolocale.RequestManager;

/**
 * Permet de créer le groupe pour la visibilité de la topbar si celui-ci n'éxiste pas,
 * et de l'enregistrer dans les propriétés de JPlatform
 */
public class SocleChannelListener extends ChannelListener{
	
	private static final Logger LOGGER = Logger.getLogger(SocleChannelListener.class);

	@Override
	public void handleFinalize() {}
	
	@Override
	public void initBeforeStoreLoad() throws Exception {}
	
	@Override
	public void initAfterStoreLoad() throws Exception {
		// Permet de créer le groupe pour la visibilité de la topbar si celui-ci n'éxiste pas
		processVisibleTopbarGroup();
		
		// Initialise l'alarmlistener des tokens Infolocale
		initInfolocaleTokenAlarmListener();
	}

	
	/**
	 * Permet de créer le groupe pour la visibilité de la topbar si celui-ci n'éxiste pas
	 */
	private void processVisibleTopbarGroup() {
		// Le goupe visibilité de la topbar éxiste déjà,
		// il n'est donc pas nécéssaire de le créer
		if(checkVisibleTopbarGroup()) {
			return;
		}
		// Les écritures JPlatform sont coupées,
		// il n'est donc pas possible de créer le groupe
		if(!getChannel().isDataWriteEnabled()) {
			LOGGER.warn("Impossible de créer le groupe pour la visibilité de la topbar");
			return;
		}
		// Création du groupe pour la visibilité de la topbar
		createVisibleTopbarGroup();	
	}
	
	
	/**
	 * Création du groupe pour la visibilité de la topbar,
	 * et l'enregistre dans la propriété correspondante de JPlatform
	 */
	private void createVisibleTopbarGroup() {
		LOGGER.info("Création du groupe pour la visibilité de la topbar");
		Member adminMember = getChannel().getDefaultAdmin();
		// Création du groupe dans JPlatform
		Group localVisibleGroup = new Group();
		localVisibleGroup.setName(JcmsUtil.glpd("jcmsplugin.socle.visible-topbar.group.name"));
		localVisibleGroup.performCreate(adminMember);
		// Enregistre le groupe dans les propriétés de JPlatform
		JProperties localJProperties = new JProperties();
		localJProperties.put(SocleConstants.VISIBLE_TOPBAR_GROUP_PROP, localVisibleGroup.getId());
		getChannel().updateAndSaveProperties(localJProperties);
	}
	
	
	/**
	 * Vérifie si le groupe pour la visibilité de la topbar éxiste
	 * @return true si le groupe pour la visibilité de la topbar éxiste
	 */
	private boolean checkVisibleTopbarGroup() {
		// Récupère le groupe depuis la propriété du module
		Group visibleTopbarGroup = getChannel().getGroup(SocleConstants.VISIBLE_TOPBAR_GROUP_PROP);
		return Util.notEmpty(visibleTopbarGroup);
	}
	
	/**
	 * Initialise l'alarmlistener des tokens Infolocale
	 */
	private void initInfolocaleTokenAlarmListener() {
		String schedule = Channel.getChannel().getProperty("jcmsplugin.socle.infolocale.schedule");
		InfolocaleTokenAlarmListener alarmListener = new InfolocaleTokenAlarmListener();
		AlarmEntry alarmEntry;
		try {
			alarmEntry = new AlarmEntry(schedule, alarmListener);
			AlarmManager alarmMgr = Channel.getChannel().getCommonAlarmManager();
		    alarmMgr.addAlarm(alarmEntry);
		} catch (PastDateException | ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// Effectuer la génération des tokens au démarrage
		RequestManager.initTokens();
	}

}
