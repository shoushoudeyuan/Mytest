package net.joystart.setting.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;

import net.joystart.common.controller.BaseController;
import net.joystart.common.util.ConstantUtil;
import net.joystart.common.util.MessageResult;
import net.joystart.common.util.SysLogUtil;
import net.joystart.common.util.log.Log4jTask;
import net.joystart.coupon.entity.CouponRule;
import net.joystart.setting.entity.BaseInsurance;
import net.joystart.setting.entity.CustomerClass;
import net.joystart.setting.service.IAuditCustomerService;

@Controller
@RequestMapping("/auditCus")
public class AuditCustomerController extends BaseController {

	@Resource
	IAuditCustomerService auditCustomerService;
	
	//保险页面列表查询
		@RequestMapping("/getAuditList")
		public void getAuditList(HttpServletRequest request, HttpServletResponse response) {
			try {
				List<CustomerClass> list = null;
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

			    Integer count = this.auditCustomerService.SelectCountSetting(params);
				// 查询列表
				list = auditCustomerService.SelectAllSetting(params);
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
				Log4jTask.addLog("审核列表报错", System.currentTimeMillis(), Log4jTask.ERROR,
						BaseInsuranceController.class.getName(), ex);
			}
		}
		
		@RequestMapping("/addAuditCustomer")
		public void updateOrInsertRule(CustomerClass customerClass, HttpServletRequest request, HttpServletResponse response) {
			// HashMap<String, Object> messageMap = new HashMap<String, Object>();
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("id", customerClass.getId());
			params.put("className", customerClass.getClassname());

			if (this.auditCustomerService.IsExistName(params)) {
				int Result = 0;
				if (null == customerClass.getId()) {
					Result = this.auditCustomerService.InsertAuditCustomer(customerClass);
					SysLogUtil.addLog(request, "添加用户审核设置", 1);
					this.out(response, Result > 0 ? 1 : 0);
					return;
				}

				// this.sysRoleService.selectByPrimaryKey(sysRole.getId());
				Result = this.auditCustomerService.UpdateAuditCustomer(customerClass);
				SysLogUtil.addLog(request, "修改用户审核设置", 1);
				// messageMap.put("success", Result > 0 ? true : false);
				// messageMap.put("message", Result > 0 ? "修改规则成功！" : "修改规则失败");
				this.out(response, Result > 0 ? 1 : 0);
			} else {
				this.out(response, 2);
			}
			return;
		}
		
		@RequestMapping("/deleteAuditCustomer")
		public void deleteAuditCustomer(String ids, HttpServletRequest request, HttpServletResponse response) {
			if (StringUtils.isEmpty(ids)) {
				this.out(response, 0);
				return;
			}

			String[] split = ids.split(",");
			for (int i = 0; i < split.length; i++) {
				if (!StringUtils.isEmpty(split[i])) {
					this.auditCustomerService.DeleteAuditCustomer(Integer.valueOf(split[i]));
				}			
			}
			SysLogUtil.addLog(request, "删除用户审核设置", 1);
			this.out(response, 1);
			return;
		}
		
		@RequestMapping("/selectAuditCustomer")
		public void selectAuditCustomer(HttpServletRequest request, HttpServletResponse response) {
			String auditId = request.getParameter("auditId");
			CustomerClass customerClass = this.auditCustomerService.SelectById(Integer.valueOf(auditId));
			HashMap<String, Object> resuleMap = new HashMap<>();
			resuleMap.put("success", true);
			resuleMap.put("cusaudit", customerClass);
			this.webOut(response, resuleMap);
			return;
		}
}
