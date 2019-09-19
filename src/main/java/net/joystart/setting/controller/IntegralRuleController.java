package net.joystart.setting.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;

import net.joystart.common.controller.BaseController;
import net.joystart.common.util.SysLogUtil;
import net.joystart.setting.entity.ScoreRuleSet;
import net.joystart.setting.service.IIntegralRuleService;

@Controller
@RequestMapping("/integralRule")
public class IntegralRuleController extends BaseController {

	@Resource
	IIntegralRuleService integralRuleService;
	
	@RequestMapping("/findintegralrule")
	public void FindIntegralInfo(HttpServletRequest request, HttpServletResponse response) {
		List<ScoreRuleSet> list = null;
		Map<String, Object> params = new HashMap<String, Object>();
		HashMap<String, Object> dataMap = new HashMap<String, Object>();

		String p_pageSize = request.getParameter("rows");
		if (!StringUtils.isEmpty(p_pageSize)) {
			params.put("pageSize", Integer.valueOf(p_pageSize));
		} else {
			params.put("pageSize", 20);
		}
		String p_pageNumber = request.getParameter("page");
		if (!StringUtils.isEmpty(p_pageNumber)) {
			params.put("startIndex", (Integer.valueOf(p_pageNumber) - 1) * Integer.valueOf(p_pageSize));
		} else {
			params.put("startIndex", 0);
		}

		Integer count = this.integralRuleService.getIntegralCount(params);
		// 查询列表
		list = this.integralRuleService.getIntegralRuleInfo(params);
		dataMap.put("list", list);
		HashMap<String, Object> messageMap = new HashMap<String, Object>();
		messageMap.put("total", count);
		messageMap.put("rows", list);

		this.webOut(response, messageMap);
		return;
	}
	
	@RequestMapping("/selectIntegralRule")
	public void selectRuleByID(HttpServletRequest request, HttpServletResponse response) {
		String ruleId = request.getParameter("ruleId");
		ScoreRuleSet rule = this.integralRuleService.getIntegralById(Integer.valueOf(ruleId));
		HashMap<String, Object> resuleMap = new HashMap<>();
		resuleMap.put("success", true);
		resuleMap.put("rule", rule);
		this.webOut(response, resuleMap);
		return;
	}
	
	@RequestMapping("/updateIntegralRule")
	public void updateIntegralRuleDetail(ScoreRuleSet ruleDetail, HttpServletRequest request,
			HttpServletResponse response) {
		int Result = 0;
		Result = this.integralRuleService.updateIntegralRule(ruleDetail);
		
		SysLogUtil.addLog(request, "编辑保险规则", 1);

		this.out(response, Result > 0 ? 1 : 0);
		return;
	}
}
