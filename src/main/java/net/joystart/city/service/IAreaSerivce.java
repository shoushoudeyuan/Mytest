package net.joystart.city.service;

import java.util.List;

import net.joystart.city.entity.Area;

public interface IAreaSerivce {
		
	List<Area> getProvince();
	
	List<Area> getCityOrCounty(Long id);	
}
