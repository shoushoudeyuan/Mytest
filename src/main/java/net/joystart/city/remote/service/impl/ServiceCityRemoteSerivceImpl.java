package net.joystart.city.remote.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.alibaba.dubbo.config.annotation.Service;

import net.joystart.city.dao.ServiceCityMapper;
import net.joystart.city.entity.ServiceCity;
import net.joystart.city.remote.service.IServiceCityRemoteSerivce;

@Service(timeout = 60000, retries = 0)
public class ServiceCityRemoteSerivceImpl implements IServiceCityRemoteSerivce {

	@Autowired
	private ServiceCityMapper serviceCityMapper;
	
	@Override
	public int deleteByPrimaryKey(Integer id) {
		return this.serviceCityMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(ServiceCity record) {
		return this.serviceCityMapper.insert(record);
	}

	@Override
	public int insertSelective(ServiceCity record) {
		return this.serviceCityMapper.insertSelective(record);
	}

	@Override
	public ServiceCity selectByPrimaryKey(Integer id) {
		return this.serviceCityMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(ServiceCity record) {
		return this.serviceCityMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(ServiceCity record) {
		return this.serviceCityMapper.updateByPrimaryKey(record);
	}

	@Override
	public List<ServiceCity> list(Map<String, Object> params) {
		return this.serviceCityMapper.list(params);
	}

	@Override
	public Integer count(Map<String, Object> params) {
		return this.serviceCityMapper.count(params);
	}

	@Override
	public List<ServiceCity> getServerCity() {
		return serviceCityMapper.getServerCity();
	}

	@Override
	public String getAllCityIdStr() {
		return serviceCityMapper.getAllCityIdStr();
	}

}
