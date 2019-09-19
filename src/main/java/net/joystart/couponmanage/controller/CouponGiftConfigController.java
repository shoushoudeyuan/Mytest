package net.joystart.couponmanage.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import net.joystart.common.controller.BaseController;
import net.joystart.common.util.ConstantUtil;
import net.joystart.common.util.MessageResult;
import net.joystart.common.util.SysLogUtil;
import net.joystart.couponmanage.entity.giftconfig.AutoGiftConfig4EntMember;
import net.joystart.couponmanage.entity.giftconfig.CouponGiftConfig;
import net.joystart.couponmanage.entity.giftconfig.GiftConfig4FirstOrder;
import net.joystart.couponmanage.entity.giftconfig.GiftConfig4InviteFriends;
import net.joystart.couponmanage.entity.giftconfig.GiftConfig4OrderCost;
import net.joystart.couponmanage.entity.giftconfig.GiftConfig4RegisterEntMember;
import net.joystart.couponmanage.entity.giftconfig.GiftConfig4UserRegister;
import net.joystart.couponmanage.enums.CouponGiftModeEnum;
import net.joystart.couponmanage.service.ICouponGiftConfigService;
import net.joystart.enterprise.entity.Company;
import net.joystart.enterprise.remote.service.ICompanyRemoteService;

@Controller
@RequestMapping("/giftconfig")
public class CouponGiftConfigController extends BaseController{

	@Autowired
	ICouponGiftConfigService svcConfig;
	
	@Autowired
	ICompanyRemoteService svcCompany;
	
	@RequestMapping("/list")
	public void List(HttpServletRequest request, HttpServletResponse response,String couponRuleName) {
		HashMap<String, Object> result = new HashMap<String, Object>();
		try{
			List<CouponGiftConfig> lst = svcConfig.selectByRuleName(couponRuleName);
			result.put("total", lst.size());
			result.put("rows", lst);
			webOut(response, result);
			return;
		}catch(Exception e){
			logger.error("查询优惠券规则失败！",e);
			result.put("code", ConstantUtil.W_SYSTEM_ERROR);
			result.put("message", "查询优惠券规则失败");
			webOut(response, result);
			return;
		}
		
	}
	
	@RequestMapping("/getgiftconfig")
	public void getGiftConfig(HttpServletRequest request, HttpServletResponse response, Integer ec){
		MessageResult result = new MessageResult();
		if(ec == null){
			result.setCode(ConstantUtil.W_SYSTEM_ERROR);
			result.setMessage("获取优惠券赠送规则参数错误！");
			outJson(response,result);
			return;
		}
		
		try{
			Object config = null;
			CouponGiftModeEnum mode = CouponGiftModeEnum.valueOf(ec);
			switch(mode){
				case 注册用户赠:
					config = svcConfig.selectByEnumCode(CouponGiftModeEnum.注册用户赠,GiftConfig4UserRegister.class);
					break;
				case 邀请好友赠:
					config = svcConfig.selectByEnumCode(CouponGiftModeEnum.邀请好友赠,GiftConfig4InviteFriends.class);
					break;
				case 订单满额赠:
					config = svcConfig.selectByEnumCode(CouponGiftModeEnum.订单满额赠, GiftConfig4OrderCost.class);
					break;
				case 首次用车结单赠:
					config = svcConfig.selectByEnumCode(CouponGiftModeEnum.首次用车结单赠, GiftConfig4FirstOrder.class);
					break;
				case 首次成为企业用户赠:
					config = svcConfig.selectByEnumCode(CouponGiftModeEnum.首次成为企业用户赠, GiftConfig4RegisterEntMember.class);
					break;
				case 企业会员按时间赠:
					config = svcConfig.selectByEnumCode(CouponGiftModeEnum.企业会员按时间赠, AutoGiftConfig4EntMember.class);
			}
			
			result.setCode(ConstantUtil.W_SUCCESS);
			result.setMessage("获取优惠券赠送规则成功！");
			result.setData(config);
			outJson(response,result);
		}catch(Exception e){
			result.setCode(ConstantUtil.W_SYSTEM_ERROR);
			result.setMessage("获取优惠券赠送规则失败！");
			
			logger.error("获取优惠券赠送规则失败！ec:{}",ec,e);
			outJson(response,result);
		}
	}
	
	@RequestMapping("/getcompany")
	public void getcompany(HttpServletRequest request, HttpServletResponse response){
		MessageResult result = new MessageResult();
		try{
			List<Company> lst = svcCompany.getCompanyAll(null);
			List<Map<String,Object>> data = new ArrayList<>();
			for(Company company : lst){
				Map<String,Object> map = new HashMap<>();
				map.put("id", company.getId());
				map.put("companyName", company.getCompanyname());
				data.add(map);
			}
			
			result.setCode(ConstantUtil.W_SUCCESS);
			result.setMessage("获取企业会员按时间赠规则的公司信息成功！");
			result.setData(data);
			outJson(response,result);
		}catch(Exception e){
			result.setCode(ConstantUtil.W_SYSTEM_ERROR);
			result.setMessage("获取企业会员按时间赠规则的公司信息失败！");
			
			logger.error("获取企业会员按时间赠规则的公司信息失败！",e);
			outJson(response,result);
		}
	}
	
	@RequestMapping("/saveregisterconfig")
	public void saveregister(HttpServletRequest request, HttpServletResponse response, GiftConfig4UserRegister config) {
		MessageResult result = new MessageResult();
		if(config == null){
			result.setCode(ConstantUtil.W_PARAWTER_NULL);
			result.setMessage("注册用户赠参数错误");
			outJson(response,result);
			return;
		}
		
		try{
			svcConfig.saveGiftConfig4UserRegister(config);
			SysLogUtil.addLog(request, "保存注册用户赠", 1);
			result.setCode(ConstantUtil.W_SUCCESS);
			result.setMessage("保存注册用户赠成功");
			outJson(response,result);
			return;
		}catch(Exception e){
			logger.error("保存注册用户赠错误",e);
			SysLogUtil.addLog(request, "保存注册用户赠", 0);
			result.setCode(ConstantUtil.W_SYSTEM_ERROR);
			result.setMessage("保存注册用户赠失败！");
			outJson(response,result);
			return;
		}
		
	}
	
	@RequestMapping("/saveinvitefriends")
	public void inviteFriends(HttpServletRequest request, HttpServletResponse response, GiftConfig4InviteFriends config){
		MessageResult result = new MessageResult();
		if(config == null){
			result.setCode(ConstantUtil.W_PARAWTER_NULL);
			result.setMessage("邀请好友赠参数错误");
			outJson(response,result);
			return;
		}
		
		try{
			svcConfig.saveGiftConfig4InviteFriends(config);
			SysLogUtil.addLog(request, "保存邀请好友赠", 1);
			result.setCode(ConstantUtil.W_SUCCESS);
			result.setMessage("保存邀请好友赠成功");
			outJson(response,result);
			return;
		}catch(Exception e){
			logger.error("保存邀请好友赠错误",e);
			SysLogUtil.addLog(request, "保存邀请好友赠", 0);
			result.setCode(ConstantUtil.W_SYSTEM_ERROR);
			result.setMessage("保存邀请好友赠失败！");
			outJson(response,result);
			return;
		}
	}
	
	@RequestMapping("/saveordergiftconfig")
	public void saveOrderGiftConfig(HttpServletRequest request, HttpServletResponse response, GiftConfig4OrderCost config){
		MessageResult result = new MessageResult();
		if(config == null){
			result.setCode(ConstantUtil.W_PARAWTER_NULL);
			result.setMessage("订单满额赠参数错误");
			outJson(response,result);
			return;
		}
		
		try{
			svcConfig.saveGiftConfig4OrderCost(config);
			SysLogUtil.addLog(request, "保存订单满额赠", 1);
			result.setCode(ConstantUtil.W_SUCCESS);
			result.setMessage("保存订单满额赠成功");
			outJson(response,result);
			return;
		}catch(Exception e){
			logger.error("保存订单满额赠错误",e);
			SysLogUtil.addLog(request, "保存订单满额赠", 0);
			result.setCode(ConstantUtil.W_SYSTEM_ERROR);
			result.setMessage("保存订单满额赠失败！");
			outJson(response,result);
			return;
		}
	}
	
	@RequestMapping("/savefirstorderconfig")
	public void saveFirstOrderConfig(HttpServletRequest request, HttpServletResponse response, GiftConfig4FirstOrder config){
		MessageResult result = new MessageResult();
		if(config == null){
			result.setCode(ConstantUtil.W_PARAWTER_NULL);
			result.setMessage("首次用车结单赠参数错误");
			outJson(response,result);
			return;
		}
		
		try{
			svcConfig.saveGiftConfig4FirstOrder(config);
			SysLogUtil.addLog(request, "保存首次用车结单赠", 1);
			result.setCode(ConstantUtil.W_SUCCESS);
			result.setMessage("保存首次用车结单赠成功");
			outJson(response,result);
			return;
		}catch(Exception e){
			logger.error("保存首次用车结单赠错误",e);
			SysLogUtil.addLog(request, "保存首次用车结单赠", 0);
			result.setCode(ConstantUtil.W_SYSTEM_ERROR);
			result.setMessage("保存首次用车结单赠失败！");
			outJson(response,result);
			return;
		}
	}
	
	@RequestMapping("/saveregisterentmemberconfig")
	public void saveRegisterEntMemberConfig(HttpServletRequest request, HttpServletResponse response, GiftConfig4RegisterEntMember config){
		MessageResult result = new MessageResult();
		if(config == null){
			result.setCode(ConstantUtil.W_PARAWTER_NULL);
			result.setMessage("首次成为企业会员赠参数错误");
			outJson(response,result);
			return;
		}
		
		try{
			svcConfig.saveGiftConfig4RegisterEntMember(config);
			SysLogUtil.addLog(request, "保存首次成为企业会员赠", 1);
			result.setCode(ConstantUtil.W_SUCCESS);
			result.setMessage("保存首次成为企业会员赠成功");
			outJson(response,result);
			return;
		}catch(Exception e){
			logger.error("保存首次成为企业会员赠错误",e);
			SysLogUtil.addLog(request, "保存首次成为企业会员赠", 0);
			result.setCode(ConstantUtil.W_SYSTEM_ERROR);
			result.setMessage("保存首次成为企业会员赠失败！");
			outJson(response,result);
			return;
		}
	}
	
	
	@RequestMapping("/saveentmemberconfig")
	public void saveEntMemberConfig(HttpServletRequest request, HttpServletResponse response){
		MessageResult result = new MessageResult();
		AutoGiftConfig4EntMember config = new AutoGiftConfig4EntMember();
		String configId = request.getParameter("id");
		if(StringUtils.isBlank(configId)){
			result.setCode(ConstantUtil.W_PARAWTER_NULL);
			result.setMessage("企业会员按时间赠参数错误");
			outJson(response,result);
			return;
		}else{
			config.setId(Integer.valueOf(configId));
		}
		
		String companyId = request.getParameter("companyId");
		if(StringUtils.isNotBlank(companyId)){
			config.setCompanyId(new ArrayList<>());
			String[] arr = companyId.split(",");
			for(String id : arr){
				config.getCompanyId().add(Integer.valueOf(id));
			}
		}
		
		String autoSendDate = request.getParameter("autoSendDate");
		if(StringUtils.isNoneBlank(autoSendDate)){
			autoSendDate = autoSendDate.replaceAll(" 00:00:00", "");
			config.setAutoSendDate(Arrays.asList(autoSendDate.split(",")));
		}
		
		try{
			svcConfig.saveAutoGiftConfig4RegisterEntMember(config);
			SysLogUtil.addLog(request, "保存企业会员按时间赠", 1);
			result.setCode(ConstantUtil.W_SUCCESS);
			result.setMessage("保存企业会员按时间赠成功");
			outJson(response,result);
			return;
		}catch(Exception e){
			logger.error("保存企业会员按时间赠错误",e);
			SysLogUtil.addLog(request, "保存企业会员按时间赠", 0);
			result.setCode(ConstantUtil.W_SYSTEM_ERROR);
			result.setMessage("保存企业会员按时间赠失败！");
			outJson(response,result);
			return;
		}
	}
	
}
