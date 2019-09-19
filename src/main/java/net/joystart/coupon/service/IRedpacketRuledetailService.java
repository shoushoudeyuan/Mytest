package net.joystart.coupon.service;

import java.util.List;

import net.joystart.coupon.entity.Activity;
import net.joystart.coupon.entity.RedpacketRuledetail;

public interface IRedpacketRuledetailService {
	public List<RedpacketRuledetail> selectByActiviID(Activity activity);
}
