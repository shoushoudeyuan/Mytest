package net.joystart.coupon.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import net.joystart.activity.dao.ActivitiesMapper;
import net.joystart.activity.entity.Activities;
import net.joystart.coupon.dao.CouponRuleItemMapper;
import net.joystart.coupon.dao.Coupon_RuleMapper;
import net.joystart.coupon.entity.CouponRule;
import net.joystart.coupon.entity.CouponRuleItem;
import net.joystart.coupon.service.ICouponRuleService;
import net.joystart.advert.entity.Advertisement;

@Service("coupon_RuleService")
public class CouponRuleServiceImpl implements ICouponRuleService {

	@Resource
	Coupon_RuleMapper coupon_RuleMapper;

	@Resource
	CouponRuleItemMapper couponRuleItemMapper;

	@Resource
	ActivitiesMapper activitiesMapper;

	public List<CouponRule> getCouponRuleList(Map params) {
		return this.coupon_RuleMapper.selectAll(params);
	}

	public int getCount(Map params) {
		return this.coupon_RuleMapper.selectAllCount(params);
	}

	public CouponRule selectRuleByID(Integer Id) {
		return this.coupon_RuleMapper.selectByPrimaryKey(Id);
	}

	public int insertRule(CouponRule rule) {
		rule.setIssystem(0);
		rule.setIsdelete(0);
		rule.setCreatedate(new Date());
		return this.coupon_RuleMapper.insertSelective(rule);
	}

	public int updateRule(CouponRule rule) {
		return this.coupon_RuleMapper.updateByPrimaryKeySelective(rule);
	}

	public boolean IsExistName(Map params) {
		CouponRule coupon = this.coupon_RuleMapper.selectByName(params);

		if (coupon == null)
			return true;
		else {
			return false;
		}
	}

	public boolean IsExistIdenfition(Map params) {
		CouponRule coupon = this.coupon_RuleMapper.selectByIdenfition(params);

		if (coupon == null)
			return true;
		else {
			return false;
		}
	}

	public void deleteRule(int id) {
		Activities activities = this.activitiesMapper.getActivityByRuleID(id);

		if (activities == null) {
			CouponRule coupon = new CouponRule();
			coupon.setId(id);
			coupon.setIsdelete(1);

			this.coupon_RuleMapper.updateByPrimaryKeySelective(coupon);
		}
	}

	@Override
	public List<CouponRule> getCouponRuleKeyValueList() {
		return coupon_RuleMapper.getCouponRuleKeyValueList();
	}

	public List<CouponRuleItem> getRuleDetailList(String identification) {
		return this.couponRuleItemMapper.selectByIdentification(identification);
	}

	public int insertRuleDetail(CouponRuleItem ruleDetail) {
		ruleDetail.setCreatedate(new Date());
		return this.couponRuleItemMapper.insertSelective(ruleDetail);
	}

	public int updateRuleDetail(CouponRuleItem ruleDetail) {
		return this.couponRuleItemMapper.updateByPrimaryKeySelective(ruleDetail);
	}

	public void deleteRuleDetail(int id) {
		this.couponRuleItemMapper.deleteByPrimaryKey(id);
	}

	public CouponRuleItem selectRuleDetailByID(Integer Id) {
		return this.couponRuleItemMapper.selectByPrimaryKey(Id);
	}

	@Override
	public List<Advertisement> getCouponRuleItemList(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return this.couponRuleItemMapper.getCouponRuleItemList(params);
	}

	@Override
	public int getCouponRuleItemCount(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return this.couponRuleItemMapper.getCouponRuleItemCount(params);
	}

	@Override
	public int addCouponItem(CouponRuleItem ruleItem) {
		// TODO Auto-generated method stub
		return this.couponRuleItemMapper.addCouponItem(ruleItem);
	}

	@Override
	public int deleteCouponItem(List<String> idStrList) {
		// TODO Auto-generated method stub
		return this.couponRuleItemMapper.deleteCouponItem(idStrList);
	}

	@Override
	public int updateCouponItem(CouponRuleItem ruleItem) {
		// TODO Auto-generated method stub
		return this.couponRuleItemMapper.updateCouponItem(ruleItem);
	}

}
