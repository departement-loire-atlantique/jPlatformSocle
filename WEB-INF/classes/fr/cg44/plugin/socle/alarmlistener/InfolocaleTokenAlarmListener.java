package fr.cg44.plugin.socle.alarmlistener;

import com.jalios.jdring.AlarmEntry;
import com.jalios.jdring.AlarmListener;

import fr.cg44.plugin.socle.infolocale.RequestManager;

public class InfolocaleTokenAlarmListener implements AlarmListener {
	
	@Override
	public void handleAlarm(AlarmEntry alarm) {
		RequestManager.initTokens();
	}
	
}