package net.joystart.couponmanage.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
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
import net.joystart.common.controller.BaseController;
import net.joystart.common.database.DataSourceAspect;
import net.joystart.common.database.HandleDataSource;
import net.joystart.common.entity.PayConfig;
import net.joystart.common.service.IPayConfigService;
import net.joystart.common.util.ConstantUtil;
import net.joystart.common.util.MessageResult;
import net.joystart.common.util.PostMsgHttpContent;
import net.joystart.common.util.SysLogUtil;
import net.joystart.couponmanage.entity.CouponPackageItem;
import net.joystart.couponmanage.entity.CustomerCouponNew;
import net.joystart.couponmanage.entity.CustomerCouponNewVO;
import net.joystart.couponmanage.enums.CouponGiftModeEnum;
import net.joystart.couponmanage.enums.CouponTypeEnum;
import net.joystart.couponmanage.enums.CouponUsedEnum;
import net.joystart.couponmanage.service.ICustomerCouponNewService;
import net.joystart.customer.entity.Customer;
import net.joystart.customer.remote.service.ICustomerRemoteService;
import net.joystart.customer.remote.service.IMessageRemoteService;
import net.joystart.setting.entity.BaseMessageTemplate;
import net.joystart.setting.remote.service.IBaseMessageTemplateRemoteService;

/**
 * 优惠券controller
 * @author zm.mu
 *
 */
@Controller
@RequestMapping("/customerCouponNew")
public class CustomerCouponNewController extends BaseController {

	@Autowired
	private ICustomerCouponNewService customerCouponNewService;
	
	@Resource 
    IBaseMessageTemplateRemoteService baseMessageTemplateRemoteService;
	
	@Autowired
	private ICustomerRemoteService customerRemoteService;
	
	@Resource
    IPayConfigService payConfigService;
	
	@Resource
	IMessageRemoteService messageRemoteService;
	
	/**
	 * 优惠券列表
	 * @param request
	 * @param response
	 */
	@RequestMapping("/getCustomerCouponNewList")
	public void getCustomerCouponNewList(HttpServletRequest request, HttpServletResponse response) {
		
		HashMap<String, Object> result = new HashMap<String, Object>();
		
		Integer page = request.getParameter("page") == null ? 1 : Integer.valueOf(request.getParameter("page"));
		Integer rows = request.getParameter("rows") == null ? 10 : Integer.valueOf(request.getParameter("rows"));
		
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("startIndex", (page-1)*rows);
		paramMap.put("pageSize", rows);
		String couponNo = request.getParameter("couponNo");
		String mobile = request.getParameter("mobile");
		String isUsed = request.getParameter("isUsed");
		String expireDate = request.getParameter("expireDate");
		String sourceType = request.getParameter("sourceType");
		String createDateStart = request.getParameter("createDateStart");
		String createDateEnd = request.getParameter("createDateEnd");
		
		if (StringUtils.isNotEmpty(couponNo)) {
			paramMap.put("couponNo", couponNo);
		}
		if (StringUtils.isNotEmpty(mobile)) {
			paramMap.put("mobile", mobile);
		}
		if (StringUtils.isNotEmpty(isUsed)) {
			paramMap.put("isUsed", isUsed);
		}
		if (StringUtils.isNotEmpty(expireDate)) {
			paramMap.put("expireDate", expireDate);
		}
		if (StringUtils.isNotEmpty(sourceType)) {
			paramMap.put("sourceType", sourceType);
		}if (StringUtils.isNotEmpty(createDateStart)) {
			paramMap.put("createDateStart", createDateStart);
		}
		if (StringUtils.isNotEmpty(createDateEnd)) {
			paramMap.put("createDateEnd", createDateEnd);
		}
		
		try {
			List<CustomerCouponNewVO> list = customerCouponNewService.getCustomerCouponNewList(paramMap);
			Integer count = customerCouponNewService.getCustomerCouponNewCount(paramMap);
			result.put("total", count);
			result.put("rows", list);
			webOut(response, result);
		} catch (Exception e) {
			logger.error("获取优惠券列表错误,"+DataSourceAspect.getCurrentDataSource(), e);
			result.put("code", ConstantUtil.W_SYSTEM_ERROR);
			result.put("message", "获取优惠券列表错误");
			webOut(response, result);
		}
	}
	
	/**
	 * 添加优惠券
	 * @param request
	 * @param response
	 * @param customerCouponNew
	 */
	@RequestMapping("/addCustomerCouponNew")
	public void addCustomerCouponNew(HttpServletRequest request, HttpServletResponse response,CustomerCouponNew customerCouponNew){
		MessageResult result;
		if (StringUtils.isEmpty(customerCouponNew.getCouponName())||customerCouponNew.getCustomerId()==null
				||customerCouponNew.getIsEnable()==null ||customerCouponNew.getCouponConfigId()==null) {
			result = new MessageResult(ConstantUtil.W_PARAWTER_NULL,"参数缺失");
			webOut(response, result);
			return;
		}
		try {
			customerCouponNew.setSourceType((byte)CouponGiftModeEnum.系统录入.getValue());
			customerCouponNew.setSourceId(-1);
			List<CustomerCouponNew> listCouponNew =  new ArrayList<CustomerCouponNew>();
			listCouponNew.add(customerCouponNew);
			int i = customerCouponNewService.addCustomerCouponNewBatch(listCouponNew);
			
			if (i > 0) {
				
				BaseMessageTemplate msg = baseMessageTemplateRemoteService.selectTitleAndContentByIdentification(ConstantUtil.M_MANUAL_COUPONS);
				Customer customer = this.customerRemoteService.selectByPrimaryKey(customerCouponNew.getCustomerId());
				if(msg!=null&&customer!=null&&msg.getMessageType()!=null){
					String content = msg.getContent().replaceAll("【couponInfo】", "1张"+customerCouponNew.getCouponName());
					if(msg.getMessageType().indexOf(ConstantUtil.MESSAGETYPE_SMS)!=-1){
						PayConfig payConfig = payConfigService.seleConfigByHost(request.getServerName());
						PostMsgHttpContent.sendMessage(customer.getMobile(),content,payConfig.getSmstaskid());
					}
					if(msg.getMessageType().indexOf(ConstantUtil.MESSAGETYPE_SYS)!=-1){
						messageRemoteService.sendSysMessage(msg.getTitle(), content, customer.getId());
					}
				}
				
				SysLogUtil.addLog(request, "添加优惠券:"+customerCouponNew.getCouponName(), 1);
				result = new MessageResult(ConstantUtil.W_SUCCESS,"操作成功");
			}else{
				logger.error("创建优惠券失败,"+DataSourceAspect.getCurrentDataSource());
				SysLogUtil.addLog(request, "添加优惠券:"+customerCouponNew.getCouponName(), 0);
				result = new MessageResult(ConstantUtil.W_EXCEPTION,"操作失败");
			}
			webOut(response, result);
		} catch (Exception e) {
			logger.error("创建优惠券错误,"+DataSourceAspect.getCurrentDataSource(), e);
			SysLogUtil.addLog(request, "添加优惠券:"+customerCouponNew.getCouponName(), 0);
			result = new MessageResult(ConstantUtil.W_EXCEPTION,"操作失败");
			webOut(response, result);
		}
	}
	
	/**
	 * 编辑更新优惠券
	 * @param request
	 * @param response
	 * @param customerCouponNew
	 */
	@RequestMapping("/editCustomerCouponNew")
	public void editCustomerCouponNew(HttpServletRequest request, HttpServletResponse response,CustomerCouponNew customerCouponNew){
		MessageResult result;
		if (customerCouponNew.getId() == null||customerCouponNew.getIsEnable()==null
				||customerCouponNew.getExpireDate()==null) {
			result = new MessageResult(ConstantUtil.W_PARAWTER_NULL,"参数缺失");
			webOut(response, result);
			return;
		}
		try {
			int status = customerCouponNewService.updateCustomerCouponNew(customerCouponNew);
			if (status > -1) {
				SysLogUtil.addLog(request, "编辑更新优惠券", 1);
				result = new MessageResult(ConstantUtil.W_SUCCESS,"success");
				webOut(response, result);
			}else{
				SysLogUtil.addLog(request, "编辑更新优惠券", 0);
				result = new MessageResult(ConstantUtil.W_SYSTEM_ERROR,"更新优惠券失败");
				webOut(response, result);
			}
		} catch (Exception e) {
			SysLogUtil.addLog(request, "编辑更新优惠券", 0);
			logger.error("更新优惠券失败,"+DataSourceAspect.getCurrentDataSource(), e);
			result = new MessageResult(ConstantUtil.W_EXCEPTION,"操作失败");
			webOut(response, result);
		}
	}
	
	/**
	 * 删除优惠券
	 * @param request
	 * @param response
	 */
	@RequestMapping("/deleteCustomerCouponNew")
	public void deleteCustomerCouponNew(HttpServletRequest request, HttpServletResponse response){
		MessageResult result;
		String ids = request.getParameter("ids");
		if (StringUtils.isBlank(ids)) {
			result = new MessageResult(ConstantUtil.W_PARAWTER_NULL,"参数缺失");
			webOut(response, result);
			return;
		}
		try {
			String idsArr[] = ids.split(",");
			List<Integer> list = new ArrayList<>();
			for (int i = 0; i < idsArr.length; i++) {
				list.add(Integer.parseInt(idsArr[i]));
			}
			int status = customerCouponNewService.deleteCustomerCouponNew(list);
			if (status > -1) {
				SysLogUtil.addLog(request, "删除优惠券", 1);
				result = new MessageResult(ConstantUtil.W_SUCCESS,"success");
				webOut(response, result);
			}else{
				SysLogUtil.addLog(request, "删除优惠券", 0);
				result = new MessageResult(ConstantUtil.W_SYSTEM_ERROR,"删除优惠券失败");
				webOut(response, result);
			}
			
		} catch (Exception e) {
			SysLogUtil.addLog(request, "删除优惠券", 0);
			logger.error("删除优惠券失败,"+DataSourceAspect.getCurrentDataSource(), e);
			result = new MessageResult(ConstantUtil.W_EXCEPTION,"操作失败");
			webOut(response, result);
		}
	}
	
	/**
	 * 导出优惠券列表
	 * @param response
	 * @param request
	 */
	@RequestMapping("/exportCustomerCouponNew")
	public void exportCustomerCouponNew(HttpServletResponse response, HttpServletRequest request) {
		
		Map<String, Object> paramMap = new HashMap<>();
		String couponNo = request.getParameter("couponNo");
		String mobile = request.getParameter("mobile");
		String isUsed = request.getParameter("isUsed");
		String expireDate = request.getParameter("expireDate");
		String sourceType = request.getParameter("sourceType");
		String createDateStart = request.getParameter("createDateStart");
		String createDateEnd = request.getParameter("createDateEnd");
		
		if (StringUtils.isNotEmpty(couponNo)) {
			paramMap.put("couponNo", couponNo);
		}
		if (StringUtils.isNotEmpty(mobile)) {
			paramMap.put("mobile", mobile);
		}
		if (StringUtils.isNotEmpty(isUsed)) {
			paramMap.put("isUsed", isUsed);
		}
		if (StringUtils.isNotEmpty(expireDate)) {
			paramMap.put("expireDate", expireDate);
		}
		if (StringUtils.isNotEmpty(sourceType)) {
			paramMap.put("sourceType", sourceType);
		}if (StringUtils.isNotEmpty(createDateStart)) {
			paramMap.put("createDateStart", createDateStart);
		}
		if (StringUtils.isNotEmpty(createDateEnd)) {
			paramMap.put("createDateEnd", createDateEnd);
		}
		try {
			List<CustomerCouponNewVO> list = customerCouponNewService.getCustomerCouponNewList(paramMap);
			exportExcel("优惠券列表.xls", list, response, request);
		} catch (Exception e) {
			HashMap<String, Object> result = new HashMap<String, Object>();
			logger.error("导出优惠券列表错误,"+DataSourceAspect.getCurrentDataSource(), e);
			result.put("code", ConstantUtil.W_SYSTEM_ERROR);
			result.put("message", "导出优惠券列表错误");
			webOut(response, result);
		}
	}
	
	/**
	 * 导出数据为XLS格式
	 * 
	 * @param fileName
	 *            文件的名称，可以设为绝对路径，也可以设为相对路径
	 * @param content
	 *            数据的内容
	 */
	private void exportExcel(String fileName, List<CustomerCouponNewVO> list, HttpServletResponse response,
			HttpServletRequest request) {
		WritableWorkbook wwb;
		FileOutputStream fos;
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd 23:59:59");
		try {
			fos = new FileOutputStream(fileName);
			wwb = Workbook.createWorkbook(fos);

			WritableSheet ws = wwb.createSheet("优惠券兑换活动列表", 0); // 创建一个工作表

			// 设置单元格的文字格式
			WritableFont wf = new WritableFont(WritableFont.ARIAL, 12, WritableFont.NO_BOLD, false,
					UnderlineStyle.NO_UNDERLINE, Colour.BLACK);
			WritableCellFormat wcf = new WritableCellFormat(wf);
			wcf.setVerticalAlignment(VerticalAlignment.CENTRE);
			wcf.setAlignment(Alignment.CENTRE);
			ws.setRowView(1, 500);
			// 设置标题行
			ws.addCell(new Label(0, 0, "用户手机号", wcf));
			ws.addCell(new Label(1, 0, "使用状态", wcf));
			ws.addCell(new Label(2, 0, "使用时间", wcf));
			ws.addCell(new Label(3, 0, "订单编号", wcf));
			ws.addCell(new Label(4, 0, "优惠券编号", wcf));
			ws.addCell(new Label(5, 0, "优惠券类型", wcf));
			ws.addCell(new Label(6, 0, "优惠券名称", wcf));
			ws.addCell(new Label(7, 0, "金额", wcf));
			ws.addCell(new Label(8, 0, "折扣比例", wcf));
			ws.addCell(new Label(9, 0, "最高减免", wcf));
			ws.addCell(new Label(10, 0, "配置详情", wcf));
			ws.addCell(new Label(11, 0, "来源", wcf));
			ws.addCell(new Label(12, 0, "启用状态", wcf));
			ws.addCell(new Label(13, 0, "生成日期", wcf));
			ws.addCell(new Label(14, 0, "过期日期", wcf));
			int rowsCount = list.size();
			// 填充数据的内容
			CustomerCouponNewVO vo;
			for (int i = 0; i < rowsCount; i++) {
				vo = list.get(i);
				ws.addCell(new Label(0, i + 1, vo.getMobile()==null?"-":vo.getMobile(), wcf));
				ws.addCell(new Label(1, i + 1, CouponUsedEnum.valueOfCode(vo.getIsUsed()), wcf));
				ws.addCell(new Label(2, i + 1, vo.getUsedDate()==null ? "-":simpleDateFormat.format(vo.getUsedDate()), wcf));
				ws.addCell(new Label(3, i + 1, vo.getOrderNo()==null?"-":vo.getOrderNo(), wcf));
				ws.addCell(new Label(4, i + 1, vo.getCouponNo(), wcf));
				ws.addCell(new Label(5, i + 1, CouponTypeEnum.valueOfCode(vo.getCouponType()), wcf));
				
				ws.addCell(new Label(6, i + 1, vo.getCouponName(), wcf));
				ws.addCell(new Label(7, i + 1, vo.getCouponMoney()==null?"-":vo.getCouponMoney()+"", wcf));
				
				ws.addCell(new Label(8, i + 1, vo.getDiscountPercent()==null?"-":vo.getDiscountPercent()+"%", wcf));
				ws.addCell(new Label(9, i + 1, vo.getMaxDeductionMoney()==null?"-":vo.getMaxDeductionMoney()+"", wcf));
				ws.addCell(new Label(10, i + 1, vo.getConfigDetail(), wcf));
				
				ws.addCell(new Label(11, i + 1,CouponGiftModeEnum.valueOfCode(vo.getSourceType()), wcf));
				ws.addCell(new Label(12, i + 1,vo.getIsEnable()==1?"启用":"禁用" , wcf));
				ws.addCell(new Label(13, i + 1,simpleDateFormat.format(vo.getCreateDate()) , wcf));
				ws.addCell(new Label(14, i + 1,sdf.format(vo.getExpireDate()), wcf));
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
			fileName = "优惠券兑换活动列表" + nowTime + ".xls";
			final String userAgent = request.getHeader("USER-AGENT");
			String finalFileName = null;
			if (StringUtils.contains(userAgent, "MSIE") || -1 != userAgent.indexOf("Trident")) {// IE浏览器
				finalFileName = URLEncoder.encode(fileName, "UTF8");
			} else if (StringUtils.contains(userAgent, "Mozilla")) {// google,火狐浏览器
				finalFileName = new String(fileName.getBytes(), "ISO8859-1");
			} else {
				finalFileName = URLEncoder.encode(fileName, "UTF8");// 其他浏览器
			}
			response.setHeader("Cache-Control", "private");
			response.setHeader("Pragma", "private");
			response.setContentType("application/vnd.ms-excel;charset=utf-8");
			response.setHeader("Content-Disposition", "attachment; filename=\"" + finalFileName + "\"");// 这里设置一下让浏览器弹出下载提示框，而不是直接在浏览器中打开

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
		} catch (Exception e) {
			logger.error("导出优惠券列表出错"+e.getMessage()+","+DataSourceAspect.getCurrentDataSource(),e);
		}
	}

}
