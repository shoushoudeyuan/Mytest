package net.joystart.setting.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.ejb.Lock;

import org.springframework.stereotype.Service;
import net.joystart.setting.dao.BaseMessageTemplateMapper;
import net.joystart.setting.entity.BaseMessageTemplate;
import net.joystart.setting.service.IBaseMessageTemplateService;

@Service("baseMessageTemplateService")
public class BaseMessageTemplateServiceImpl implements IBaseMessageTemplateService {

	@Resource
	BaseMessageTemplateMapper baseMessageTemplateMapper;
	
	@Override
	public List<BaseMessageTemplate> getMessageTemplateList(Map params) {
		
		return baseMessageTemplateMapper.getMessageTemplateList(params);
	}

	@Override
	public int getMessageTemplateListCount(Map params) {
		
		return baseMessageTemplateMapper.getMessageTemplateListCount(params);
	}

	@Override
	public int insertSelective(BaseMessageTemplate record) {
		
		return baseMessageTemplateMapper.insertSelective(record);
	}

	@Override
	public int updateByPrimaryKeySelective(BaseMessageTemplate record) {
		
		return baseMessageTemplateMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int getMessageTemplateCountByIdentification(Map params) {
	
		return baseMessageTemplateMapper.getMessageTemplateCountByIdentification(params);
	}
	
	

	
}
