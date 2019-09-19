package net.joystart.setting.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import net.joystart.setting.dao.CustomerClassMapper;
import net.joystart.setting.entity.CustomerClass;
import net.joystart.setting.service.IAuditCustomerService;

@Service("auditCustomerService")
public class AuditCustomerServiceImpl implements IAuditCustomerService {

	@Resource
	CustomerClassMapper customerClassMapper;
	
	public List<CustomerClass> SelectAllSetting(Map params)
	{
		return this.customerClassMapper.getAuditSettingList(params);
	}
	
	public int SelectCountSetting(Map params)
	{
		return this.customerClassMapper.getAuditSettingCount(params);
	}
	
	public int InsertAuditCustomer(CustomerClass customerClass)
	{
		customerClass.setIsdelete(0);
		customerClass.setCreatedate(new Date());
		
		return this.customerClassMapper.insertSelective(customerClass);
	}
	
	public int UpdateAuditCustomer(CustomerClass customerClass)
	{
		return this.customerClassMapper.updateByPrimaryKeySelective(customerClass);
	}
	
	public int DeleteAuditCustomer(Integer auditId)
	{
		CustomerClass customerClass = new CustomerClass();
		customerClass.setId(auditId);
		customerClass.setIsdelete(1);
		
		return this.customerClassMapper.updateByPrimaryKeySelective(customerClass);
	}
	
	public boolean IsExistName(Map params)
	{
		CustomerClass customerClass = this.customerClassMapper.selectByName(params);
		
		if(customerClass == null)
			return true;
		else {
			return false;			
		}
	}
	
	public CustomerClass SelectById(Integer auditId)
	{
		return this.customerClassMapper.selectByPrimaryKey(auditId);
	}
}
