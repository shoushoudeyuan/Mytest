package net.joystart.city.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.joystart.city.dao.AreaMapper;
import net.joystart.city.entity.Area;
import net.joystart.city.service.IAreaSerivce;

@Service("areaSerivce")
public class AreaServiceImpl implements IAreaSerivce {

	@Autowired
	private AreaMapper areaMapper;
	
	@Override
	public List<Area> getProvince() {
		return areaMapper.getProvince();
	}

	@Override
	public List<Area> getCityOrCounty(Long id) {
		return areaMapper.getCityOrCounty(id);
	}

}
