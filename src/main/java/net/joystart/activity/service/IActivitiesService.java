package net.joystart.activity.service;

import java.util.List;
import java.util.Map;

import net.joystart.activity.entity.Activities;
import net.joystart.activity.entity.ActivityRedPacket;

public interface IActivitiesService {

	int insertSelective(Activities record);

    int modifyActivityById(Activities record);
	
	/**
	 * 根据条件获取活动集合
	 * @param params
	 * @return
	 */
	List<Activities> getActivities(Map<String, Object> params);

	/**
	 * 根据条件获取单个活动
	 * @param params
	 * @return
	 */
	Activities getActivity(Map<String, Object> params);

	/**
	 * 获取活动数量
	 * @param params
	 * @return
	 */
	int getActivityCount(Map<String, Object> params);

	/**
	 * 删除活动
	 * @param ids
	 * @return
	 */
	int deleteActivity(String[] ids);

	/**
	 * 获取活动红包列表
	 * @param params
	 * @return
	 */
	List<ActivityRedPacket> getActivityRedPackets(Map<String, Object> params);
	
	/**
	 * 获取活动红包数量
	 * @param params
	 * @return
	 */
	int getActivityRedPacketCount(Map<String, Object> params);

	/**
	 * 获取活动红包对象
	 * @param params
	 * @return
	 */
	ActivityRedPacket getActivityRedPacket(Map<String, Object> params);

	/**
	 * 批量插入活动红包
	 * @param activityRedPacket
	 * @return
	 */
	int batchInsertActivityRedPacket(ActivityRedPacket activityRedPacket);

	/**
	 * 修改活动红包
	 * @param activityRedPacket
	 * @return
	 */
	int modifyActivityRedPacketById(ActivityRedPacket activityRedPacket);

	/**
	 * 删除活动红包
	 * @param ids
	 * @return
	 */
	int deleteActivityRedPacket(String[] ids);

}
