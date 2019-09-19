package net.joystart.coupon.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;

import net.joystart.advert.entity.Advertisement;
import net.joystart.common.controller.BaseController;
import net.joystart.common.util.ConstantUtil;
import net.joystart.common.util.MessageResult;
import net.joystart.common.util.PageUtil;
import net.joystart.common.util.SysLogUtil;
import net.joystart.common.util.log.Log4jTask;
import net.joystart.coupon.entity.CouponRule;
import net.joystart.coupon.entity.CouponRuleItem;
import net.joystart.coupon.service.ICouponRuleService;

@Controller
@RequestMapping("/couponRule")
public class CouponRuleController extends BaseController {

	@Resource
	ICouponRuleService coupon_RuleService;

	@RequestMapping("/Rulelist")
	public void getRuleList(HttpServletRequest request, HttpServletResponse response) {
		List<CouponRule> list = null;
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

		String strRuleName = request.getParameter("RuleName");
		if (!StringUtils.isEmpty(strRuleName)) {
			params.put("rulename", "%" + strRuleName + "%");
		}

		Integer count = this.coupon_RuleService.getCount(params);
		// 查询列表
		list = this.coupon_RuleService.getCouponRuleList(params);
		dataMap.put("list", list);
		HashMap<String, Object> messageMap = new HashMap<String, Object>();
		messageMap.put("total", count);
		messageMap.put("rows", list);

		this.webOut(response, messageMap);
		return;
	}

	@RequestMapping("/selectRule")
	public void selectCouponByID(HttpServletRequest request, HttpServletResponse response) {
		String ruleId = request.getParameter("ruleId");
		CouponRule rule = this.coupon_RuleService.selectRuleByID(Integer.valueOf(ruleId));
		HashMap<String, Object> resuleMap = new HashMap<>();
		resuleMap.put("success", true);
		resuleMap.put("rule", rule);
		this.webOut(response, resuleMap);
		return;

	}

	@RequestMapping("/updateRule")
	public void updateOrInsertRule(CouponRule rule, HttpServletRequest request, HttpServletResponse response) {
		// HashMap<String, Object> messageMap = new HashMap<String, Object>();
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", rule.getId());
		params.put("rulename", rule.getRulename());
		params.put("flagname", rule.getIdentification());

		if (this.coupon_RuleService.IsExistName(params) && this.coupon_RuleService.IsExistIdenfition(params)) {
			int Result = 0;
			if (null == rule.getId()) {
				Result = this.coupon_RuleService.insertRule(rule);
				SysLogUtil.addLog(request, "新增优惠券使用规则", Result > 0 ? 1 : 0);
				this.out(response, Result > 0 ? 1 : 0);
				return;
			}

			// this.sysRoleService.selectByPrimaryKey(sysRole.getId());
			Result = this.coupon_RuleService.updateRule(rule);
			SysLogUtil.addLog(request, "更新优惠券使用规则", Result > 0 ? 1 : 0);
			// messageMap.put("success", Result > 0 ? true : false);
			// messageMap.put("message", Result > 0 ? "修改规则成功！" : "修改规则失败");
			this.out(response, Result > 0 ? 1 : 0);
		} else {
			this.out(response, 2);
		}
		return;
	}

	@RequestMapping("/deleteRule")
	public void deleteRule(String ids, HttpServletRequest request, HttpServletResponse response) {
		if (StringUtils.isEmpty(ids)) {
			this.out(response, 0);
			return;
		}

		String[] split = ids.split(",");
		for (int i = 0; i < split.length; i++) {
			if (!StringUtils.isEmpty(split[i])) {
				this.coupon_RuleService.deleteRule(Integer.valueOf(split[i]));
			}			
		}
		SysLogUtil.addLog(request, "删除优惠券使用规则", 1);
		this.out(response, 1);
		return;
	}
	
	/**
	 * 获取优惠券键值对
	 * @param request
	 * @param response
	 */
	@RequestMapping("/getCouponRuleKeyValueList")
	public void getCouponRuleKeyValueList(HttpServletRequest request, HttpServletResponse response) {
		MessageResult result = new MessageResult();
		try {
			List<CouponRule> list = this.coupon_RuleService.getCouponRuleKeyValueList();
			if(list==null){
				list = new ArrayList<CouponRule>();
			}
			webOut(response, list);
		} catch (Exception e) {
			Log4jTask.addLog("获取优惠券时出现异常", System.currentTimeMillis(), Log4jTask.ERROR, CouponRuleController.class.getName(),
					e);
			result = new MessageResult(ConstantUtil.M_SYSTEM_ERROR, "系统发生未知错误");
			webOut(response, result);
		}
	}

	@RequestMapping("/RuleDetaillist")
	public void getRuleDetailList(HttpServletRequest request, HttpServletResponse response) {
		List<CouponRuleItem> list = null;
		HashMap<String, Object> dataMap = new HashMap<String, Object>();

		String strIdentification = request.getParameter("identification");

		// 查询列表
		list = this.coupon_RuleService.getRuleDetailList(strIdentification);
		Integer count = list.size();
		dataMap.put("list", list);
		HashMap<String, Object> messageMap = new HashMap<String, Object>();
		messageMap.put("total", count);
		messageMap.put("rows", list);

		this.webOut(response, messageMap);
		return;
	}

	@RequestMapping("/updateRuleDetail")
	public void updateOrInsertRuleDetail(CouponRuleItem ruleDetail, HttpServletRequest request,
			HttpServletResponse response) {
		if (ruleDetail.getType() == 0) {
			ruleDetail.setDiscount(0);
		}
		int Result = 0;
		if (null == ruleDetail.getId()) {
			Result = this.coupon_RuleService.insertRuleDetail(ruleDetail);
			SysLogUtil.addLog(request, "新增优惠券使用规则明细", Result > 0 ? 1 : 0);
			this.out(response, Result > 0 ? 1 : 0);
			return;
		}

		Result = this.coupon_RuleService.updateRuleDetail(ruleDetail);
		SysLogUtil.addLog(request, "修改优惠券使用规则明细", Result > 0 ? 1 : 0);
		this.out(response, Result > 0 ? 1 : 0);
		return;
	}
	
	@RequestMapping("/deleteRuleDetail")
	public void deleteRuleDetail(String ids, HttpServletRequest request, HttpServletResponse response) {
		if (StringUtils.isEmpty(ids)) {
			this.out(response, 0);
			return;
		}

		String[] split = ids.split(",");
		for (int i = 0; i < split.length; i++) {
			if (!StringUtils.isEmpty(split[i])) {
				this.coupon_RuleService.deleteRuleDetail(Integer.valueOf(split[i]));
			}			
		}
		SysLogUtil.addLog(request, "删除优惠券使用规则明细", 1);
		this.out(response, 1);
		return;
	}
	
	@RequestMapping("/selectRuleDetail")
	public void selectRuleDetailByID(HttpServletRequest request, HttpServletResponse response) {
		String ruleId = request.getParameter("ruleDetailId");
		CouponRuleItem ruleDetail = this.coupon_RuleService.selectRuleDetailByID(Integer.valueOf(ruleId));
		HashMap<String, Object> resuleMap = new HashMap<>();
		resuleMap.put("success", true);
		resuleMap.put("ruleDetail", ruleDetail);
		this.webOut(response, resuleMap);
		return;

	}
	@RequestMapping("/getCouponRuleItemList")
    public void advertisementListWeb(HttpServletRequest request,HttpServletResponse response,int rows , int page)
    {
        MessageResult messageResult = new MessageResult();
        Map<String, Object> params = new HashMap<String,Object>();
        Map<String, Object> dataMap = new HashMap<String,Object>();
        
       String businessID = request.getParameter("businessID");
       params.put("businessID", businessID);
       params.put("ruleIdentification", "地推优惠券");
          
        params.put("rowStart",PageUtil.rowStart(page - 1, rows) );
        params.put("pageSize",rows );
                
        try 
        {
            List<Advertisement> list = coupon_RuleService.getCouponRuleItemList(params);
            int countRuleItem = coupon_RuleService.getCouponRuleItemCount(params);

            HashMap<String, Object> messageMap = new HashMap<String, Object>();
//            messageMap.put("pageSize", this.pageSize);
//            messageMap.put("pageNumber", this.pageNumber);
            messageMap.put("total", countRuleItem);
            messageMap.put("rows", list);
            this.webOut(response, messageMap);
        } 
        catch (Exception e) 
        {
            e.printStackTrace();
            messageResult.setCode(ConstantUtil.M_SYSTEM_ERROR);
            messageResult.setMessage("服务器繁忙，请稍后重试！");
            this.out(response, messageResult);
            Log4jTask.addLog("获得地推优惠券列表发生错误!", System.currentTimeMillis(), Log4jTask.ERROR, this.getClass().getName(), e);     
            return;
        }
    }
	
	
	@RequestMapping("/addOrUpdateCouponItem")
    public void addCouponItem(CouponRuleItem ruleItem, HttpServletRequest request,HttpServletResponse response)
    {
        MessageResult message = new MessageResult();              
        try 
        {
            if(null == ruleItem.getId())
            {
                
                ruleItem.setCreatedate(new Date()); 
                
                int result = 0;
                result = this.coupon_RuleService.addCouponItem(ruleItem);
                SysLogUtil.addLog(request, "添加地推优惠券规则", result);
                if (result != 0)
                {
                    message.setCode(ConstantUtil.M_SUCCESS);
                    message.setMessage("操作成功");
                    this.out(response, message);
                    return;
                }
                else {
                    message.setCode(ConstantUtil.M_REQUEST_INCORRECT);;
                    this.out(response, message);
                    return;
                }
                
                
            }
            
            
            ruleItem.setModifydate(new Date()); 

            int resultM = 0; 
            resultM = this.coupon_RuleService.updateCouponItem(ruleItem);
            SysLogUtil.addLog(request, "更新地推优惠券规则", resultM);
            if (resultM != 0)
            {
                message.setCode(ConstantUtil.M_SUCCESS);
                message.setMessage("操作成功");
                this.out(response, message);
                return;
            }
            else {
                message.setCode(ConstantUtil.M_REQUEST_INCORRECT);;
                this.out(response, message);
                return;
            }
        } 
        catch (Exception e) 
        {
        	SysLogUtil.addLog(request, "保存地推优惠券规则", 0);
            e.printStackTrace();
            message.setCode(ConstantUtil.M_SYSTEM_ERROR);
            message.setMessage("服务器繁忙，请稍后重试！");
            this.out(response, message);
            Log4jTask.addLog("获得增加地推规则发生错误!", System.currentTimeMillis(), Log4jTask.ERROR, this.getClass().getName(), e);     
            return;
        }
    }
	
	@RequestMapping("/deleteCouponItem")
    public void deleteCouponItem(HttpServletResponse response, HttpServletRequest request,String ids) 
    {
        MessageResult message = new MessageResult();
        try {
        
//        Map<String,Object> params = new HashMap<String,Object>();
        
        if (ids == null || "".equals(ids))
        {
            message.setCode(ConstantUtil.M_EXCEPTION);
            message.setMessage("id不能为空！");
        }
        else 
        {
            
//            params.put("id",id );
             String[]  idsArr = ids.split(",");
            List<String> idStrList = Arrays.asList(idsArr);
            
            
            
            int result = 0;
            result = coupon_RuleService.deleteCouponItem(idStrList); 
            SysLogUtil.addLog(request, "删除地推优惠券规则", 1);
            
            if (result != 0)
            {
                message.setCode(ConstantUtil.M_SUCCESS);
                message.setMessage("操作成功");
            }
            else
            {
                message.setCode(request+"");
                message.setMessage("操作失败");
            }
        }
                
        out(response, message);
        } catch (Exception exception) {
        	SysLogUtil.addLog(request, "删除地推优惠券规则", 0);
            Log4jTask.addLog("删除地推规则接口报错", System.currentTimeMillis(), Log4jTask.ERROR,
            		CouponRuleController.class.getName(), exception);
            message.setCode(ConstantUtil.M_SYSTEM_ERROR);
            message.setMessage("系统发生未知错误");
            this.out(response, message);
        }
    
    }
    
	
}
