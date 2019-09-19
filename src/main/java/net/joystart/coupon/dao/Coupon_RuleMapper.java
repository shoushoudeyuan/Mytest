package net.joystart.coupon.dao;

import java.util.List;
import java.util.Map;

import net.joystart.coupon.entity.CouponRule;

public interface Coupon_RuleMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(CouponRule record);

    int insertSelective(CouponRule record);

    CouponRule selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(CouponRule record);

    int updateByPrimaryKey(CouponRule record);
    
    List<CouponRule> selectAll(Map<String, Object> params);
    
    int selectAllCount(Map<String, Object> params);
    
    CouponRule selectByName(Map<String, Object> params);
    
    CouponRule selectByIdenfition(Map<String, Object> params);

	List<CouponRule> getCouponRuleKeyValueList();
}