package net.joystart.customerservice.dao;

import java.util.List;
import java.util.Map;

import net.joystart.customerservice.entity.ServiceEvent;

public interface ServiceEventMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(ServiceEvent record);

    int insertSelective(ServiceEvent record);

    ServiceEvent selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ServiceEvent record);

    int updateByPrimaryKey(ServiceEvent record);

	List<ServiceEvent> getServiceEvents(Map<String, Object> params);

	int getServiceEventCount(Map<String, Object> params);

	int deleteServiceEvent(String[] ids);
}