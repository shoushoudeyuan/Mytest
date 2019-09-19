package net.joystart.datanumerical.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;

import net.joystart.common.controller.BaseController;
import net.joystart.common.util.ConstantUtil;
import net.joystart.common.util.MessageResult;
import net.joystart.common.util.date.UtilTimeFormatter;
import net.joystart.common.util.log.Log4jTask;
import net.joystart.customer.remote.service.ICustomerRemoteService;
import net.joystart.vehicle.entity.Parkinglot;
import net.joystart.vehicle.entity.VehicleModel;
import net.joystart.vehicle.remote.service.IParkinglotRemoteService;
import net.joystart.vehicle.remote.service.IVehicleRemoteService;


@Controller
@RequestMapping("/customerStatic")
public class CustomerStaticController extends BaseController {
	
	@Resource
	private ICustomerRemoteService customerService;
	
	@Autowired 
	IParkinglotRemoteService parkinglotRemoteService;

	@Autowired 
	IVehicleRemoteService vehicleRemoteService;
	
	/**
	 * 统计每日新注册用户数
	 * @param response
	 * @param request
	 */
	@RequestMapping("/newCustomerStatisByDay")
	public void newCustomerStatis(HttpServletResponse response, HttpServletRequest request) {
		Map<String, Object> params = new HashMap<String, Object>();
		MessageResult result = new MessageResult();
		String createStartTime = request.getParameter("createStartTime");
		String createEndTime = request.getParameter("createEndTime");
		Map<String, Object> json = new HashMap<String, Object>();
		
		Calendar calendar = Calendar.getInstance();  
		 Date now = new Date();
		 calendar.setTime(now); 
		 if (!StringUtils.isBlank(createEndTime)) {
			 String getdateymNum = UtilTimeFormatter.getStringTimeYMD(createEndTime);
				params.put("createEndTime",getdateymNum);
				json.put("createEndTimeTemp", getdateymNum);
			}else{
				 String createEndTimeTemp = new SimpleDateFormat("yyyy-MM-dd").format(calendar.getTime());
				 json.put("createEndTimeTemp", createEndTimeTemp);
				params.put("createEndTime",createEndTimeTemp);
			}
		
		if (!StringUtils.isBlank(createStartTime)) {
			String getdateymNum = UtilTimeFormatter.getStringTimeYMD(createStartTime);
			params.put("createStartTime", getdateymNum);
			json.put("createStartTimeTemp", getdateymNum);
		}else{
			calendar.add(Calendar.MONTH, -1);
			calendar.add(Calendar.DAY_OF_MONTH, 1);
			
			String createStartTimeTemp = new SimpleDateFormat("yyyy-MM-dd").format(calendar.getTime());
			json.put("createStartTimeTemp", createStartTimeTemp);
			params.put("createStartTime",createStartTimeTemp );

		}
		
		try {
			String[] categories;
			List<String> listStr = new ArrayList<String>();
			List listLong = new ArrayList();
			List list = customerService.newCustomerStatisByDay(params);
			for (int i = 0; i < list.size(); i++) {
				Map cus = (Map) list.get(i);
				Date str = (Date) cus.get("td_date");
				String format = new SimpleDateFormat("yyyy年MM月dd日").format(str);
				listStr.add(format);
				
				listLong.add( cus.get("count"));
			}
			categories = listStr.toArray(new String[listStr.size()]); 
					
			
			
			json.put("categories", categories);
			json.put("values", listLong.toArray());
			result = new MessageResult(ConstantUtil.M_SUCCESS, "成功", json);
			out(response, result);
		} catch (Exception e) {
			result = new MessageResult(ConstantUtil.M_SYSTEM_ERROR, "统计查询获取会员失败");
			out(response, result);
			Log4jTask.addLog("统计查询获取会员失败", System.currentTimeMillis(), Log4jTask.ERROR,
					CustomerStaticController.class.getName(), e);
		}

	}
	
	
	/**
	 * 统计每日新增会员数
	 * @param response
	 * @param request
	 */
	@RequestMapping("/activeCustomerStatisByDay")
	public void activeCustomerStatisByDay(HttpServletResponse response, HttpServletRequest request) {
		Map<String, Object> params = new HashMap<String, Object>();
		MessageResult result = new MessageResult();
		String createStartTime = request.getParameter("createStartTime");
		String createEndTime = request.getParameter("createEndTime");
		Map<String, Object> json = new HashMap<String, Object>();
		
		Calendar calendar = Calendar.getInstance();  
		 Date now = new Date();
		 calendar.setTime(now); 
		 if (!StringUtils.isBlank(createEndTime)) {
			 String getdateymNum = UtilTimeFormatter.getStringTimeYMD(createEndTime);
				params.put("createEndTime",getdateymNum);
				json.put("createEndTimeTemp", getdateymNum);
			}else{
				 String createEndTimeTemp = new SimpleDateFormat("yyyy-MM-dd").format(calendar.getTime());
				 json.put("createEndTimeTemp", createEndTimeTemp);
				params.put("createEndTime",createEndTimeTemp);
			}
		
		if (!StringUtils.isBlank(createStartTime)) {
			String getdateymNum = UtilTimeFormatter.getStringTimeYMD(createStartTime);
			params.put("createStartTime", getdateymNum);
			json.put("createStartTimeTemp", getdateymNum);
		}else{
			calendar.add(Calendar.MONTH, -1);
			calendar.add(Calendar.DAY_OF_MONTH, 1);
			
			String createStartTimeTemp = new SimpleDateFormat("yyyy-MM-dd").format(calendar.getTime());
			json.put("createStartTimeTemp", createStartTimeTemp);
			params.put("createStartTime",createStartTimeTemp );

		}
		
		try {
			String[] categories;
			List<String> listStr = new ArrayList<String>();
			List listLong = new ArrayList();
			List list = customerService.activeCustomerStatisByDay(params);
			for (int i = 0; i < list.size(); i++) {
				Map cus = (Map) list.get(i);
				Date str = (Date) cus.get("td_date");
				String format = new SimpleDateFormat("yyyy年MM月dd日").format(str);
				listStr.add(format);
				
				listLong.add( cus.get("count"));
			}
			categories = listStr.toArray(new String[listStr.size()]); 
					
			
			
			json.put("categories", categories);
			json.put("values", listLong.toArray());
			result = new MessageResult(ConstantUtil.M_SUCCESS, "成功", json);
			out(response, result);
		} catch (Exception e) {
			result = new MessageResult(ConstantUtil.M_SYSTEM_ERROR, "统计查询获取会员失败");
			out(response, result);
			Log4jTask.addLog("统计查询获取会员失败", System.currentTimeMillis(), Log4jTask.ERROR,
					CustomerStaticController.class.getName(), e);
		}

	}
	
	/**
	 * 统计车场回款钱数
	 * @param response
	 * @param request
	 */
	@RequestMapping("/payParkByMonth")
	public void payParkByMonth(HttpServletResponse response, HttpServletRequest request) {
		Map<String, Object> params = new HashMap<String, Object>();
		MessageResult result = new MessageResult();
		List<Parkinglot> list = new ArrayList<>();
		HashMap<String, Object> dataMap = new HashMap<String, Object>();
		
		String p_pageSize = request.getParameter("rows");
		if (!StringUtils.isEmpty(p_pageSize)) {
			params.put("pageSize", Integer.valueOf(p_pageSize));
		} else {
			params.put("pageSize", 10000);
		}
		
		String p_pageNumber = request.getParameter("page");
		if (!StringUtils.isEmpty(p_pageNumber)) {
			params.put("startIndex", (Integer.valueOf(p_pageNumber) - 1) * Integer.valueOf(p_pageSize));
		} else {
			params.put("startIndex", 0);
		}
		
		List<Parkinglot> parkinglotList = this.parkinglotRemoteService.getParkinglotList(params);
		
		params.clear();
		
		String createStartTime = request.getParameter("createStartTime");
		String createEndTime = request.getParameter("createEndTime");
		Map<String, Object> json = new HashMap<String, Object>();
		SimpleDateFormat dateymd = new SimpleDateFormat("yyyy-MM-dd");
		Calendar calendar = Calendar.getInstance(); 
		 if (!StringUtils.isBlank(createEndTime)) {
		 	String temp = createEndTime+"-01";
			params.put("createEndTime",temp);
			try {
				calendar.setTime(dateymd.parse(temp));
			} catch (ParseException e) {
				e.printStackTrace();
			}
			calendar.add(Calendar.MONTH, 1);
			json.put("createEndTimeTemp", dateymd.format(calendar.getTime()));
		}else{
			calendar.setTime(new Date());
			params.put("createEndTime",dateymd.format(calendar.getTime()));
			calendar.add(Calendar.MONTH, 1);
			json.put("createEndTimeTemp", dateymd.format(calendar.getTime()));
		}
		if (!StringUtils.isBlank(createStartTime)) {
			String temp = createStartTime+"-01";
			params.put("createStartTime", temp);
			
			try {
				calendar.setTime(dateymd.parse(temp));
			} catch (ParseException e) {
				e.printStackTrace();
			}
			calendar.add(Calendar.MONTH, 1);
			json.put("createStartTimeTemp", dateymd.format(calendar.getTime()));
			
		}else{
			calendar.setTime(new Date());
			calendar.add(Calendar.YEAR, -1);
			calendar.add(Calendar.MONDAY, 1);
			params.put("createStartTime",dateymd.format(calendar.getTime()) );
			calendar.add(Calendar.MONTH, 1);
			json.put("createStartTimeTemp", dateymd.format(calendar.getTime()));
		}
		
		try {
			List<Map<String, Object>> payParkByMonth = customerService.payParkByMonth(params);
			Map<String, Map<String, Object>> payParkMap = new HashMap<String, Map<String, Object>>();
			List<String> legends = new ArrayList<String>();
			List series  = new ArrayList();
			List<String> categories = getMonthBetween(params.get("createStartTime").toString(), params.get("createEndTime").toString());
			Map<String, Object> datamap = new HashMap<String, Object>();
			for (Map<String, Object> map : payParkByMonth) {
				for (String dateStr : categories) {
					if(payParkMap.get(map.get("rentParkID").toString())!=null){
						datamap = payParkMap.get(map.get("rentParkID").toString());
					}else{
						datamap = new HashMap<String, Object>();
					}
					if(dateStr.equals(map.get("td_date").toString())){
						datamap.put(dateStr, map.get("count")!=null?map.get("count"):0.00);
					}
					payParkMap.put(map.get("rentParkID").toString(), datamap);
				}
			}
			for (Parkinglot parkinglot : parkinglotList) {
				legends.add(parkinglot.getName());
				List listMap = new ArrayList();
				Map serireMap = new HashMap();
				Map<String, Object> parkMap = payParkMap.get(parkinglot.getId().toString());
				for (String ca : categories) {
					if(parkMap!=null){
						listMap.add(parkMap.get(ca)!=null?parkMap.get(ca):0.00);
					}else{
						listMap.add(0.00);
					}
				}
				serireMap.put("data", listMap);
				serireMap.put("name", parkinglot.getName());
				serireMap.put("type", "line");
				series.add(serireMap);
			}
			
			json.put("categories", categories.toArray());
			json.put("legends", legends.toArray());
			json.put("series", new Gson().toJson(series));
			result = new MessageResult(ConstantUtil.M_SUCCESS, "成功", json);
			out(response, result);
		} catch (Exception e) {
			result = new MessageResult(ConstantUtil.M_SYSTEM_ERROR, "统计查询获取失败");
			out(response, result);
			Log4jTask.addLog("统计查询失败", System.currentTimeMillis(), Log4jTask.ERROR,
					CustomerStaticController.class.getName(), e);
		}

	}
	
	@RequestMapping("/payParkByDay")
	public void payParkByDay(HttpServletResponse response, HttpServletRequest request) {
		Map<String, Object> params = new HashMap<String, Object>();
		MessageResult result = new MessageResult();
		
		List<Parkinglot> list = new ArrayList<>();
		HashMap<String, Object> dataMap = new HashMap<String, Object>();
		
		String p_pageSize = request.getParameter("rows");
		if (!StringUtils.isEmpty(p_pageSize)) {
			params.put("pageSize", Integer.valueOf(p_pageSize));
		} else {
			params.put("pageSize", 10000);
		}
		
		String p_pageNumber = request.getParameter("page");
		if (!StringUtils.isEmpty(p_pageNumber)) {
			params.put("startIndex", (Integer.valueOf(p_pageNumber) - 1) * Integer.valueOf(p_pageSize));
		} else {
			params.put("startIndex", 0);
		}
		
		List<Parkinglot> parkinglotList = this.parkinglotRemoteService.getParkinglotList(params);
		params.clear();
		String createStartTime = request.getParameter("createStartTime");
		String createEndTime = request.getParameter("createEndTime");
		Map<String, Object> json = new HashMap<String, Object>();
		
		Calendar calendar = Calendar.getInstance();  
		 Date now = new Date();
		 calendar.setTime(now); 
		 if (!StringUtils.isBlank(createEndTime)) {
				params.put("createEndTime",createEndTime);
				json.put("createEndTimeTemp", createEndTime);
			}else{
				 String createEndTimeTemp = new SimpleDateFormat("yyyy-MM-dd").format(calendar.getTime());
				 json.put("createEndTimeTemp", createEndTimeTemp);
				params.put("createEndTime",createEndTimeTemp);
			}
		if (!StringUtils.isBlank(createStartTime)) {
			params.put("createStartTime", createStartTime);
			json.put("createStartTimeTemp", createStartTime);
		}else{
			calendar.add(Calendar.MONDAY, 0);
			calendar.add(Calendar.DATE, -6);
			String createStartTimeTemp = new SimpleDateFormat("yyyy-MM-dd").format(calendar.getTime());
			json.put("createStartTimeTemp", createStartTimeTemp);
			params.put("createStartTime",createStartTimeTemp );

		}
		try {
			List<Map<String, Object>> payParkByMonth = customerService.payParkByDay(params);
			Map<String, Map<String, Object>> payParkMap = new HashMap<String, Map<String, Object>>();
			List<String> legends = new ArrayList<String>();
			List series  = new ArrayList();
			List<String> categories = findDates(createStartTime, createEndTime);
			Map<String, Object> datamap = new HashMap<String, Object>();
			for (Map<String, Object> map : payParkByMonth) {
				for (String dateStr : categories) {
					if(payParkMap.get(map.get("rentParkID").toString())!=null){
						datamap = payParkMap.get(map.get("rentParkID").toString());
					}else{
						datamap = new HashMap<String, Object>();
					}
					if(dateStr.equals(map.get("td_date").toString())){
						datamap.put(dateStr, map.get("count")!=null?map.get("count"):0.00);
					}
					payParkMap.put(map.get("rentParkID").toString(), datamap);
				}
			}
			for (Parkinglot parkinglot : parkinglotList) {
				legends.add(parkinglot.getName());
				List listMap = new ArrayList();
				Map serireMap = new HashMap();
				Map<String, Object> parkMap = payParkMap.get(parkinglot.getId().toString());
				for (String ca : categories) {
					if(parkMap!=null){
						listMap.add(parkMap.get(ca)!=null?parkMap.get(ca):0.00);
					}else{
						listMap.add(0.00);
					}
				}
				serireMap.put("data", listMap);
				serireMap.put("name", parkinglot.getName());
				serireMap.put("type", "line");
				series.add(serireMap);
			}
			json.put("categories", categories.toArray());
			json.put("legends", legends.toArray());
			json.put("series", new Gson().toJson(series));
			result = new MessageResult(ConstantUtil.M_SUCCESS, "成功", json);
			out(response, result);
		} catch (Exception e) {
			result = new MessageResult(ConstantUtil.M_SYSTEM_ERROR, "统计查询获取失败");
			out(response, result);
			Log4jTask.addLog("统计查询失败", System.currentTimeMillis(), Log4jTask.ERROR,
					CustomerStaticController.class.getName(), e);
		}

	}
	
	
	@RequestMapping("/modelOrderCount")
	public void modelOrderCount(HttpServletResponse response, HttpServletRequest request) {
		Map<String, Object> params = new HashMap<String, Object>();
		MessageResult result = new MessageResult();
		
		
		List<Parkinglot> list = new ArrayList<>();
		HashMap<String, Object> dataMap = new HashMap<String, Object>();
		
		
		List<VehicleModel> modelList = this.vehicleRemoteService.modelOrder(params);
		
		params.clear();
		
		
		
		
		String createStartTime = request.getParameter("createStartTime");
		String createEndTime = request.getParameter("createEndTime");
		Map<String, Object> json = new HashMap<String, Object>();
		
		Calendar calendar = Calendar.getInstance();  
		 Date now = new Date();
		 calendar.setTime(now); 
		 if (!StringUtils.isBlank(createEndTime)) {
			 	
				params.put("createEndTime",createEndTime);
				json.put("createEndTimeTemp", createEndTime);
			}else{
				 String createEndTimeTemp = new SimpleDateFormat("yyyy-MM-dd").format(calendar.getTime());
				 json.put("createEndTimeTemp", createEndTimeTemp);
				params.put("createEndTime",createEndTimeTemp);
			}
		
		if (!StringUtils.isBlank(createStartTime)) {
			params.put("createStartTime", createStartTime);
			json.put("createStartTimeTemp", createStartTime);
		}else{
			
			calendar.add(Calendar.MONDAY, 0);
			calendar.add(Calendar.DATE, -6);
			
			String createStartTimeTemp = new SimpleDateFormat("yyyy-MM-dd").format(calendar.getTime());
			json.put("createStartTimeTemp", createStartTimeTemp);
			params.put("createStartTime",createStartTimeTemp );

		}
		
		try {
			List<String> categories = new ArrayList<String>();
			List legends = new ArrayList();
			List series  = new ArrayList();
			for(int i = 0; i < modelList.size(); i++){
				
				legends.add(modelList.get(i).getModelname());
				params.put("returnParkID", modelList.get(i).getId());
				List payParkByMonth = customerService.modelOrderCount(params);
				Map serireMap = new HashMap();
				List listMap = new ArrayList();
				
				
				for (int j = 0; j < payParkByMonth.size(); j++) {
					//{"data":[44018,51319,68097,73303,54493,12057,0],"name":"北京西客站","type":"line"}

					Map cus = (Map) payParkByMonth.get(j);
					listMap.add(cus.get("COUNT"));
					if(i == 0){
						categories.add(cus.get("td_date").toString());
					}
				}
				serireMap.put("data", listMap);
				serireMap.put("name", modelList.get(i).getModelname());
				serireMap.put("type", "line");
				
				series.add(serireMap);
				
			}
			
			json.put("categories", categories.toArray());
			json.put("legends", legends.toArray());
			json.put("series", new Gson().toJson(series));
			result = new MessageResult(ConstantUtil.M_SUCCESS, "成功", json);
			out(response, result);
		} catch (Exception e) {
			result = new MessageResult(ConstantUtil.M_SYSTEM_ERROR, "统计查询获取失败");
			out(response, result);
			Log4jTask.addLog("统计查询失败", System.currentTimeMillis(), Log4jTask.ERROR,
					CustomerStaticController.class.getName(), e);
		}

	}
	
	 private List<String> findDates(String start, String end){  
    	List<String> lDate = new ArrayList<String>();  
    	try {
    		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");  
    		Date dBegin = sdf.parse(start);  
    		Date dEnd = sdf.parse(end);  
    		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy年MM月dd日"); 
    		lDate.add(sdf2.format(dBegin));  
    		Calendar calBegin = Calendar.getInstance();  
    		// 使用给定的 Date 设置此 Calendar 的时间  
    		calBegin.setTime(dBegin);  
    		Calendar calEnd = Calendar.getInstance();  
    		// 使用给定的 Date 设置此 Calendar 的时间  
    		calEnd.setTime(dEnd);  
    		// 测试此日期是否在指定日期之后  
    		while (dEnd.after(calBegin.getTime())) {  
    			// 根据日历的规则，为给定的日历字段添加或减去指定的时间量  
    			calBegin.add(Calendar.DAY_OF_MONTH, 1);  
    			lDate.add(sdf2.format(calBegin.getTime()));  
    		}  
		} catch (Exception e) {
			// TODO: handle exception
		}
    	return lDate;  
    }
	 
	 private List<String> getMonthBetween(String minDate, String maxDate) throws ParseException {
	     ArrayList<String> result = new ArrayList<String>();
	     SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");//格式化为年月
	     Calendar min = Calendar.getInstance();
	     Calendar max = Calendar.getInstance();
	     min.setTime(sdf.parse(minDate));
	     min.set(min.get(Calendar.YEAR), min.get(Calendar.MONTH), 1);
	     max.setTime(sdf.parse(maxDate));
	     max.set(max.get(Calendar.YEAR), max.get(Calendar.MONTH), 2);
	     Calendar curr = min;
	     while (curr.before(max)) {
	    	 result.add(sdf.format(curr.getTime()));
	    	 curr.add(Calendar.MONTH, 1);
	     }
	     return result;
	}
		 
}
