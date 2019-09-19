package net.joystart.promotion.remote.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.alibaba.dubbo.config.annotation.Service;

import net.joystart.promotion.dao.PromotionRulesMapper;
import net.joystart.promotion.entity.PromotionRules;
import net.joystart.promotion.remote.service.IPromotionRulesRemoteService;

/**
 *
 * @author 李大海
 * @create 2016年8月19日 下午3:25:56
 *
 */

@Service(timeout=60000,retries=0)
public class PromotionRulesRemoteServiceImpl implements IPromotionRulesRemoteService {

	@Resource
	PromotionRulesMapper promotionRulesMapper;

	/* (non-Javadoc)
	 * @see net.joystart.promotion.service.IPromotionRulesService#list(java.util.Map)
	 */
	@Override
	public List<PromotionRules> list(Map param) {
		return promotionRulesMapper.list(param);
	}

	/* (non-Javadoc)
	 * @see net.joystart.promotion.service.IPromotionRulesService#count(java.util.Map)
	 */
	@Override
	public int count(Map param) {
		return promotionRulesMapper.count(param);
	}

	/* (non-Javadoc)
	 * @see net.joystart.promotion.service.IPromotionRulesService#insertRules(net.joystart.promotion.entity.PromotionRules)
	 */
	@Override
	public int insertRules(PromotionRules rules) {
		return promotionRulesMapper.insertRules(rules);
	}

	/* (non-Javadoc)
	 * @see net.joystart.promotion.service.IPromotionRulesService#updateRules(net.joystart.promotion.entity.PromotionRules)
	 */
	@Override
	public int updateRules(PromotionRules rules) {
		return promotionRulesMapper.updateRules(rules);
	}

	/* (non-Javadoc)
	 * @see net.joystart.promotion.service.IPromotionRulesService#deleteRules(java.util.List)
	 */
	@Override
	public int deleteRules(List<String> param) {
		return promotionRulesMapper.deleteRules(param);
	}

	/* (non-Javadoc)
	 * @see net.joystart.promotion.service.IPromotionRulesService#selectRulesByUserName(java.lang.String)
	 */
	@Override
	public PromotionRules selectRulesByUserName(String userName) {
		return promotionRulesMapper.selectRulesByUserName(userName);
	}
	
	public PromotionRules selectRulesByParam(Map param)
	{
		return promotionRulesMapper.selectRulesByParam(param);
	}
	
}
