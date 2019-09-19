package net.joystart.couponmanage.entity.giftconfig;

import lombok.Data;

@Data
public class GiftConfig4RegisterEntMember extends CouponGiftConfig{

	/*
	 * 首次成为企业会员
	 */
	private Boolean registerEntMember;
	
	/*
	 * 企业会员首次用车行程
	 */
	private Boolean firstOrderAndPayment;
	
	/*
	 * 行车里程 公里
	 */
	private Integer firstOrderMileage;
}
