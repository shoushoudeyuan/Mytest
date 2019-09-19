package net.joystart.activity.dao;

import java.util.List;
import java.util.Map;

import net.joystart.activity.entity.Activities;


public interface ActivitiesMapper {

	int deleteByPrimaryKey(Integer id);

    int insert(Activities record);

    int insertSelective(Activities record);

    Activities selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Activities record);

    int updateByPrimaryKey(Activities record);
    
	List<net.joystart.activity.entity.Activities> getActivities(Map<String, Object> params);

	int getActivityCount(Map<String, Object> params);

	int deleteActivity(String[] ids);
	
    Activities getActivityByRuleID(Integer ruleID);

}