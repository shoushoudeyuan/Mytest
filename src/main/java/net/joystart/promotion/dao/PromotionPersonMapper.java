package net.joystart.promotion.dao;

import java.util.List;
import java.util.Map;

import net.joystart.promotion.entity.PromotionPerson;

public interface PromotionPersonMapper {
    
	List<PromotionPerson> list(Map param);
	int count(Map param);
	int insertPerson(PromotionPerson business);
	int updatePerson(PromotionPerson business);
	int deletePerson(List<String> param);
	PromotionPerson selectPersonByUserName(String userName);
	
	
	List<Map<String, Object>> getPerformanceList(Map<String, Object> param);
	int performanceCount(Map param);
	
	PromotionPerson selectPersonByCustomerId(Integer customerId);
	
	PromotionPerson selectPersonByBindCustomerId(Integer customerId);
	
	PromotionPerson selectPersonById(Integer id);
	
	/**
	 * 根据渠道码获取推广人员信息
	 * @param channelCode
	 * @return PromotionPerson
	 * @author 刘诗越
	 * @date 2017年9月9日
	 */
	PromotionPerson selectByChanneCode(String channelCode);
	/**
     * 根据渠道码获取推广人员信息--关联PromotionBusiness表是否删除
     * @param channelCode
     * @return PromotionPerson
     * @author 刘诗越
     * @date 2017年9月9日
     */
    PromotionPerson selectProPersonByChanneCode(String channelCode);
}