package net.joystart.couponmanage.remote.impl;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;

import com.alibaba.dubbo.config.annotation.Service;

import net.joystart.channel.entity.Channel;
import net.joystart.channel.service.IChannelService;
import net.joystart.common.util.MessageResult;
import net.joystart.couponmanage.enums.CouponGiftModeEnum;
import net.joystart.couponmanage.enums.CustomerBehaviorEnum;
import net.joystart.couponmanage.remote.service.IGiftCouponRemoteService;
import net.joystart.couponmanage.service.impl.GiftCouponContext;
import net.joystart.promotion.entity.PromotionPerson;
import net.joystart.promotion.service.IPromotionPersonService;

@Service(timeout=60000,retries=0,interfaceClass=IGiftCouponRemoteService.class)
public class GiftCouponRemoteServiceImpl implements IGiftCouponRemoteService{

	@Autowired
	private GiftCouponContext factory;
	
	@Autowired
	private IChannelService channelService;
	
	@Resource
	IPromotionPersonService promotionPersonService;
	
	@Override
	public Map<CouponGiftModeEnum, MessageResult> giftCoupon(CustomerBehaviorEnum behavior, Integer customerId) {
		return giftCoupon(behavior,customerId,"");
	}
	
	@Override
	public Map<CouponGiftModeEnum, MessageResult> giftCouponSync(CustomerBehaviorEnum behavior, Integer customerId) {
		return giftCoupon(behavior,customerId,"");
	}
	
	@Override
	public Map<CouponGiftModeEnum,MessageResult> giftCoupon(CustomerBehaviorEnum behavior,Integer customerId,String exchangeCode){
		return factory.giftCoupon(behavior, customerId, exchangeCode,null);
	}	
	
	@Override
	public Map<CouponGiftModeEnum,MessageResult> giftCoupon(CustomerBehaviorEnum behavior,Integer customerId,Integer orderId){
		return factory.giftCoupon(behavior, customerId, null,orderId);
	}

	@Override
	public String isChannelOrPromotion(String exChangeCode) {
		Channel channel = channelService.getChannelByChannelCode(exChangeCode);
		if(channel == null){
			PromotionPerson person = promotionPersonService.selectProPersonByChanneCode(exChangeCode);
			if(person==null){
				return null;
			}
			return "promotionCode";
		}else{
			return "channelCode";
		}
	}	
}
