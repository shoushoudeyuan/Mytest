package net.joystart.promotion.controller;

import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import net.joystart.common.controller.BaseController;
import net.joystart.common.util.ConstantUtil;
import net.joystart.common.util.DataGridResult;
import net.joystart.common.util.MessageResult;
import net.joystart.common.util.PageUtil;
import net.joystart.common.util.SysLogUtil;
import net.joystart.common.util.log.Log4jTask;
import net.joystart.promotion.entity.PromotionRules;
import net.joystart.promotion.service.IPromotionRulesService;
import net.joystart.system.entity.SysUser;

/**
 *
 * @author 李大海
 * @create 2016年8月19日 下午3:06:20
 *
 */

@Controller
@RequestMapping("/promotionRules")
public class PromotionRulesController extends BaseController {
	
	@Resource
	private IPromotionRulesService promotionRulesService;
	
	@RequestMapping("/rulesList")
	public void rulesList(HttpServletResponse response, HttpServletRequest request,int rows,int page) 
	{
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("rowStart",PageUtil.rowStart(page - 1, rows) );
		params.put("pageSize",rows );
		String businessId = request.getParameter("businessId");
		params.put("businessId",businessId );
		List<PromotionRules> customerList =promotionRulesService.list(params); 
		int rowCount =promotionRulesService.count(params);
		
		DataGridResult dgr = new DataGridResult();
		dgr.setTotal(rowCount);
		dgr.setRows(customerList);
		webOut(response, dgr);
	
	}
	
	
	@RequestMapping("/addRules")
    public void addRules(PromotionRules cus, HttpServletResponse response, HttpServletRequest request) {
        MessageResult message = new MessageResult();
        try {
            
            
//            String regExp = ConstantUtil.REG_PASSWORD_EXP;
//            Pattern p = Pattern.compile(regExp);
//            Matcher m = p.matcher(cus.getPassword().trim());
//            if (!m.find()) {
//                message.setCode(ConstantUtil.M_EXCEPTION);
//                message.setMessage("请输入正确的密码(6至12位的数字、字母和下划线)");
//                this.out(response, message);
//                return;
//            }

//            PromotionRules business = promotionRulesService.selectRulesByUserName(cus.getUsername());
//            if (business != null)// 用户名已经存在
//            {
//                message.setCode(ConstantUtil.M_EXCEPTION);
//                message.setMessage("用户名已经注册");
//                this.out(response, message);
//                return;
//            }

            
            cus.setCreatedate(new Date());
            SysUser sysUser = (SysUser)request.getSession().getAttribute("user");
            cus.setUserid(sysUser.getId());
            int i = promotionRulesService.insertRules(cus);
            
            if (i != 0)
            {
            	SysLogUtil.addLog(request, "添加规则", 1);
                message.setCode(ConstantUtil.M_SUCCESS);
                message.setMessage("操作成功");
            }
            else
            {
            	SysLogUtil.addLog(request, "添加规则", 0);
                message.setCode("0");
                message.setMessage("操作失败");
            }
            
            this.out(response, message);

        } catch (Exception exception) {
        	 SysLogUtil.addLog(request, "添加规则", 0);
            Log4jTask.addLog("添加推广商户接口报错", System.currentTimeMillis(), Log4jTask.ERROR,
            		PromotionRulesController.class.getName(), exception);
            message.setCode(ConstantUtil.M_SYSTEM_ERROR);
            message.setMessage("系统发生未知错误");
            this.out(response, message);
        }
    }
	
	@RequestMapping("/updateRules")
    public void updateRules(PromotionRules cus, HttpServletResponse response, HttpServletRequest request) {
        MessageResult message = new MessageResult();
        try {

//            PromotionPerson business = promotionRulesService.selectRulesByUserName(cus.getUsername());
//            if (business != null &&  cus.getId() !=  business.getId())// 用户名已经存在
//            {
//                message.setCode(ConstantUtil.M_EXCEPTION);
//                message.setMessage("用户名已经被占用");
//                this.out(response, message);
//                return;
//            }

            
            // 添加用户
            cus.setModifydate(new Date());
            int i = promotionRulesService.updateRules(cus);
            
            if (i != 0)
            {
            	SysLogUtil.addLog(request, "修改规则", 1);
                message.setCode(ConstantUtil.M_SUCCESS);
                message.setMessage("操作成功");
            }
            else
            {
            	SysLogUtil.addLog(request, "修改规则", 0);
                message.setCode("0");
                message.setMessage("操作失败");
            }
            
            this.out(response, message);

        } catch (Exception exception) {
        	SysLogUtil.addLog(request, "修改规则", 0);
            Log4jTask.addLog("修改推广商户接口报错", System.currentTimeMillis(), Log4jTask.ERROR,
            		PromotionRulesController.class.getName(), exception);
            message.setCode(ConstantUtil.M_SYSTEM_ERROR);
            message.setMessage("系统发生未知错误");
            this.out(response, message);
        }
    }
	
	@RequestMapping("/deleteRules")
    public void deleteRules(HttpServletResponse response, HttpServletRequest request,String ids) 
    {
        MessageResult message = new MessageResult();
        try {
        
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
            result = promotionRulesService.deleteRules(idStrList); 
            
            if (result != 0)
            {
            	SysLogUtil.addLog(request, "删除规则", 1);
                message.setCode(ConstantUtil.M_SUCCESS);
                message.setMessage("操作成功");
            }
            else
            {
            	SysLogUtil.addLog(request, "删除规则", 1);
                message.setCode(request+"");
                message.setMessage("操作失败");
            }
        }
                
        out(response, message);
        } catch (Exception exception) {
        	SysLogUtil.addLog(request, "删除规则", 0);
            Log4jTask.addLog("删除推广商家接口报错", System.currentTimeMillis(), Log4jTask.ERROR,
            		PromotionRulesController.class.getName(), exception);
            message.setCode(ConstantUtil.M_SYSTEM_ERROR);
            message.setMessage("系统发生未知错误");
            this.out(response, message);
        }
    
    }

}
