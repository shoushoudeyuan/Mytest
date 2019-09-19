package net.joystart.promotion.controller;

import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import net.joystart.common.controller.BaseController;
import net.joystart.common.util.ConstantUtil;
import net.joystart.common.util.DataGridResult;
import net.joystart.common.util.MessageResult;
import net.joystart.common.util.PageUtil;
import net.joystart.common.util.SysLogUtil;
import net.joystart.common.util.log.Log4jTask;
import net.joystart.common.util.security.EncryptionUtil;
import net.joystart.couponmanage.entity.CouponPackage;
import net.joystart.couponmanage.service.ICouponPackageService;
import net.joystart.promotion.entity.PromotionBusiness;
import net.joystart.promotion.service.IPromotionBusinessService;
import net.joystart.system.entity.SysUser;
import net.joystart.system.remote.service.ISysUserRemoteService;

/**
 *
 * @author 李大海
 * @create 2016年8月19日 下午3:06:20
 *
 */

@Controller
@RequestMapping("/promotionBusiness")
public class PromotionBusinessController extends BaseController {
	
	@Resource
	private IPromotionBusinessService promotionBusinessService;
	
	@Resource
	private ISysUserRemoteService sysUserRemoteService;
	
	@Autowired
	private ICouponPackageService svcPackage;
	
	@RequestMapping("/businessList")
	public void businessList(HttpServletResponse response, HttpServletRequest request,int rows,int page) 
	{
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("rowStart",PageUtil.rowStart(page - 1, rows) );
		params.put("pageSize",rows );
		String username = request.getParameter("username");
		String name = request.getParameter("name");
		String mobile = request.getParameter("mobile");
		String address = request.getParameter("address");
		String mail = request.getParameter("mail");
		if (!StringUtils.isBlank(username)) {
			params.put("username","%"+username+"%" );
		}
		if (!StringUtils.isBlank(name)) {
			params.put("name","%"+name+"%" );
		}
		if (!StringUtils.isBlank(mobile)) {
		    params.put("mobile","%"+mobile+"%" );
		}
		if (!StringUtils.isBlank(address)) {
			params.put("address","%"+address+"%" );
		}
		if (!StringUtils.isBlank(mail)) {
		    params.put("mail","%"+mail+"%" );
		}
		
		List<PromotionBusiness> customerList =promotionBusinessService.list(params); 
		int rowCount =promotionBusinessService.count(params);
		
		DataGridResult dgr = new DataGridResult();
		dgr.setTotal(rowCount);
		dgr.setRows(customerList);
		webOut(response, dgr);
	
	}
	
	
	@RequestMapping("/addBusiness")
    public void addBusiness(PromotionBusiness cus, HttpServletResponse response, HttpServletRequest request) {
        MessageResult message = new MessageResult();
        try {
            
            
//            String regExp = ConstantUtil.REG_PASSWORD_EXP;
//            Pattern p = Pattern.compile(regExp);
//            Matcher m = p.matcher(cus.getPassword().trim());
//            if (!m.find()) {
//                message.setCode(ConstantUtil.M_EXCEPTION);
//                message.setMessage("请输入正确的密码(6至8位的数字、字母、下划线)");
//                this.out(response, message);
//                return;
//            }

            PromotionBusiness business = promotionBusinessService.selectBusinessByUserName(cus.getUsername());
            SysUser sysUser = sysUserRemoteService.selectByUserName(cus.getUsername());
            if (business != null || sysUser != null)// 用户名已经存在
            {
                message.setCode(ConstantUtil.M_EXCEPTION);
                message.setMessage("用户名已经注册");
                this.out(response, message);
                return;
            }
            
            

            
            // 添加用户
            
            cus.setPassword(cus.getPassword());
            cus.setCreatedate(new Date());
            
            //管理员表
            SysUser user = new SysUser();
            user.setUsername(cus.getUsername());
            user.setPassword(cus.getPassword());
            user.setEmail(cus.getMail());
            user.setMobile(cus.getMobile());
            user.setRealname("推广管理员");
            user.setStatus((int)cus.getIsdisable());
    		user.setCreatedate(new Date());
    		user.setGender(0);
    		user.setQuestion("我是推广商");
    		user.setAnwser("是的");
    		SysUser loginUser = (SysUser) request.getSession().getAttribute("user");
    		if( loginUser != null)
    		{
    			user.setCreateuser(loginUser.getId());
    		}
            
            int i = promotionBusinessService.insertBusiness(cus,user);
            
            SysLogUtil.addLog(request, "添加推广商", 1);
            
            if (i != 0)
            {
                message.setCode(ConstantUtil.M_SUCCESS);
                message.setMessage("操作成功");
            }
            else
            {
                message.setCode("0");
                message.setMessage("操作失败");
            }
            
            this.out(response, message);

        } catch (Exception exception) {
        	SysLogUtil.addLog(request, "添加推广商", 0);
            Log4jTask.addLog("添加推广商户接口报错", System.currentTimeMillis(), Log4jTask.ERROR,
                    PromotionBusinessController.class.getName(), exception);
            message.setCode(ConstantUtil.M_SYSTEM_ERROR);
            message.setMessage("系统发生未知错误");
            this.out(response, message);
        }
    }
	
	@RequestMapping("/updateBusiness")
    public void updateBusiness(PromotionBusiness cus, HttpServletResponse response, HttpServletRequest request) {
        MessageResult message = new MessageResult();
        try {
            
            

//            PromotionBusiness business = promotionBusinessService.selectBusinessByUserName(cus.getUsername());
//          
//            if (business != null &&  cus.getId() !=  business.getId())// 用户名已经存在
//            {
//                message.setCode(ConstantUtil.M_EXCEPTION);
//                message.setMessage("用户名已经被占用");
//                this.out(response, message);
//                return;
//            }
          //管理员表
            SysUser user = sysUserRemoteService.selectByUserName(cus.getUsername());
//            if (user != null &&  user.getId().intValue() !=  cus.getUserId().intValue())// 用户名已经存在
//            {
//                message.setCode(ConstantUtil.M_EXCEPTION);
//                message.setMessage("用户名已经被占用!");
//                this.out(response, message);
//                return;
//            }
            if(user == null)
            {
            	user = new SysUser();
            }
            user.setId(cus.getUserId());
            
            user.setUsername(cus.getUsername());
            user.setEmail(cus.getMail());
            user.setMobile(cus.getMobile());
            user.setRealname(cus.getName());
            user.setStatus((int)cus.getIsdisable());
            user.setModifydate(cus.getModifydate());
            
            cus.setModifydate(new Date());
            int i = promotionBusinessService.updateBusiness(cus,user);
            SysLogUtil.addLog(request, "修改推广商", 1);
            if (i != 0)
            {
            	SysLogUtil.addLog(request, "修改推广商", 1);
                message.setCode(ConstantUtil.M_SUCCESS);
                message.setMessage("操作成功");
            }
            else
            {
            	SysLogUtil.addLog(request, "修改推广商", 0);
                message.setCode("0");
                message.setMessage("操作失败");
            }
            
            this.out(response, message);

        } catch (Exception exception) {
        	SysLogUtil.addLog(request, "修改推广商", 0);
            Log4jTask.addLog("修改推广商户接口报错", System.currentTimeMillis(), Log4jTask.ERROR,
                    PromotionBusinessController.class.getName(), exception);
            message.setCode(ConstantUtil.M_SYSTEM_ERROR);
            message.setMessage("系统发生未知错误");
            this.out(response, message);
        }
    }
	
	@RequestMapping("/deleteBusiness")
    public void deleteBusiness(HttpServletResponse response, HttpServletRequest request,String ids) 
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
            result = promotionBusinessService.deleteBusiness(idStrList); 
            
            
            if (result != 0)
            {
            	SysLogUtil.addLog(request, "删除推广商", 1);
                message.setCode(ConstantUtil.M_SUCCESS);
                message.setMessage("操作成功");
            }
            else
            {
            	SysLogUtil.addLog(request, "删除推广商", 0);
                message.setCode(request+"");
                message.setMessage("操作失败");
            }
        }
                
        out(response, message);
        } catch (Exception exception) {
        	SysLogUtil.addLog(request, "删除推广商", 0);
            Log4jTask.addLog("删除推广商家接口报错", System.currentTimeMillis(), Log4jTask.ERROR,
                    PromotionBusinessController.class.getName(), exception);
            message.setCode(ConstantUtil.M_SYSTEM_ERROR);
            message.setMessage("系统发生未知错误");
            this.out(response, message);
        }
    
    }
	
	@RequestMapping("/login")
	public void login(HttpServletRequest request,HttpServletResponse response) throws Exception{
		HashMap<String,Object> messageMap = new HashMap<String,Object>();
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put("userName", username);
		params.put("password", EncryptionUtil.md5(password));
		
		PromotionBusiness cus = promotionBusinessService.login(params);
		if(cus != null)
		{
			request.getSession().setAttribute("businessId", cus.getId());
			messageMap.put("success",true);
			this.out(response, messageMap);
		}
		else
		{
			messageMap.put("success",false);
			this.out(response, messageMap);
		}
	}
	
	
	@RequestMapping("/couponpackageid")
    public void getCouponPackageId(HttpServletResponse response, HttpServletRequest request,Integer businessId,String userName) {
		MessageResult result = new MessageResult();
		try{
			CouponPackage p = new CouponPackage();
			p.setPkgname(userName + "推广优惠券");
			svcPackage.createPackage(p);
			promotionBusinessService.updateCouponPackageId(businessId,p.getId());
			result.setCode(ConstantUtil.W_SUCCESS);
			result.setData(p.getId());
			outJson(response,result);
		}catch(Exception e){
			result.setCode(ConstantUtil.W_EXCEPTION);
			outJson(response,result);
		}
		
	}
}
