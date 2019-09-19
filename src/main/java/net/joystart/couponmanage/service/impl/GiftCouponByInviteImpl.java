package net.joystart.couponmanage.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;

import net.joystart.common.util.ConstantUtil;
import net.joystart.couponmanage.entity.CustomerCouponNew;
import net.joystart.couponmanage.entity.GiftCouponArg;
import net.joystart.couponmanage.entity.giftconfig.GiftConfig4InviteFriends;
import net.joystart.couponmanage.enums.CouponGiftModeEnum;
import net.joystart.customer.entity.Customer;
import net.joystart.customer.remote.service.ICustomerRemoteService;
import net.joystart.order.entity.Order;
import net.joystart.order.enums.OrderStatus;
import net.joystart.order.remote.service.IOrderRemoteService;

@Service
public class GiftCouponByInviteImpl extends AbstractGiftCouponService {

	@Autowired
	private ICustomerRemoteService customerRemoteService;
	
	@Autowired
	private IOrderRemoteService orderService;
	
	private Integer inviteeId;
	private Integer inviterId;
	private boolean canGift4Invitee;
	private boolean canGift4Inviter;
	private Customer invitee;
	private boolean isInviated ;
	
	@Override
	protected boolean canGiftCoupon(GiftCouponArg arg) throws Exception {
		if(StringUtils.isBlank(arg.getExchangeCode())){
			return false;
		}
		invitee = customerRemoteService.selectByPrimaryKey(arg.getTargetCustomerId());
		inviteeId = invitee.getId();
		JSONObject inviter = customerRemoteService.getCustomerIdByInvitationCode(arg.getExchangeCode());
		
		// 该邀请码没有对应的用户
		if (null == inviter) {
			logger.debug("邀请好友赠:该邀请码{}没有对应的用户",arg.getExchangeCode());
			result.setCode(ConstantUtil.W_EXCEPTION);
			result.setMessage("此邀请码不存在！");
			return false;
		}
		
		GiftConfig4InviteFriends giftConfig = svcGiftConfig.selectByEnumCode(CouponGiftModeEnum.邀请好友赠, GiftConfig4InviteFriends.class);
		if(giftConfig.getIsValidate() == 0){
			logger.debug("邀请好友赠:规则已禁用");
			result.setCode(ConstantUtil.W_EXCEPTION);
			result.setMessage("已被禁止兑换");
			return false;
		}
		
		//判断被邀请人能否兑换优惠券
		canGift4Invitee = giftCoupon4Invitee(arg,giftConfig,invitee);
		//判断邀请人能否兑换优惠券
		canGift4Inviter = giftCoupon4Inviter(arg,giftConfig,invitee,inviter);
		if(!canGift4Invitee&&!canGift4Inviter){
			return false;
		}
		return true;
	}
	
	@Override
	protected void endGiftCoupon(GiftCouponArg arg,List<CustomerCouponNew> lstCoupon,int giftCount) {
		arg.setTargetCustomerId(inviteeId);
		if(giftCount <= 0){
			result.setCode(ConstantUtil.W_EXCEPTION);
			result.setData(false);
			return;
		}
		
		Customer customer = new Customer();
		customer.setId(arg.getTargetCustomerId());
		if(canGift4Inviter){
			customer.setIsSendRecommendCoupon(1);
			customer.setRecommendcode(arg.getExchangeCode());
			result.setCode(ConstantUtil.W_SUCCESS);
			result.setData(true);
		}else if(invitee.getIsSendRecommendCoupon() == 0){
			result.setCode(ConstantUtil.W_EXCEPTION);
			result.setData(false);
			result.setMessage("暂未满足兑换条件");
		}
		
		if(canGift4Invitee){
			customer.setRecommendcode(arg.getExchangeCode());
			customer.setIsSendInviteCoupon(1);		
			result.setCode(ConstantUtil.W_SUCCESS);
			result.setData(true);
		}else if(invitee.getIsSendInviteCoupon() == 0){
			result.setCode(ConstantUtil.W_EXCEPTION);
			result.setData(false);
			result.setMessage("暂未满足兑换条件");
		}
		
		if(canGift4Invitee || canGift4Inviter){
			customerRemoteService.updaeCustomer(customer);
		}
	}
	
	@Override
	protected List<CustomerCouponNew> beginGiftCoupon(GiftCouponArg arg,Integer packageId){
		List<CustomerCouponNew> lstCoupon = new ArrayList<>();
		
		if(canGift4Inviter && inviterId != null){
			arg.setTargetCustomerId(inviterId);
			lstCoupon = super.beginGiftCoupon(arg,packageId);
		}
		
		if(canGift4Invitee && inviteeId != null){
			arg.setTargetCustomerId(inviteeId);
			lstCoupon.addAll(super.beginGiftCoupon(arg,packageId));
		}
		
		return lstCoupon;
	}
	
	private boolean giftCoupon4Invitee(GiftCouponArg arg,GiftConfig4InviteFriends giftConfig,Customer invitee){
		if(!giftConfig.getInviteeRegistedAndUseInviteCode4Invitee() && !giftConfig.getInviteeIdentified4Invitee() && !giftConfig.getInviteePayDeposit4Invitee()){
			logger.debug("邀请好友赠:被邀请人{}的规则未配置",arg.getTargetCustomerId());
			result.setCode(ConstantUtil.W_EXCEPTION);
			result.setMessage("暂未满足兑换条件");
			return false;
		}
		
		if(invitee.getIsSendInviteCoupon() == 1){
			logger.debug("邀请好友赠:用户{}已领取过优惠券",invitee.getId());
			result.setCode(ConstantUtil.W_EXCEPTION);
			result.setMessage("您已领取过优惠券！");
			return false;
		}
		
		if(giftConfig.getInviteeIdentified4Invitee()){
			if(invitee.getIdentityapprove() != 1){
				logger.debug("邀请好友赠:{}用户未认证不能赠送优惠券",arg.getTargetCustomerId());
				result.setCode(ConstantUtil.W_EXCEPTION);
				result.setMessage("暂未满足兑换条件");
				return false;
			}
		}
		
		if(giftConfig.getInviteePayDeposit4Invitee()){
			if(invitee.getMemberType() == 0){
				logger.debug("邀请好友赠:{}用户未缴纳保证金不能赠送优惠券",arg.getTargetCustomerId());
				result.setCode(ConstantUtil.W_EXCEPTION);
				result.setMessage("暂未满足兑换条件");
				return false;
			}
		}
		
		
		inviteeId = invitee.getId();
		return true;
	}
	
	private boolean giftCoupon4Inviter(GiftCouponArg arg,GiftConfig4InviteFriends giftConfig,Customer invitee,JSONObject inviter){
		inviterId = null;
		
		if(!giftConfig.getInviteeIdentified4Inviter() && !giftConfig.getInviteePayDeposit4Inviter() && !giftConfig.getInviteeFirstRentCarAndPayment4Inviter()){
			logger.debug("邀请好友赠:邀请人{}的被邀请人{}规则未配置",invitee.getId(),inviter.getInteger("id"));
			return false;
		}
		
		if(invitee.getIsSendRecommendCoupon() == 1){
			logger.debug("邀请好友赠:邀请人{}已领取被邀请人{}注册优惠券",inviter.getInteger("id"),invitee.getId());
			return false;
		}
		
		if(giftConfig.getInviteeIdentified4Inviter()){
			if(invitee.getIdentityapprove() != 1){
				logger.debug("邀请好友赠:被邀请人{}未认证邀请人{}不能赠送优惠券",invitee.getId(),inviter.getInteger("id"));
				return false;
			}
		}
		
		if(giftConfig.getInviteePayDeposit4Inviter()){
			if(invitee.getMemberType() == 0){
				logger.debug("邀请好友赠:被邀请人{}未缴纳保证金邀请人{}不能赠送优惠券",invitee.getId(),inviter.getInteger("id"));
				return false;
			}
		}
		
		if(giftConfig.getInviteeFirstRentCarAndPayment4Inviter()){
			boolean isFirst = orderService.selectCountByCustomerId(invitee.getId()) == 1;
			if(!isFirst){
				logger.debug("邀请好友赠:被邀请人{}不是首次用车，邀请人{}不能赠送优惠券",invitee.getId(),inviter.getInteger("id"));
				return false;
			}
			
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("customerId", invitee.getId());
			params.put("pageSize", 10);
			params.put("pageNumber", 0);
			List<Order> lstOrder = orderService.getOrderList(params);
			if(lstOrder == null || lstOrder.size() != 1 ){
				logger.debug("邀请好友赠:用户{}不是首单",arg.getTargetCustomerId());
				return false;
			}
			
			Order order = lstOrder.get(0);
			if(order.getOrderstatus() != OrderStatus.COMPLETED.getValue() || 
					(order.getReturnMiles() - order.getTakeMiles()) < giftConfig.getInviteeFirstDriverMileage4Inviter()){
				logger.debug("邀请好友赠:被邀请人{}行驶里程小于{}公里，邀请人{}不能赠送优惠券",invitee.getId(),giftConfig.getInviteeFirstDriverMileage4Inviter(),inviter.getInteger("id"));
				return false;
			}
		}
		
		inviterId = inviter.getInteger("id");
		return true;
	}

}
