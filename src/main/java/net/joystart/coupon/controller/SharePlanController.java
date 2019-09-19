package net.joystart.coupon.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.aspectj.weaver.ast.Var;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;

import net.joystart.common.controller.BaseController;
import net.joystart.common.util.ConstantUtil;
import net.joystart.common.util.MessageResult;
import net.joystart.common.util.SysLogUtil;
import net.joystart.common.util.log.Log4jTask;
import net.joystart.coupon.entity.SharePlan;
import net.joystart.coupon.service.ISharePlanService;
import net.joystart.customer.entity.Customer;

@Controller
@RequestMapping("/shareplan")
public class SharePlanController extends BaseController {
	@Resource
	ISharePlanService sharePlanService;

	//共享计划页面列表查询
	@RequestMapping("/getSharePlanList")
	public void getSharePlanList(HttpServletRequest request, HttpServletResponse response) {
		try {
			List<SharePlan> list = null;
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

			String username = request.getParameter("username");
			if (!StringUtils.isEmpty(username)) {
				params.put("username", "%" + username + "%");
			}
			
			String platenumber = request.getParameter("platenumber");
			if (!StringUtils.isEmpty(platenumber)) {
				params.put("platenumber", "%" + platenumber + "%");
			}
			
			String starttime = request.getParameter("starttime");
			if (!StringUtils.isEmpty(starttime)) {
				params.put("starttime", starttime);
			}
			
			String endtime = request.getParameter("endtime");
			if (!StringUtils.isEmpty(endtime)) {
				params.put("endtime", endtime);
			}

		    Integer count = this.sharePlanService.getSharePlanListCount(params);
			// 查询列表
			list = sharePlanService.getSharePlanList(params);
			dataMap.put("list", list);
			HashMap<String, Object> messageMap = new HashMap<String, Object>();
		    messageMap.put("total", count);
			messageMap.put("rows", list);

			this.webOut(response, messageMap);
			return;
		} catch (Exception ex) {
			MessageResult result = new MessageResult();
			result = new MessageResult(ConstantUtil.M_SYSTEM_ERROR, "服务器繁忙，请稍后重试");
			out(response, result);
			Log4jTask.addLog("共享计划列表报错", System.currentTimeMillis(), Log4jTask.ERROR,
					SharePlanController.class.getName(), ex);
		}
	}
	//共享计划页面添加
	@RequestMapping("/sharePlanAdd")
	public void sharePlanAdd(SharePlan sp, HttpServletRequest request, HttpServletResponse response) {
		try {
			
			Customer customer = new Customer();
			customer.setUsername(sp.getUsername());
			Customer cus= sharePlanService.getCustomerByUserName(customer);
			if(cus==null)
			{
				this.out(response, 1);//用户不存在
				return;
			}
			if(new Byte("1").equals(cus.getIsdelete()))
			{
				this.out(response, 2);//用户已经删除
				return;
			}
			if(new Byte("1").equals(cus.getIsdisable()))
			{
				this.out(response, 3);//用户已经禁用
				return;
			}
			sp.setCustomerid(cus.getId());
			sp.setCreatedate(new Date());
			Integer result = sharePlanService.insertSelective(sp);
			
			SysLogUtil.addLog(request, "添加共享计划", 1);
			if(result!=0)
			{
				this.out(response, 4);//添加成功
				return;
			}
			else {
				this.out(response, 5);//添加失败
				return;
			}
		
			
		
		} catch (Exception ex) {
			SysLogUtil.addLog(request, "添加共享计划", 0);
			this.out(response, 0);//报错
			Log4jTask.addLog("共享计划添加报错", System.currentTimeMillis(), Log4jTask.ERROR,
					SharePlanController.class.getName(), ex);
			return;
		}
	}
	//共享计划页面修改
	@RequestMapping("/sharePlanUpdate")
	public void sharePlanUpdate(SharePlan sp,HttpServletRequest request, HttpServletResponse response) {
		try {
			
			Customer customer = new Customer();
			customer.setUsername(sp.getUsername());
			Customer cus= sharePlanService.getCustomerByUserName(customer);
			if(cus==null)
			{
				this.out(response, 1);//用户不存在
				return;
			}
			if(new Byte("1").equals(cus.getIsdelete()))
			{
				this.out(response, 2);//用户已经删除
				return;
			}
			if(new Byte("1").equals(cus.getIsdisable()))
			{
				this.out(response, 3);//用户已经禁用
				return;
			}
			sp.setCustomerid(cus.getId());
			sp.setCreatedate(new Date());
			Integer result = sharePlanService.updateByPrimaryKeySelective(sp);
			SysLogUtil.addLog(request, "修改共享计划", result);
			if(result!=0)
			{
				this.out(response, 4);//修改成功
				return;
			}
			else {
				this.out(response, 5);//修改失败
				return;
			}
		
			
		
		} catch (Exception ex) {
			this.out(response, 0);//报错
			Log4jTask.addLog("共享计划修改报错", System.currentTimeMillis(), Log4jTask.ERROR,
					SharePlanController.class.getName(), ex);
			return;
		}
	}
	//共享计划删除
	@RequestMapping("/sharePlanDelete")
	public void sharePlanDelete(String ids, HttpServletRequest request, HttpServletResponse response) {
		try {
			String[] split = ids.split(",");
			for (int i = 0; i < split.length; i++) {
				this.sharePlanService.deleteByPrimaryKey(Integer.valueOf(split[i]));				
			}
			SysLogUtil.addLog(request, "删除共享计划", 1);
			this.out(response, 1);//成功
			return;
		} catch (Exception ex) {
			SysLogUtil.addLog(request, "删除共享计划", 0);
			this.out(response, 0);//失败
			Log4jTask.addLog("共享计划删除报错", System.currentTimeMillis(), Log4jTask.ERROR,
					SharePlanController.class.getName(), ex);
			return;
		}
		
	}
	//共享计划验证信息
	@RequestMapping("/sharePlanCheckUser")
	public void sharePlanCheckUser(String username, HttpServletRequest request, HttpServletResponse response) {
		try {
			Customer customer = new Customer();
			customer.setUsername(username);
			Customer cus= sharePlanService.getCustomerByUserName(customer);
			if(cus==null)
			{
				this.out(response, 1);//用户不存在
				return;
			}
			if(new Byte("1").equals(cus.getIsdelete()))
			{
				this.out(response, 2);//用户已经删除
				return;
			}
			if(new Byte("1").equals(cus.getIsdisable()))
			{
				this.out(response, 3);//用户已经禁用
				return;
			}
			
			this.out(response, 4);//成功
			return;
		} catch (Exception ex) {
			this.out(response, 0);//失败
			Log4jTask.addLog("共享计划验证信息报错", System.currentTimeMillis(), Log4jTask.ERROR,
					SharePlanController.class.getName(), ex);
			return;
		}
		
	}
	
	
}
