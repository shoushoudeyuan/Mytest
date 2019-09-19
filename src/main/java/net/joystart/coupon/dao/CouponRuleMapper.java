package net.joystart.coupon.dao;

import net.joystart.coupon.entity.CouponRule;

public interface CouponRuleMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(CouponRule record);

    int insertSelective(CouponRule record);

    CouponRule selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(CouponRule record);

    int updateByPrimaryKey(CouponRule record);
}