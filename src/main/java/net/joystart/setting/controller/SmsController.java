package net.joystart.setting.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import net.joystart.common.controller.BaseController;
import net.joystart.common.entity.PayConfig;
import net.joystart.common.service.IPayConfigService;
import net.joystart.common.util.ConstantUtil;
import net.joystart.common.util.MessageResult;
import net.joystart.common.util.log.Log4jTask;
import net.joystart.setting.service.ISmsService;

@Controller
@RequestMapping("/sms")
public class SmsController extends BaseController
{
    @Resource
    ISmsService smsService;
    
    @Resource
    IPayConfigService payConfigService;

    /**
     * @Description 短信记录
     * @author:  zhuwq
     * Create at: 2017年8月29日 上午11:14:28
     * @param response
     * @param request
     * @param rows
     * @param page
     */
    @RequestMapping("/list")
    public void list(HttpServletResponse response, HttpServletRequest request, int rows, int page) {
        Map<String, Object> params = new HashMap<String, Object>();
        try{
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
            
            String startTtime = request.getParameter("startTime");
            if (!StringUtils.isBlank(startTtime)){
                params.put("startTime", startTtime);
            }
            
            String endTime = request.getParameter("endTime");
            if (!StringUtils.isBlank(endTime)){
                params.put("endTime", endTime);
            }
            String mobile = request.getParameter("mobile");
            if (!StringUtils.isBlank(mobile)){
                params.put("mobile", mobile);
            }
            String hostName = request.getServerName();
            PayConfig payConfig = payConfigService.seleConfigByHost(hostName);
            params.put("taskId", payConfig.getSmstaskid());
            params.put("smsvalidatetaskid", payConfig.getSmsvalidatetaskid());
            HashMap<String, Object> dataMap = new HashMap<String, Object>();
            
            List<Map<String,Object>> smsList = smsService.getSmsLogList(params);
            //获取总条数
            Integer count = smsService.getSmsLogListCount(params);
            dataMap.put("total", count);
            dataMap.put("rows", smsList);
            webOut(response, dataMap);
        }catch(Exception e){
            Log4jTask.addLog("获取短信记录列表报错", System.currentTimeMillis(), Log4jTask.ERROR, SmsController.class.getName(), e);
            MessageResult result = new MessageResult(ConstantUtil.M_SYSTEM_ERROR, "系统发生未知错误");
            out(response, result);
        }
    }
}
