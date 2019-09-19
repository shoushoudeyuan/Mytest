package net.joystart.activity.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
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
import org.apache.commons.lang3.time.DateFormatUtils;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
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
import jxl.write.WriteException;
import jxl.write.biff.RowsExceededException;
import net.joystart.activity.entity.Activities;
import net.joystart.activity.entity.ActivityRedPacket;
import net.joystart.activity.service.IActivitiesService;
import net.joystart.common.controller.BaseController;
import net.joystart.common.util.ConstantUtil;
import net.joystart.common.util.DataGridResult;
import net.joystart.common.util.MessageResult;
import net.joystart.common.util.PageUtil;
import net.joystart.common.util.SysLogUtil;
import net.joystart.common.util.log.Log4jTask;

@Controller
@RequestMapping("/activity")
public class ActivitiesController extends BaseController {
	@Resource
	private IActivitiesService activitiesService;

	@InitBinder
	@Override
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		dateFormat.setLenient(false);
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}
	
	@RequestMapping("/getActivities")
	public void getActivities(HttpServletResponse response, HttpServletRequest request, int rows, int page) {
		MessageResult result = new MessageResult();
		String activityName = request.getParameter("activityName");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("rowStart", PageUtil.rowStart(page - 1, rows));
		params.put("pageSize", rows);
		if (StringUtils.isNotBlank(activityName)) {
			params.put("activityName", activityName);
		}
		try {
			List<Activities> activities = activitiesService.getActivities(params);
			if (activities.isEmpty()) {
				activities = new ArrayList<Activities>();
			}
			DataGridResult dgr = new DataGridResult();
			int rowCount = activitiesService.getActivityCount(params);
			dgr.setTotal(rowCount);
			dgr.setRows(activities);
			this.webOut(response, dgr);
			return;
		} catch (Exception e) {
			result = new MessageResult(ConstantUtil.M_SYSTEM_ERROR, "服务器繁忙，请稍后重试");
			out(response, result);
			Log4jTask.addLog("获取活动列表时出现异常", System.currentTimeMillis(), Log4jTask.ERROR,
					ActivitiesController.class.getName(), e);
		}
	}

	@RequestMapping("/getActivity")
	public void getActivity(HttpServletResponse response, HttpServletRequest request) {
		MessageResult result = new MessageResult();
		try {
			String activityId = request.getParameter("activityId");
			Map<String, Object> params = new HashMap<String, Object>();
			if (StringUtils.isNotBlank(activityId)) {
				params.put("activityId", Integer.parseInt(activityId));
			}

			Activities activity = activitiesService.getActivity(params);
			if (null == activity) {
				activity = new Activities();
			}
			this.webOut(response, activity);
			return;
		} catch (Exception e) {
			result = new MessageResult(ConstantUtil.M_SYSTEM_ERROR, "服务器繁忙，请稍后重试");
			out(response, result);
			Log4jTask.addLog("获取活动时出现异常", System.currentTimeMillis(), Log4jTask.ERROR,
					ActivitiesController.class.getName(), e);
		}
	}

	@RequestMapping("/saveActivity")
	public void saveActivity(Activities activity, HttpServletResponse response, HttpServletRequest request) {
		MessageResult result = new MessageResult();
		int res = 0;
		try {
			String activitylink = "http://localhost:8080/event/do.jsp";
			if (null == activity.getId()) {
				activity.setActivitylink(activitylink);
				activity.setCreatedate(new Date());
				res = activitiesService.insertSelective(activity);
				SysLogUtil.addLog(request, "新增活动", 1);
			} else {
				res = activitiesService.modifyActivityById(activity);
				SysLogUtil.addLog(request, "修改活动", 1);
			}
			Map<String, Object> data = new HashMap<String, Object>();
			data.put("result", res);
			
			this.webOut(response, data);
			return;
		} catch (Exception e) {
			SysLogUtil.addLog(request, "保存活动", 0);
			result = new MessageResult(ConstantUtil.M_SYSTEM_ERROR, "服务器繁忙，请稍后重试");
			out(response, result);
			Log4jTask.addLog("保存活动时出现异常", System.currentTimeMillis(), Log4jTask.ERROR,
					ActivitiesController.class.getName(), e);
		}
	}

	@RequestMapping("/deleteActivity")
	public void deleteActivity(String activityIds, HttpServletResponse response, HttpServletRequest request) {
		MessageResult result = new MessageResult();
		int res = 0;
		try {
			if (StringUtils.isNotBlank(activityIds)) {
				String[] ids = activityIds.split("\\,");
				res = activitiesService.deleteActivity(ids);
				SysLogUtil.addLog(request, "删除活动", 1);
			}
			this.webOut(response, res);
			return;
		} catch (Exception e) {
			SysLogUtil.addLog(request, "删除活动", 0);
			result = new MessageResult(ConstantUtil.M_SYSTEM_ERROR, "服务器繁忙，请稍后重试");
			out(response, result);
			Log4jTask.addLog("删除活动时出现异常", System.currentTimeMillis(), Log4jTask.ERROR,
					ActivitiesController.class.getName(), e);
		}
	}

	/**
	 * 获取活动红包列表
	 * 
	 * @param response
	 * @param request
	 * @param rows
	 * @param page
	 */
	@RequestMapping("/getRedEnvelopes")
	public void getActivityRedEnvelopes(HttpServletResponse response, HttpServletRequest request, int rows, int page) {
		MessageResult result = new MessageResult();
		String activityId = request.getParameter("activityId");// 活动ID
		String packetNum = request.getParameter("packetNum");// 红包编码
		String isUsed = request.getParameter("isUsed");// 是否使用
		String isEnable = request.getParameter("isEnable");// 是否启用

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("rowStart", PageUtil.rowStart(page - 1, rows));
		params.put("pageSize", rows);
		params.put("activityId", activityId);
		if (StringUtils.isNotBlank(packetNum)) {
			params.put("packetNum", packetNum);
		}
		if (StringUtils.isNotBlank(isUsed)) {
			params.put("isUsed", isUsed);
		}
		if (StringUtils.isNotBlank(isEnable)) {
			params.put("isEnable", isEnable);
		}
		try {
			List<ActivityRedPacket> activityRedPackets = activitiesService.getActivityRedPackets(params);
			if (activityRedPackets.isEmpty()) {
				activityRedPackets = new ArrayList<ActivityRedPacket>();
			}
			DataGridResult dgr = new DataGridResult();
			int rowCount = activitiesService.getActivityRedPacketCount(params);
			dgr.setTotal(rowCount);
			dgr.setRows(activityRedPackets);
			this.webOut(response, dgr);
			return;
		} catch (Exception e) {
			result = new MessageResult(ConstantUtil.M_SYSTEM_ERROR, "服务器繁忙，请稍后重试");
			out(response, result);
			Log4jTask.addLog("获取活动红包列表时出现异常", System.currentTimeMillis(), Log4jTask.ERROR,
					ActivitiesController.class.getName(), e);
		}
	}

	/**
	 * 获取活动红包
	 * 
	 * @param response
	 * @param request
	 */
	@RequestMapping("/getRedEnvelope")
	public void getActivityRedEnvelope(HttpServletResponse response, HttpServletRequest request) {
		MessageResult result = new MessageResult();
		try {
			String redEnvelopeId = request.getParameter("redEnvelopeId");
			Map<String, Object> params = new HashMap<String, Object>();
			if (StringUtils.isNotBlank(redEnvelopeId)) {
				params.put("activityRedPacketId", Integer.parseInt(redEnvelopeId));
			}

			ActivityRedPacket redPacket = activitiesService.getActivityRedPacket(params);
			if (null == redPacket) {
				redPacket = new ActivityRedPacket();
			}
			this.webOut(response, redPacket);
			return;
		} catch (Exception e) {
			result = new MessageResult(ConstantUtil.M_SYSTEM_ERROR, "服务器繁忙，请稍后重试");
			out(response, result);
			Log4jTask.addLog("获取活动红包时出现异常", System.currentTimeMillis(), Log4jTask.ERROR,
					ActivitiesController.class.getName(), e);
		}
	}

	@RequestMapping("/saveRedEnvelope")
	public void saveRedEnvelope(ActivityRedPacket activityRedPacket, HttpServletResponse response,
			HttpServletRequest request) {
		MessageResult result = new MessageResult();
		int res = 0;
		try {
			if (null == activityRedPacket.getId()) {
				activityRedPacket.setCreatedate(new Date());
				res = activitiesService.batchInsertActivityRedPacket(activityRedPacket);
				SysLogUtil.addLog(request, "批量插入活动红包", 1);
			} else {
				res = activitiesService.modifyActivityRedPacketById(activityRedPacket);
				SysLogUtil.addLog(request, "修改活动红包", 1);
			}
			Map<String, Object> data = new HashMap<String, Object>();
			data.put("result", res);
			this.webOut(response, data);
			return;
		} catch (Exception e) {
			SysLogUtil.addLog(request, "保存活动红包", 0);
			result = new MessageResult(ConstantUtil.M_SYSTEM_ERROR, "服务器繁忙，请稍后重试");
			out(response, result);
			Log4jTask.addLog("保存活动红包时出现异常", System.currentTimeMillis(), Log4jTask.ERROR,
					ActivitiesController.class.getName(), e);
		}
	}

	@RequestMapping("/deleteRedEnvelope")
	public void deleteRedEnvelope(String activityRedPacketIds, HttpServletResponse response,
			HttpServletRequest request) {
		MessageResult result = new MessageResult();
		int res = 0;
		try {
			if (StringUtils.isNotBlank(activityRedPacketIds)) {
				String[] ids = activityRedPacketIds.split("\\,");
				res = activitiesService.deleteActivityRedPacket(ids);
				SysLogUtil.addLog(request, "删除活动红包", 1);
			}
			this.webOut(response, res);
			return;
		} catch (Exception e) {
			SysLogUtil.addLog(request, "删除活动红包", 0);
			result = new MessageResult(ConstantUtil.M_SYSTEM_ERROR, "服务器繁忙，请稍后重试");
			out(response, result);
			Log4jTask.addLog("删除活动红包时出现异常", System.currentTimeMillis(), Log4jTask.ERROR,
					ActivitiesController.class.getName(), e);
		}
	}

	/**
	 * 导出活动红包
	 * 
	 * @param response
	 * @param request
	 */
	@RequestMapping("/exportRedEnvelopes")
	public void exportRedEnvelopes(HttpServletResponse response, HttpServletRequest request) {
		MessageResult result = new MessageResult();
		String activityId = request.getParameter("activityId");// 活动ID
		String packetNum = request.getParameter("packetNum");// 红包编码
		String isUsed = request.getParameter("isUsed");// 是否使用
		String isEnable = request.getParameter("isEnable");// 是否启用
		String ruleName = request.getParameter("couponrulename");// 规则名称

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("activityId", activityId);
		if (StringUtils.isNotBlank(packetNum)) {
			params.put("packetNum", packetNum);
		}
		if (StringUtils.isNotBlank(isUsed)) {
			params.put("isUsed", isUsed);
		}
		if (StringUtils.isNotBlank(isEnable)) {
			params.put("isEnable", isEnable);
		}
		try {
			List<ActivityRedPacket> activityRedPackets = activitiesService.getActivityRedPackets(params);
			exportExcel("redPacket.xls", ruleName, activityRedPackets, response, request);
			return;
		} catch (Exception e) {
			result = new MessageResult(ConstantUtil.M_SYSTEM_ERROR, "服务器繁忙，请稍后重试");
			out(response, result);
			Log4jTask.addLog("获取活动红包列表时出现异常", System.currentTimeMillis(), Log4jTask.ERROR,
					ActivitiesController.class.getName(), e);
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
	private void exportExcel(String fileName, String ruleName, List<ActivityRedPacket> activityRedPackets,
			HttpServletResponse response, HttpServletRequest request) {
		WritableWorkbook wwb;
		FileOutputStream fos;
		try {
			fos = new FileOutputStream(fileName);
			wwb = Workbook.createWorkbook(fos);

			WritableSheet ws = wwb.createSheet("红包列表", 0); // 创建一个工作表

			// 设置单元格的文字格式
			WritableFont wf = new WritableFont(WritableFont.ARIAL, 12, WritableFont.NO_BOLD, false,
					UnderlineStyle.NO_UNDERLINE, Colour.BLACK);
			WritableCellFormat wcf = new WritableCellFormat(wf);
			wcf.setVerticalAlignment(VerticalAlignment.CENTRE);
			wcf.setAlignment(Alignment.CENTRE);
			ws.setRowView(1, 500);
			// 设置标题行
			ws.addCell(new Label(0, 0, "编码", wcf));
			ws.addCell(new Label(1, 0, "备注", wcf));
			ws.addCell(new Label(2, 0, "来源", wcf));
			ws.addCell(new Label(3, 0, "生效日期", wcf));
			ws.addCell(new Label(4, 0, "失效日期", wcf));
			int rowsCount = activityRedPackets.size();
			;
			// 填充数据的内容
			ActivityRedPacket redPacket;
			for (int i = 0; i < rowsCount; i++) {
				redPacket = activityRedPackets.get(i);
				ws.addCell(new Label(0, i + 1, redPacket.getPacketnum(), wcf));
				ws.addCell(new Label(1, i + 1, redPacket.getRemark(), wcf));
				ws.addCell(new Label(2, i + 1, ruleName, wcf));
				ws.addCell(
						new Label(3, i + 1,
								redPacket.getStartdate() == null ? ""
										: DateFormatUtils.format(redPacket.getStartdate(), "yyyy-MM-dd HH:mm:ss"),
								wcf));
				ws.addCell(new Label(4, i + 1, redPacket.getEnddate() == null ? ""
						: DateFormatUtils.format(redPacket.getEnddate(), "yyyy-MM-dd HH:mm:ss"), wcf));
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
			fileName = "活动红包" + nowTime + ".xls";
			final String userAgent = request.getHeader("USER-AGENT");
			String finalFileName = null;
			if (StringUtils.contains(userAgent, "MSIE")) {// IE浏览器
				finalFileName = URLEncoder.encode(fileName, "UTF8");
			} else if (StringUtils.contains(userAgent, "Mozilla")) {// google,火狐浏览器
				finalFileName = new String(fileName.getBytes(), "ISO8859-1");
			} else {
				finalFileName = URLEncoder.encode(fileName, "UTF8");// 其他浏览器
			}
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
		} catch (IOException e) {
		} catch (RowsExceededException e) {
		} catch (WriteException e) {
		}
	}
}
