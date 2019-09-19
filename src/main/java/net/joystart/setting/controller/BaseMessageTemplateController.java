package net.joystart.setting.controller;

import java.io.BufferedOutputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;

import net.joystart.common.controller.BaseController;
import net.joystart.common.util.ConfigUtil;
import net.joystart.common.util.MessageResult;
import net.joystart.common.util.SysLogUtil;
import net.joystart.common.util.log.Log4jTask;
import net.joystart.setting.entity.BaseMessageTemplate;
import net.joystart.setting.service.IBaseMessageTemplateService;
import net.joystart.setting.utils.SensitiveWordsUtil;

@Controller
@RequestMapping("/baseMessageTemplate")
public class BaseMessageTemplateController extends BaseController
{
	@Resource
	IBaseMessageTemplateService baseMessageTemplateService;
	
	//短信模板列表
	@RequestMapping("/getMessageTemplateList")
	public void getMessageTemplateList(HttpServletRequest request, HttpServletResponse response) {
		List<BaseMessageTemplate> list = null;
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
		
		String identification = request.getParameter("identification");
		if (!StringUtils.isEmpty(identification)) {
			params.put("identification","%"+identification+"%");
		} else {
			params.put("identification", null);
		}
		
		String content = request.getParameter("content");
		if (!StringUtils.isEmpty(content)) {
			params.put("content","%"+content+"%");
		} else {
			params.put("content", null);
		}
		
		

		Integer count = baseMessageTemplateService.getMessageTemplateListCount(params);
		// 查询列表
		list = baseMessageTemplateService.getMessageTemplateList(params);
		dataMap.put("list", list);
		HashMap<String, Object> messageMap = new HashMap<String, Object>();
		messageMap.put("total", count);
		messageMap.put("rows", list);

		this.webOut(response, messageMap);
		return;
	}
	//短信模板添加
	@RequestMapping("/messageTemplateAdd")
	public void messageTemplateAdd(BaseMessageTemplate message, HttpServletRequest request, HttpServletResponse response) {
	    MessageResult messageResult = new MessageResult();
	    try {
			Map<String, Object> params = new HashMap<String, Object>();
			String identification = message.getIdentification();
			if (!StringUtils.isEmpty(identification)) {
				params.put("identification",identification);
			} else {
				params.put("identification", null);
			}
			
			Integer count = baseMessageTemplateService.getMessageTemplateCountByIdentification(params);
			
			if(count!=0)
			{
				this.out(response, 2);//信息别称已存在
				return;
			}
			//过滤敏感词
			List<String> sensitiveWords = SensitiveWordsUtil.getSensitiveWords();
            for (String words : sensitiveWords) {
                if(message.getContent().indexOf(words)!=-1){
                    //短信内容含有敏感词
                    messageResult.setCode("3");
                    messageResult.setMessage("短信内容含有敏感词:"+"<label style='color:red'>"+words+"</label>");
                    this.out(response, messageResult);
                    return;
                }
            }
			
			message.setCreatedate(new Date());
			baseMessageTemplateService.insertSelective(message);
			SysLogUtil.addLog(request, "添加短信模板", 1);

			this.out(response, 1);//成功
			return;
		} catch (Exception ex) {
			SysLogUtil.addLog(request, "添加短信模板", 0);
			Log4jTask.addLog("添加车辆价格报错", System.currentTimeMillis(), Log4jTask.ERROR,
					BaseMessageTemplateController.class.getName(), ex);
			this.out(response, 0);//失败
			return;
			
		}
	}
	//短信模板修改
	@RequestMapping("/messageTemplateUpdate")
	public void messageTemplateUpdate(BaseMessageTemplate message, HttpServletRequest request, HttpServletResponse response) {
	    MessageResult messageResult = new MessageResult();
		try {
		
			//过滤敏感词
            List<String> sensitiveWords = SensitiveWordsUtil.getSensitiveWords();
            for (String words : sensitiveWords) {
                if(message.getContent().indexOf(words)!=-1){
                    //短信内容含有敏感词
                    messageResult.setCode("3");
                    messageResult.setMessage("信息内容含有敏感词:"+"<label style='color:red'>"+words+"</label>");
                    this.out(response, messageResult);
                    return;
                }
            }
			
			baseMessageTemplateService.updateByPrimaryKeySelective(message);
			SysLogUtil.addLog(request, "通知模板修改", 1);

			this.out(response, 1);//成功
			return;
		} catch (Exception ex) {
			SysLogUtil.addLog(request, "通知模板修改", 0);
			Log4jTask.addLog("添加通知模板报错", System.currentTimeMillis(), Log4jTask.ERROR,
					BaseMessageTemplateController.class.getName(), ex);
			this.out(response, 0);//失败
			return;
			
		}
	}
	
	@RequestMapping("/downSensitiveWords")
    public void downSensitiveWords(HttpServletRequest request, HttpServletResponse response) throws Exception {   
	    response.setContentType("text/plain");// 一下两行关键的设置  
        response.addHeader("Content-Disposition", "attachment;filename=sensitiveWords.txt");// filename指定默认的名字  
        BufferedOutputStream buff = null;  
        StringBuffer write = new StringBuffer();  
        ServletOutputStream outSTr = null;  
        try {  
            outSTr = response.getOutputStream();// 建立  
            buff = new BufferedOutputStream(outSTr);  
            String sensitiveWords = ConfigUtil.pro.getProperty("sensitiveWords");
            write.append(sensitiveWords);          
            buff.write(write.toString().getBytes("UTF-8"));  
            buff.flush();  
            buff.close();  
        } catch (Exception e) {  
            e.printStackTrace();  
        } finally {  
            try {  
                buff.close();  
                outSTr.close();  
            } catch (Exception e) {  
                e.printStackTrace();  
            }  
        }  
    }   
}
