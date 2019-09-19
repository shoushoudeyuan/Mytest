package net.joystart.city.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import net.joystart.city.entity.Area;
import net.joystart.city.service.IAreaSerivce;
import net.joystart.common.controller.BaseController;
import net.joystart.common.util.ConstantUtil;
import net.joystart.common.util.MessageResult;
import net.joystart.common.util.log.Log4jTask;

@Controller
@RequestMapping("/area")
public class AreaController extends BaseController {
	@Resource
	@Qualifier("areaSerivce")
	private IAreaSerivce areaSerivce;
	//服务城市下拉框数据
	@RequestMapping("/getProvince")
	public void getProvince(HttpServletResponse response,HttpServletRequest request) 
	{
		try {
			List<Area> list = areaSerivce.getProvince();
			Area area = new Area();
			//area.setId(-1l);
			//area.setName("请选择");
			//area.setFull_name("请选择");
			//list.add(0, area);
			out(response, list);
		} catch (Exception e) {
			MessageResult result = new MessageResult();
			result = new MessageResult(ConstantUtil.M_SYSTEM_ERROR, "服务器繁忙，请稍后重试");
			out(response, result);
			Log4jTask.addLog("获取服务城市列表报错", System.currentTimeMillis(), Log4jTask.ERROR,
					AreaController.class.getName(), e);
		}
	}
	
	//服务城市下拉框数据
		@RequestMapping("/getCityOrCounty")
		public void getCityOrCounty(HttpServletResponse response,HttpServletRequest request) 
		{
			String areaId = request.getParameter("id");
			try {
				List<Area> list = areaSerivce.getCityOrCounty(Long.parseLong(areaId));
				Area area = new Area();
				//area.setId(-1l);
				//area.setName("请选择");
				//area.setFull_name("请选择");
				//list.add(0, area);
				out(response, list);
			} catch (Exception e) {
				MessageResult result = new MessageResult();
				result = new MessageResult(ConstantUtil.M_SYSTEM_ERROR, "服务器繁忙，请稍后重试");
				out(response, result);
				Log4jTask.addLog("获取服务城市列表报错", System.currentTimeMillis(), Log4jTask.ERROR,
						ServiceCityController.class.getName(), e);
			}
		}
	
	}
