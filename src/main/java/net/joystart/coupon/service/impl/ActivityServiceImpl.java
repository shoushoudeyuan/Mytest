package net.joystart.coupon.service.impl;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import net.joystart.coupon.dao.ActivityMapper;
import net.joystart.coupon.entity.Activity;
import net.joystart.coupon.service.IActivityService;

@Service("activityService")
public class ActivityServiceImpl implements IActivityService {

	@Resource
	private ActivityMapper activityMapper;
	
	public ActivityMapper getActivityMapper() {
		return activityMapper;
	}

	public void setActivityMapper(ActivityMapper activityMapper) {
		this.activityMapper = activityMapper;
	}

	@Override
	public Activity selectByParams(Map parmas) {
		return this.activityMapper.selectByParams(parmas);
	}
	
}
