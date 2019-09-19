package net.joystart.couponmanage.service;

import java.util.List;

import net.joystart.common.util.MessageResult;
import net.joystart.couponmanage.entity.GiftCouponArg;

public interface IGiftCouponService {

	MessageResult giftCoupon(GiftCouponArg arg);
	
	MessageResult batchSendGoupon(List<Integer> lstCustomerId,Integer packageId,Integer opLogId);
}
