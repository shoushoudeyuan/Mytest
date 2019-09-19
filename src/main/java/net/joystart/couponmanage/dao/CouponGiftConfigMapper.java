package net.joystart.couponmanage.dao;

import java.util.List;

import net.joystart.couponmanage.entity.giftconfig.CouponGiftConfig;

public interface CouponGiftConfigMapper {
    
	int updateByIdSelective(CouponGiftConfig config);

	List<CouponGiftConfig> selectAll();
	
	List<CouponGiftConfig> selectByRuleName(String ruleName);
	
	CouponGiftConfig selectById(Integer id);
	
	CouponGiftConfig selectByEnumCode(Integer mode);
}