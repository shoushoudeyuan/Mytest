package net.joystart.city.dao;

import java.util.List;
import java.util.Map;

import net.joystart.city.entity.ServiceCity;

public interface ServiceCityMapper {
	ServiceCity selectByPrimaryKey(Integer id);
	
	int deleteByPrimaryKey(Integer id);

    int insert(ServiceCity record);

    int insertSelective(ServiceCity record);

    int updateByPrimaryKeySelective(ServiceCity record);

    int updateByPrimaryKey(ServiceCity record);
    
    ServiceCity selectByCityName(Map params);
    
    List<ServiceCity> selectAll();

	List<ServiceCity> getServerCity();
    
	List<ServiceCity> list(Map<String, Object> params);

	Integer count(Map<String, Object> params); 
	
	String getAllCityIdStr();
	
}