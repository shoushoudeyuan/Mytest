package net.joystart.coupon.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import net.joystart.coupon.dao.SharePlanMapper;
import net.joystart.coupon.entity.SharePlan;
import net.joystart.coupon.service.ISharePlanService;
import net.joystart.customer.entity.Customer;

@Service("sharePlanService")
public class SharePlanServiceImpl implements ISharePlanService {
	@Resource
	SharePlanMapper sharePlanMapper;
	
	
	@Override
	public List<SharePlan> getSharePlanList(Map params) {
		
		return sharePlanMapper.getSharePlanList(params);
	}


	@Override
	public Customer getCustomerByUserName(Customer cus) {
		
		return sharePlanMapper.getCustomerByUserName(cus);
	}


	@Override
	public int insertSelective(SharePlan record) {
		
		return sharePlanMapper.insertSelective(record);
		
	}


	@Override
	public int updateByPrimaryKeySelective(SharePlan record) {
		
		return sharePlanMapper.updateByPrimaryKeySelective(record);
	}


	@Override
	public int deleteByPrimaryKey(Integer id) {
		return sharePlanMapper.deleteByPrimaryKey(id);
	}


	@Override
	public int getSharePlanListCount(Map params) {
		return sharePlanMapper.getSharePlanListCount(params);
	}

}
