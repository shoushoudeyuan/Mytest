package net.joystart.coupon.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import net.joystart.coupon.dao.CouponRuleDetailMapper;
import net.joystart.coupon.entity.CouponRuleDetail;
import net.joystart.coupon.entity.RuleItem;
import net.joystart.coupon.service.ICouponRuleDetailService;

@Component("couponRuleDetailService")
public class CouponRuleDetailServiceImpl implements ICouponRuleDetailService {

	@Resource
	private CouponRuleDetailMapper couponRuleDetail;
	
	@Override
	public List<CouponRuleDetail> selectByIdentification(String Identification) {
		// TODO Auto-generated method stub
		return couponRuleDetail.selectByIdentification(Identification);
	}

	@Override
	public List<RuleItem> getItemByInvitationCode(String invitationCode) {
		
		return couponRuleDetail.getItemByInvitationCode(invitationCode);
	}

	@Override
	public List<CouponRuleDetail> selectValidCouponByIdentification(String Identification) {
		return couponRuleDetail.selectValidCouponByIdentification(Identification);
	}

}
