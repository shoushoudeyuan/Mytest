package net.joystart.setting.service;

import java.util.List;
import java.util.Map;
public interface ISmsService {
	Integer getSmsLogListCount(Map<String, Object> params);
	List<Map<String, Object>> getSmsLogList(Map<String, Object> params);
}
