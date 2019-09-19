package net.joystart.coupon.service;

import java.util.List;
import java.util.Map;

import net.joystart.coupon.entity.Coupon;
import net.joystart.coupon.entity.CustomerCoupon;
import net.joystart.invoice.entity.CustomerInvoice;

public interface ICustomerCouponService {
	List<CustomerCoupon> getCustomerCouponList(Map params);
	
	int getCount(Map params);
	
	int deleteCustomerCoupon(Integer id,Integer sysId);
	
	int updateCustomerCoupon(CustomerCoupon rule);
	
	int insertCustomerCoupon(CustomerCoupon coupon);
	
	CustomerCoupon selectCustomerCoupon(Integer id);
	
	int insertLotCoupon(CustomerCoupon coupon);
	
	List<CustomerInvoice> getInvoiceList(Map params);
	
	int getInvoiceCount(Map params);
	
	int updateInvoiceStatus(Integer id);
	
	void presentCoupon(Integer customerId);
	
	int insertCoupon(Coupon record);
	
	CustomerCoupon selectByPrimaryKey(Integer couponId);
}
