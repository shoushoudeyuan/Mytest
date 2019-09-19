package net.joystart.city.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.joystart.city.entity.ServiceCity;
import net.joystart.city.service.IServiceCitySerivce;
import net.joystart.city.dao.ServiceCityMapper;

@Service("serviceCitySerivce")
public class ServiceCitySerivceImpl implements IServiceCitySerivce {

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
