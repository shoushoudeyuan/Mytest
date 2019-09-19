package net.joystart.coupon.service;

import java.util.List;
import java.util.Map;

import net.joystart.coupon.entity.SharePlan;
import net.joystart.customer.entity.Customer;

public interface ISharePlanService {
	
	List<SharePlan>  getSharePlanList(Map params);
	
	Customer getCustomerByUserName(Customer cus);
	
	int insertSelective(SharePlan record);
	
	int updateByPrimaryKeySelective(SharePlan record);
	
	int deleteByPrimaryKey(Integer id);
	
	int getSharePlanListCount(Map params);
}
