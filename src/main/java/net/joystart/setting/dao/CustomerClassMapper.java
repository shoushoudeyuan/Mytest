package net.joystart.setting.dao;

import java.util.List;
import java.util.Map;

import net.joystart.setting.entity.BaseInsurance;
import net.joystart.setting.entity.CustomerClass;

public interface CustomerClassMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(CustomerClass record);

    int insertSelective(CustomerClass record);

    CustomerClass selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(CustomerClass record);

    int updateByPrimaryKey(CustomerClass record);
    
    List<CustomerClass> getAuditSettingList(Map params);
    
    int getAuditSettingCount(Map params);
    
    CustomerClass selectByName(Map params);
}