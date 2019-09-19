package net.joystart.setting.service;

import java.util.List;
import java.util.Map;

import net.joystart.setting.entity.BaseMessageTemplate;

public interface IBaseMessageTemplateService {

	List<BaseMessageTemplate>  getMessageTemplateList(Map params);
	
	int getMessageTemplateListCount(Map params);
	
	int insertSelective(BaseMessageTemplate record);
	 
	int updateByPrimaryKeySelective(BaseMessageTemplate record);
	
	int getMessageTemplateCountByIdentification(Map params);
}
