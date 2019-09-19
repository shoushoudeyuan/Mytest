package net.joystart.promotion.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import jxl.Workbook;
import jxl.format.Alignment;
import jxl.format.Colour;
import jxl.format.UnderlineStyle;
import jxl.format.VerticalAlignment;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;
import jxl.write.biff.RowsExceededException;
import net.joystart.common.controller.BaseController;
import net.joystart.common.util.ConstantUtil;
import net.joystart.common.util.DataGridResult;
import net.joystart.common.util.MessageResult;
import net.joystart.common.util.PageUtil;
import net.joystart.common.util.SysLogUtil;
import net.joystart.common.util.log.Log4jTask;
import net.joystart.promotion.entity.PromotionPerson;
import net.joystart.promotion.service.IPromotionPersonService;

/**
 *
 * @author 李大海
 * @create 2016年8月19日 下午3:06:20
 *
 */

@Controller
@RequestMapping("/promotionPerson")
public class PromotionPersonController extends BaseController {
	
	@Resource
	private IPromotionPersonService promotionPersonService;
	
	@RequestMapping("/personList")
	public void personList(HttpServletResponse response, HttpServletRequest request,int rows,int page) 
	{
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("rowStart",PageUtil.rowStart(page - 1, rows) );
		params.put("pageSize",rows );
		String username = request.getParameter("username");
		String name = request.getParameter("name");
		String mobile = request.getParameter("mobile");
		String businessId = request.getParameter("businessId");
		String isdisable = request.getParameter("isdisable");
		if (!StringUtils.isBlank(username)) {
			params.put("username","%"+username+"%" );
		}
		if (!StringUtils.isBlank(name)) {
			params.put("name","%"+name+"%" );
		}
		if (!StringUtils.isBlank(mobile)) {
		    params.put("mobile","%"+mobile+"%" );
		}
		if (!StringUtils.isBlank(isdisable)) {
		    params.put("isdisable",isdisable );
		}
		if (!StringUtils.isBlank(businessId)) {
			params.put("businessId",businessId );
		}
		
		List<PromotionPerson> personList =promotionPersonService.list(params); 
		int rowCount =promotionPersonService.count(params);
		
		DataGridResult dgr = new DataGridResult();
		dgr.setTotal(rowCount);
		dgr.setRows(personList);
		webOut(response, dgr);
	
	}
	
	
	@RequestMapping("/addPerson")
    public void addPerson(PromotionPerson cus, HttpServletResponse response, HttpServletRequest request) {
        MessageResult message = new MessageResult();
        try {
        	PromotionPerson person = promotionPersonService.selectPersonByBindCustomerId(cus.getBindCustomerId());
        	if (person != null) {// 用会员已经被其他推广人员绑定
                message.setCode(ConstantUtil.M_EXCEPTION);
                message.setMessage("用户已经被其他推广人员绑定，请更换");
                this.out(response, message);
                return;
            }

            PromotionPerson business = promotionPersonService.selectPersonByUserName(cus.getUsername());
            if (business != null){// 用户名已经存在
                message.setCode(ConstantUtil.M_EXCEPTION);
                message.setMessage("用户名已经注册");
                this.out(response, message);
                return;
            }
			// 生成渠道码
			String channelCode = String.valueOf(Math.abs(new Random().nextLong()));
			channelCode = "Q" + channelCode.substring(channelCode.length() - 8, channelCode.length());
			PromotionPerson p = promotionPersonService.selectByChanneCode(channelCode);
			if (null != p) {
				channelCode = String.valueOf(Math.abs(new Random().nextLong()));
				channelCode = "Q" + channelCode.substring(channelCode.length() - 8, channelCode.length());
			}
			
			cus.setChannelCode(channelCode);
            // 添加用户
            cus.setCreatedate(new Date());
            int i = promotionPersonService.insertPerson(cus);

            
            if (i != 0){
                message.setCode(ConstantUtil.M_SUCCESS);
                message.setMessage("操作成功");
				SysLogUtil.addLog(request, "添加推广人员", 1);
            }else {
            	SysLogUtil.addLog(request, "添加推广人员", 0);
                message.setCode("0");
                message.setMessage("操作失败");
            }
            
            this.out(response, message);

        } catch (Exception exception) {
        	SysLogUtil.addLog(request, "添加推广人员", 0);
            Log4jTask.addLog("添加推广商户接口报错", System.currentTimeMillis(), Log4jTask.ERROR,
                    PromotionPersonController.class.getName(), exception);
            message.setCode(ConstantUtil.M_SYSTEM_ERROR);
            message.setMessage("系统发生未知错误");
            this.out(response, message);
        }
    }
	
	@RequestMapping("/updatePerson")
    public void updatePerson(PromotionPerson cus, HttpServletResponse response, HttpServletRequest request) {
        MessageResult message = new MessageResult();
        try {
        	PromotionPerson person1 = promotionPersonService.selectPersonByUserName(cus.getUsername());
            if (person1 != null &&  cus.getId() !=  person1.getId()) {// 用户名已经存在
                message.setCode(ConstantUtil.M_EXCEPTION);
                message.setMessage("用户名已经被占用");
                this.out(response, message);
                return;
            }
            
            PromotionPerson person2 = promotionPersonService.selectPersonById(cus.getId());
            if(person2.getBindCustomerId() == null){
            	PromotionPerson person = promotionPersonService.selectPersonByBindCustomerId(cus.getBindCustomerId());
            	if (person != null){// 用会员已经被其他推广人员绑定
                    message.setCode(ConstantUtil.M_EXCEPTION);
                    message.setMessage("用户已经被其他推广人员绑定，请更换");
                    this.out(response, message);
                    return;
                }
            }
        	
        	
            if (StringUtils.isBlank(person2.getChannelCode())) {
    			// 生成渠道码
    			String channelCode = String.valueOf(Math.abs(new Random().nextLong()));
    			channelCode = "Q" + channelCode.substring(channelCode.length() - 8, channelCode.length());
    			cus.setChannelCode(channelCode);
            }

            
            // 添加用户
            cus.setModifydate(new Date());
            int i = promotionPersonService.updatePerson(cus);
            
            if (i != 0){
                message.setCode(ConstantUtil.M_SUCCESS);
                SysLogUtil.addLog(request, "修改推广人员", 1);
                message.setMessage("操作成功");
            } else{
                message.setCode("0");
                SysLogUtil.addLog(request, "修改推广人员", 0);
                message.setMessage("操作失败");
            }
            
            this.out(response, message);

        } catch (Exception exception) {
        	SysLogUtil.addLog(request, "修改推广人员", 0);
            Log4jTask.addLog("修改推广商户接口报错", System.currentTimeMillis(), Log4jTask.ERROR,
                    PromotionPersonController.class.getName(), exception);
            message.setCode(ConstantUtil.M_SYSTEM_ERROR);
            message.setMessage("系统发生未知错误");
            this.out(response, message);
        }
    }
	
	@RequestMapping("/deletePerson")
    public void deletePerson(HttpServletResponse response, HttpServletRequest request,String ids) 
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
            result = promotionPersonService.deletePerson(idStrList); 
            
            if (result != 0)
            {
            	SysLogUtil.addLog(request, "删除推广人员", 1);
                message.setCode(ConstantUtil.M_SUCCESS);
                message.setMessage("操作成功");
            }
            else
            {
            	 SysLogUtil.addLog(request, "删除推广人员", 0);
                message.setCode(request+"");
                message.setMessage("操作失败");
            }
        }
                
        out(response, message);
        } catch (Exception exception) {
        	SysLogUtil.addLog(request, "删除推广人员", 0);
            Log4jTask.addLog("删除推广商家接口报错", System.currentTimeMillis(), Log4jTask.ERROR,
                    PromotionPersonController.class.getName(), exception);
            message.setCode(ConstantUtil.M_SYSTEM_ERROR);
            message.setMessage("系统发生未知错误");
            this.out(response, message);
        }
    
    }
	
	/**
	 * 绩效列表
	 * @param response
	 * @param request
	 */
	@RequestMapping("/performanceList")
	public void performanceList(HttpServletResponse response, HttpServletRequest request,int rows,int page)
	{
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("rowStart",PageUtil.rowStart(page - 1, rows) );
		params.put("pageSize",rows );
		String invitationCode = request.getParameter("invitationCode");
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		if (!StringUtils.isBlank(invitationCode)) {
			params.put("invitationCode",invitationCode );
		}
		
		if (!StringUtils.isBlank(startDate) ) 
		{
			params.put("startDate",startDate );
		}
		if(!StringUtils.isBlank(endDate))
		{
			params.put("endDate",endDate+" 23:59:59" );
		}
		List<Map<String,Object>> resutList = promotionPersonService.getPerformanceList(params);
		int rowCount =promotionPersonService.performanceCount(params);
		
		DataGridResult dgr = new DataGridResult();
		dgr.setTotal(rowCount);
		dgr.setRows(resutList);
		webOut(response, dgr);
	}
	
	@RequestMapping("/performanceExcelList")
	public void performanceExcelList(HttpServletResponse response, HttpServletRequest request)
	{
		Map<String,Object> params = new HashMap<String,Object>();
		String invitationCode = request.getParameter("invitationCode");
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		if (!StringUtils.isBlank(invitationCode)) {
			params.put("invitationCode",invitationCode );
		}
		
		if (!StringUtils.isBlank(startDate) && !StringUtils.isBlank(endDate)) 
		{
			params.put("startDate",startDate );
			params.put("endDate",endDate );
		}
		List<Map<String,Object>> resutList = promotionPersonService.getPerformanceList(params);
		exportperformanceExcel("绩效成绩.xls", resutList, response, request);
		
	}
	
	private void exportperformanceExcel(String fileName, List<Map<String,Object>> resutList, HttpServletResponse response,
            HttpServletRequest request) {
        WritableWorkbook wwb;
        FileOutputStream fos;
        try {
            fos = new FileOutputStream(fileName);
            wwb = Workbook.createWorkbook(fos);

            WritableSheet ws = wwb.createSheet(fileName, 0); // 创建一个工作表

            // 设置单元格的文字格式
            WritableFont wf = new WritableFont(WritableFont.ARIAL, 12, WritableFont.NO_BOLD, false,
                    UnderlineStyle.NO_UNDERLINE, Colour.BLACK);
            WritableCellFormat wcf = new WritableCellFormat(wf);
            wcf.setVerticalAlignment(VerticalAlignment.CENTRE);
            wcf.setAlignment(Alignment.CENTRE);
            ws.setRowView(1, 500);
            // 设置标题行
            ws.addCell(new Label(0, 0, "订单号", wcf));
            ws.addCell(new Label(1, 0, "用户名", wcf));
            ws.addCell(new Label(2, 0, "姓名", wcf));
            ws.addCell(new Label(3, 0, "订单实付金额", wcf));
            ws.addCell(new Label(4, 0, "提成百分比", wcf));
            ws.addCell(new Label(5, 0, "提成金额", wcf));
            ws.addCell(new Label(6, 0, "订单完成时间", wcf));
            ws.addCell(new Label(7, 0, "绩效周期起始日", wcf));
            ws.addCell(new Label(8, 0, "绩效周期截止日", wcf));
            
            
            // 填充数据的内容
            for (int i = 0; i < resutList.size(); i++) {
            	Map<String,Object> map = resutList.get(i); 
                ws.addCell(new Label(0, i + 1, map.get("orderNo")+"", wcf));
                ws.addCell(new Label(1, i + 1, map.get("userName")+"", wcf));
                ws.addCell(new Label(2, i + 1, map.get("name")+"", wcf));
                ws.addCell(new Label(3, i + 1, map.get("actualPaymentCost")+"", wcf));
                ws.addCell(new Label(4, i + 1, map.get("pushPercent")+"", wcf));
                ws.addCell(new Label(5, i + 1, map.get("pushMoney")+"", wcf));
                ws.addCell(new Label(6, i + 1, map.get("finishDate")+"", wcf));
                ws.addCell(new Label(7, i + 1, map.get("startDays")+"", wcf));
                ws.addCell(new Label(8, i + 1, map.get("endDays")+"", wcf));
            }

            wwb.write();
            wwb.close();
            FileInputStream fileInputStream = new FileInputStream(new File(fileName));
            response.reset(); // 必要地清除response中的缓存信息
            Date dt = new Date();// 如果不需要格式,可直接用dt,dt就是当前系统时间
            DateFormat df = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");// 设置显示格式
            String nowTime = "";
            nowTime = df.format(dt);// 用DateFormat的format()方法在dt中获取并以yyyy/MM/dd
                                    // HH:mm:ss格式显示
            fileName = "绩效成绩" + nowTime + ".xls";
            final String userAgent = request.getHeader("USER-AGENT");
            String finalFileName = null;
            if (StringUtils.contains(userAgent, "MSIE")) {// IE浏览器
                finalFileName = URLEncoder.encode(fileName, "UTF8");
            } else if (StringUtils.contains(userAgent, "Mozilla")) {// google,火狐浏览器
                finalFileName = new String(fileName.getBytes(), "ISO8859-1");
            } else {
                finalFileName = URLEncoder.encode(fileName, "UTF8");// 其他浏览器
            }
            response.setHeader("Content-Disposition", "attachment; filename=\"" + finalFileName + "\"");// 这里设置一下让浏览器弹出下载提示框，而不是直接在浏览器中打开

            // response.setCharacterEncoding("gb2312");//必须写，否则会有乱码
            // response.setE = System.Text.Encoding.UTF7; //必须写，否则会有乱码
            // response.setHeader("Content-Disposition", "attachment;
            // filename='分时订单.xls'");
            javax.servlet.ServletOutputStream out = response.getOutputStream();
            byte[] content = new byte[fileInputStream.available()];
            int length = 0;
            while ((length = fileInputStream.read(content)) != -1) {
                out.write(content, 0, length);
            }
            out.write(content);
            out.flush();
            fileInputStream.close();
            out.close();
        } catch (IOException e) {
        	e.printStackTrace();
        } catch (RowsExceededException e) {
        	e.printStackTrace();
        } catch (WriteException e) {
        	e.printStackTrace();
        }
    }

	
	
	@RequestMapping("/personExcelList")
	public void personExcelList(HttpServletResponse response, HttpServletRequest request) 
	{
		Map<String,Object> params = new HashMap<String,Object>();
		String username = request.getParameter("username");
		String name = request.getParameter("name");
		String mobile = request.getParameter("mobile");
		String businessId = request.getParameter("businessId");
		String isdisable = request.getParameter("isdisable");
		if (!StringUtils.isBlank(username)) {
			params.put("username","%"+username+"%" );
		}
		if (!StringUtils.isBlank(name)) {
			params.put("name","%"+name+"%" );
		}
		if (!StringUtils.isBlank(mobile)) {
		    params.put("mobile","%"+mobile+"%" );
		}
		if (!StringUtils.isBlank(isdisable)) {
		    params.put("isdisable",isdisable );
		}
		if (!StringUtils.isBlank(businessId)) {
		    params.put("businessId",businessId );
		}
		List<PromotionPerson> personList =promotionPersonService.list(params); 
		
		exportPersonExcel("推广人员.xls",personList, response, request);
	
	}
	
	private void exportPersonExcel(String fileName, List<PromotionPerson> personList, HttpServletResponse response,
            HttpServletRequest request) {
        WritableWorkbook wwb;
        FileOutputStream fos;
        try {
            fos = new FileOutputStream(fileName);
            wwb = Workbook.createWorkbook(fos);

            WritableSheet ws = wwb.createSheet(fileName, 0); // 创建一个工作表

            // 设置单元格的文字格式
            WritableFont wf = new WritableFont(WritableFont.ARIAL, 12, WritableFont.NO_BOLD, false,
                    UnderlineStyle.NO_UNDERLINE, Colour.BLACK);
            WritableCellFormat wcf = new WritableCellFormat(wf);
            wcf.setVerticalAlignment(VerticalAlignment.CENTRE);
            wcf.setAlignment(Alignment.CENTRE);
            ws.setRowView(1, 500);
            // 设置标题行
            ws.addCell(new Label(0, 0, "订单金额", wcf));
            ws.addCell(new Label(1, 0, "提出金额", wcf));
            ws.addCell(new Label(2, 0, "用户名", wcf));
            ws.addCell(new Label(3, 0, "真实姓名", wcf));
            ws.addCell(new Label(4, 0, "手机号", wcf));
            ws.addCell(new Label(5, 0, "创建时间", wcf));
            ws.addCell(new Label(6, 0, "状态", wcf));
            
            
            // 填充数据的内容
            for (int i = 0; i < personList.size(); i++) {
            	PromotionPerson person = personList.get(i); 
                ws.addCell(new Label(0, i + 1, (person.getOrdermoney()==null)?"":person.getOrdermoney()+"", wcf));
                ws.addCell(new Label(1, i + 1, (person.getPushmoney()==null)?"":person.getPushmoney()+"", wcf));
                ws.addCell(new Label(2, i + 1, person.getUserName(), wcf));
                ws.addCell(new Label(3, i + 1, person.getName(), wcf));
                ws.addCell(new Label(4, i + 1, (person.getBindCustomerId() == null)?person.getMobile():person.getMobile()+"(已绑定)", wcf));
                ws.addCell(new Label(5, i + 1, person.getCreatedate()==null?
                        "":DateFormatUtils.format(person.getCreatedate(), "yyyy-MM-dd HH:mm:ss"), wcf));
                if (person.getIsdisable() ==0)
                {
                    ws.addCell(new Label(6, i + 1, "启用", wcf));
                }
                else {
                    ws.addCell(new Label(6, i + 1, "禁用", wcf));
                }
            }

            wwb.write();
            wwb.close();
            FileInputStream fileInputStream = new FileInputStream(new File(fileName));
            response.reset(); // 必要地清除response中的缓存信息
            Date dt = new Date();// 如果不需要格式,可直接用dt,dt就是当前系统时间
            DateFormat df = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");// 设置显示格式
            String nowTime = "";
            nowTime = df.format(dt);// 用DateFormat的format()方法在dt中获取并以yyyy/MM/dd
                                    // HH:mm:ss格式显示
            fileName = "推广人员" + nowTime + ".xls";
            final String userAgent = request.getHeader("USER-AGENT");
            String finalFileName = null;
            if (StringUtils.contains(userAgent, "MSIE")) {// IE浏览器
                finalFileName = URLEncoder.encode(fileName, "UTF8");
            } else if (StringUtils.contains(userAgent, "Mozilla")) {// google,火狐浏览器
                finalFileName = new String(fileName.getBytes(), "ISO8859-1");
            } else {
                finalFileName = URLEncoder.encode(fileName, "UTF8");// 其他浏览器
            }
            response.setHeader("Content-Disposition", "attachment; filename=\"" + finalFileName + "\"");// 这里设置一下让浏览器弹出下载提示框，而不是直接在浏览器中打开

            // response.setCharacterEncoding("gb2312");//必须写，否则会有乱码
            // response.setE = System.Text.Encoding.UTF7; //必须写，否则会有乱码
            // response.setHeader("Content-Disposition", "attachment;
            // filename='分时订单.xls'");
            javax.servlet.ServletOutputStream out = response.getOutputStream();
            byte[] content = new byte[fileInputStream.available()];
            int length = 0;
            while ((length = fileInputStream.read(content)) != -1) {
                out.write(content, 0, length);
            }
            out.write(content);
            out.flush();
            fileInputStream.close();
            out.close();
        } catch (IOException e) {
        	e.printStackTrace();
        } catch (RowsExceededException e) {
        	e.printStackTrace();
        } catch (WriteException e) {
        	e.printStackTrace();
        }
    }

}
