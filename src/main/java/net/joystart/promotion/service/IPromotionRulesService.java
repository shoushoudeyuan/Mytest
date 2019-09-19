package net.joystart.promotion.service;

import java.util.List;
import java.util.Map;

import net.joystart.promotion.entity.PromotionRules;

/**
 *
 * @author 李大海
 * @create 2016年8月19日 下午2:30:25
 *
 */
public interface IPromotionRulesService {
	
	List<PromotionRules> list(Map param);
	int count(Map param);
	int insertRules(PromotionRules rules);
	int updateRules(PromotionRules rules);
	int deleteRules(List<String> param);
	PromotionRules selectRulesByUserName(String userName);
	/**
	 *  
	 * @param  businessId 推广商家ID, customerCreateDate 用户创建时间
	 * @return
	 */
	PromotionRules selectRulesByParam(Map param);
}
