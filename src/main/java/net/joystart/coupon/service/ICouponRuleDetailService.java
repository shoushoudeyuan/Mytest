package net.joystart.coupon.service;

import java.util.List;

import net.joystart.coupon.entity.CouponRuleDetail;
import net.joystart.coupon.entity.RuleItem;


public interface ICouponRuleDetailService {
	
	List<CouponRuleDetail> selectByIdentification(String Identification);
	
	List<CouponRuleDetail> selectValidCouponByIdentification(String Identification);
	
	List<RuleItem> getItemByInvitationCode(String invitationCode);
}
