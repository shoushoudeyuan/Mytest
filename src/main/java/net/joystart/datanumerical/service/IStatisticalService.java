package net.joystart.datanumerical.service;

import java.util.List;
import java.util.Map;
public interface IStatisticalService {
	Integer getSmsStatisticalListCount(Map<String, Object> params);
	List<Map<String, Object>> getSmsStatisticalList(Map<String, Object> params);
	int getSmsStatisticalListAllCount(Map<String, Object> params);
}
