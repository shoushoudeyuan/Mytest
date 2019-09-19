package net.joystart.coupon.dao;



import java.util.List;

import net.joystart.coupon.entity.CouponRuleDetail;
import net.joystart.coupon.entity.RuleItem;

public interface CouponRuleDetailMapper {
	int deleteByPrimaryKey(Integer id);

    int insert(CouponRuleDetail record);

    int insertSelective(CouponRuleDetail record);

    CouponRuleDetail selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(CouponRuleDetail record);

    int updateByPrimaryKey(CouponRuleDetail record);
    
    List<CouponRuleDetail> selectByIdentification(String identification);
    
    List<CouponRuleDetail> selectValidCouponByIdentification(String Identification);
    
    CouponRuleDetail selectDetailById(CouponRuleDetail couponRuleDetail);
    
    List<RuleItem> getItemByInvitationCode(String invitationCode);
    
    List<CouponRuleDetail> getCouponItemByBusinessId(Integer businessId);
}