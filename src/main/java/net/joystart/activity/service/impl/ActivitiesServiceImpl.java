package net.joystart.activity.service.impl;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import net.joystart.activity.dao.ActivitiesMapper;
import net.joystart.activity.dao.ActivityRedPacketMapper;
import net.joystart.activity.entity.Activities;
import net.joystart.activity.entity.ActivityRedPacket;
import net.joystart.activity.service.IActivitiesService;
import net.joystart.common.util.ConstantUtil;
import net.joystart.common.util.StringUtil;

@Service("activitiesService")
public class ActivitiesServiceImpl implements IActivitiesService {

	@Resource
	private ActivitiesMapper activitiesMapper;
	
	@Resource
	private ActivityRedPacketMapper activityRedPacketMapper;

	@Override
	public List<Activities> getActivities(Map<String, Object> params) {
		return activitiesMapper.getActivities(params);
	}

	@Override
	public int getActivityCount(Map<String, Object> params) {
		return activitiesMapper.getActivityCount(params);
	}
	
	@Override
	public Activities getActivity(Map<String, Object> params) {
		Object oActivityId = params.get("activityId");
		int id=0;
		if(null !=oActivityId){
			id=Integer.parseInt(oActivityId.toString());
		}
		return activitiesMapper.selectByPrimaryKey(id);
	}

	@Override
	public int insertSelective(Activities record) {
		return activitiesMapper.insertSelective(record);
	}

	@Override
	public int modifyActivityById(Activities record) {
		return activitiesMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int deleteActivity(String[] ids) {
		return activitiesMapper.deleteActivity(ids);
	}

	@Override
	public List<ActivityRedPacket> getActivityRedPackets(Map<String, Object> params) {
		return activityRedPacketMapper.getActivityRedPackets(params);
	}

	@Override
	public int getActivityRedPacketCount(Map<String, Object> params) {
		return activityRedPacketMapper.getActivityRedPacketCount(params);
	}

	@Override
	public ActivityRedPacket getActivityRedPacket(Map<String, Object> params) {
		Object oRedEnvelopeId = params.get("activityRedPacketId");
		int id=0;
		if(null !=oRedEnvelopeId){
			id=Integer.parseInt(oRedEnvelopeId.toString());
		}
		return activityRedPacketMapper.selectByPrimaryKey(id);
	}

	@Override
	public int batchInsertActivityRedPacket(ActivityRedPacket activityRedPacket) {
		List<ActivityRedPacket> activityRedPackets = new ArrayList<ActivityRedPacket>();
		int length = activityRedPacket.getNumber();
		for(int i=0;i<length;i++){
			ActivityRedPacket arp = (ActivityRedPacket)activityRedPacket.clone();
			//TODO 查找一下红包编码的生成规则,待完善
			arp.setPacketnum(generateRedPacketNumber());
			activityRedPackets.add(arp);
		}
		return activityRedPacketMapper.batchInsertActivityRedPacket(activityRedPackets);
	}

	@Override
	public int modifyActivityRedPacketById(ActivityRedPacket activityRedPacket) {
		return activityRedPacketMapper.updateByPrimaryKeySelective(activityRedPacket);
	}

	@Override
	public int deleteActivityRedPacket(String[] ids) {
		return activityRedPacketMapper.deleteActivityRedPacket(ids);
	}

	/**
     * 生成红包编号   
     * @param prefix 前缀
     * @param key 标识
     * @return
     */
	public String generateRedPacketNumber() {
		String result;
		Calendar now=Calendar.getInstance();
		String year = now.get(Calendar.YEAR)+"";
		while(true) {
			String strRandom = StringUtil.getRandomString(7, ConstantUtil.REDPACKET_NUMBER_SEEDSOURCE);
			//code = "HB"+year+month+day+code;
			result = ConstantUtil.REDPACKET_NUMBER_PREFIX+year+strRandom;
			Integer res = activityRedPacketMapper.isExistRedPacketNumber(result);
			if(res==null)break;
		}
        return result;
	}
	
}
