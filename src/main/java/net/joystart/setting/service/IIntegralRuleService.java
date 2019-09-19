package net.joystart.setting.service;

import java.util.List;
import java.util.Map;

import net.joystart.setting.entity.ScoreRuleSet;

public interface IIntegralRuleService {

	List<ScoreRuleSet> getIntegralRuleInfo(Map params);
	
	int getIntegralCount(Map params);
	
	ScoreRuleSet getIntegralById(Integer id);
	
	int updateIntegralRule(ScoreRuleSet rule);
	
	ScoreRuleSet getIntegralBySentType(Integer sendType);
}
