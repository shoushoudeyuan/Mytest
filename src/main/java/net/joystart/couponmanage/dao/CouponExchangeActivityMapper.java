package net.joystart.couponmanage.dao;

import java.util.List;
import java.util.Map;

import net.joystart.couponmanage.entity.CouponExchangeActivity;

/**
 * 优惠券兑换活动
* 
* @author zm.mu   
* @date 2018年5月31日 下午2:03:18
 */
public interface CouponExchangeActivityMapper {

	/**
	 * 兑换活动列表
	 * @param paramMap
	 * @return
	 */
	List<CouponExchangeActivity> getCouponExchangeActivityList(Map<String, Object> paramMap);

	/**
	 * 兑换活动列表数量
	 * @param paramMap
	 * @return
	 */
	Integer getCouponExchangeActivityCount(Map<String, Object> paramMap);

	/**
	 * 创建兑换活动并生成券码
	 */
	int insertCouponExchangeActivity(CouponExchangeActivity activity);

	/**
	 * 编辑更新兑换活动
	 * @return
	 */
	int updateCouponExchangeActivity(CouponExchangeActivity activity);

	/**
	 * 删除兑换活动
	 * @return
	 */
	int deleteCouponExchangeActivity(List<Integer> list);

	/**
	 * 根据id获取兑换活动
	 * @param paramMap
	 * @return
	 */
	CouponExchangeActivity getCouponExchangeActivityById(Map<String, Object> paramMap);

}
