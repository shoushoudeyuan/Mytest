package net.joystart.couponmanage.dao;

import net.joystart.couponmanage.entity.CouponBatchOplog;

public interface CouponBatchOplogMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(CouponBatchOplog record);

    int insertSelective(CouponBatchOplog record);

    CouponBatchOplog selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(CouponBatchOplog record);

    int updateByPrimaryKey(CouponBatchOplog record);
}