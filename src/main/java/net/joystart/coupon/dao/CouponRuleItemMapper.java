package net.joystart.coupon.dao;

import java.util.List;
import java.util.Map;

import net.joystart.coupon.entity.CouponRuleItem;
import net.joystart.advert.entity.Advertisement;

public interface CouponRuleItemMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(CouponRuleItem record);

    int insertSelective(CouponRuleItem record);

    CouponRuleItem selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(CouponRuleItem record);

    int updateByPrimaryKey(CouponRuleItem record);
    
    List<CouponRuleItem> selectByIdentification(String identification);

    List<Advertisement> getCouponRuleItemList(Map<String, Object> params);

    int getCouponRuleItemCount(Map<String, Object> params);

    int addCouponItem(CouponRuleItem ruleItem);

    int deleteCouponItem(List<String> idStrList);

    int updateCouponItem(CouponRuleItem ruleItem);

}