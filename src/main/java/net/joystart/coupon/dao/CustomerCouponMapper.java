package net.joystart.coupon.dao;

import java.util.List;
import java.util.Map;

import net.joystart.coupon.entity.CustomerCoupon;

public interface CustomerCouponMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(CustomerCoupon record);

    int insertSelective(CustomerCoupon record);

    CustomerCoupon selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(CustomerCoupon record);

    int updateByPrimaryKey(CustomerCoupon record);
    
    List<CustomerCoupon> selectAll(Map params);
    
    int selectCount(Map params);
    
    int getCountByCode(String couponCode);
    
    CustomerCoupon selectById(Integer couponId);
    
    /**
     * @Description E+互联
     * @author:  zhuwq
     * Create at: 2017年8月16日 下午4:37:08
     * @param params
     * @return
     */
    List<Map<String, Object>> geCouponList(Map params);
    /**
     * @Description E+互联
     * @author:  zhuwq
     * Create at: 2017年8月16日 下午4:37:08
     * @param params
     * @return
     */
    int geCouponListCount(Map params);
}