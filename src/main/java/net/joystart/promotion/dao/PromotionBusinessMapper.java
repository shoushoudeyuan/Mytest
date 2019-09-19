package net.joystart.promotion.dao;

import java.util.List;
import java.util.Map;

import net.joystart.promotion.entity.PromotionBusiness;

public interface PromotionBusinessMapper 
{
	List<PromotionBusiness> list(Map param);
	
	int count(Map param);
	
	int insertBusiness(PromotionBusiness business);
	int updateBusiness(PromotionBusiness business);
	int deleteBusiness(List<String> param);
	/**
	 * 根据userid删除推广商
	 * @param param
	 * @return
	 */
	int deleteBusinessByUserId(List<Object> param);
	PromotionBusiness selectBusinessByUserName(String userName);
	PromotionBusiness login(Map param);
	PromotionBusiness selectBusinessByPersonId(Integer personId);
	
	int updateCouponPackageId(Map<String,Object> param);
}