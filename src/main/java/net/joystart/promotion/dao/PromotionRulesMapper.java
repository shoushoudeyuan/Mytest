package net.joystart.promotion.dao;

import java.util.List;
import java.util.Map;

import net.joystart.promotion.entity.PromotionRules;

public interface PromotionRulesMapper {
   
	List<PromotionRules> list(Map param);
	int count(Map param);
	int insertRules(PromotionRules rules);
	int updateRules(PromotionRules rules);
	int deleteRules(List<String> param);
	PromotionRules selectRulesByUserName(String userName);
	
	PromotionRules selectRulesByParam(Map param);
	
}
