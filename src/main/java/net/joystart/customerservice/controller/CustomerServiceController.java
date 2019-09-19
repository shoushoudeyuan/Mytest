package net.joystart.customerservice.controller;

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
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;

import net.joystart.common.controller.BaseController;
import net.joystart.common.util.ConstantUtil;
import net.joystart.common.util.DataGridResult;
import net.joystart.common.util.MessageResult;
import net.joystart.common.util.PageUtil;
import net.joystart.common.util.SysLogUtil;
import net.joystart.common.util.log.Log4jTask;
import net.joystart.customerservice.entity.AnswerQuestion;
import net.joystart.customerservice.entity.QuestionCategory;
import net.joystart.customerservice.entity.ServiceEvent;
import net.joystart.customerservice.service.ICustomerServiceService;

/**
 * 客服管理
 * @author LDY20151214
 *
 */
@Controller
@RequestMapping("/customerService")
public class CustomerServiceController extends BaseController {
	@Resource
	private ICustomerServiceService customerServiceService;


	@InitBinder
	@Override
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		dateFormat.setLenient(false);
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}
	
	/**
	 * 获取服务记录列表
	 * @param response
	 * @param request
	 */
	@RequestMapping("/getServiceEvents")
	public void getServiceEvents(HttpServletResponse response, HttpServletRequest request, int rows, int page) {
		MessageResult result = new MessageResult();
		try {
			String orderNo = request.getParameter("orderNo");
			String name = request.getParameter("customerName");
			String mobile = request.getParameter("mobile");
			String eventCategory = request.getParameter("eventcategory");
			String dealwithresult = request.getParameter("dealwithresult");
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("rowStart", PageUtil.rowStart(page - 1, rows));
			params.put("pageSize", rows);
			params.put("eventcategory", eventCategory);
			if (StringUtils.isNotBlank(orderNo)) {
				params.put("orderno", orderNo);
			}
			if (StringUtils.isNotBlank(name)) {
				params.put("customername", name);
			}
			if (StringUtils.isNotBlank(mobile)) {
				params.put("mobile", mobile);
			}
			if (StringUtils.isNotBlank(dealwithresult)) {
				params.put("dealwithresult", dealwithresult);
			}
			List<ServiceEvent> serviceEvents = customerServiceService.getServiceEvents(params);
			if (null == serviceEvents) {
				serviceEvents = new ArrayList<ServiceEvent>();
			}
			DataGridResult dgr = new DataGridResult();
			int rowCount = customerServiceService.getServiceEventCount(params);
			dgr.setTotal(rowCount);
			dgr.setRows(serviceEvents);
			this.webOut(response, dgr);
			return;
		} catch (Exception e) {
			result = new MessageResult(ConstantUtil.M_SYSTEM_ERROR, "服务器繁忙，请稍后重试");
			this.webOut(response, result);
			Log4jTask.addLog("获取服务记录时出现异常", System.currentTimeMillis(), Log4jTask.ERROR,
					CustomerServiceController.class.getName(), e);
		}
	}
	
	/**
	 * 保存服务事件(故障,违章,救援,催款)
	 * @param record
	 * @param response
	 * @param request
	 */
	@RequestMapping("/saveServiceEvent")
	public void saveServiceEvent(ServiceEvent record, HttpServletResponse response, HttpServletRequest request) {
		MessageResult result = new MessageResult();
		int res = 0;
		try {
			if (null == record.getId()) {
				record.setCreatedate(new Date());
				res = customerServiceService.insertSelective(record);
				SysLogUtil.addLog(request, "新增服务事件", 1);
			} else {
				res = customerServiceService.modifyFaultRecordById(record);
				SysLogUtil.addLog(request, "修改服务事件", 1);
			}
			if(res>0){
				result.setCode(ConstantUtil.M_SUCCESS);
				result.setMessage("操作成功");
				result.setData(res);
			}else{
				result.setCode(ConstantUtil.M_EXCEPTION);
				SysLogUtil.addLog(request, "保存服务事件", 0);
				result.setMessage("保存失败");
			}
			this.webOut(response, result);
			return;
		} catch (Exception e) {
			SysLogUtil.addLog(request, "保存服务事件", 0);
			result = new MessageResult(ConstantUtil.M_SYSTEM_ERROR, "服务器繁忙，请稍后重试");
			this.webOut(response, result);
			Log4jTask.addLog("保存记录时出现异常", System.currentTimeMillis(), Log4jTask.ERROR,
					CustomerServiceController.class.getName(), e);
		}
	}
	
	/**
	 * 根据服务事件id获取服务
	 * @param response
	 * @param request
	 */
	@RequestMapping("/getServiceEventById")
	public void getServiceEventById(HttpServletResponse response, HttpServletRequest request) {
		MessageResult result = new MessageResult();
		try {
			String sEventId = request.getParameter("eventId");
			Integer eventId = Integer.parseInt(sEventId);
			ServiceEvent serviceEvent = customerServiceService.getServiceEventById(eventId);
			if (null == serviceEvent) {
				serviceEvent = new ServiceEvent();
			}
			this.webOut(response, serviceEvent);
			return;
		} catch (Exception e) {
			result = new MessageResult(ConstantUtil.M_SYSTEM_ERROR, "服务器繁忙，请稍后重试");
			this.webOut(response, result);
			Log4jTask.addLog("服务事件id获取数据时出现异常", System.currentTimeMillis(), Log4jTask.ERROR,
					CustomerServiceController.class.getName(), e);
		}
	}
	
	/**
	 * 批量删除服务记录
	 * @param eventIds
	 * @param response
	 * @param request
	 */
	@RequestMapping("/deleteServiceEvent")
	public void deleteServiceEvent(String eventIds, HttpServletResponse response, HttpServletRequest request) {
		MessageResult result = new MessageResult();
		int res = 0;
		try {
			if (StringUtils.isNotBlank(eventIds)) {
				String[] ids = eventIds.split("\\,");
				res = customerServiceService.deleteServiceEvent(ids);
				SysLogUtil.addLog(request, "删除服务记录", 1);
			}
			this.webOut(response, res);
			return;
		} catch (Exception e) {
			SysLogUtil.addLog(request, "删除服务记录", 0);
			result = new MessageResult(ConstantUtil.M_SYSTEM_ERROR, "服务器繁忙，请稍后重试");
			out(response, result);
			Log4jTask.addLog("删除服务记录时出现异常", System.currentTimeMillis(), Log4jTask.ERROR,
					CustomerServiceController.class.getName(), e);
		}
	}
	
	/** 
	 * 获取反馈问题列表
	 * @param response
	 * @param request
	 */
	@RequestMapping("/getAnswerQuestions")
	public void getAnswerQuestions(HttpServletResponse response, HttpServletRequest request, int rows, int page) {
		MessageResult result = new MessageResult();
		try {
			String orderNo = request.getParameter("orderNo");
			String plateNumber = request.getParameter("plateNumber");
			String mobile = request.getParameter("customerMobile");
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("rowStart", PageUtil.rowStart(page - 1, rows));
			params.put("pageSize", rows);
			if (StringUtils.isNotBlank(orderNo)) {
				params.put("orderno", orderNo);
			}
			if (StringUtils.isNotBlank(plateNumber)) {
				params.put("platenumber", plateNumber);
			}
			if (StringUtils.isNotBlank(mobile)) {
				params.put("customermobile", mobile);
			}
			List<AnswerQuestion> questions = customerServiceService.getAnswerQuestions(params);
			if (null == questions) {
				questions = new ArrayList<AnswerQuestion>();
			}
			DataGridResult dgr = new DataGridResult();
			int rowCount = customerServiceService.getAnswerQuestionCount(params);
			dgr.setTotal(rowCount);
			dgr.setRows(questions);
			this.webOut(response, dgr);
			return;
		} catch (Exception e) {
			result = new MessageResult(ConstantUtil.M_SYSTEM_ERROR, "服务器繁忙，请稍后重试");
			this.webOut(response, result);
			Log4jTask.addLog("获取问题列表时出现异常", System.currentTimeMillis(), Log4jTask.ERROR,
					CustomerServiceController.class.getName(), e);
		}
	}
	
	/**
	 * 保存反馈问题
	 * @param record
	 * @param response
	 * @param request
	 */
	@RequestMapping("/saveQuestion")
	public void saveQuestion(AnswerQuestion record, HttpServletResponse response, HttpServletRequest request) {
		MessageResult result = new MessageResult();
		int res = 0;
		try {
			if (null == record.getId()) {
				record.setCreatedate(new Date());
				
				res = customerServiceService.insertQuestion(record);
				SysLogUtil.addLog(request, "新增问题", 1);
			} else {
				res = customerServiceService.modifyQuestionById(record);
				SysLogUtil.addLog(request, "编辑问题", 1);
			}
			if(res>0){
				result.setCode(ConstantUtil.M_SUCCESS);
				result.setMessage("操作成功");
				result.setData(res);
			}else{
				result.setCode(ConstantUtil.M_EXCEPTION);
				SysLogUtil.addLog(request, "新增或编辑问题", 0);
				result.setMessage("保存失败");
			}
			this.webOut(response, result);
			return;
		} catch (Exception e) {
			SysLogUtil.addLog(request, "新增或编辑问题", 0);
			result = new MessageResult(ConstantUtil.M_SYSTEM_ERROR, "服务器繁忙，请稍后重试");
			this.webOut(response, result);
			Log4jTask.addLog("保存反馈问题数据时出现异常", System.currentTimeMillis(), Log4jTask.ERROR,
					CustomerServiceController.class.getName(), e);
		}
	}
	
	/**
	 * 根据id获取反馈问题
	 * @param response
	 * @param request
	 */
	@RequestMapping("/getQuestionById")
	public void getQuestionById(HttpServletResponse response, HttpServletRequest request) {
		MessageResult result = new MessageResult();
		try {
			String sQuestionId = request.getParameter("questionId");
			Integer questionId = Integer.parseInt(sQuestionId);
			AnswerQuestion question = customerServiceService.getQuestionById(questionId);
			if (null == question) {
				question = new AnswerQuestion();
			}
			this.webOut(response, question);
			return;
		} catch (Exception e) {
			result = new MessageResult(ConstantUtil.M_SYSTEM_ERROR, "服务器繁忙，请稍后重试");
			this.webOut(response, result);
			Log4jTask.addLog("服务事件id获取数据时出现异常", System.currentTimeMillis(), Log4jTask.ERROR,
					CustomerServiceController.class.getName(), e);
		}
	}
	
	/** 
	 * 获取反馈问题列表
	 * @param response
	 * @param request
	 */
	@RequestMapping("/getQuestionCategories")
	public void getQuestionCategories(HttpServletResponse response, HttpServletRequest request) {
		MessageResult result = new MessageResult();
		try {
			List<QuestionCategory> questionCategories = customerServiceService.getAllQuestionCategories();
			if (null == questionCategories) {
				questionCategories = new ArrayList<QuestionCategory>();
			}
			this.webOut(response, questionCategories);
			return;
		} catch (Exception e) {
			result = new MessageResult(ConstantUtil.M_SYSTEM_ERROR, "服务器繁忙，请稍后重试");
			this.webOut(response, result);
			Log4jTask.addLog("获取问题分类时出现异常", System.currentTimeMillis(), Log4jTask.ERROR,
					CustomerServiceController.class.getName(), e);
		}
	}
	
}
