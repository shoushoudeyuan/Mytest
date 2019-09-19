package net.joystart.couponmanage.entity;

import lombok.Data;
import net.joystart.couponmanage.enums.CouponGiftModeEnum;

@Data
public class GiftCouponArg {

	/*
	 * 来源
	 */
	private CouponGiftModeEnum source;
	
	/*
	 * 来源Id
	 */
	private Integer sourceId;
	
	/*
	 * 目标用户ID
	 */
	private Integer targetCustomerId;
	
	/*
	 * 兑换码：渠道码，邀请码，推广码等
	 */
	private String exchangeCode; 
	
	/*
	 * 订单编号
	 */
	private Integer orderId;
}
