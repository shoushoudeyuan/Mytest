package net.joystart.couponmanage.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import net.joystart.couponmanage.entity.CouponUseConfig;

public interface CouponUseConfigMapper {

	int insertSelective(CouponUseConfig record);
	
    CouponUseConfig selectById(Integer id);

    int updateByIdSelective(CouponUseConfig coupnRuleConfig);
    
    List<CouponUseConfig> selectCouponUseConfig(Map<String,Object> params);
    
    Integer selectCouponUseConfigCount(Map<String,Object> params);

	int updateCouponState(CouponUseConfig rule);

	int deleteCouponUseConfig(@Param ("ids") List<Integer> ids);
	
	List<String> selectCouponNameList();
}
