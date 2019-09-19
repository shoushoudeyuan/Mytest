package net.joystart.setting.service;

import java.util.List;
import java.util.Map;

import net.joystart.setting.entity.CustomerClass;

public interface IAuditCustomerService {

	List<CustomerClass> SelectAllSetting(Map params);
	
	int SelectCountSetting(Map params);
	
	int InsertAuditCustomer(CustomerClass customerClass);
	
	int UpdateAuditCustomer(CustomerClass customerClass);
	
	int DeleteAuditCustomer(Integer auditId);
	
	boolean IsExistName(Map params);
	
	CustomerClass SelectById(Integer auditId);
}
