package net.joystart.setting.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import net.joystart.setting.dao.ScoreRuleSetMapper;
import net.joystart.setting.entity.ScoreRuleSet;
import net.joystart.setting.service.IIntegralRuleService;

@Service("integralRuleService")
public class IntegralRuleServiceImpl implements IIntegralRuleService {

	@Resource
	ScoreRuleSetMapper scoreRuleSetMapper;
	
	public List<ScoreRuleSet> getIntegralRuleInfo(Map params)
	{
		return this.scoreRuleSetMapper.selectAll(params);
	}
	
	public int getIntegralCount(Map params)
	{
		return this.scoreRuleSetMapper.selectCount(params);
	}
	
	public ScoreRuleSet getIntegralById(Integer id)
	{
		return this.scoreRuleSetMapper.selectByPrimaryKey(id);
	}
	
	public int updateIntegralRule(ScoreRuleSet rule)
	{
		return this.scoreRuleSetMapper.updateByPrimaryKeySelective(rule);
	}
	
	public ScoreRuleSet getIntegralBySentType(Integer sendType)
	{
		return this.scoreRuleSetMapper.selectBySengType(sendType);
	}
}
