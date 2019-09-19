package net.joystart.setting.dao;

import java.util.List;
import java.util.Map;

import net.joystart.setting.entity.BaseMessageTemplate;

public interface BaseMessageTemplateMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(BaseMessageTemplate record);

    int insertSelective(BaseMessageTemplate record);

    BaseMessageTemplate selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(BaseMessageTemplate record);

    int updateByPrimaryKey(BaseMessageTemplate record);
    
    List<BaseMessageTemplate>  getMessageTemplateList(Map params);
    
    int getMessageTemplateListCount(Map params);
    
    int getMessageTemplateCountByIdentification(Map params);
    
    BaseMessageTemplate selectTitleAndContentByIdentification(String Identification);
}