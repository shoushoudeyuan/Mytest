package net.joystart.city.service;

import java.util.List;
import java.util.Map;

import net.joystart.city.entity.ServiceCity;

public interface IServiceCitySerivce {

		int deleteByPrimaryKey(Integer id);

	    int insert(ServiceCity record);

	    int insertSelective(ServiceCity record);

	    ServiceCity selectByPrimaryKey(Integer id);

	    int updateByPrimaryKeySelective(ServiceCity record);

	    int updateByPrimaryKey(ServiceCity record);

		List<ServiceCity> list(Map<String, Object> params);

		Integer count(Map<String, Object> params);
		
		List<ServiceCity> getServerCity();
		
		/**
		 * 获取所有服务城市的id拼接起来的字符串 
		 * @return String
		 * @author 刘诗越
		 * @date 2017年8月25日
		 */
		String getAllCityIdStr();
		
		
}
