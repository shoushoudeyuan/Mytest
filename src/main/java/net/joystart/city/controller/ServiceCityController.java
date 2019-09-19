package net.joystart.city.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import net.joystart.city.entity.ServiceCity;
import net.joystart.city.service.IServiceCitySerivce;
import net.joystart.common.controller.BaseController;
import net.joystart.common.util.ConstantUtil;
import net.joystart.common.util.MessageResult;
import net.joystart.common.util.SysLogUtil;
import net.joystart.common.util.log.Log4jTask;
import net.joystart.vehicle.remote.service.IParkinglotRemoteService;


@Controller
@RequestMapping("/city")
public class ServiceCityController extends BaseController{
	@Resource
	private IServiceCitySerivce serviceCitySerivce;
	
	@Resource
	private IParkinglotRemoteService parkinglotRemoteService;
	
	//服务城市下拉框数据
	@RequestMapping("/getServiceCityList")
	public void getServiceCityList(HttpServletResponse response,HttpServletRequest request) 
	{
		String cityId = request.getParameter("id");
		int icityId = -1;
		if (!StringUtils.isBlank(cityId) && !"undefined".equals(cityId)) {
			icityId = new Integer(cityId);
		}
		try {
			List<ServiceCity> list = serviceCitySerivce.getServerCity();
			ServiceCity sCity = new ServiceCity();
			
			sCity.setId(-1);
			sCity.setShowname("请选择");
			//sCity.setSelected(true);
			list.add(0, sCity);
			
			for(ServiceCity plt : list)
			{
				if(plt!=null)
				{
					if(plt.getId()==icityId)
					{
						plt.setSelected(true);
						break;
					}
					
				}
			}
			out(response, list);
		} catch (Exception e) {
			MessageResult result = new MessageResult();
			result = new MessageResult(ConstantUtil.M_SYSTEM_ERROR, "服务器繁忙，请稍后重试");
			out(response, result);
			Log4jTask.addLog("获取服务城市列表报错", System.currentTimeMillis(), Log4jTask.ERROR,
					ServiceCityController.class.getName(), e);
		}
	}
	
	//服务城市下拉框数据
	@RequestMapping("/getAllCityList")
	public void list(HttpServletRequest request,HttpServletResponse response){
		List<ServiceCity> list = null;
		Map<String,Object> params = new HashMap<String,Object>();
		HashMap<String,Object> dataMap = new HashMap<String,Object>();
			
		String p_pageSize = request.getParameter("rows");
		if(!StringUtils.isEmpty(p_pageSize)){
			params.put("pageSize",Integer.valueOf(p_pageSize) );
		}else{
			params.put("pageSize",20 );
		}
		String p_pageNumber = request.getParameter("page");
		if(!StringUtils.isEmpty(p_pageNumber)){
			params.put("startIndex", (Integer.valueOf(p_pageNumber) - 1) * Integer.valueOf(p_pageSize));
		}else{
			params.put("startIndex", 0);
		}
		
		String id = request.getParameter("id");
		if(!StringUtils.isEmpty(id)){
			params.put("id",id);
		}
		
		String showName = request.getParameter("showName");
		if(!StringUtils.isEmpty(showName)){
			params.put("showName","%"+showName+"%" );
		}

		
		Integer count = this.serviceCitySerivce.count(params);
		//查询列表
		list = this.serviceCitySerivce.list(params);
		dataMap.put("list", list);
		HashMap<String,Object> messageMap = new HashMap<String,Object>();
		messageMap.put("total", count);
		messageMap.put("rows", list);
		
		this.webOut(response, messageMap);
	}
	
	@RequestMapping("/select")
	public void select(HttpServletRequest request,HttpServletResponse response){
		
		String id = request.getParameter("id");
		ServiceCity serviceCity= this.serviceCitySerivce.selectByPrimaryKey(Integer.valueOf(id));
		HashMap<String,Object> resuleMap = new HashMap<>();
		resuleMap.put("success", true);
		resuleMap.put("serviceCity", serviceCity);
		this.webOut(response, resuleMap);
		return;
		
	}
	
	@RequestMapping("/update")
	public void updateOrInsert(ServiceCity serviceCity,HttpServletRequest request,HttpServletResponse response){
		try{
			if(null == serviceCity.getId()){
				/*在 2019 0814 版本中去掉服务城市数量限制*/
//				Map<String,Object> params = new HashMap<String,Object>();
//				Integer count = this.serviceCitySerivce.count(params);
//				if(count>=2){
//					this.webOut(response, 3);
//					return;
//				}
				serviceCity.setCreatedate(new Date());
				int result = this.serviceCitySerivce.insert(serviceCity);
				SysLogUtil.addLog(request, "新增服务城市", result);
				this.webOut(response, 1);
				return;
			}else{
				if(serviceCity.getStatus()==0){
					int vcount = parkinglotRemoteService.getVehicleCountByCityID(serviceCity.getId());
					if(vcount>0){
						this.webOut(response, 4);
						return;
					}
				}
				int result = this.serviceCitySerivce.updateByPrimaryKeySelective(serviceCity);
				SysLogUtil.addLog(request, "更新服务城市", result);
				this.webOut(response, 1);
				return;
			}
		}catch (Exception e) {
			SysLogUtil.addLog(request, "保存服务城市", 0);
			this.out(response, 2);
		}
		
		
	}
	
	@RequestMapping("/delete")
	public void delete(String ids,HttpServletRequest request,HttpServletResponse response){
		
		HashMap<String,Object> messageMap = new HashMap<String,Object>();
		
		if(StringUtils.isEmpty(ids)){
			messageMap.put("success", false);
			messageMap.put("message", "没有可删除的服务城市！");
			this.out(response, messageMap);
			return;
		}
		
		
		String[] split = ids.split(",");
		for (int i = 0; i < split.length; i++) {
			int vcount = parkinglotRemoteService.getVehicleCountByCityID(Integer.valueOf(split[i]));
			if(vcount>0){
				messageMap.put("success", false);
				messageMap.put("message", "该服务城市下有车辆，不能删除");
				this.out(response, messageMap);
				return;
			}
			this.serviceCitySerivce.deleteByPrimaryKey(Integer.valueOf(split[i]));
		}
		SysLogUtil.addLog(request, "删除服务城市", 1);
		messageMap.put("success", "删除成功！");
		this.out(response, messageMap);
	}
}
