package net.joystart.couponmanage.service;

import java.util.List;

import net.joystart.couponmanage.entity.CouponUseConfig;
import net.joystart.couponmanage.enums.CouponTypeEnum;

public interface ICouponUseConfigService {

	boolean saveCouponUseConfig(CouponUseConfig couponRuleConfig);
	
	boolean enableCouponUseConfig(Integer id);
	
	boolean disableCouponUseConfig(Integer id);
	
	int deleteCouponUseConfig(List<Integer> ids);
	
	CouponUseConfig getCouponUseConfig(Integer id);
	
	List<CouponUseConfig> selectCouponUseConfig(Integer pageIndex,Integer pageSize, String configName,CouponTypeEnum couponType,Integer isValidate);
	
	Integer selectCouponUseConfigCount(String configName,CouponTypeEnum couponType,Integer isValidate);
	
	List<String> selectCouponNameList();
	
}
