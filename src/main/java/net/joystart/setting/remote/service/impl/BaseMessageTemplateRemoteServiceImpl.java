package net.joystart.setting.remote.service.impl;

import javax.annotation.Resource;

import com.alibaba.dubbo.config.annotation.Service;

import net.joystart.setting.dao.BaseMessageTemplateMapper;
import net.joystart.setting.entity.BaseMessageTemplate;
import net.joystart.setting.remote.service.IBaseMessageTemplateRemoteService;

@Service(timeout=60000,retries=0,interfaceClass=IBaseMessageTemplateRemoteService.class)
public class BaseMessageTemplateRemoteServiceImpl implements IBaseMessageTemplateRemoteService {

	@Resource
	BaseMessageTemplateMapper baseMessageTemplateMapper;
	
	@Override
	public BaseMessageTemplate selectTitleAndContentByIdentification(String Identification) {
		return baseMessageTemplateMapper.selectTitleAndContentByIdentification(Identification);
	}

	
}
