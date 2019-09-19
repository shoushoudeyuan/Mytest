package net.joystart.couponmanage.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.citrus.util.StringUtil;

import net.joystart.common.controller.BaseController;
import net.joystart.common.util.ConstantUtil;
import net.joystart.common.util.MessageResult;
import net.joystart.couponmanage.entity.CouponPackage;
import net.joystart.couponmanage.entity.CouponPackageItem;
import net.joystart.couponmanage.service.ICouponPackageService;

@Controller
@RequestMapping("/couponpackage")
public class CouponPackageController extends BaseController{

	@Autowired
	private ICouponPackageService svcPackage;
	
	@RequestMapping("/list")
	public void list(HttpServletRequest request, HttpServletResponse response,Integer packageId){
		HashMap<String, Object> result = new HashMap<String, Object>();
		if(packageId == null ){
			result.put("total", 0);
			result.put("rows", null);
			webOut(response, result);
		}
		Integer page = request.getParameter("page") == null ? 1 : Integer.valueOf(request.getParameter("page"));
		Integer rows = request.getParameter("rows") == null ? 10 : Integer.valueOf(request.getParameter("rows"));
		try {
			List<CouponPackageItem> lst = svcPackage.selectCouponPackageItem(page, rows,packageId);
			Integer count = svcPackage.selectCouponPackageItemCount(packageId);
			result.put("total", count);
			result.put("rows", lst);
			webOut(response, result);
		} catch (Exception e) {
			logger.error("获取优惠券规则列表错误", e);
			result.put("code", ConstantUtil.W_SYSTEM_ERROR);
			result.put("message", "获取优惠券规则列表失败");
			webOut(response, result);
		}
	}
	
	@RequestMapping("/delete")
	public void delete(HttpServletRequest request, HttpServletResponse response,String ids){
		MessageResult result = new MessageResult();
		if (StringUtil.isBlank(ids)) {
			result.setCode(ConstantUtil.W_PARAWTER_NULL);
			result.setMessage("请选择需要删除的优惠券信息");
			outJson(response, result);
			return;
		}
		
		try{
			String[] arrId = ids.split(",");
			List<Integer> lstId = new ArrayList<>();
			for (String id : arrId) {
				lstId.add(Integer.valueOf(id));
			}

			Boolean ret = svcPackage.deleteCouponPackageItem(lstId);
			if (!ret) {
				result.setCode(ConstantUtil.W_SYSTEM_ERROR);
				result.setMessage("删除优惠卷信息失败!");
				outJson(response, result);
				return;
			}

			result.setCode(ConstantUtil.W_SUCCESS);
			result.setMessage("删除优惠卷信息信息成功！");
			outJson(response, result);
		}catch(Exception e){
			logger.error("删除优惠卷信息失败！", e);
			result.setCode(ConstantUtil.W_SYSTEM_ERROR);
			result.setMessage("删除优惠卷信息失败！");
			outJson(response, result);
		}
	}
	
	@RequestMapping("/save")
	public void delete(HttpServletRequest request, HttpServletResponse response,CouponPackageItem packageItem){
		MessageResult result = new MessageResult();
		if (packageItem == null) {
			result.setCode(ConstantUtil.W_PARAWTER_NULL);
			result.setMessage("优惠券信息参数错误");
			outJson(response, result);
			return;
		}
		
		try{
			Boolean ret = svcPackage.saveCouponPackageItem(packageItem);
			if (!ret) {
				result.setCode(ConstantUtil.W_SYSTEM_ERROR);
				result.setMessage("保存优惠卷信息失败!");
				outJson(response, result);
				return;
			}

			result.setCode(ConstantUtil.W_SUCCESS);
			result.setMessage("保存优惠卷信息成功！");
			outJson(response, result);
		}catch(Exception e){
			logger.error("保存优惠卷信息失败！", e);
			result.setCode(ConstantUtil.W_SYSTEM_ERROR);
			result.setMessage("保存优惠卷信息失败！");
			outJson(response, result);
		}
	}
	
		
}
