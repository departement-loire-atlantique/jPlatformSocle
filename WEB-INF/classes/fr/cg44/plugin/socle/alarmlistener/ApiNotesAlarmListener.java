package fr.cg44.plugin.socle.alarmlistener;

import com.jalios.jdring.AlarmEntry;
import com.jalios.jdring.AlarmListener;

import fr.cg44.plugin.socle.api.ApiNotesCacheManager;

public class ApiNotesAlarmListener implements AlarmListener {
  
  @Override
  public void handleAlarm(AlarmEntry alarm) {
    ApiNotesCacheManager apiNotesCache = ApiNotesCacheManager.INSTANCE;
    apiNotesCache.refreshBeanData();
  }
  
}