package net.joystart.coupon.dao;

import java.util.List;

import net.joystart.coupon.entity.Activity;
import net.joystart.coupon.entity.RedpacketRuledetail;

public interface RedpacketRuledetailMapper {

	List<RedpacketRuledetail> selectByActivityID(Activity activity);

}