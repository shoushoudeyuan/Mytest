package net.joystart.coupon.service;

import java.util.List;
import java.util.Map;

import net.joystart.advert.entity.Advertisement;
import net.joystart.coupon.entity.CouponRule;
import net.joystart.coupon.entity.CouponRuleItem;

public interface ICouponRuleService {
	List<CouponRule> getCouponRuleList(Map params);
	
	int getCount(Map params);
	
	CouponRule selectRuleByID(Integer Id);
	
	int insertRule(CouponRule rule);
	
	int updateRule(CouponRule rule);
	
	boolean IsExistName(Map params);
	
	boolean IsExistIdenfition(Map params);
	
	void deleteRule(int id);

	List<CouponRule> getCouponRuleKeyValueList();
	
	List<CouponRuleItem> getRuleDetailList(String identification);
	
	int insertRuleDetail(CouponRuleItem ruleDetail);
	
	int updateRuleDetail(CouponRuleItem ruleDetail);
	
	void deleteRuleDetail(int id);
	
	CouponRuleItem selectRuleDetailByID(Integer Id);

    List<Advertisement> getCouponRuleItemList(Map<String, Object> params);

    int getCouponRuleItemCount(Map<String, Object> params);

    int addCouponItem(CouponRuleItem ruleItem);

    int deleteCouponItem(List<String> idStrList);

    int updateCouponItem(CouponRuleItem ruleItem);

}
