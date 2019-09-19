package net.joystart.couponmanage.dao;

import java.util.List;
import java.util.Map;

import net.joystart.couponmanage.entity.CouponUseConfig;
import net.joystart.couponmanage.entity.CustomerCouponNew;
import net.joystart.couponmanage.entity.CustomerCouponNewVO;

public interface CustomerCouponNewMapper {
    
	/**
	 * 列表
	 * @param paramMap
	 * @return
	 */
	List<CustomerCouponNewVO> getCustomerCouponNewList(Map<String, Object> paramMap);
	
	
	List<CustomerCouponNewVO> selectHistoryCoupon(Map<String, Object> paramMap);
	
	CustomerCouponNewVO getCustomerCouponNewVOByCouponId(Integer couponId);

	/**
	 * 列表数量
	 * @param paramMap
	 * @returns
	 */
	Integer getCustomerCouponNewCount(Map<String, Object> paramMap);
	
	/**
	 * 编辑更新
	 * @return
	 */
	Integer updateCustomerCouponNew(CustomerCouponNew customerCouponNew);
	
	/**
	 * 更新用户的优惠券已使用
	 * @param couponId
	 * @return
	 */
	Integer updateCustomerCouponNewIsUsed(Integer couponId);
	
	/**
	 * 删除
	 * @return
	 */
	Integer deleteCustomerCouponNew(List<Integer> idList);
	
	/**
	 * 批量添加优惠券
	 */
	int insert(List<CustomerCouponNew> lstCoupon);

	/**
	 * 查找优惠券
	 * @param id
	 * @return
	 */
    CustomerCouponNew selectById(Integer id);
    
    /**
     * 按订单Id查找优惠券
     * @param orderId
     * @return
     */
    CustomerCouponNewVO selectByOrderId(Integer orderId);
    
    /**
     * 判断优惠券编码是否存在
     * @param couponCode
     * @return
     */
    int getCouponCodeIsExists(String couponCode);
    
    /**
     * 获取用户某一张优惠券的使用配置信息
     * @param id 优惠券与客户绑定关系的id
     * @return
     */
    CouponUseConfig selectCustomerCouponConfig(Integer id);
}