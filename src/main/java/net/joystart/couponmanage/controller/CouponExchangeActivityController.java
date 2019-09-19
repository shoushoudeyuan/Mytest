package net.joystart.couponmanage.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import net.joystart.common.database.DataSourceAspect;
import net.joystart.common.util.ConstantUtil;
import net.joystart.common.util.MessageResult;
import net.joystart.common.util.SysLogUtil;
import net.joystart.couponmanage.entity.CouponExchangeActivity;
import net.joystart.couponmanage.entity.CouponExchangeCode;
import net.joystart.couponmanage.service.ICouponExchangeActivityService;
import net.joystart.couponmanage.service.ICouponExchangeCodeService;

/**
 * 优惠券兑换券码管理
* 
* @author zm.mu   
* @date 2018年5月31日 下午2:20:17
 */
@Controller
@RequestMapping("/couponExchangeActivity")
public class CouponExchangeActivityController extends BaseController {

	@Autowired
	private ICouponExchangeActivityService couponExchangeActivityService;
	
	@Resource
	private ICouponExchangeCodeService couponExchangeCodeService;

	/**
	 * 兑换活动列表
	 * @param request
	 * @param response
	 */
	@RequestMapping("/getExActivityList")
	public void getActivityList(HttpServletRequest request, HttpServletResponse response) {
		HashMap<String, Object> result = new HashMap<String, Object>();
		Integer page = request.getParameter("page") == null ? 1 : Integer.valueOf(request.getParameter("page"));
		Integer rows = request.getParameter("rows") == null ? 10 : Integer.valueOf(request.getParameter("rows"));
		String activityName = request.getParameter("activityName");
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("startIndex", (page-1)*rows);
		paramMap.put("pageSize", rows);
		if (StringUtils.isNotEmpty(activityName)) {
			paramMap.put("activityName", activityName);
		}
		try {
			List<CouponExchangeActivity> list = couponExchangeActivityService.getCouponExchangeActivityList(paramMap);
			Integer count = couponExchangeActivityService.getCouponExchangeActivityCount(paramMap);
			result.put("total", count);
			result.put("rows", list);
			webOut(response, result);
		} catch (Exception e) {
			logger.error("获取优惠券兑换活动列表错误,"+DataSourceAspect.getCurrentDataSource(), e);
			result.put("code", ConstantUtil.W_SYSTEM_ERROR);
			result.put("message", "获取优惠券兑换活动列表错误");
			webOut(response, result);
		}
	}
	
	/**
	 * 添加兑换活动
	 * @param request
	 * @param response
	 * @param activity
	 */
	@RequestMapping("/addActivity")
	public void addActivity(HttpServletRequest request, HttpServletResponse response,CouponExchangeActivity activity){
		MessageResult result;
		if (StringUtils.isEmpty(activity.getActivityName())||activity.getExchangeCount()==null
				||activity.getIsEnable()==null ||activity.getEndDate()==null) {
			result = new MessageResult(ConstantUtil.W_PARAWTER_NULL,"参数缺失");
			webOut(response, result);
			return;
		}
		try {
			activity.setEndDate(new Date(activity.getEndDate().getTime()+(24*3600-1)*1000));
			couponExchangeActivityService.addActivityAndCreateExchangeCode(activity);
			SysLogUtil.addLog(request, "创建优惠券兑换码活动："+activity.getActivityName(), 1);
			result = new MessageResult(ConstantUtil.W_SUCCESS,"success");
			webOut(response, result);
		} catch (Exception e) {
			SysLogUtil.addLog(request, "创建优惠券兑换码活动:"+activity.getActivityName(), 0);
			logger.error("创建优惠券兑换码活动错误,"+DataSourceAspect.getCurrentDataSource(), e);
			result = new MessageResult(ConstantUtil.W_EXCEPTION,"操作失败");
			webOut(response, result);
		}
	}
	
	/**
	 * 编辑更新活动
	 * @param request
	 * @param response
	 * @param activity
	 */
	@RequestMapping("/editActivity")
	public void editActivity(HttpServletRequest request, HttpServletResponse response,CouponExchangeActivity activity){
		MessageResult result;
		if (StringUtils.isEmpty(activity.getActivityName())||activity.getIsEnable()==null ||activity.getEndDate()==null) {
			result = new MessageResult(ConstantUtil.W_PARAWTER_NULL,"参数缺失");
			webOut(response, result);
			return;
		}
		try {
			activity.setEndDate(new Date(activity.getEndDate().getTime()+(24*3600-1)*1000));
			int status = couponExchangeActivityService.updateCouponExchangeActivity(activity);
			if (status > -1) {
				SysLogUtil.addLog(request, "编辑更新活动:"+activity.getActivityName(), 1);
				result = new MessageResult(ConstantUtil.W_SUCCESS,"success");
				webOut(response, result);
			}else{
				SysLogUtil.addLog(request, "编辑更新活动:"+activity.getActivityName(), 0);
				result = new MessageResult(ConstantUtil.W_SYSTEM_ERROR,"更新优惠券兑换码活动失败");
				webOut(response, result);
			}
		} catch (Exception e) {
			logger.error("更新优惠券兑换码活动失败,"+DataSourceAspect.getCurrentDataSource(), e);
			SysLogUtil.addLog(request, "编辑更新活动:"+activity.getActivityName(), 0);
			result = new MessageResult(ConstantUtil.W_EXCEPTION,"操作失败");
			webOut(response, result);
		}
	}
	
	/**
	 * 删除活动
	 * @param request
	 * @param response
	 */
	@RequestMapping("/deleteActivity")
	public void deleteActivity(HttpServletRequest request, HttpServletResponse response){
		MessageResult result;
		String ids = request.getParameter("ids");
		if (StringUtils.isBlank(ids)) {
			result = new MessageResult(ConstantUtil.W_PARAWTER_NULL,"参数缺失");
			webOut(response, result);
			return;
		}
		try {
			String idsArr[] = ids.split(",");
			List<Integer> list = new ArrayList<>();
			for (int i = 0; i < idsArr.length; i++) {
				list.add(Integer.parseInt(idsArr[i]));
			}
			int status = couponExchangeActivityService.deleteCouponExchangeActivity(list);
			if (status > -1) {
				SysLogUtil.addLog(request, "删除活动", 1);
				result = new MessageResult(ConstantUtil.W_SUCCESS,"success");
				webOut(response, result);
			}else{
				SysLogUtil.addLog(request, "删除活动", 0);
				result = new MessageResult(ConstantUtil.W_SYSTEM_ERROR,"删除优惠券兑换码活动失败");
				webOut(response, result);
			}
			
		} catch (Exception e) {
			SysLogUtil.addLog(request, "删除活动", 0);
			logger.error("删除优惠券兑换码活动失败,"+DataSourceAspect.getCurrentDataSource(), e);
			result = new MessageResult(ConstantUtil.W_EXCEPTION,"操作失败");
			webOut(response, result);
		}
	}
	
	/**
	 * 获取优惠券券码列表
	 * @param request
	 * @param response
	 */
	@RequestMapping("/getCouponExchangeCodeList")
	public void getCouponExchangeCodeList(HttpServletRequest request, HttpServletResponse response){
		HashMap<String, Object> result = new HashMap<String, Object>();
		Integer page = request.getParameter("page") == null ? 1 : Integer.valueOf(request.getParameter("page"));
		Integer rows = request.getParameter("rows") == null ? 10 : Integer.valueOf(request.getParameter("rows"));
		String activityId = request.getParameter("activityId");
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("startIndex", (page-1)*rows);
		paramMap.put("pageSize", rows);
		
		if (StringUtils.isEmpty(activityId)) {
			result.put("code", ConstantUtil.W_PARAWTER_NULL);
			result.put("message", "参数为空");
			webOut(response, result);
			return;
		}
		paramMap.put("activityId", activityId);
		
		try {
			List<CouponExchangeCode> list = couponExchangeCodeService.getCouponExchangeCodeList(paramMap);
			Integer count = couponExchangeCodeService.getCouponExchangeCodeCount(paramMap);
			result.put("total", count);
			result.put("rows", list);
			webOut(response, result);
		} catch (Exception e) {
			logger.error("获取优惠券兑换码错误,"+DataSourceAspect.getCurrentDataSource(), e);
			result.put("code", ConstantUtil.W_SYSTEM_ERROR);
			result.put("message", "获取优惠券兑换码错误");
			webOut(response, result);
		}
	}
	
	/**
	 * 导出活动列表
	 * @param response
	 * @param request
	 */
	@RequestMapping("/exportActivity")
	public void exportActivity(HttpServletResponse response, HttpServletRequest request) {
		String activityName = request.getParameter("activityName");
		String selectIds = request.getParameter("selectIds");
		Map<String, Object> paramMap = new HashMap<>();
		if (StringUtils.isNotEmpty(activityName)) {
			paramMap.put("activityName", activityName);
		}
		if (StringUtils.isNotEmpty(selectIds)) {
			paramMap.put("selectIds", selectIds);
		}
		try {
			List<CouponExchangeCode> list = couponExchangeCodeService.getCouponExchangeCodeList4Export(paramMap);
			exportExcel("券码列表.xls", list, response, request);
		} catch (Exception e) {
			HashMap<String, Object> result = new HashMap<String, Object>();
			logger.error("导出优惠券兑换活动列表错误,"+DataSourceAspect.getCurrentDataSource(), e);
			result.put("code", ConstantUtil.W_SYSTEM_ERROR);
			result.put("message", "导出优惠券兑换活动列表错误");
			webOut(response, result);
		}
	}
	
	/**
	 * 导出数据为XLS格式
	 * 
	 * @param fileName
	 *            文件的名称，可以设为绝对路径，也可以设为相对路径
	 * @param content
	 *            数据的内容
	 */
	private void exportExcel(String fileName, List<CouponExchangeCode> exCodeList, HttpServletResponse response,
			HttpServletRequest request) {
		WritableWorkbook wwb;
		FileOutputStream fos;
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			fos = new FileOutputStream(fileName);
			wwb = Workbook.createWorkbook(fos);

			WritableSheet ws = wwb.createSheet("优惠券兑换活动列表", 0); // 创建一个工作表

			// 设置单元格的文字格式
			WritableFont wf = new WritableFont(WritableFont.ARIAL, 12, WritableFont.NO_BOLD, false,
					UnderlineStyle.NO_UNDERLINE, Colour.BLACK);
			WritableCellFormat wcf = new WritableCellFormat(wf);
			wcf.setVerticalAlignment(VerticalAlignment.CENTRE);
			wcf.setAlignment(Alignment.CENTRE);
			ws.setRowView(1, 500);
			// 设置标题行
			ws.addCell(new Label(0, 0, "券码", wcf));
			ws.addCell(new Label(1, 0, "状态", wcf));
			ws.addCell(new Label(2, 0, "兑换状态", wcf));
			ws.addCell(new Label(3, 0, "活动名称", wcf));
			ws.addCell(new Label(4, 0, "创建日期", wcf));
			ws.addCell(new Label(5, 0, "过期日期", wcf));
			ws.addCell(new Label(6, 0, "兑换日期", wcf));
			ws.addCell(new Label(7, 0, "用户手机号", wcf));
			int rowsCount = exCodeList.size();
			// 填充数据的内容
			CouponExchangeCode code;
			for (int i = 0; i < rowsCount; i++) {
				code = exCodeList.get(i);
				ws.addCell(new Label(0, i + 1,code.getCode(), wcf));
				ws.addCell(new Label(1, i + 1, code.getIsEnable()==1?"启用":"禁用", wcf));
				ws.addCell(new Label(2, i + 1,code.getIsExchanged()==1?"未兑换":"已兑换", wcf));
				ws.addCell(new Label(3, i + 1, code.getActivityName(), wcf));
				ws.addCell(new Label(4, i + 1,simpleDateFormat.format(code.getCreateDate()) , wcf));
				ws.addCell(new Label(5, i + 1,simpleDateFormat.format(code.getEndDate()), wcf));
				ws.addCell(new Label(6, i + 1,code.getExchangeDate()==null?"":simpleDateFormat.format(code.getExchangeDate()), wcf));
				ws.addCell(new Label(7, i + 1,code.getCustomerMobile()==null?"":code.getCustomerMobile(), wcf));
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
			fileName = "优惠券兑换活动列表" + nowTime + ".xls";
			final String userAgent = request.getHeader("USER-AGENT");
			String finalFileName = null;
			if (StringUtils.contains(userAgent, "MSIE") || -1 != userAgent.indexOf("Trident")) {// IE浏览器
				finalFileName = URLEncoder.encode(fileName, "UTF8");
			} else if (StringUtils.contains(userAgent, "Mozilla")) {// google,火狐浏览器
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
			logger.error("导出活动列表出错"+e.getMessage()+","+DataSourceAspect.getCurrentDataSource(),e);
		}
	}

}
