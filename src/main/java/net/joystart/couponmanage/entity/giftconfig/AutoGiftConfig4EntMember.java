package net.joystart.couponmanage.entity.giftconfig;

import java.util.List;

import lombok.Data;

@Data
public class AutoGiftConfig4EntMember extends CouponGiftConfig {

	/*
	 * 选择定时推送优惠卷的企业名单
	 */
	private List<Integer> companyId; 
	
	/*
	 * 发送优惠券日期列表，只到天
	 */
	private List<String> autoSendDate;
}
