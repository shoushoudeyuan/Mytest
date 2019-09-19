package net.joystart.promotion.dao;

import net.joystart.promotion.entity.PromotionPerformance;

public interface PromotionPerformanceMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(PromotionPerformance record);

    int insertSelective(PromotionPerformance record);

    PromotionPerformance selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(PromotionPerformance record);

    int updateByPrimaryKey(PromotionPerformance record);
}