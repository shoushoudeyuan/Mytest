package net.joystart.couponmanage.dao;

import java.util.List;
import java.util.Map;

import net.joystart.couponmanage.entity.CouponExchangeCode;

/**
 * 优惠券兑换码
* 
* @author zm.mu   
* @date 2018年5月31日 下午2:03:18
 */
public interface CouponExchangeCodeMapper {

	/**
	 * 获取兑换码列表
	 * @param paramMap
	 * @return
	 */
	List<CouponExchangeCode> getCouponExchangeCodeList(Map<String, Object> paramMap);

	/**
	 * 兑换码数量
	 * @param paramMap
	 * @return
	 */
	Integer getCouponExchangeCodeCount(Map<String, Object> paramMap);
	
	/**
	 * 检查优惠券兑换码是否有效存在
	 * @param paramMap
	 * @return
	 */
	CouponExchangeCode checkCouponExchangeCodeExist(Map<String, Object> paramMap);

	/**
	 * 批量添加兑换码
	 * @param list
	 * @return
	 */
	int addCouponExchangeCodeBatch(List<CouponExchangeCode> list);

	/**
	 * 编辑更新兑换码
	 * @return
	 */
	int updateCouponExchangeCode(CouponExchangeCode couponExchangeCode);

	/**
	 * 删除兑换码
	 * @return
	 */
	int deleteCouponExchangeCode(List<Integer> list);
	
	/**
	 * 根据兑换码获取实体
	 * @param paramMap
	 * @return
	 */
	CouponExchangeCode getValideCouponExchangeCodeByCode(Map<String, Object> paramMap);

	/**
	 * 获取导出券码列表
	 * @param paramMap
	 * @return
	 */
	List<CouponExchangeCode> getCouponExchangeCodeList4Export(Map<String, Object> paramMap);

}
