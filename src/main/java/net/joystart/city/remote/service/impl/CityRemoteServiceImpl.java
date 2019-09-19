package net.joystart.city.remote.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;

import com.alibaba.dubbo.config.annotation.Service;
import com.google.gson.Gson;

import net.joystart.city.dao.ServiceCityMapper;
import net.joystart.city.entity.ServiceCity;
import net.joystart.city.remote.service.ICityRemoteService;
import net.joystart.common.util.JSONProcesser;
import net.joystart.common.util.baiDu.BaiDuAPIUtil;
import net.joystart.common.util.tencent.TengXunAPIUtil;

@Service(timeout = 60000, retries = 0)
public class CityRemoteServiceImpl implements ICityRemoteService {

	@Resource
	ServiceCityMapper serviceCityMapper;

	// 通过GPS坐标获取服务城市信息
	public ServiceCity getServiceCityByGPS(String lng, String lat) {
		// 通过GPS坐标逆向解析获取城市信息
		String result = TengXunAPIUtil.getDetailByBaidu(Double.valueOf(lng), Double.valueOf(lat), 5);
		if (!StringUtils.isBlank(result)) {
			// 将地图返回json转化为实体
			net.joystart.mapCoordinates.entity.ReturnResult RR = (net.joystart.mapCoordinates.entity.ReturnResult) JSONProcesser
			        .jsonProcesser(result, net.joystart.mapCoordinates.entity.ReturnResult.class);

			// Gson gson = new Gson();
			// net.joystart.mapCoordinates.entity.ReturnResult RR =
			// gson.fromJson(result,
			// net.joystart.mapCoordinates.entity.ReturnResult.class);

			if (RR != null) {
				// 获取城市的名称
				String CityName = RR.getResult().getAddress_component().getCity();
				String countyName = RR.getResult().getAddress_component().getDistrict();
				// 获取城市名称的前2个字
				String smallCityName = "";
				if (!StringUtils.isBlank(result)) {
					smallCityName = CityName.length() >2 ? CityName.substring(0, 2):CityName;
				}
				
				// 获取城市名称的前2个字
				String smallcountyName = "";
				if (!StringUtils.isBlank(countyName)) {
					smallcountyName = countyName.substring(0, countyName.length()-1);
				}

				// 根据2个城市名字筛选获取所有城市对应的id
				Map<String, Object> params = new HashMap<String, Object>();
				params.put("fullname", "%" + CityName + "%");
				params.put("name", "%" + smallCityName + "%");
				params.put("countyName", "%" + countyName + "%");
				params.put("smallcountyName", "%" + smallcountyName + "%");
				ServiceCity city = this.serviceCityMapper.selectByCityName(params);
				if(city==null){
					Map<String, Object> paramscity = new HashMap<String, Object>();
					paramscity.put("fullname", "%" + CityName + "%");
					paramscity.put("name", "%" + smallCityName + "%");
					city = this.serviceCityMapper.selectByCityName(paramscity);
				}
				return city;
			}
		}

		return null;
	}
	
	public static void main(String[] args) {
		String result = TengXunAPIUtil.getDetailByBaidu(Double.valueOf("113.06"), Double.valueOf("22.61"), 5);
		if (!StringUtils.isBlank(result)) {
			// 将地图返回json转化为实体
			net.joystart.mapCoordinates.entity.ReturnResult RR = (net.joystart.mapCoordinates.entity.ReturnResult) JSONProcesser
			        .jsonProcesser(result, net.joystart.mapCoordinates.entity.ReturnResult.class);

			// Gson gson = new Gson();
			// net.joystart.mapCoordinates.entity.ReturnResult RR =
			// gson.fromJson(result,
			// net.joystart.mapCoordinates.entity.ReturnResult.class);

			if (RR != null) {
				// 获取城市的名称
				String CityName = RR.getResult().getAddress_component().getCity();
				String countyName = RR.getResult().getAddress_component().getDistrict();
				// 获取城市名称的前2个字
				String smallCityName = "";
				if (!StringUtils.isBlank(result)) {
					smallCityName = CityName.length() >2 ? CityName.substring(0, 2):CityName;
				}
				
				// 获取城市名称的前2个字
				String smallcountyName = "";
				if (!StringUtils.isBlank(countyName)) {
					smallcountyName = countyName.substring(0, countyName.length()-1);
				}

				// 根据2个城市名字筛选获取所有城市对应的id
				Map<String, Object> params = new HashMap<String, Object>();
				params.put("fullname", "%" + CityName + "%");
				params.put("name", "%" + smallCityName + "%");
				params.put("countyName", "%" + countyName + "%");
				params.put("smallcountyName", "%" + smallcountyName + "%");
				
//				ServiceCity city = this.serviceCityMapper.selectByCityName(params);
//				if(city==null){
//					Map<String, Object> paramscity = new HashMap<String, Object>();
//					paramscity.put("fullname", "%" + CityName + "%");
//					paramscity.put("name", "%" + smallCityName + "%");
//					city = this.serviceCityMapper.selectByCityName(paramscity);
//				}
			}
		}
	}

	/**
	 * 通过GPS坐标获取服务城市信息 百度地图--wangxinan
	 */
	public ServiceCity getBaiduServiceCityByGPS(String lng, String lat) {
		Gson gson = new Gson();
		// 通过GPS坐标逆向解析获取城市信息
		String result = BaiDuAPIUtil.getDetailByGPS(Double.valueOf(lng), Double.valueOf(lat));
		if (!StringUtils.isBlank(result)) {

			// 将Json转化为Map集合，取出服务城市
			Map<String, Object> map1 = new HashMap<String, Object>();
			map1 = gson.fromJson(result, map1.getClass());
			Map<String, Object> map2 = (Map<String, Object>) map1.get("result");
			Map<String, Object> map3 = (Map<String, Object>) map2.get("addressComponent");

			if (map3 != null) {
				// 获取城市的名称
				String CityName = (String) map3.get("city");
				String countyName = (String) map3.get("district");
				// 获取城市名称的前2个字
				String smallCityName = "";
				if (!StringUtils.isBlank(result)) {
					smallCityName = CityName.substring(0, 2);
				}
				
				// 获取城市名称的前2个字
				String smallcountyName = "";
				if (!StringUtils.isBlank(countyName)) {
					smallcountyName = countyName.substring(0, countyName.length()-1);
				}

				// 根据2个城市名字筛选获取所有城市对应的id
				Map<String, Object> params = new HashMap<String, Object>();
				params.put("fullname", "%" + CityName + "%");
				params.put("name", "%" + smallCityName + "%");
				params.put("countyName", "%" + countyName + "%");
				params.put("smallcountyName", "%" + smallcountyName + "%");
				ServiceCity city = this.serviceCityMapper.selectByCityName(params);
				if(city==null){
					Map<String, Object> paramscity = new HashMap<String, Object>();
					paramscity.put("fullname", "%" + CityName + "%");
					paramscity.put("name", "%" + smallCityName + "%");
					city = this.serviceCityMapper.selectByCityName(paramscity);
				}
				return city;
			}
		}
		return null;
	}

	public List<ServiceCity> getAllServiceCity() {
		return this.serviceCityMapper.selectAll();
	}
}
