package net.joystart.activity.dao;

import java.util.List;
import java.util.Map;

import net.joystart.activity.entity.ActivityRedPacket;

public interface ActivityRedPacketMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(ActivityRedPacket record);

    int insertSelective(ActivityRedPacket record);

    ActivityRedPacket selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ActivityRedPacket record);

    int updateByPrimaryKey(ActivityRedPacket record);

	List<ActivityRedPacket> getActivityRedPackets(Map<String, Object> params);

	int getActivityRedPacketCount(Map<String, Object> params);
	
	int deleteActivityRedPacket(String[] ids);

	int batchInsertActivityRedPacket(List<ActivityRedPacket> activityRedPackets);

	Integer isExistRedPacketNumber(String packetNum);
}