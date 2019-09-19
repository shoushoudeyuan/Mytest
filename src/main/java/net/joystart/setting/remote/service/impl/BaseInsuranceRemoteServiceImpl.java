package net.joystart.setting.remote.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.alibaba.dubbo.config.annotation.Service;

import net.joystart.setting.dao.BaseInsuranceMapper;
import net.joystart.setting.entity.BaseInsurance;
import net.joystart.setting.remote.service.IBaseInsuranceRemoteService;

@Service(timeout=60000,retries=0)
public class BaseInsuranceRemoteServiceImpl implements IBaseInsuranceRemoteService {
	
	@Resource
	BaseInsuranceMapper baseInsuranceMapper;

	@Override
	public List<BaseInsurance> getBaseInsuranceList(Map params) {
		
		return baseInsuranceMapper.getBaseInsuranceList(params);
	}

	@Override
	public int getBaseInsuranceListCount(Map params) {
		
		return baseInsuranceMapper.getBaseInsuranceListCount(params);
	}

	@Override
	public int insertSelective(BaseInsurance record) {
		
		return baseInsuranceMapper.insertSelective(record);
	}

	@Override
	public int updateByPrimaryKeySelective(BaseInsurance record) {
		
		return baseInsuranceMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int deleteByPrimaryKey(Integer id) {
		
		return baseInsuranceMapper.deleteByPrimaryKey(id);
	}

    @Override
    public BaseInsurance selectByPrimaryKey(Integer id) {
        return baseInsuranceMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<Integer> getRequiredInsuranceModel() {
        return baseInsuranceMapper.getRequiredInsuranceModel();
    }

	@Override
	public List<BaseInsurance> getInsuranceList(Map<String, Object> params) {
		return baseInsuranceMapper.getInsuranceList(params);
	}
	

}
