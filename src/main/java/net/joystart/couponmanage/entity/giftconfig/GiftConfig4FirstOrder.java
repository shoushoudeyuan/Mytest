package net.joystart.couponmanage.entity.giftconfig;

import lombok.Data;
import net.joystart.order.enums.OrderStatus;

@Data
public class GiftConfig4FirstOrder extends CouponGiftConfig {

	/*
	 * 20 首次订单还车成功待支付状态
	 * 50首次订单还车成功已支付状态
	 */
	private Integer orderStatus;
	
	
	private Boolean checkFirstOrderMileage;
	
	/*
	 * 首次用车行程 公里	
	 */
	private Integer firstOrderMileage;
}
