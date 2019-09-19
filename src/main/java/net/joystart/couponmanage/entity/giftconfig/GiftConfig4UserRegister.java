package net.joystart.couponmanage.entity.giftconfig;

import com.alibaba.fastjson.JSON;

import lombok.Data;

@Data
public class GiftConfig4UserRegister extends CouponGiftConfig {

	/*
	 * 注册成功
	 */
	private Boolean userRegistered;
	
	/*
	 * 认证成功
	 */
	private Boolean userIdentified;
	
	/*
	 * 缴纳保证金成功
	 */
	private Boolean payDeposit;
	
}
