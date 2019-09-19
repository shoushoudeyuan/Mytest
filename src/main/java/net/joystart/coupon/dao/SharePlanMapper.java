package net.joystart.coupon.dao;

import java.util.List;
import java.util.Map;

import net.joystart.coupon.entity.SharePlan;
import net.joystart.customer.entity.Customer;

public interface SharePlanMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(SharePlan record);

    int insertSelective(SharePlan record);

    SharePlan selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(SharePlan record);

    int updateByPrimaryKey(SharePlan record);
    
    List<SharePlan>  getSharePlanList(Map params);
    
    Customer getCustomerByUserName(Customer cus);
    
    int getSharePlanListCount(Map params);
}