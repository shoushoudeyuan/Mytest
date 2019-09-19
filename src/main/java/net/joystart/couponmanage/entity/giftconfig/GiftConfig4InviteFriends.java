package net.joystart.couponmanage.entity.giftconfig;

import lombok.Data;

@Data
public class GiftConfig4InviteFriends extends CouponGiftConfig {

	/****************************被邀请人获得优惠券条件***********************/
	/*
	 * 被邀请人注册成功并兑换邀请码绑定关系
	 */
	private Boolean inviteeRegistedAndUseInviteCode4Invitee;
	
	/*
	 * 被邀请人身份认证成功
	 */
	private Boolean inviteeIdentified4Invitee;
	
	/*
	 * 被邀请人缴纳保证金成功
	 */
	private Boolean inviteePayDeposit4Invitee;
	
	
	
	/****************************邀请人获得优惠券条件***********************/
	/*
	 * 被邀请人身份认证成功
	 */
	private Boolean inviteeIdentified4Inviter;
	
	/*
	 * 被邀请人缴纳保证金成功
	 */
	private Boolean inviteePayDeposit4Inviter;
	
	/*
	 * 被邀请人首次用车并订单支付成功
	 */
	private Boolean inviteeFirstRentCarAndPayment4Inviter;
	
	/*
	 * 被邀请人首次用车行驶里程
	 */
	private Integer inviteeFirstDriverMileage4Inviter;
}
