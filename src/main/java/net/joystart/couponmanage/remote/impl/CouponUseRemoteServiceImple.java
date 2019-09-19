package net.joystart.couponmanage.remote.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.dubbo.config.annotation.Service;

import net.joystart.common.jta.IJTAFunction;
import net.joystart.common.jta.JTAServiceExcutor;
import net.joystart.common.jta.JTATransactional;
import net.joystart.coupon.entity.Coupon;
import net.joystart.coupon.entity.CustomerCoupon;
import net.joystart.couponmanage.remote.service.ICouponUseRemoteService;
import net.joystart.couponmanage.service.impl.CouponUseService;

@Service(timeout=60000,retries=0,interfaceClass=ICouponUseRemoteService.class)
public class CouponUseRemoteServiceImple  implements ICouponUseRemoteService{

	@Autowired
	private CouponUseService svcCouponUser;
	
	@Resource
	RedisTemplate<String, Object> redisTemplate;
	
	@Override
	public List<Coupon> CouponList(Integer customerId) {
		return svcCouponUser.CouponList(customerId);
	}
	
	@Override
	public List<Coupon> CouponList(Integer customerId,Integer orderId){
		return svcCouponUser.CouponList(customerId,orderId);
	}
	
	@Override
	public List<Coupon> historyCoupon(Integer customerId,Integer pageSize,Integer pageNumber){
		return svcCouponUser.historyCoupon(customerId, pageSize, pageNumber);
	}
	
	@Override
	public CustomerCoupon getCouponById(Integer couponId){
		CustomerCoupon coupon = svcCouponUser.getCouponById(couponId);
		return coupon;
	}
	
	@Override
	public Coupon getCouponByOrderId(Integer orderId){
		return svcCouponUser.getCouponByOrderId(orderId);
	}
	
	@JTATransactional
	@Transactional(isolation=Isolation.READ_UNCOMMITTED)
	@Override
	public Integer setNewCouponIsUsed(Coupon coupon){
		Object result = JTAServiceExcutor.handle(new IJTAFunction() {
			@Override
			public Object execute() {
				return svcCouponUser.setCustomerCouponIsUsed(coupon);
			}
		}, redisTemplate);
		return (Integer) result;
		
	}

	@Override
	public boolean getIfCanUseCouponByRule(Integer couponId, Integer orderId) {
		return svcCouponUser.getIfCanUseCouponByRule(couponId, orderId);
	}
	

}
