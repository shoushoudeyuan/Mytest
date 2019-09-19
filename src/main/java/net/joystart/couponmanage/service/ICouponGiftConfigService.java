package net.joystart.couponmanage.service;

import java.util.List;

import net.joystart.couponmanage.entity.giftconfig.AutoGiftConfig4EntMember;
import net.joystart.couponmanage.entity.giftconfig.CouponGiftConfig;
import net.joystart.couponmanage.entity.giftconfig.GiftConfig4FirstOrder;
import net.joystart.couponmanage.entity.giftconfig.GiftConfig4InviteFriends;
import net.joystart.couponmanage.entity.giftconfig.GiftConfig4OrderCost;
import net.joystart.couponmanage.entity.giftconfig.GiftConfig4RegisterEntMember;
import net.joystart.couponmanage.entity.giftconfig.GiftConfig4UserRegister;
import net.joystart.couponmanage.enums.CouponGiftModeEnum;

public interface ICouponGiftConfigService {

	Boolean saveGiftConfig4UserRegister(GiftConfig4UserRegister config);
	
	List<CouponGiftConfig> selectByRuleName(String name);
	
	<T extends CouponGiftConfig> T selectByEnumCode(CouponGiftModeEnum mode,Class<T> e) throws InstantiationException, IllegalAccessException ;

	Boolean saveGiftConfig4InviteFriends(GiftConfig4InviteFriends config);

	Boolean saveGiftConfig4OrderCost(GiftConfig4OrderCost config);

	Boolean saveGiftConfig4FirstOrder(GiftConfig4FirstOrder config);

	Boolean saveGiftConfig4RegisterEntMember(GiftConfig4RegisterEntMember config);

	Boolean saveAutoGiftConfig4RegisterEntMember(AutoGiftConfig4EntMember config);
}
