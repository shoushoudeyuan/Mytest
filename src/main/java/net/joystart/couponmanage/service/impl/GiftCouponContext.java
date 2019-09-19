package net.joystart.couponmanage.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import net.joystart.common.context.SpringContextUtil;
import net.joystart.common.util.MessageResult;
import net.joystart.couponmanage.entity.GiftCouponArg;
import net.joystart.couponmanage.enums.CouponGiftModeEnum;
import net.joystart.couponmanage.enums.CustomerBehaviorEnum;
import net.joystart.couponmanage.service.IGiftCouponService;
import net.joystart.customer.entity.Customer;
import net.joystart.customer.remote.service.ICustomerRemoteService;

@Component
public class GiftCouponContext {
	
	protected final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private ICustomerRemoteService customerRemoteService;
	
	public Map<CouponGiftModeEnum,MessageResult> giftCoupon(CustomerBehaviorEnum behavior,Integer customerId,String exchangeCode,Integer orderId){
		Map<CouponGiftModeEnum,MessageResult> result = new HashMap<>();
		GiftCouponArg arg;
		MessageResult data;

		logger.debug("优惠券赠送请求：行为：{}；用户：{}；兑换码：{}，订单Id：{}",behavior,customerId,exchangeCode,orderId);
		switch(behavior){
			case 用户注册成功:
				arg = createArg(CouponGiftModeEnum.注册用户赠,null,customerId,null,null);
				data = CreateGiftCoupon(arg.getSource()).giftCoupon(arg);
				result.put(CouponGiftModeEnum.注册用户赠, data);
				
				break;
			case 身份认证成功:
				arg = createArg(CouponGiftModeEnum.注册用户赠,null,customerId,null,null);
				data = CreateGiftCoupon(arg.getSource()).giftCoupon(arg);
				result.put(CouponGiftModeEnum.注册用户赠, data);
				
				arg = createArg(CouponGiftModeEnum.邀请好友赠,null,customerId,getInvitationCode(customerId),orderId);
				data = CreateGiftCoupon(arg.getSource()).giftCoupon(arg);
				result.put(CouponGiftModeEnum.邀请好友赠, data);
				break;
			case 保证金缴纳成功:
				arg = createArg(CouponGiftModeEnum.注册用户赠,null,customerId,null,null);
				data = CreateGiftCoupon(arg.getSource()).giftCoupon(arg);
				result.put(CouponGiftModeEnum.注册用户赠, data);
				
				arg = createArg(CouponGiftModeEnum.邀请好友赠,null,customerId,getInvitationCode(customerId),orderId);
				data = CreateGiftCoupon(arg.getSource()).giftCoupon(arg);
				result.put(CouponGiftModeEnum.邀请好友赠, data);
				break;
			case 成为企业会员:
				arg = createArg(CouponGiftModeEnum.首次成为企业用户赠,null,customerId,null,null);
				data = CreateGiftCoupon(arg.getSource()).giftCoupon(arg);
				result.put(CouponGiftModeEnum.首次成为企业用户赠, data);
				break;
			case 用户成功还车:
				arg = createArg(CouponGiftModeEnum.首次用车结单赠,null,customerId,getInvitationCode(customerId),orderId);
				data = CreateGiftCoupon(arg.getSource()).giftCoupon(arg);
				result.put(CouponGiftModeEnum.首次用车结单赠, data);
				
				arg = createArg(CouponGiftModeEnum.订单满额赠,null,customerId,null ,orderId);
				data = CreateGiftCoupon(arg.getSource()).giftCoupon(arg);
				result.put(CouponGiftModeEnum.订单满额赠, data);
				break;
			case 订单成功支付:
				arg = createArg(CouponGiftModeEnum.邀请好友赠,null,customerId,getInvitationCode(customerId),orderId);
				data = CreateGiftCoupon(arg.getSource()).giftCoupon(arg);
				result.put(CouponGiftModeEnum.邀请好友赠, data);
				
				arg = createArg(CouponGiftModeEnum.订单满额赠,null,customerId,null ,orderId);
				data = CreateGiftCoupon(arg.getSource()).giftCoupon(arg);
				result.put(CouponGiftModeEnum.订单满额赠, data);
				
				arg = createArg(CouponGiftModeEnum.首次用车结单赠,null,customerId,null ,orderId);
				data = CreateGiftCoupon(arg.getSource()).giftCoupon(arg);
				result.put(CouponGiftModeEnum.首次用车结单赠, data);
				
				arg = createArg(CouponGiftModeEnum.首次成为企业用户赠,null,customerId,null,orderId);
				data = CreateGiftCoupon(arg.getSource()).giftCoupon(arg);
				result.put(CouponGiftModeEnum.首次成为企业用户赠, data);
				break;
			case 邀请码兑换:
				arg = createArg(CouponGiftModeEnum.手动兑换邀请码,2,customerId,exchangeCode,null);
				data = CreateGiftCoupon(arg.getSource()).giftCoupon(arg);
				result.put(CouponGiftModeEnum.手动兑换邀请码, data);
				break;
			case 渠道码兑换:
				arg = createArg(CouponGiftModeEnum.渠道,null,customerId,exchangeCode,null);
				data = CreateGiftCoupon(arg.getSource()).giftCoupon(arg);
				result.put(CouponGiftModeEnum.渠道, data);
				break;
			case 推广码兑换:
				arg = createArg(CouponGiftModeEnum.推广,null,customerId,exchangeCode,null);
				data = CreateGiftCoupon(arg.getSource()).giftCoupon(arg);
				result.put(CouponGiftModeEnum.推广, data);
				break;
			case 券包码兑换:
				arg = createArg(CouponGiftModeEnum.券码兑换,null,customerId,exchangeCode,null);
				data = CreateGiftCoupon(arg.getSource()).giftCoupon(arg);
				result.put(CouponGiftModeEnum.券码兑换, data);
				break;
			case 系统定时赠送:
				//定时赠送
				arg = createArg(CouponGiftModeEnum.企业会员按时间赠,null,customerId,null,null);
				data = CreateGiftCoupon(arg.getSource()).giftCoupon(arg);
				result.put(CouponGiftModeEnum.企业会员按时间赠, data);
				break;
			default:
				break;
		}
		
		return result;
	}
	
	public MessageResult batchSendGoupon(List<Integer> lstCustomerId,Integer packageId,Integer opLogId){
		return CreateGiftCoupon(CouponGiftModeEnum.系统录入).batchSendGoupon(lstCustomerId, packageId,opLogId);
	}
	
	private GiftCouponArg createArg(CouponGiftModeEnum source,Integer sourceId,Integer customerId,String exchangeCode,Integer orderId){
		GiftCouponArg arg = new GiftCouponArg();
		arg.setSource(source);
		if(sourceId == null){
			arg.setSourceId(arg.getSource().getValue());
		}else{
			arg.setSourceId(sourceId);
		}
		arg.setTargetCustomerId(customerId);
		arg.setExchangeCode(exchangeCode);
		arg.setOrderId(orderId);
		return arg;
	}
	
	private String getInvitationCode(Integer customerId){
		Customer invitee = customerRemoteService.selectByPrimaryKey(customerId);
		return invitee.getRecommendcode();
		
	}
	
	private IGiftCouponService CreateGiftCoupon(CouponGiftModeEnum mode){
		IGiftCouponService service = null;

		switch(mode){
			case 注册用户赠:
				service = SpringContextUtil.getBean(GiftCouponByRegisterImpl.class);
				break;
			case 邀请好友赠:
				service = SpringContextUtil.getBean(GiftCouponByInviteImpl.class);
				break;
			case 手动兑换邀请码:
				service = SpringContextUtil.getBean(GiftCouponByExchangeInviteImpl.class);
				break;
			case 订单满额赠:
				service = SpringContextUtil.getBean(GiftCouponByOrderCostImpl.class);
				break;
			case 首次用车结单赠:
				service = SpringContextUtil.getBean(GiftCouponByFirstOrderImpl.class);
				break;
			case 首次成为企业用户赠:
				service = SpringContextUtil.getBean(GiftCouponByFirstEntMemberImple.class);
				break;
			case 企业会员按时间赠:
				service = SpringContextUtil.getBean(GiftCouponByEntMemberTimerImpl.class);
				break;
			case 系统录入:
				service = SpringContextUtil.getBean(GiftCouponByBatchSendImpl.class);
				break;
			case 渠道:
				service = SpringContextUtil.getBean(GiftCouponByChannelImpl.class);
				break;
			case 推广:
				service = SpringContextUtil.getBean(GiftCouponByPromotionImpl.class);
				break;
			case 券码兑换:
				service = SpringContextUtil.getBean(GiftCouponByExchangeActivityImpl.class);
				break;
		}
		
		return service;
	}
}
