package net.joystart.datanumerical.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.NumberFormat;
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

import jxl.Workbook;
import jxl.format.Alignment;
import jxl.format.Colour;
import jxl.format.UnderlineStyle;
import jxl.format.VerticalAlignment;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import net.joystart.common.controller.BaseController;
import net.joystart.common.entity.PayConfig;
import net.joystart.common.service.IPayConfigService;
import net.joystart.common.util.ConstantUtil;
import net.joystart.common.util.MessageResult;
import net.joystart.common.util.date.UtilTimeFormatter;
import net.joystart.common.util.log.Log4jTask;
import net.joystart.customer.remote.service.ICustomerRemoteService;
import net.joystart.datanumerical.entity.SeriesVo;
import net.joystart.datanumerical.entity.StatisticsQuery;
import net.joystart.datanumerical.service.IStatisticalService;
import net.joystart.order.remote.service.IOrderRemoteService;
import net.joystart.vehicle.entity.Parkinglot;
import net.joystart.vehicle.entity.Vehicle;
import net.joystart.vehicle.remote.service.IParkinglotRemoteService;
import net.joystart.vehicle.remote.service.IVehicleRemoteService;

/**
 *
 * @author lei
 * @create 2016年8月23日
 */

@Controller
@RequestMapping("/numericalController")
public class NumericalController extends BaseController {
	
	@Resource
	private ICustomerRemoteService customerService;
	
	@Resource
	private IOrderRemoteService orderRemoteService;
	
	@Autowired
	private IVehicleRemoteService vehicleRemoteService;

	@Autowired
	private IParkinglotRemoteService parkinglotRemoteService;
	
	@Resource
    IPayConfigService payConfigService;
	
	@Resource
	private IStatisticalService statisticalService;

	// 通过ajax请求数据 将请求的数据返回到页面进行图表的显示
		/**
		 * 注册会员统计
		 * @author:cuijinlong
		 * @date:2016年11月18日 下午2:31:28
		 * @param response
		 * @param request
		 */
		@RequestMapping("/gettestdata")
		public void getTestData(HttpServletResponse response, HttpServletRequest request) {
			Map<String, Object> params = new HashMap<String, Object>();
			MessageResult result = new MessageResult();
			String createStartTime = request.getParameter("createStartTime");
			String createEndTime = request.getParameter("createEndTime");
			Map<String, Object> json = new HashMap<String, Object>();
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM");
			SimpleDateFormat df2 = new SimpleDateFormat("yyyy-MM-dd");
			Calendar calendar = Calendar.getInstance();
			Date now = new Date();
			calendar.setTime(now);
			if (!StringUtils.isBlank(createStartTime)) {
				params.put("createStartTime", createStartTime);
				try {
					String temp = createStartTime+"-01";
					calendar.setTime(df2.parse(temp));
					calendar.add(Calendar.MONTH, 1);
					json.put("createStartTimeTemp", df2.format(calendar.getTime()));
				} catch (ParseException e) {
					calendar.add(Calendar.MONTH, -4);
					calendar.add(Calendar.DAY_OF_MONTH, 1);
					String createStartTimeTemp = new SimpleDateFormat("yyyy-MM").format(calendar.getTime());
					params.put("createStartTime", createStartTimeTemp);
					calendar.add(Calendar.MONTH, 1);
					json.put("createStartTimeTemp", df2.format(calendar.getTime()));
					e.printStackTrace();
				}
			} else {
				calendar.add(Calendar.MONTH, -4);
				calendar.add(Calendar.DAY_OF_MONTH, 1);
				String createStartTimeTemp = new SimpleDateFormat("yyyy-MM").format(calendar.getTime());
				params.put("createStartTime", createStartTimeTemp);
				calendar.add(Calendar.MONTH, 1);
				json.put("createStartTimeTemp", df2.format(calendar.getTime()));
			}
			if (!StringUtils.isBlank(createEndTime)) {
				params.put("createEndTime", createEndTime);
				try {
					String temp = createEndTime+"-01";
					calendar.setTime(df2.parse(temp));
					calendar.add(Calendar.MONTH, 1);
					json.put("createEndTime", df2.format(calendar.getTime()));
				}catch (ParseException e) {
					params.put("createEndTime", df.format(new Date()));
					calendar.setTime(new Date());
					calendar.add(Calendar.MONTH, 1);
					json.put("createEndTime", df2.format(calendar.getTime()));
					e.printStackTrace();
				}
			} else {
				params.put("createEndTime", df.format(new Date()));
				calendar.setTime(new Date());
				calendar.add(Calendar.MONTH, 1);
				json.put("createEndTime", df2.format(calendar.getTime()));
			}
			try {
				List<String> listStr = new ArrayList<String>();
				List listLong = new ArrayList();
				List list = customerService.getDateNumericalAction(params);
				String[] categories;
				for (int i = 0; i < list.size(); i++) {
					Map cus = (Map) list.get(i);
					Date str = (Date) cus.get("strDate");
					String format = new SimpleDateFormat("yyyy年MM月").format(str);
					listStr.add(format);
					
					listLong.add(cus.get("count"));
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
						NumericalController.class.getName(), e);
			}

		}
		/**
		 * 订单统计
		 * @author:cuijinlong
		 * @date:2016年11月18日 下午2:31:54
		 * @param response
		 * @param request
		 */
		@RequestMapping("/gettestdataOrder")
		public void gettestdataOrder(HttpServletResponse response, HttpServletRequest request) {
			MessageResult result = new MessageResult();
			String createStartTime = request.getParameter("createStartTime");
			String createEndTime = request.getParameter("createEndTime");
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			Map<String, Object> json = new HashMap<String, Object>();
			StatisticsQuery sq = new StatisticsQuery();
			Calendar calendar = Calendar.getInstance();
			Date now = new Date();
			calendar.setTime(now);
			try {
				if (StringUtils.isBlank(createStartTime)) {
					Calendar c = Calendar.getInstance();
					c.setTime(new Date());
					c.add(Calendar.MONTH, -6);
					sq.setStartDate(c.getTime());
					c.add(Calendar.MONTH, 1);
					json.put("createStartTime", new SimpleDateFormat("yyyy-MM-dd").format(c.getTime()));
				} else {
					try{
						String temp = createStartTime+"-01";
						sq.setStartDate(df.parse(temp));
						Calendar c = Calendar.getInstance();
						c.setTime(sq.getStartDate());
						c.add(Calendar.MONTH, 1);
						json.put("createStartTime", new SimpleDateFormat("yyyy-MM-dd").format(c.getTime()));
					}catch(Exception e){
						Calendar c = Calendar.getInstance();
						c.setTime(new Date());
						c.add(Calendar.MONTH, -6);
						sq.setStartDate(c.getTime());
						c.add(Calendar.MONTH, 1);
						json.put("createStartTime", new SimpleDateFormat("yyyy-MM-dd").format(c.getTime()));
					}
				}
				if (StringUtils.isBlank(createEndTime)) {
					sq.setEndDate(new Date());
					Calendar c = Calendar.getInstance();
					c.setTime(sq.getEndDate());
					c.add(Calendar.MONTH, 1);
					json.put("createendimeTemp", new SimpleDateFormat("yyyy-MM-dd").format(c.getTime()));
				} else {
					try{
						String temp = createEndTime+"-30";
						sq.setEndDate(df.parse(temp));
						Calendar c = Calendar.getInstance();
						c.setTime(sq.getEndDate());
						c.add(Calendar.MONTH, 1);
						json.put("createendimeTemp", new SimpleDateFormat("yyyy-MM-dd").format(c.getTime()));
					}catch(Exception e){
						sq.setEndDate(new Date());
						Calendar c = Calendar.getInstance();
						c.setTime(sq.getEndDate());
						c.add(Calendar.MONTH, 1);
						json.put("createendimeTemp", new SimpleDateFormat("yyyy-MM-dd").format(c.getTime()));
					}
				}
				Gson json1 = new Gson();
				long[] ret = orderRemoteService.gettestdataOrder(sq);
				String[] retDate = getDateArrByMonth(sq.getStartDate(), sq.getEndDate());
				json.put("categories", json1.toJson(retDate).toString());
				json.put("values", json1.toJson(ret).toString());
				out(response, json);
			} catch (Exception e) {
				result = new MessageResult(ConstantUtil.M_SYSTEM_ERROR, "统计订单失败");
				out(response, result);
				Log4jTask.addLog("统计订单失败", System.currentTimeMillis(), Log4jTask.ERROR, NumericalController.class.getName(),
						e);
			}

		}
		/**
		 * 车场订单 
		 * @author:cuijinlong
		 * @date:2016年11月18日 下午2:32:31
		 * @param response
		 * @param request
		 */

		@RequestMapping("/getParkall")
		public void gettestdatavehice(HttpServletResponse response, HttpServletRequest request) {
			String createStartTime = request.getParameter("createStartTime");
			String createEndTime = request.getParameter("createEndTime");
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM");
			SimpleDateFormat df1 = new SimpleDateFormat("yyyy-MM-dd");
			Map<String, Object> params = new HashMap<String, Object>();
			Map<String, Object> json = new HashMap<String, Object>();
			Calendar calendar = Calendar.getInstance();
			Date now = new Date();
			calendar.setTime(now);
			if (!StringUtils.isBlank(createStartTime)) {
				String temp = createStartTime+"-01";
				params.put("createStartTime", temp);
				Calendar c = Calendar.getInstance();
				try {
					c.setTime(df1.parse(temp));
					c.add(Calendar.MONTH, 1);
					json.put("createStartTime", df1.format(c.getTime()));
				} catch (ParseException e) {
					calendar.add(Calendar.MONTH, -4);
					calendar.add(Calendar.DAY_OF_MONTH, 1);
					String createStartTimeTemp = new SimpleDateFormat("yyyy-MM").format(calendar.getTime());
					createStartTimeTemp = createStartTimeTemp+"-01";
					params.put("createStartTime", createStartTimeTemp);
					calendar.add(Calendar.MONTH, 1);
					json.put("createStartTime", df1.format(calendar.getTime()));
					createStartTime = createStartTimeTemp;
					e.printStackTrace();
				}
			} else {
				calendar.add(Calendar.MONTH, -4);
				calendar.add(Calendar.DAY_OF_MONTH, 1);
				String createStartTimeTemp = new SimpleDateFormat("yyyy-MM").format(calendar.getTime());
				createStartTimeTemp = createStartTimeTemp+"-01";
				params.put("createStartTime", createStartTimeTemp);
				calendar.add(Calendar.MONTH, 1);
				json.put("createStartTime", df1.format(calendar.getTime()));
				createStartTime = createStartTimeTemp;
			}
			if (!StringUtils.isBlank(createEndTime)) {
				String temp = createEndTime+"-01";
				params.put("createEndTime", temp);
				Calendar c = Calendar.getInstance();
				try {
					c.setTime(df1.parse(temp));
					c.add(Calendar.MONTH, 1);
					json.put("createEndTime", df1.format(c.getTime()));
				} catch (ParseException e) {
					String createendimeTemp = new SimpleDateFormat("yyyy-MM").format(new Date());
					createendimeTemp = createendimeTemp+"-31";
					params.put("createEndTime", createendimeTemp);
					c.setTime(new Date());
					c.add(Calendar.MONTH, 1);
					json.put("createEndTime", new SimpleDateFormat("yyyy-MM-dd").format(c.getTime()));
					createEndTime = createendimeTemp;
					e.printStackTrace();
				}
			} else {
				String createendimeTemp = new SimpleDateFormat("yyyy-MM").format(new Date());
				createendimeTemp = createendimeTemp+"-31";
				params.put("createEndTime", createendimeTemp);
				Calendar c = Calendar.getInstance();
				c.setTime(new Date());
				c.add(Calendar.MONTH, 1);
				json.put("createEndTime", new SimpleDateFormat("yyyy-MM-dd").format(c.getTime()));
				createEndTime = createendimeTemp;
			}
			List<Parkinglot> parkList = parkinglotRemoteService.getParkall();// 查询所有车场
			SeriesVo[] retList = new SeriesVo[parkList.size()];
			String[] parkName = new String[parkList.size()];
			for (int i = 0; i < parkList.size(); i++) {
				Parkinglot park = parkList.get(i);
				SeriesVo vo = new SeriesVo();
				params.put("parkid", park.getId());
				long[] ret = orderRemoteService.getOrderByPark(params);
				vo.setName(park.getName());
				vo.setData(ret);
				retList[i] = vo;
				parkName[i] = park.getName();
			}
			try {
				String[] retDate = getDateArrByMonth(df.parse(createStartTime), df.parse(createEndTime));
				Gson gson = new Gson();
				String parkArr = gson.toJson(retList).toString();
				json.put("parkArr", parkArr);
				json.put("parkName", gson.toJson(parkName).toString());
				json.put("retDate", gson.toJson(retDate).toString());
				out(response, json);
			} catch (ParseException e) {
				e.printStackTrace();
			}

		}

		private String[] getDateArrByMonth(Date startDate, Date endDate) {
			Calendar c = Calendar.getInstance();
			List<String> list = new ArrayList<String>();
			SimpleDateFormat df = new SimpleDateFormat("yyyy年MM月");

			for (; startDate.getTime() <= endDate.getTime();) {
				String _startDate = df.format(startDate);
				list.add(_startDate);
				c.setTime(startDate);
				c.add(Calendar.MONTH, 1);
				startDate = c.getTime();
			}

			String[] ret = new String[list.size()];
			for (int i = 0; i < list.size(); i++) {
				ret[i] = list.get(i);
			}

			return ret;
		}

		/**
		 * //用户使用率
		 * 
		 * @author:崔金龙
		 * @date:2016年11月17日 下午4:41:08
		 * @param response
		 * @param request
		 */
		@RequestMapping("/customerPer")
		public void customerPer(HttpServletResponse response, HttpServletRequest request) {
			String createStartTime = request.getParameter("createStartTime");
			String createEndTime = request.getParameter("createEndTime");
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			StatisticsQuery sq = new StatisticsQuery();
			Map<String, Object> json = new HashMap<String, Object>();
			try {
				if (!StringUtils.isBlank(createStartTime)) {
					String temp = createStartTime+"-01";
					sq.setStartDate(df.parse(temp));
					Calendar c = Calendar.getInstance();
					c.setTime(sq.getStartDate());
					c.add(Calendar.MONTH, 1);
					json.put("createStartTime", df.format(c.getTime()));

				}
				if (!StringUtils.isBlank(createEndTime)) {
					String temp = createEndTime+"-01";
					sq.setEndDate(df.parse(temp));
					Calendar c = Calendar.getInstance();
					c.setTime(sq.getEndDate());
					c.add(Calendar.MONTH, 1);
					json.put("createEndTime", df.format(c.getTime()));
				}
				if (StringUtils.isBlank(createStartTime)) {
					Calendar c = Calendar.getInstance();
					c.setTime(new Date());
					c.add(Calendar.DAY_OF_MONTH, -6);
					sq.setStartDate(c.getTime());
					c.add(Calendar.MONTH,1);
					json.put("createStartTime", df.format(c.getTime()));
				}
				if (StringUtils.isBlank(createEndTime)) {
					sq.setEndDate(new Date());
					Calendar c = Calendar.getInstance();
					c.setTime(sq.getEndDate());
					c.add(Calendar.MONTH,1);
					json.put("createEndTime", df.format(c.getTime()));
				}
				Calendar cc = Calendar.getInstance();
				Date startDate = sq.getStartDate();
				int _week = getDayOfWeek(startDate);
				cc.setTime(startDate);
				while (_week != 1) {
					cc.add(Calendar.DAY_OF_MONTH, -1);
					_week = getDayOfWeek(cc.getTime());
				}
				startDate = cc.getTime();
				Date endDate = sq.getEndDate();
				_week = getDayOfWeek(endDate);
				cc.setTime(endDate);
				while (_week != 7) {
					cc.add(Calendar.DAY_OF_MONTH, 1);
					_week = getDayOfWeek(cc.getTime());
				}
				endDate = cc.getTime();
				sq.setStartDate(startDate);
				sq.setEndDate(endDate);
				String[] retDate = getDateArrByWeek(sq.getStartDate(), sq.getEndDate());
				long count = customerService.getCount();
				long[] cArr = customerService.findCustomerCo(sq);
				long[] xArr = customerService.findCustomerCos(sq);
				double[] iArr = new double[cArr.length];
				NumberFormat nf = NumberFormat.getInstance();
				nf.setMinimumFractionDigits(4);
				for (int i = 0; i < cArr.length; i++) {
					if (cArr[i] == 0 || xArr[i] == 0) {
						iArr[i] = 0;
					} else {
						iArr[i] = Double.valueOf(nf.format((double) cArr[i] / (double) xArr[i]));
					}
				}
				Gson gson = new Gson();
				json.put("count", count);
				json.put("cArr", gson.toJson(cArr).toString());
				json.put("iArr", gson.toJson(iArr).toString());
				json.put("xArr", gson.toJson(xArr).toString());
				json.put("retDate", gson.toJson(retDate).toString());
				out(response, json);
			} catch (Exception e) {
				e.printStackTrace();
			}

		}

		/**
		 * //获取星期几，周一到周日，返回1-7
		 * 
		 * @author:崔金龙
		 * @date:2016年11月17日 下午4:40:16
		 * @param date
		 * @return
		 */
		public int getDayOfWeek(Date date) {
			Calendar c = Calendar.getInstance();
			c.setTime(date);
			int d = c.get(Calendar.DAY_OF_WEEK) - 1;
			if (d == 0) {
				return 7;
			}
			return d;
		}

		/**
		 * 
		 * @author:崔金龙
		 * @date:2016年11月17日 下午4:40:50
		 * @param startDate
		 * @param endDate
		 * @return
		 */
		private String[] getDateArrByWeek(Date startDate, Date endDate) {
			Calendar c = Calendar.getInstance();
			List<String> list = new ArrayList<String>();
			SimpleDateFormat df = new SimpleDateFormat("YYYY年MM月dd日");
			for (; startDate.getTime() <= endDate.getTime();) {
				String _startDate = df.format(startDate);
				c.setTime(startDate);
				c.add(Calendar.WEEK_OF_MONTH, 1);
				startDate = c.getTime();
				String _endDate = df.format(startDate);
				c.setTime(startDate);
				c.add(Calendar.DATE, -1);
				_endDate = df.format(c.getTime());
				list.add(_startDate+"-"+_endDate);
			}

			String[] ret = new String[list.size()];
			for (int i = 0; i < list.size(); i++) {
				ret[i] = list.get(i);
			}

			return ret;
		}
	    
		//每日创建订单
		@RequestMapping("/getCreateOrder")
		public void getCreateOrder(HttpServletResponse response, HttpServletRequest request) throws ParseException {
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
				params.put("createEndTime", getdateymNum);
				json.put("createEndTimeTemp", getdateymNum);
			} else {
				String createEndTimeTemp = new SimpleDateFormat("yyyy-MM-dd").format(calendar.getTime());
				json.put("createEndTimeTemp", createEndTimeTemp);
				params.put("createEndTime", createEndTimeTemp);
			}

			if (!StringUtils.isBlank(createStartTime)) {
				String getdateymNum = UtilTimeFormatter.getStringTimeYMD(createStartTime);
				params.put("createStartTime", getdateymNum);
				json.put("createStartTimeTemp", getdateymNum);
			} else {
				calendar.add(Calendar.MONTH, 0);
				calendar.add(Calendar.DAY_OF_MONTH, -6);

				String createStartTimeTemp = new SimpleDateFormat("yyyy-MM-dd").format(calendar.getTime());
				json.put("createStartTimeTemp", createStartTimeTemp);
				params.put("createStartTime", createStartTimeTemp);

			}
			try{
				String[] categories;
				List<String> listStr = new ArrayList<String>();
				List listLong = new ArrayList();
				List list = orderRemoteService.getCreateOrders(params);
				for (int i = 0; i < list.size(); i++) {
					Map cus = (Map) list.get(i);
					Date str = (Date) cus.get("td_date");
					String format = new SimpleDateFormat("yyyy年MM月dd日").format(str);
					listStr.add(format);

					listLong.add(cus.get("COUNT"));
				}
				categories = listStr.toArray(new String[listStr.size()]);

				json.put("categories", categories);
				json.put("values", listLong.toArray());
				result = new MessageResult(ConstantUtil.M_SUCCESS, "成功", json);
				out(response, result);

			}catch(Exception e){
				result = new MessageResult(ConstantUtil.M_SYSTEM_ERROR, "统计订单失败");
				out(response, result);
				Log4jTask.addLog("统计订单失败", System.currentTimeMillis(), Log4jTask.ERROR, NumericalController.class.getName(),
						e);
			}
			
		}
		//在租车辆
		@RequestMapping("/getCarList")
		public void getCarList(HttpServletResponse response, HttpServletRequest request) {
			List<Vehicle> list = null;
			Map<String, Object> params = new HashMap<String, Object>();
			HashMap<String, Object> dataMap = new HashMap<String, Object>();

			String p_pageSize = request.getParameter("rows");
			if (!StringUtils.isEmpty(p_pageSize)) {
				params.put("pageSize", Integer.valueOf(p_pageSize));
			} else {
				params.put("pageSize", 10);
			}
			String p_pageNumber = request.getParameter("page");
			if (!StringUtils.isEmpty(p_pageNumber)) {
				params.put("startIndex", (Integer.valueOf(p_pageNumber) - 1) * Integer.valueOf(p_pageSize));
			} else {
				params.put("startIndex", 0);
			}

			String selectCity = request.getParameter("cityId");
			if (!StringUtils.isBlank(selectCity) && !("-1".equals(selectCity))) {
				params.put("selectCity", selectCity);
			} else {
				params.put("selectCity", null);
			}

			String brankch = request.getParameter("serviceId");
			if (!StringUtils.isEmpty(brankch)) {
				params.put("brankch", brankch);
			} else {
				params.put("brankch", null);
			}

			String parking = request.getParameter("carPortId");
			if (!StringUtils.isEmpty(parking)) {
				params.put("position", parking);
			} else {
				params.put("position", null);
			}
			try{
				int count = this.vehicleRemoteService.selectVehicleCarCount(params);
				// 获取列表
				list = this.vehicleRemoteService.selectVehicleCar(params);
				if(list!=null && list.size()>0){
					dataMap.put("list", list);
				}
				dataMap.put("total", count);
				dataMap.put("rows", list);
				webOut(response, dataMap);
				return;
			}catch(Exception e){
				throw e;
			}
		}

		/**
		 * 导出
		 * 
		 * @param response
		 * @param request
		 */
		@RequestMapping("/allList")
		public void allList(HttpServletResponse response, HttpServletRequest request) {
			List<Vehicle> list = null;
			Map<String, Object> params = new HashMap<String, Object>();
			HashMap<String, Object> dataMap = new HashMap<String, Object>();

			String selectCity = request.getParameter("cityId");
			if (!StringUtils.isBlank(selectCity) && !("-1".equals(selectCity))) {
				params.put("selectCity", selectCity);
			} else {
				params.put("selectCity", null);
			}

			String brankch = request.getParameter("serviceId");
			if (!StringUtils.isEmpty(brankch)) {
				params.put("brankch", brankch);
			} else {
				params.put("brankch", null);
			}

			String parking = request.getParameter("carPortId");
			if (!StringUtils.isEmpty(parking)) {
				params.put("position", parking);
			} else {
				params.put("position", null);
			}

			// 获取列表
			list = this.vehicleRemoteService.selectVehicleCar(params);

			exportExcel("在租车辆列表.xls", list, response, request);
		}

		/** */
		/**
		 * 导出数据为XLS格式
		 * 
		 * @param fileName
		 *            文件的名称，可以设为绝对路径，也可以设为相对路径
		 * @param content
		 *            数据的内容
		 */
		private void exportExcel(String fileName, List manager, HttpServletResponse response, HttpServletRequest request) {
			WritableWorkbook wwb;
			FileOutputStream fos;
			try {
				fos = new FileOutputStream(fileName);
				wwb = Workbook.createWorkbook(fos);

				WritableSheet ws = wwb.createSheet("在租车辆列表", 0); // 创建一个工作表

				// 设置单元格的文字格式
				WritableFont wf = new WritableFont(WritableFont.ARIAL, 12, WritableFont.NO_BOLD, false,
						UnderlineStyle.NO_UNDERLINE, Colour.BLACK);
				WritableCellFormat wcf = new WritableCellFormat(wf);
				wcf.setVerticalAlignment(VerticalAlignment.CENTRE);
				wcf.setAlignment(Alignment.CENTRE);
				ws.setRowView(1, 500);
				// 设置标题行

				ws.addCell(new Label(0, 0, "车辆型号", wcf));
				ws.addCell(new Label(1, 0, "车牌号", wcf));
				ws.addCell(new Label(2, 0, "取车车场/网点", wcf));
				ws.addCell(new Label(3, 0, "订单编号", wcf));
				ws.addCell(new Label(4, 0, "下单时间", wcf));

				int rowsCount = manager.size();
				;
				// 填充数据的内容
				Vehicle vehicle;
				for (int i = 0; i < rowsCount; i++) {
					vehicle = (Vehicle) manager.get(i);
					//
					if (vehicle.getVehiclemodelname() != null) {
						ws.addCell(new Label(0, i + 1, vehicle.getVehiclemodelname().toString(), wcf));
					}

					if (vehicle.getPlatenumber() != null) {
						ws.addCell(new Label(1, i + 1, vehicle.getPlatenumber().toString(), wcf));
					}
					if (null != vehicle.getGetCarParking()) {

						ws.addCell(new Label(2, i + 1, vehicle.getParkNameOrbranchname().toString(), wcf));
					}

					if (null != vehicle.getOrderId()) {

						ws.addCell(new Label(3, i + 1, vehicle.getOrderId().toString(), wcf));
					}

					if (null != vehicle.getCreateOrderTime()) {
						
						Date bt_createtime = vehicle.getCreateOrderTime();
						Date dt = new Date();// 如果不需要格式,可直接用dt,dt就是当前系统时间
						DateFormat df = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");// 设置显示格式
						
						ws.addCell(new Label(4, i + 1,df.format(bt_createtime)+"", wcf));
					}
				}

				wwb.write();
				wwb.close();
				FileInputStream fileInputStream = new FileInputStream(new File(fileName));
				response.reset(); // 必要地清除response中的缓存信息
				Date dt = new Date();// 如果不需要格式,可直接用dt,dt就是当前系统时间
				DateFormat df = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");// 设置显示格式
				String nowTime = "";
				nowTime = df.format(dt);// 用DateFormat的format()方法在dt中获取并以yyyy/MM/dd
										// HH:mm:ss格式显示
				fileName = "在租车辆列表" + nowTime + ".xls";
				final String userAgent = request.getHeader("USER-AGENT");
				String finalFileName = null;
				if (org.apache.commons.lang3.StringUtils.contains(userAgent, "MSIE")
						|| -1 != userAgent.indexOf("Trident")) {// IE浏览器
					finalFileName = URLEncoder.encode(fileName, "UTF8");
				} else if (org.apache.commons.lang3.StringUtils.contains(userAgent, "Mozilla")) {// google,火狐浏览器
					finalFileName = new String(fileName.getBytes(), "ISO8859-1");
				} else {
					finalFileName = URLEncoder.encode(fileName, "UTF8");// 其他浏览器
				}
				response.setHeader("Cache-Control", "private");
				response.setHeader("Pragma", "private");
				response.setContentType("application/vnd.ms-excel;charset=utf-8");
				response.setHeader("Content-Disposition", "attachment; filename=\"" + finalFileName + "\"");// 这里设置一下让浏览器弹出下载提示框，而不是直接在浏览器中打开

				// response.setCharacterEncoding("gb2312");//必须写，否则会有乱码
				// response.setE = System.Text.Encoding.UTF7; //必须写，否则会有乱码
				// response.setHeader("Content-Disposition", "attachment;
				// filename='分时订单.xls'");
				javax.servlet.ServletOutputStream out = response.getOutputStream();
				byte[] content = new byte[fileInputStream.available()];
				int length = 0;
				while ((length = fileInputStream.read(content)) != -1) {
					out.write(content, 0, length);
				}
				out.write(content);
				out.flush();
				fileInputStream.close();
				out.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		/**
		 * 当月注册用户转化率
		 * 
		 * @author:崔金龙
		 * @date:2016年11月17日 下午4:39:26
		 * @param response
		 * @param request
		 */
		@RequestMapping("/registerPer")
		public void registerPer(HttpServletResponse response, HttpServletRequest request) {
			String createStartTime = request.getParameter("createStartTime");
			String createEndTime = request.getParameter("createEndTime");
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			StatisticsQuery sq = new StatisticsQuery();
			Map<String, Object> json = new HashMap<String, Object>();
			try {
				if (!StringUtils.isBlank(createStartTime)) {
					String temp  =createStartTime+"-01";
					sq.setStartDate(df.parse(temp));
					Calendar c = Calendar.getInstance();
					c.setTime(sq.getStartDate());
					c.add(Calendar.MONTH, 1);
					json.put("createStartTime", df.format(c.getTime()));
				}
				if (!StringUtils.isBlank(createEndTime)) {
					String temp  =createEndTime+"-01";
					sq.setEndDate(df.parse(temp));
					Calendar c = Calendar.getInstance();
					c.setTime(sq.getEndDate());
					c.add(Calendar.MONTH, 1);
					json.put("createEndTime",  df.format(c.getTime()));
				}
				if (StringUtils.isBlank(createStartTime)) {
					Calendar c = Calendar.getInstance();
					c.setTime(new Date());
					c.add(Calendar.DAY_OF_MONTH, -6);
					sq.setStartDate(c.getTime());
					c.add(Calendar.MONTH, 1);
					json.put("createStartTime", df.format(c.getTime()));
				}
				if (StringUtils.isBlank(createEndTime)) {
					Calendar c = Calendar.getInstance();
					sq.setEndDate(new Date());
					c.setTime(new Date());
					c.add(Calendar.MONTH,1);
					json.put("createEndTime", df.format(c.getTime()));
				}
				Calendar cc = Calendar.getInstance();
				Date startDate = sq.getStartDate();
				int _week = getDayOfWeek(startDate);
				cc.setTime(startDate);
				while (_week != 1) {
					cc.add(Calendar.DAY_OF_MONTH, -1);
					_week = getDayOfWeek(cc.getTime());
				}
				startDate = cc.getTime();
				Date endDate = sq.getEndDate();
				_week = getDayOfWeek(endDate);
				cc.setTime(endDate);
				while (_week != 7) {
					cc.add(Calendar.DAY_OF_MONTH, 1);
					_week = getDayOfWeek(cc.getTime());
				}
				endDate = cc.getTime();
				sq.setStartDate(startDate);
				sq.setEndDate(endDate);
				String[] retDate = getDateArrByWeek(sq.getStartDate(), sq.getEndDate());
				long[] cArr = customerService.findCustomerCoReg(sq);
				long[] rArr = customerService.findCustomerReg(sq);
				double[] iArr = new double[cArr.length];
				NumberFormat nf = NumberFormat.getInstance();
				nf.setMinimumFractionDigits(4);
				for (int i = 0; i < cArr.length; i++) {

					if (cArr[i] == 0) {
						iArr[i] = 0;
					} else {
						iArr[i] = Double.valueOf(nf.format((double) cArr[i] / (double) rArr[i]));
					}
				}
				Gson gson = new Gson();
				json.put("cArr", gson.toJson(cArr).toString());
				json.put("rArr", gson.toJson(rArr).toString());
				json.put("iArr", gson.toJson(iArr).toString());
				json.put("retDate", gson.toJson(retDate).toString());
				out(response, json);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

	    //每日车场出场数
		@RequestMapping("/parkCreateOrder")
		public void parkCreateOrder(HttpServletResponse response, HttpServletRequest request) {
			Map<String, Object> params = new HashMap<String, Object>();
			MessageResult result = new MessageResult();

			String createStartTime = request.getParameter("createStartTime");
			String createEndTime = request.getParameter("createEndTime");
			Map<String, Object> json = new HashMap<String, Object>();

			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Calendar calendar = Calendar.getInstance();
			Date now = new Date();
			calendar.setTime(now);
			if (!StringUtils.isBlank(createEndTime)) {
				params.put("createEndTime", createEndTime);
				json.put("createEndTimeTemp", createEndTime);
			} else {
				String createEndTimeTemp = sdf.format(calendar.getTime());
				json.put("createEndTimeTemp", createEndTimeTemp);
				params.put("createEndTime", createEndTimeTemp);
			}

			if (!StringUtils.isBlank(createStartTime)) {
				params.put("createStartTime", createStartTime);
				json.put("createStartTimeTemp", createStartTime);
			} else {

				calendar.add(Calendar.MONDAY, 0);
				calendar.add(Calendar.DATE, -6);

				String createStartTimeTemp = sdf.format(calendar.getTime());
				json.put("createStartTimeTemp", createStartTimeTemp);
				params.put("createStartTime", createStartTimeTemp);
			}

			try {
				List<String> categories = new ArrayList<String>();
				
				Date startTime = sdf.parse((String) params.get("createStartTime"));
				Date endTime = sdf.parse((String) params.get("createEndTime"));
				
				int i = 0;
				while (startTime.getTime()+i*24*3600*1000 < endTime.getTime()) {
					categories.add(sdf.format(new Date(startTime.getTime()+i*24*3600*1000)));
					i++;
				}
				
				List<String> legends = new ArrayList<String>();
				List<Map<String, Object>> series = new ArrayList<Map<String,Object>>();

				List<Map<String, Object>> parkList = customerService.getParkOrderCount(params);
				Map<String,Object> serireMap = new HashMap<String,Object>();
				List<Integer> dataList = new ArrayList<Integer>();

				String lastParkId = "";
				Date lastTempDate = new Date(startTime.getTime());
				
				for (Map<String, Object> park : parkList) {
					Date date = sdf.parse(park.get("createDate").toString());
					Integer count = Integer.parseInt(park.get("count").toString());
					String parkID = park.get("rentParkID").toString();
					if (lastParkId.length() == 0) {//first
						legends.add(park.get("rentParkName").toString());
						serireMap.put("name", park.get("rentParkName"));
						serireMap.put("type", "line");
						
						if (date.after(startTime)) {
							int j = 0;
							while (startTime.getTime()+j*24*3600*1000 < date.getTime()) {
								dataList.add(0);
								j++;
							}
						}
					}else if (!parkID.equals(lastParkId)) {//next
						if (lastTempDate.before(endTime)) {
							int j = 1;
							while (lastTempDate.getTime()+j*24*3600*1000 <= endTime.getTime()) {
								dataList.add(0);
								j++;
							}
						}
						serireMap.put("data", dataList);
						series.add(serireMap);
						dataList = new ArrayList<Integer>();
						serireMap = new HashMap<String,Object>();
						legends.add(park.get("rentParkName").toString());
						serireMap.put("name", park.get("rentParkName"));
						serireMap.put("type", "line");
						lastTempDate = new Date(startTime.getTime());
						
						if (date.after(startTime)) {
							int j = 0;
							while (lastTempDate.getTime()+j*24*3600*1000 < date.getTime()) {
								dataList.add(0);
								j++;
							}
						}
					}else{//the same one
						int j = 1;
						while (lastTempDate.getTime()+j*24*3600*1000 < date.getTime()) {
							dataList.add(0);
							j++;
						}
					}
					dataList.add(count);
					lastTempDate = date;
					lastParkId = parkID;
				}
				
				if (lastParkId.length() > 0) {
					if (lastTempDate.before(endTime)) {
						int j = 1;
						while (lastTempDate.getTime()+j*24*3600*1000 <= endTime.getTime()) {
							dataList.add(0);
							j++;
						}
					}
					serireMap.put("data", dataList);
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
				Log4jTask.addLog("统计查询失败", System.currentTimeMillis(), Log4jTask.ERROR, NumericalController.class.getName(),
						e);
			}
		}
		
		
		
		//在场车辆统计	
		@RequestMapping("/getCarParkingList")
			public void getCarParkingList(HttpServletRequest request,HttpServletResponse response){
				
				List<Vehicle> list = null;
				Map<String, Object> params = new HashMap<String, Object>();
				HashMap<String, Object> dataMap = new HashMap<String, Object>();

				String p_pageSize = request.getParameter("rows");
				if (!StringUtils.isEmpty(p_pageSize)) {
					params.put("pageSize", Integer.valueOf(p_pageSize));
				} else {
					params.put("pageSize", 10);
				}
				String p_pageNumber = request.getParameter("page");
				if (!StringUtils.isEmpty(p_pageNumber)) {
					params.put("startIndex", (Integer.valueOf(p_pageNumber) - 1) * Integer.valueOf(p_pageSize));
				} else {
					params.put("startIndex", 0);
				}
				String parkingid = request.getParameter("carPortId");
				if (!StringUtils.isEmpty(parkingid)  && !"-1".equals(parkingid)) {
					params.put("parkingid", parkingid);
				} 	
				String branchid = request.getParameter("serviceId");
				if (!StringUtils.isEmpty(branchid) && !"-1".equals(branchid)) {
					params.put("branchingid", branchid);
				} 	
				String cityid = request.getParameter("cityId");
				if (!StringUtils.isEmpty(cityid) && !"-1".equals(cityid)) {
					params.put("cityingid", cityid);
				} 	
				String statusno = request.getParameter("statusing");
				if (!StringUtils.isEmpty(statusno)) {
					params.put("statusing", statusno);
				} 
				
				try{
					int count = this.vehicleRemoteService.selectVehicleCarListCount(params);
					
					list= 	this.vehicleRemoteService.selectVehicleCarList(params);
					
					dataMap.put("total", count);
					dataMap.put("rows", list);
					webOut(response, dataMap);
					return;
					
					
				}catch(Exception e){
							Log4jTask.addLog("获取车辆列表报错", System.currentTimeMillis(), Log4jTask.ERROR, NumericalController.class.getName(), e);
							MessageResult result = new MessageResult(ConstantUtil.M_SYSTEM_ERROR, "系统发生未知错误");
							out(response, result);
				}
			}
		
		
		/**
		 * 导出
		 * 
		 * @param response
		 * @param request
		 */
		@RequestMapping("/allLists")
		public void allLists(HttpServletResponse response, HttpServletRequest request) {
			List<Vehicle> list = null;
			Map<String, Object> params = new HashMap<String, Object>();
			HashMap<String, Object> dataMap = new HashMap<String, Object>();

			
			String parkingid = request.getParameter("carPortId");
			if (!StringUtils.isEmpty(parkingid)  && !"-1".equals(parkingid)) {
				params.put("parkingid", parkingid);
			} 	
			String branchid = request.getParameter("serviceId");
			if (!StringUtils.isEmpty(branchid) && !"-1".equals(branchid)) {
				params.put("branchingid", branchid);
			} 	
			String cityid = request.getParameter("cityId");
			if (!StringUtils.isEmpty(cityid) && !"-1".equals(cityid)) {
				params.put("cityingid", cityid);
			} 	
			String statusno = request.getParameter("statusing");
			if (!StringUtils.isEmpty(statusno)) {
				params.put("statusing", statusno);
			} 
			
			try{
				// 获取列表
				list= 	this.vehicleRemoteService.selectVehicleCarList(params);
				
				
				exportExcels("在场车辆列表.xls", list, response, request);
				
				
			}catch(Exception e){
						Log4jTask.addLog("获取车辆列表报错", System.currentTimeMillis(), Log4jTask.ERROR, NumericalController.class.getName(), e);
						MessageResult result = new MessageResult(ConstantUtil.M_SYSTEM_ERROR, "系统发生未知错误");
						out(response, result);
			}
			
		}
		
		
		
		/** */
		/**
		 * 导出数据为XLS格式
		 * 
		 * @param fileName
		 *            文件的名称，可以设为绝对路径，也可以设为相对路径
		 * @param content
		 *            数据的内容
		 */
		private void exportExcels(String fileName, List manager, HttpServletResponse response,
				HttpServletRequest request) {
			WritableWorkbook wwb;
			FileOutputStream fos;
			try {
				fos = new FileOutputStream(fileName);
				wwb = Workbook.createWorkbook(fos);

				WritableSheet ws = wwb.createSheet("在场车辆列表", 0); // 创建一个工作表

				// 设置单元格的文字格式
				WritableFont wf = new WritableFont(WritableFont.ARIAL, 12, WritableFont.NO_BOLD, false,
						UnderlineStyle.NO_UNDERLINE, Colour.BLACK);
				WritableCellFormat wcf = new WritableCellFormat(wf);
				wcf.setVerticalAlignment(VerticalAlignment.CENTRE);
				wcf.setAlignment(Alignment.CENTRE);
				ws.setRowView(1, 500);
				// 设置标题行
				
				ws.addCell(new Label(0, 0, "车场/网点名称", wcf));
				ws.addCell(new Label(1, 0, "车辆型号", wcf));
				ws.addCell(new Label(2, 0, "车牌号", wcf));
				ws.addCell(new Label(3, 0, "车辆电量", wcf));
				ws.addCell(new Label(4, 0, "可行驶里程数", wcf));
				ws.addCell(new Label(5, 0, "状态", wcf));
				int rowsCount = manager.size();
				;
				// 填充数据的内容
				Vehicle vehicle;
				for (int i = 0; i < rowsCount; i++) {
					vehicle =   (Vehicle) manager.get(i);
//					
					if(vehicle.getParkNameOrbranchname()!=null){
						ws.addCell(new Label(0, i + 1, vehicle.getParkNameOrbranchname().toString(), wcf));
					}
					
					
					if(vehicle.getVehiclemodelname()!=null){
						ws.addCell(new Label(1, i + 1, vehicle.getVehiclemodelname().toString(), wcf));
					}
					if(null != vehicle.getPlatenumber()){
						
						ws.addCell(new Label(2, i + 1, vehicle.getPlatenumber().toString(), wcf));
					}
					
					if(null != vehicle.getMileage()){
						
						ws.addCell(new Label(3, i + 1, vehicle.getMileage().toString(), wcf));
					}
					
					if(null!=vehicle.getElectricity()){
						ws.addCell(new Label(4, i + 1, vehicle.getElectricity().toString(), wcf));
					}
					int val = vehicle.getStatus();
					if(7 == val){
						ws.addCell(new Label(5, i + 1, "可用", wcf));
					}
					else if(8 == val){
						ws.addCell(new Label(5, i + 1, "已租", wcf));
					}
					else if(9 == val){
						ws.addCell(new Label(5, i + 1, "禁用/任务中", wcf));
						
					}else if(12 == val){
						ws.addCell(new Label(5, i + 1, "待整备", wcf));
					}else if(13 == val){
						ws.addCell(new Label(5, i + 1, "调整中", wcf));
					}else if(14 == val){
						ws.addCell(new Label(5, i + 1, "维修中", wcf));
					}
					else if(15 == val){
						ws.addCell(new Label(5, i + 1, "保养中", wcf));
					}
					else if(16 == val){
						ws.addCell(new Label(5, i + 1, "换车中", wcf));
					}

				}

				wwb.write();
				wwb.close();
				FileInputStream fileInputStream = new FileInputStream(new File(fileName));
				response.reset(); // 必要地清除response中的缓存信息
				Date dt = new Date();// 如果不需要格式,可直接用dt,dt就是当前系统时间
				DateFormat df = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");// 设置显示格式
				String nowTime = "";
				nowTime = df.format(dt);// 用DateFormat的format()方法在dt中获取并以yyyy/MM/dd
										// HH:mm:ss格式显示
				fileName = "在场车辆列表" + nowTime + ".xls";
				final String userAgent = request.getHeader("USER-AGENT");
				String finalFileName = null;
				if (org.apache.commons.lang3.StringUtils.contains(userAgent, "MSIE") || -1 != userAgent.indexOf("Trident")) {// IE浏览器
					finalFileName = URLEncoder.encode(fileName, "UTF8");
				} else if (org.apache.commons.lang3.StringUtils.contains(userAgent, "Mozilla")) {// google,火狐浏览器
					finalFileName = new String(fileName.getBytes(), "ISO8859-1");
				} else {
					finalFileName = URLEncoder.encode(fileName, "UTF8");// 其他浏览器
				}
				response.setHeader("Cache-Control", "private");  
				response.setHeader("Pragma", "private");  
				response.setContentType("application/vnd.ms-excel;charset=utf-8");
				response.setHeader("Content-Disposition", "attachment; filename=\"" + finalFileName + "\"");// 这里设置一下让浏览器弹出下载提示框，而不是直接在浏览器中打开
				
				javax.servlet.ServletOutputStream out = response.getOutputStream();
				byte[] content = new byte[fileInputStream.available()];
				int length = 0;
				while ((length = fileInputStream.read(content)) != -1) {
					out.write(content, 0, length);
				}
				out.write(content);
				out.flush();
				fileInputStream.close();
				out.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		/**
		 * @Description 短信统计
		 * @author:  zhuwq
		 * Create at: 2017年8月10日 下午4:41:37
		 * @param request
		 * @param response
		 */
	    @RequestMapping("/smsStatistical")
	    public void smsStatistical(HttpServletRequest request, HttpServletResponse response){
	        try{
	            
	            Map<String, Object> params = new HashMap<String, Object>();
	            
	            String p_pageSize = request.getParameter("rows");
	            if (!StringUtils.isEmpty(p_pageSize)) {
	                params.put("pageSize", Integer.valueOf(p_pageSize));
	            } else {
	                params.put("pageSize", 10);
	            }
	            String p_pageNumber = request.getParameter("page");
	            if (!StringUtils.isEmpty(p_pageNumber)) {
	                params.put("startIndex", (Integer.valueOf(p_pageNumber) - 1) * Integer.valueOf(p_pageSize));
	            } else {
	                params.put("startIndex", 0);
	            }
	            
	            String startTtime = request.getParameter("startTime");
	            if (!StringUtils.isBlank(startTtime))
	                params.put("startTime", startTtime);
	            
	            String endTime = request.getParameter("endTime");
	            if (!StringUtils.isBlank(endTime))
	                params.put("endTime", endTime);
	            String hostName = request.getServerName();
	            PayConfig payConfig = payConfigService.seleConfigByHost(hostName);
	            params.put("taskId", payConfig.getSmstaskid());
	            params.put("smsvalidatetaskid", payConfig.getSmsvalidatetaskid());
	            HashMap<String, Object> dataMap = new HashMap<String, Object>();
	            
	            List<Map<String,Object>> statisticalList = statisticalService.getSmsStatisticalList(params);
	            //获取总条数
	            Integer countAll = statisticalService.getSmsStatisticalListAllCount(params);
	            Integer count = statisticalService.getSmsStatisticalListCount(params);
	            dataMap.put("total", count);
	            dataMap.put("countAll", countAll);
	            dataMap.put("rows", statisticalList);
	            webOut(response, dataMap);
	            return;
	        }
	        catch(Exception e){
	            
	            Log4jTask.addLog("获取短信统计列表报错", System.currentTimeMillis(), Log4jTask.ERROR, NumericalController.class.getName(), e);
	            MessageResult result = new MessageResult(ConstantUtil.M_SYSTEM_ERROR, "系统发生未知错误");
	            out(response, result);
	        }
	 }
}
