package net.joystart.setting.dao;

import java.util.List;
import java.util.Map;

import net.joystart.setting.entity.ScoreRuleSet;

public interface ScoreRuleSetMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(ScoreRuleSet record);

    int insertSelective(ScoreRuleSet record);

    ScoreRuleSet selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ScoreRuleSet record);

    int updateByPrimaryKey(ScoreRuleSet record);
    
    List<ScoreRuleSet> selectAll(Map params);
    
    int selectCount(Map params);
    
    ScoreRuleSet selectBySengType(Integer sendType);
}