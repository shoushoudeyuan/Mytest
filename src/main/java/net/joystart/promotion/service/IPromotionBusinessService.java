package net.joystart.promotion.service;

import java.util.List;
import java.util.Map;

import net.joystart.promotion.entity.PromotionBusiness;
import net.joystart.system.entity.SysUser;

/**
 *
 * @author 李大海
 * @create 2016年8月19日 下午2:30:25
 *
 */
public interface IPromotionBusinessService {
	
	List<PromotionBusiness> list(Map param);
	int count(Map param);
	int insertBusiness(PromotionBusiness business,SysUser user);
	int updateBusiness(PromotionBusiness business,SysUser user);
	int deleteBusiness(List<String> param);
	PromotionBusiness selectBusinessByUserName(String userName);
	/**
	 * 根据推广人员ID，查询推广商家
	 * @param personId
	 * @return
	 */
	PromotionBusiness selectBusinessByPersonId(Integer personId);
	PromotionBusiness login(Map param);
	int updateCouponPackageId(Integer businessId, Integer packageId);

}
