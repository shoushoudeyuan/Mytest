package net.joystart.couponmanage.entity.giftconfig;

import lombok.Data;

@Data
public class GiftConfig4OrderCost extends CouponGiftConfig{

	/*
	 * 1 按订单应付金额 2按订单实付金额
	 */
	private Integer costMode;

	/*
	 * 是否按订单金额赠送并支付成功
	 */
	private Boolean giftByPaymentOrderCost;
	
	/*
	 * 金额值
	 */
	private Double orderCost;
}
