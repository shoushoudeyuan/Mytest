package net.joystart.couponmanage.service;

import java.util.List;
import java.util.Map;

import net.joystart.couponmanage.entity.CustomerCouponNew;
import net.joystart.couponmanage.entity.CustomerCouponNewVO;

/**
 * 
* 优惠券service
* @author zm.mu   
* @date 2018年5月31日 下午2:01:22
 */
public interface ICustomerCouponNewService {

	/**
	 * 列表
	 * @param paramMap
	 * @return
	 */
	List<CustomerCouponNewVO> getCustomerCouponNewList(Map<String, Object> paramMap);

	/**
	 * 列表数量
	 * @param paramMap
	 * @returns
	 */
	Integer getCustomerCouponNewCount(Map<String, Object> paramMap);
	
	/**
	 * 批量添加优惠券
	 */
	int addCustomerCouponNewBatch(List<CustomerCouponNew> customerCouponNew);
	
	/**
	 * 编辑更新
	 * @return
	 */
	Integer updateCustomerCouponNew(CustomerCouponNew customerCouponNew);
	
	/**
	 * 删除
	 * @return
	 */
	Integer deleteCustomerCouponNew(List<Integer> idList);
	
	/**
	 * 查找优惠券
	 * @param id
	 * @return
	 */
    CustomerCouponNew selectById(Integer id);
    
    /**
     * 判断优惠券编码是否存在
     * @param couponCode
     * @return
     */
    int getCouponCodeIsExists(String couponCode);

    /**
     * 更新优惠券为已使用
     * @param couponId
     * @return
     */
	Integer updateCustomerCouponNewIsUsed(Integer couponId);
	/**
	 * 查询优惠券及优惠券配置
	 * @param couponId
	 * @return
	 */
	CustomerCouponNewVO getCustomerCouponNewVOByCouponId(Integer couponId);
	
}
