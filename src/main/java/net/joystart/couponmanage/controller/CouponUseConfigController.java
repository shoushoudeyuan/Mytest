package net.joystart.couponmanage.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.joystart.city.entity.ServiceCity;
import net.joystart.city.service.IServiceCitySerivce;
import net.joystart.common.controller.BaseController;
import net.joystart.common.util.ConstantUtil;
import net.joystart.common.util.MessageResult;
import net.joystart.couponmanage.entity.CouponUseConfig;
import net.joystart.couponmanage.enums.CouponTypeEnum;
import net.joystart.couponmanage.service.ICouponUseConfigService;
import net.joystart.vehicle.entity.CarType;
import net.joystart.vehicle.remote.service.ICarTypeRemoteService;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.citrus.util.StringUtil;

@Controller
@RequestMapping("/useconfig")
public class CouponUseConfigController extends BaseController {

	@Autowired
	private ICouponUseConfigService svcUseConfig;

	@Autowired
	private IServiceCitySerivce svcCity;

	@Autowired
	ICarTypeRemoteService carTypeRemoteService;

	@RequestMapping("/list")
	public void List(HttpServletRequest request, HttpServletResponse response) {
		HashMap<String, Object> result = new HashMap<String, Object>();
		Integer page = request.getParameter("page") == null ? 1 : Integer.valueOf(request.getParameter("page"));
		Integer rows = request.getParameter("rows") == null ? 10 : Integer.valueOf(request.getParameter("rows"));
		Integer isValidate = (request.getParameter("queryIsValidate") == null || StringUtils.isBlank(request.getParameter("queryIsValidate"))) ? null : Integer.valueOf(request.getParameter("queryIsValidate"));
		String configName = request.getParameter("queryConfigName");
		CouponTypeEnum couponType = null;
		if (request.getParameter("queryCouponType") == null
				|| StringUtils.isBlank(request.getParameter("queryCouponType")))
			couponType = null;
		else if (request.getParameter("queryCouponType").equals("1"))
			couponType = CouponTypeEnum.DISCOUNT;
		else if (request.getParameter("queryCouponType").equals("2"))
			couponType = CouponTypeEnum.DEDUCTION;

		try {
			List<CouponUseConfig> lst = svcUseConfig.selectCouponUseConfig(page, rows, configName, couponType,
					isValidate);
			Integer count = svcUseConfig.selectCouponUseConfigCount(configName, couponType, isValidate);
			result.put("total", count);
			result.put("rows", lst);
			webOut(response, result);
		} catch (Exception e) {
			logger.error("获取优惠券规则配置列表错误", e);
			result.put("code", ConstantUtil.W_SYSTEM_ERROR);
			result.put("message", "获取优惠券规则配置列表失败");
			webOut(response, result);
		}
	}

	@RequestMapping("/configdetail")
	public void configDetail(HttpServletRequest request, HttpServletResponse response) {
		MessageResult result = new MessageResult();
		try {
			List<CouponUseConfig> lst = svcUseConfig.selectCouponUseConfig(null, null, null, null,null);
			lst = lst.stream().filter(e->e.getIsValidate().equals(1)).collect(Collectors.toList());
			result.setCode(ConstantUtil.W_SUCCESS);
			result.setMessage("获取优惠券使用配置数据成功");
			result.setData(lst);
			outJson(response, result);
		} catch (Exception e) {
			logger.error("获取优惠券使用配置数据失败", e);
			result.setCode(ConstantUtil.W_SYSTEM_ERROR);
			result.setMessage("获取优惠券规则配置列表失败");
			outJson(response, result);
		}
	}
	
	@RequestMapping("couponName")
	public void couponName(HttpServletRequest request, HttpServletResponse response){
		MessageResult result = new MessageResult();
		try{
			List<String> lstName = svcUseConfig.selectCouponNameList();
			result.setCode(ConstantUtil.W_SUCCESS);
			result.setMessage("获取优惠券名称数据成功");
			result.setData(lstName);
			outJson(response, result);
			
		}catch(Exception e){
			logger.error("获取优惠券名称列表失败", e);
			result.setCode(ConstantUtil.W_SUCCESS);
			result.setMessage("获取优惠券名称列表失败！");
			outJson(response, result);
			return;
		}
	}
	
	@RequestMapping("/carmodeandctiy")
	public void carType(HttpServletRequest request, HttpServletResponse response) {
		MessageResult result = new MessageResult();
		List<Map<String, Object>> lstCarMode = new ArrayList<>();
		List<Map<String, Object>> lstCity = new ArrayList<>();
		try {
			Map<String, Object> params = new HashMap<>();
			params.put("startIndex", 0);
			params.put("pageSize", 1000);
			List<CarType> lst = carTypeRemoteService.selectByParam(params);

			for (CarType car : lst) {
				Map<String, Object> carMode = new HashMap<>();
				carMode.put("id", car.id);
				carMode.put("serialName", car.serialName);
				carMode.put("modeName", car.modelName);
				lstCarMode.add(carMode);
			}
		} catch (Exception e) {
			logger.error("优惠卷配置获取车型列表失败", e);
			result.setCode(ConstantUtil.W_SUCCESS);
			result.setMessage("获取车型列表失败！");
			webOut(response, result);
			return;
		}

		try {
			List<ServiceCity> lst = svcCity.getServerCity();

			for (ServiceCity city : lst) {
				Map<String, Object> serviceCity = new HashMap<>();
				serviceCity.put("id", city.getId());
				serviceCity.put("name", city.getShowname());
				lstCity.add(serviceCity);
			}
		} catch (Exception e) {
			logger.error("获取服务城市列表报错", e);
			result.setCode(ConstantUtil.W_SYSTEM_ERROR);
			result.setMessage("获取服务城市失败！");
			webOut(response, result);
			return;
		}

		Map<String, Object> data = new HashMap<>();
		data.put("city", lstCity);
		data.put("carMode", lstCarMode);
		result.setData(data);
		result.setCode(ConstantUtil.W_SUCCESS);
		outJson(response, result);
	}

	@RequestMapping("/saveconfig")
	public void saveConfig(HttpServletRequest request, HttpServletResponse response, CouponUseConfig config) {
		MessageResult result = new MessageResult();

		if (config == null || StringUtil.isBlank(config.getConfigName()) || config.getCouponType() == null
				|| config.getValidateDay() == null || config.getIsValidate() == null
				|| (config.getCouponType() == CouponTypeEnum.DISCOUNT.getValue() && config.getDiscountPercent() == null
						&& config.getMaxDeductionMoney() == null)
				|| (config.getCouponType() == CouponTypeEnum.DEDUCTION.getValue() && config.getCouponMoney() == null)) {
			result.setCode(ConstantUtil.W_PARAWTER_NULL);
			result.setMessage("提交的优惠卷信息不完整！");
			outJson(response, result);
			return;
		}

		try {
			boolean ret = svcUseConfig.saveCouponUseConfig(config);
			if(ret){
				result.setCode(ConstantUtil.W_SUCCESS);
				result.setMessage("保存优惠卷配置信息成功！");
			}else{
				result.setCode(ConstantUtil.W_EXCEPTION);
				result.setMessage("保存优惠卷配置信息失败，优惠券名称是否已存在！");
			}
			outJson(response, result);
			return;
		} catch (Exception e) {
			logger.error("保存优惠卷配置信息失败！", e);
			result.setCode(ConstantUtil.W_SYSTEM_ERROR);
			result.setMessage("保存优惠卷配置信息失败！");
			outJson(response, result);
			return;
		}

	}

	@RequestMapping("/setvalidate")
	public void setValidate(HttpServletRequest request, HttpServletResponse response, Integer id,Integer isValidate) {
		MessageResult result = new MessageResult();
		if (id == null || isValidate == null) {
			result.setCode(ConstantUtil.W_PARAWTER_NULL);
			result.setMessage("设置优惠卷配置参数错误！");
			outJson(response, result);
			return;
		}

		try {
			String msg = "";
			if (isValidate == 1) {
				svcUseConfig.enableCouponUseConfig(id);
				msg = "启用优惠卷配置成功";
			} else {
				svcUseConfig.disableCouponUseConfig(id);
				msg = "禁用优惠卷配置成功";
			}

			result.setCode(ConstantUtil.W_SUCCESS);
			result.setMessage(msg);
			outJson(response, result);
		} catch (Exception e) {
			result.setCode(ConstantUtil.W_SYSTEM_ERROR);
			result.setMessage("设置优惠卷配置失败！");
			outJson(response, result);
		}
	}

	@RequestMapping("/deleteconfig")
	public void deteleConfig(HttpServletRequest request, HttpServletResponse response, String ids) {
		MessageResult result = new MessageResult();
		if (StringUtil.isBlank(ids)) {
			result.setCode(ConstantUtil.W_PARAWTER_NULL);
			result.setMessage("请选择需要删除的配置信息");
			outJson(response, result);
			return;
		}

		try {
			String[] arrId = ids.split(",");
			List<Integer> lstId = new ArrayList<>();
			for (String id : arrId) {
				lstId.add(Integer.valueOf(id));
			}

			int ret = svcUseConfig.deleteCouponUseConfig(lstId);
			if (ret == 0) {
				result.setCode(ConstantUtil.W_SYSTEM_ERROR);
				result.setMessage("删除优惠卷配置信息失败!");
				outJson(response, result);
				return;
			}

			result.setCode(ConstantUtil.W_SUCCESS);
			result.setMessage("删除配置信息成功！");
			outJson(response, result);
		} catch (Exception e) {
			logger.error("删除优惠卷配置信息失败！", e);
			result.setCode(ConstantUtil.W_SYSTEM_ERROR);
			result.setMessage("删除优惠卷配置信息失败！");
			outJson(response, result);
		}

	}
	
	@RequestMapping("/list4Combobox")
	public void list4Combobox(HttpServletRequest request, HttpServletResponse response) {
		Integer isValidate = (request.getParameter("queryIsValidate") == null || StringUtils.isBlank(request.getParameter("queryIsValidate"))) ? null : Integer.valueOf(request.getParameter("queryIsValidate"));
		CouponTypeEnum couponType = null;
		if (request.getParameter("queryCouponType") == null
				|| StringUtils.isBlank(request.getParameter("queryCouponType")))
			couponType = null;
		else if (request.getParameter("queryCouponType").equals("1"))
			couponType = CouponTypeEnum.DISCOUNT;
		else if (request.getParameter("queryCouponType").equals("2"))
			couponType = CouponTypeEnum.DEDUCTION;

		try {
			List<CouponUseConfig> lst = svcUseConfig.selectCouponUseConfig(null, null, null, couponType,isValidate);
			webOut(response, lst);
		} catch (Exception e) {
			logger.error("获取优惠券规则配置列表错误list4Combobox", e);
			HashMap<String, Object> result = new HashMap<String, Object>();
			result.put("code", ConstantUtil.W_SYSTEM_ERROR);
			result.put("message", "获取优惠券规则配置列表失败list4Combobox");
			webOut(response, result);
		}
	}
 
}
