package net.joystart.coupon.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import net.joystart.coupon.dao.RedpacketRuledetailMapper;
import net.joystart.coupon.entity.Activity;
import net.joystart.coupon.entity.RedpacketRuledetail;
import net.joystart.coupon.service.IRedpacketRuledetailService;

@Component("redpacketRuledetailService")
public class RedpacketRuledetailImpl implements IRedpacketRuledetailService {

	@Resource
	private RedpacketRuledetailMapper redpacketRuledetailMapper;

	
	
	
	public RedpacketRuledetailMapper getRedpacketRuledetailMapper() {
		return redpacketRuledetailMapper;
	}

	public void setRedpacketRuledetailMapper(RedpacketRuledetailMapper redpacketRuledetailMapper) {
		this.redpacketRuledetailMapper = redpacketRuledetailMapper;
	}

	@Override
	public List<RedpacketRuledetail> selectByActiviID(Activity activity) {
		return this.redpacketRuledetailMapper.selectByActivityID(activity);
	}
	
	
}
