package net.joystart.coupon.remote.service.impl;

import java.util.Map;

import javax.annotation.Resource;

import com.alibaba.dubbo.config.annotation.Service;

import net.joystart.coupon.dao.ActivityMapper;
import net.joystart.coupon.entity.Activity;
import net.joystart.coupon.remote.service.IActivityRemoteService;

@Service(timeout=60000,retries=0)
public class ActivityRemoteServiceImpl implements IActivityRemoteService {

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
