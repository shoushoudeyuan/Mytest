package net.joystart.coupon.dao;

import java.util.List;
import java.util.Map;

import net.joystart.coupon.entity.Coupon;
import net.joystart.coupon.entity.CouponOld;

public interface CouponMapper {
	/**
	 * 添加优惠券
	 * @param coupon
	 * @return
	 */
	int insert(Coupon coupon);
	
    
    /**
     * 根据动态参数查询兑换券
     * @param params
     * @return
     */
    List<Coupon> list(Map params);
    
    List<CouponOld> listOld(Map params);
    
    /**
     * 根据动态参数更新优惠券
     * @param params
     * @return
     */
    Integer update(Coupon coupon);
	
    /**
     *  
     * @param code
     * @return
     */
    Integer getCountByCode(String code);
    
    /**
     *  根据订单ID获取优惠券
     * @param orderId
     * @return
     */
    Coupon getCouponByOrderId(Integer orderId);
    
    /**
     * 查询某用户历史优惠券
     * @param customerId
     * @return
     */
    List<Coupon> historyCoupon(Map<String, Object> params);
}