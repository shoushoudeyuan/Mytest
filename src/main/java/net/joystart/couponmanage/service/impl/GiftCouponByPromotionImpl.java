package net.joystart.couponmanage.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.joystart.common.util.ConstantUtil;
import net.joystart.couponmanage.entity.CustomerCouponNew;
import net.joystart.couponmanage.entity.GiftCouponArg;
import net.joystart.customer.entity.Customer;
import net.joystart.customer.remote.service.ICustomerRemoteService;
import net.joystart.promotion.entity.PromotionBusiness;
import net.joystart.promotion.entity.PromotionPerson;
import net.joystart.promotion.service.IPromotionBusinessService;
import net.joystart.promotion.service.IPromotionPersonService;

@Service
public class GiftCouponByPromotionImpl extends AbstractGiftCouponService {

	@Autowired
	private IPromotionPersonService promotionPersonService;
	
	@Autowired
	private IPromotionBusinessService promotionBusinessService;
	
	@Autowired
	private ICustomerRemoteService customerRemoteService;
	
	@Override
	protected boolean canGiftCoupon(GiftCouponArg arg) throws Exception {
		// 查询此渠道码有无对应的推广人员(未删除的,删除的推广人员的渠道码失效)
		PromotionPerson person = promotionPersonService.selectProPersonByChanneCode(arg.getExchangeCode());
		if (null == person) {
			logger.debug("{}兑换的推广码{}无效",arg.getTargetCustomerId(),arg.getExchangeCode());
			result.setCode(ConstantUtil.W_EXCEPTION);
			result.setMessage("该推广码不存在");
			return false;
		}
		
		if(person.getIsdisable() == 1){
			logger.debug("{}兑换的推广码{}的推广人员{}已禁用",arg.getTargetCustomerId(),arg.getExchangeCode(),person.getName());
			result.setCode(ConstantUtil.W_EXCEPTION);
			result.setMessage("该推广码无效");
			return false;
		}
		
		PromotionBusiness pb = promotionBusinessService.selectBusinessByPersonId(person.getId());
		if(pb == null){
			logger.debug("{}推广码对应的推广商不存在！",arg.getExchangeCode());
			result.setCode(ConstantUtil.W_EXCEPTION);
			result.setMessage("该推广码无效");
			return false;
		}
		
		if(pb.getIsdisable() == 1){
			logger.debug("{}兑换的推广码{}的推广商{}已禁用",arg.getTargetCustomerId(),arg.getExchangeCode(),pb.getName());
			result.setCode(ConstantUtil.W_EXCEPTION);
			result.setMessage("该推广码无效");
			return false;
		}
		
		// 查询该用户有没有使用别人的邀请码兑换过优惠券
		boolean isInvited = customerRemoteService.selectUseInvitationCodeGetCounponCount(arg.getTargetCustomerId()) > 0;
		if (isInvited) {
			logger.debug("{}已使用推广码或邀请码兑换过",arg.getTargetCustomerId());
			result.setCode(ConstantUtil.W_EXCEPTION);
			result.setMessage("兑换失败，已通过其他方式进行过兑换");
			return false;
		}
		
		//保存推广关系
		if(!isInvited){
			Map<String, Object> params = new HashMap<String, Object>(4);
			params.put("createDate", new Date());
			params.put("useId", arg.getTargetCustomerId());
			params.put("usedId", person.getId());
			params.put("type", 1);
			customerRemoteService.insertCustomerInvite(params);
		}

		if(pb.getCouponPackageId() == null){
			logger.debug("{}推广码对应的推广商{}没有配置优惠券！",arg.getExchangeCode(),pb.getName());
			result.setCode(ConstantUtil.W_EXCEPTION);
			result.setMessage("该推广码无优惠券");
			return false;
		}
		
		arg.setSourceId(pb.getCouponPackageId());
		return true;
	}

	@Override
	protected void endGiftCoupon(GiftCouponArg arg, List<CustomerCouponNew> lstCoupon, int giftCount) {
		if(lstCoupon != null && lstCoupon.size() > 0 && giftCount <= 0){
			result.setCode(ConstantUtil.W_EXCEPTION);
			result.setData(false);
			return;
		}
		
		Customer customer = new Customer();
		customer.setId(arg.getTargetCustomerId());
		customer.setRecommendcode(arg.getExchangeCode());
		customer.setIsSendInviteCoupon(1);
		customerRemoteService.updaeCustomer(customer);

	}

}
