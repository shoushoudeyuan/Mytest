package net.joystart.setting.service;

import java.util.List;
import java.util.Map;

import net.joystart.setting.entity.LimitCarNumber;
import net.joystart.setting.entity.LimitCarNumberSetting;

public interface ILimitCarNumberService
{
    List<Map<String, Object>> cityList();
    
    List<LimitCarNumber> limitCarNumberList(Map<String, Object> params);

    int getLimitCarNumberCount(Map<String, Object> params);

    int addLimitCarNumber(Map<String, Object> params);

    int deleteLimitCarNumber(Map<String, Object> params);

    int updateLimitCarNumber(Map<String, Object> params);

    List<LimitCarNumberSetting> limitCarNumberSettingList(
            Map<String, Object> params);

    int getLimitCarNumberSettingCount(Map<String, Object> params);

    int addLimitCarNumberSetting(Map<String, Object> params);

    int deleteLimitCarNumberSetting(Map<String, Object> params);

    int deleteLimitCarNumberSettings(List<String> params);

    int deleteLimitCarNumbers(List<String> params);
    
    int updateLimitCarNumberSetting(Map<String, Object> params);
    /**
     * @Description 限号规则查询
     * @author:  zhuwq
     * Create at: 2017年7月17日 下午1:56:55
     * @param params
     * @return
     */
    List<LimitCarNumber> getLimitCarNumberList(Map<String, Object> params);
    
    int selectLimitCarNumberCount(Map<String, Object> params);
    
    void vehicleLimitNumberTask();
}
