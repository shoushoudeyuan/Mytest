package net.joystart.setting.service;

import java.util.List;
import java.util.Map;

import net.joystart.setting.entity.BaseInsurance;

public interface IBaseInsuranceService {
	
	 List<BaseInsurance> getBaseInsuranceList(Map params);
	    
	 int getBaseInsuranceListCount(Map params);
	 
	 int insertSelective(BaseInsurance record);
	 
	 int updateByPrimaryKeySelective(BaseInsurance record);
	 
	 int deleteByPrimaryKey(Integer id);

	 BaseInsurance selectByPrimaryKey(Integer id);
	 
	 /**
	  * @Description 获取必选保险车型id
	  * @author:  zhuwq
	  * Create at: 2017年9月25日 下午3:37:43
	  * @return
	  */
	 List<Integer> getRequiredInsuranceModel();
}
