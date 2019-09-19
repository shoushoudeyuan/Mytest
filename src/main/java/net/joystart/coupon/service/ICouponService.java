package net.joystart.coupon.service;

import java.util.List;
import java.util.Map;

import net.joystart.coupon.entity.Coupon;
import net.joystart.coupon.entity.CouponOld;

public interface ICouponService {

	List<Coupon> list(Map params);
	List<CouponOld> listOld(Map params);
	int insert(Coupon coupon);
	Integer update(Coupon coupon);
	Integer saveIntegralExchange(int customerid,int RuleDetailID,int count);
	Integer getCountByCode(String code);
	List<Coupon> historyCoupon(Map<String, Object> params);
}
