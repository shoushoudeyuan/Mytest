package net.joystart.setting.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import net.joystart.common.controller.BaseController;
import net.joystart.common.util.ConstantUtil;
import net.joystart.common.util.MessageResult;
import net.joystart.common.util.SysLogUtil;
import net.joystart.common.util.log.Log4jTask;
import net.joystart.setting.entity.BaseInsurance;
import net.joystart.setting.service.IBaseInsuranceService;
import net.joystart.system.entity.SysUser;

@Controller
@RequestMapping("/baseInsurance")
public class BaseInsuranceController extends BaseController {
	@Resource
	IBaseInsuranceService baseInsuranceService;

	//保险页面列表查询
	@RequestMapping("/getBaseInsuranceList")
	public void getSharePlanList(HttpServletRequest request, HttpServletResponse response) {
		try {
			List<BaseInsurance> list = null;
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

			String insurancename = request.getParameter("insurancename");
			if (!StringUtils.isEmpty(insurancename)) {
				params.put("insurancename", "%" + insurancename + "%");
			}
			String selectCity = request.getParameter("selectCity");
			if (!StringUtils.isEmpty(selectCity) && !("-1".equals(selectCity))) {
				params.put("servicecityid", selectCity);
			} else {
				params.put("servicecityid", null);
			}
			String vehicleserialid = request.getParameter("selectSeries");
			if (!StringUtils.isEmpty(vehicleserialid) && !("-1".equals(vehicleserialid))) {
				params.put("vehicleserialid", vehicleserialid);
			} else {
				params.put("vehicleserialid", null);
			}
			
			String selectModel = request.getParameter("selectModel");
			if (!StringUtils.isEmpty(selectModel) && !("-1".equals(selectModel))) {
				params.put("vehiclemodelid", selectModel);
			} else {
				params.put("vehiclemodelid", null);
			}
			
		    Integer count = this.baseInsuranceService.getBaseInsuranceListCount(params);
			// 查询列表
			list = baseInsuranceService.getBaseInsuranceList(params);
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
			Log4jTask.addLog("保险列表报错", System.currentTimeMillis(), Log4jTask.ERROR,
					BaseInsuranceController.class.getName(), ex);
		}
	}
	//保险页面添加
	@RequestMapping("/baseInsuranceAdd")
	public void sharePlanAdd(BaseInsurance bInsurance, HttpServletRequest request, HttpServletResponse response) {
		try {
			
			if(request.getSession().getAttribute("user")!=null)
			{
				SysUser user = (SysUser)request.getSession().getAttribute("user");
				bInsurance.setCreateuser(user.getId());
			}
			else
			{
				bInsurance.setCreateuser(0);
			}
			bInsurance.setInsurancetype((byte)1);
			
			bInsurance.setCreatedate(new Date());
			Integer result = baseInsuranceService.insertSelective(bInsurance);
			SysLogUtil.addLog(request, "添加保险", 1);
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
			SysLogUtil.addLog(request, "添加保险", 0);
			this.out(response, 0);//报错
			Log4jTask.addLog("保险添加报错", System.currentTimeMillis(), Log4jTask.ERROR,
					BaseInsuranceController.class.getName(), ex);
			return;
		}
	}
	//保险页面修改
	@RequestMapping("/baseInsuranceUpdate")
	public void sharePlanUpdate(BaseInsurance bInsurance,HttpServletRequest request, HttpServletResponse response) {
		try {
			
			if(request.getSession().getAttribute("user")!=null)
			{
				SysUser user = (SysUser)request.getSession().getAttribute("user");
				bInsurance.setCreateuser(user.getId());
			}
			else
			{
				bInsurance.setCreateuser(0);
			}
			Integer result = baseInsuranceService.updateByPrimaryKeySelective(bInsurance);
			SysLogUtil.addLog(request, "修改保险", 1);
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
			SysLogUtil.addLog(request, "修改保险", 0);
			this.out(response, 0);//报错
			Log4jTask.addLog("保险改报错", System.currentTimeMillis(), Log4jTask.ERROR,
					BaseInsuranceController.class.getName(), ex);
			return;
		}
	}
	//保险删除
	@RequestMapping("/baseInsuranceDelete")
	public void sharePlanDelete(String ids, HttpServletRequest request, HttpServletResponse response) {
		try {
			String[] split = ids.split(",");
			for (int i = 0; i < split.length; i++) {
			baseInsuranceService.deleteByPrimaryKey(Integer.valueOf(split[i]));				
			}
			SysLogUtil.addLog(request, "删除保险", 1);
			this.out(response, 1);//成功
			return;
		} catch (Exception ex) {
			SysLogUtil.addLog(request, "删除保险", 0);
			this.out(response, 0);//失败
			Log4jTask.addLog("保险删除报错", System.currentTimeMillis(), Log4jTask.ERROR,
					BaseInsuranceController.class.getName(), ex);
			return;
		}
		
	}
	
	/***
	 * 根据id查询保险信息
	 * @param id
	 * @return ModelMap
	 * @author 刘诗越
	 * @date 2017年7月10日
	 */
	@RequestMapping("/loadBaseInsuranceById")
	public @ResponseBody ModelMap loadBaseInsuranceById(Integer id) {
		ModelMap result = new ModelMap();
		try {
			BaseInsurance baseIns = baseInsuranceService.selectByPrimaryKey(id);
			result.addAttribute("baseIns", baseIns);
			return result;
		} catch (Exception e) {
			Log4jTask.addLog("根据id查询保险信息报错", System.currentTimeMillis(), Log4jTask.ERROR,
					BaseInsuranceController.class.getName(), e);
			return result;
		}
	}
	
	/***
	 * 更新保险服务介绍
	 * @param ins
	 * @param response
	 * @return void
	 * @author 刘诗越
	 * @date 2017年7月10日
	 */
	@RequestMapping("/updateInsurance")
	public void updateInsurance(BaseInsurance ins, HttpServletResponse response,HttpServletRequest request) {
		try {
			baseInsuranceService.updateByPrimaryKeySelective(ins);
			SysLogUtil.addLog(request, "更新保险服务介绍", 1);
			this.out(response, 1);
		} catch (Exception e) {
			SysLogUtil.addLog(request, "更新保险服务介绍", 0);
			this.out(response, 0);
			Log4jTask.addLog("根据id修改保险服务失败", System.currentTimeMillis(), Log4jTask.ERROR,
					BaseInsuranceController.class.getName(), e);
		}
	}
}
