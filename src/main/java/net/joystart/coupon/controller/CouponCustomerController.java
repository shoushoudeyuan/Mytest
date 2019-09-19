package net.joystart.coupon.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.time.DateFormatUtils;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;

import jxl.Workbook;
import jxl.format.Alignment;
import jxl.format.Colour;
import jxl.format.UnderlineStyle;
import jxl.format.VerticalAlignment;
import jxl.write.Label;
import jxl.write.WritableCellFeatures;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;
import jxl.write.biff.RowsExceededException;
import net.joystart.common.controller.BaseController;
import net.joystart.common.util.ConstantUtil;
import net.joystart.common.util.MessageResult;
import net.joystart.common.util.SysLogUtil;
import net.joystart.common.util.log.Log4jTask;
import net.joystart.coupon.entity.CustomerCoupon;
import net.joystart.coupon.service.ICustomerCouponService;
import net.joystart.invoice.entity.CustomerInvoice;
import net.joystart.system.entity.SysUser;

@Controller
@RequestMapping("/couponCustomer")
public class CouponCustomerController extends BaseController {

	@Resource
	ICustomerCouponService customerCouponService;

	@RequestMapping("/customerCouponList")
	public void getCustoerCouponList(HttpServletRequest request, HttpServletResponse response) {
		List<CustomerCoupon> list = null;
		Map<String, Object> params = new HashMap<String, Object>();
		HashMap<String, Object> dataMap = new HashMap<String, Object>();
		try {
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
			
			String fromenum = request.getParameter("fromenum");
			if (!StringUtils.isEmpty(fromenum)) {
				params.put("fromenum", Integer.valueOf(fromenum));
			}
			
			String strCouponNumber = request.getParameter("couponNumber");
			if (!StringUtils.isEmpty(strCouponNumber)) {
				params.put("couponCode", strCouponNumber);
			}

			String strCustomerTel = request.getParameter("customerTel");
			if (!StringUtils.isEmpty(strCustomerTel)) {
				params.put("mobile", strCustomerTel);
			}

			String strUseStatus = request.getParameter("useStatus");
			if (!StringUtils.isEmpty(strUseStatus)) {
				params.put("useStatus", strUseStatus);
			}

			String strThirdParty = request.getParameter("thirdParty");
			if (!StringUtils.isEmpty(strThirdParty)) {
				params.put("isThirdParty", strThirdParty);
			}

			String strThirdPartyName = request.getParameter("thirdPartyName");
			if (!StringUtils.isEmpty(strThirdPartyName)) {
				params.put("thirdPartyName", "%" + strThirdPartyName + "%");
			}
			
			String startTime = request.getParameter("startTime");
			if (!StringUtils.isEmpty(startTime)){
				params.put("startTime", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(startTime));
			}
			String endTime = request.getParameter("endTime");
			if (!StringUtils.isEmpty(endTime)){
				params.put("endTime", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(endTime));
			}

			Integer count = this.customerCouponService.getCount(params);
			// 查询列表
			list = this.customerCouponService.getCustomerCouponList(params);
			dataMap.put("list", list);
			HashMap<String, Object> messageMap = new HashMap<String, Object>();
			messageMap.put("total", count);
			messageMap.put("rows", list);

			this.webOut(response, messageMap);
		} catch (Exception e) {
			Log4jTask.addLog("获取优惠券信息列表报错", System.currentTimeMillis(), Log4jTask.ERROR, CouponCustomerController.class.getName(), e);
			MessageResult result = new MessageResult(ConstantUtil.M_SYSTEM_ERROR, "系统发生未知错误");
			this.webOut(response, result);
		}
		
		return;
	}

	@RequestMapping("/deleteCoupon")
	public void deleteCustomerCoupon(String ids, HttpServletRequest request, HttpServletResponse response) {
		if (StringUtils.isEmpty(ids)) {
			this.out(response, 0);
			return;
		}
		SysUser sysUser = (SysUser) request.getSession().getAttribute("user");
		String[] split = ids.split(",");
		for (int i = 0; i < split.length; i++) {
			if (!StringUtils.isEmpty(split[i])) {
				this.customerCouponService.deleteCustomerCoupon(Integer.valueOf(split[i]),sysUser.getId());
			}			
		}
		SysLogUtil.addLog(request, "删除优惠券", 1);
		this.out(response, 1);
		return;
	}

	@RequestMapping("/updateCoupon")
	public void updateOrInsertCoupon(CustomerCoupon coupon, HttpServletRequest request, HttpServletResponse response) {
	    SysUser sysUser = (SysUser) request.getSession().getAttribute("user");
	    coupon.setModifyUser(sysUser.getId());
	    if (null == coupon.getId()) {
	        coupon.setCreateUser(sysUser.getId());
			int Result = this.customerCouponService.insertCustomerCoupon(coupon);
			SysLogUtil.addLog(request, "新增优惠券", Result);
			this.out(response, Result > 0 ? 1 : 0);
			return;
		}
		int Result = this.customerCouponService.updateCustomerCoupon(coupon);
		SysLogUtil.addLog(request, "更新优惠券信息", Result);
		this.out(response, Result > 0 ? 1 : 0);
		return;
	}

	@RequestMapping("/selectCoupon")
	public void selectRuleDetailByID(HttpServletRequest request, HttpServletResponse response) {
		String couponId = request.getParameter("couponId");
		CustomerCoupon couponDetail = this.customerCouponService.selectCustomerCoupon(Integer.valueOf(couponId));
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");// 设置显示格式
		couponDetail.setStartdateNew(df.format(couponDetail.getStartdate()));
		couponDetail.setEnddateNew(df.format(couponDetail.getEnddate()));
		HashMap<String, Object> resuleMap = new HashMap<>();
		resuleMap.put("success", true);
		resuleMap.put("couponDetail", couponDetail);
		this.webOut(response, resuleMap);
		return;

	}

	@RequestMapping("/updateLotCoupon")
	public void InsertLotCoupon(CustomerCoupon coupon, HttpServletRequest request, HttpServletResponse response) {
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");// 设置显示格式
		try {
			SysUser sysUser = (SysUser) request.getSession().getAttribute("user");
			coupon.setModifyUser(sysUser.getId());
			coupon.setCreateUser(sysUser.getId());
			coupon.setEnddate(df.parse(coupon.getEnddateNew()));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		int Result = this.customerCouponService.insertLotCoupon(coupon);
		SysLogUtil.addLog(request, "批量新增优惠券", Result);
		this.out(response, Result > 0 ? 1 : 0);
		return;
	}

	@RequestMapping("/InvoiceList")
	public void getCustomerInvoiceList(HttpServletRequest request, HttpServletResponse response) {
		List<CustomerInvoice> list = null;
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

		String strType = request.getParameter("invoiceType");
		if (!StringUtils.isEmpty(strType)) {
			params.put("inviocetype", strType);
		}

		String strCustomerTel = request.getParameter("customerTel");
		if (!StringUtils.isEmpty(strCustomerTel)) {
			params.put("customerTel", strCustomerTel);
		}

		String strInvoiceName = request.getParameter("invoiceName");
		if (!StringUtils.isEmpty(strInvoiceName)) {
			params.put("invoiceName", "%" + strInvoiceName + "%");
		}

		String strContract = request.getParameter("contract");
		if (!StringUtils.isEmpty(strContract)) {
			params.put("contract", "%" + strContract + "%");
		}

		String strContractTel = request.getParameter("contractTel");
		if (!StringUtils.isEmpty(strContractTel)) {
			params.put("contractTel", strContractTel);
		}

		Integer count = this.customerCouponService.getInvoiceCount(params);
		// 查询列表
		list = this.customerCouponService.getInvoiceList(params);
		dataMap.put("list", list);
		HashMap<String, Object> messageMap = new HashMap<String, Object>();
		messageMap.put("total", count);
		messageMap.put("rows", list);

		this.webOut(response, messageMap);
		return;
	}

	@RequestMapping("/invoiceOpen")
	public void updateInvoiceStatus(String invoiceId, HttpServletRequest request, HttpServletResponse response) {
		if (StringUtils.isEmpty(invoiceId)) {
			this.out(response, 0);
			return;
		}

	    int result = this.customerCouponService.updateInvoiceStatus(Integer.valueOf(invoiceId));
	    SysLogUtil.addLog(request, "更新发票状态", result);
		this.out(response, result);
		return;
	}
	
	@InitBinder
	@Override
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		dateFormat.setLenient(false);
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}
	
	@RequestMapping("/exportList")
	public void exportList(HttpServletResponse response, HttpServletRequest request){
		Map<String, Object> params = new HashMap<String, Object>();
		try {
			String strType = request.getParameter("invoiceType");
			if (!StringUtils.isEmpty(strType)) {
				params.put("inviocetype", strType);
			}

			String strCustomerTel = request.getParameter("customerTel");
			if (!StringUtils.isEmpty(strCustomerTel)) {
				params.put("customerTel", strCustomerTel);
			}

			String strInvoiceName = request.getParameter("invoiceName");
			if (!StringUtils.isEmpty(strInvoiceName)) {
				params.put("invoiceName", "%" + strInvoiceName + "%");
			}

			String strContract = request.getParameter("contract");
			if (!StringUtils.isEmpty(strContract)) {
				params.put("contract", "%" + strContract + "%");
			}

			String strContractTel = request.getParameter("contractTel");
			if (!StringUtils.isEmpty(strContractTel)) {
				params.put("contractTel", strContractTel);
			}
			// 查询列表
			List<CustomerInvoice> list = this.customerCouponService.getInvoiceList(params);
			exportList("押金退费.xls", list, response, request);
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			
	  }
	
	/** */
	/**
	 * 导出数据为XLS格式
	 * 
	 * @param fileName
	 *            文件的名称，可以设为绝对路径，也可以设为相对路径
	 * @param content
	 *            数据的内容
	 */
	private void exportList(String fileName, List<CustomerInvoice> list, HttpServletResponse response,HttpServletRequest request) {
		WritableWorkbook wwb;
		FileOutputStream fos;
		try {
			fos = new FileOutputStream(fileName);
			wwb = Workbook.createWorkbook(fos);

			WritableSheet ws = wwb.createSheet("发票申请列表", 0); // 创建一个工作表

			// 设置单元格的文字格式
			WritableFont wf = new WritableFont(WritableFont.ARIAL, 12, WritableFont.NO_BOLD, false,
					UnderlineStyle.NO_UNDERLINE, Colour.BLACK);
			WritableCellFormat wcf = new WritableCellFormat(wf);
			wcf.setVerticalAlignment(VerticalAlignment.CENTRE);
			wcf.setAlignment(Alignment.CENTRE);
			ws.setRowView(1, 500);
			jxl.write.NumberFormat nf = new jxl.write.NumberFormat("#,##0.00"); // 设置数字格式
			jxl.write.WritableCellFormat wcfN = new jxl.write.WritableCellFormat(nf); // 设置格式
			// 设置标题行
			ws.addCell(new Label(0, 0, "类别", wcf));
			ws.addCell(new Label(1, 0, "姓名", wcf));
			ws.addCell(new Label(2, 0, "手机号", wcf));
			ws.addCell(new Label(3, 0, "纳税人识别号", wcf));
			ws.addCell(new Label(4, 0, "开票金额", wcf));
			ws.addCell(new Label(5, 0, "开票名称", wcf));
			ws.addCell(new Label(6, 0, "快递地址", wcf));
			ws.addCell(new Label(7, 0, "邮编", wcf));
			ws.addCell(new Label(8, 0, "联系人", wcf));
			ws.addCell(new Label(9, 0, "联系电话", wcf));
			ws.addCell(new Label(10, 0, "申请时间", wcf));
			ws.addCell(new Label(11, 0, "状态", wcf));
			int rowsCount = list.size();
			;
			// 填充数据的内容
			CustomerInvoice invoice;
			for (int i = 0; i < rowsCount; i++) {
				invoice = list.get(i);
				WritableCellFeatures x;
				if(invoice.getInviocetype()==1){
					ws.addCell(new Label(0, i + 1, "公司", wcf));
				}else{
					ws.addCell(new Label(0, i + 1, "个人", wcf));
				}
				ws.addCell(new Label(1, i + 1, invoice.getName(), wcf));
				ws.addCell(new Label(2, i + 1, invoice.getMobilenew(), wcf));
				ws.addCell(new Label(3, i + 1, invoice.getItin(), wcf));
				double orderCost = invoice.getMoney() == null ? 0.00 : invoice.getMoney().doubleValue();
				jxl.write.Number labelOrderCost = new jxl.write.Number(4, i + 1, orderCost, wcfN); // 格式化数值
				ws.addCell(labelOrderCost);
				ws.addCell(new Label(5, i + 1, invoice.getInname(),wcf));
				ws.addCell(new Label(6, i + 1, invoice.getAddress(), wcf));
				ws.addCell(new Label(7, i + 1, invoice.getPostalCode(), wcf));
				ws.addCell(new Label(8, i + 1, invoice.getContacts(), wcf));
				ws.addCell(new Label(9, i + 1, invoice.getMobile(), wcf));
				ws.addCell(new Label(10, i + 1, invoice.getApplayDate() == null ? ""
						: DateFormatUtils.format(invoice.getApplayDate(), "yyyy-MM-dd HH:mm:ss"), wcf));
				
				if(invoice.getIsopen()==0){
					ws.addCell(new Label(11, i + 1, "申请中", wcf));
				}else{ 
					ws.addCell(new Label(11, i + 1, "已开具", wcf));
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
			fileName = "发票申请列表" + nowTime + ".xls";
			final String userAgent = request.getHeader("USER-AGENT");
			String finalFileName = null;
			if (org.apache.commons.lang3.StringUtils.contains(userAgent, "MSIE") || -1 != userAgent.indexOf("Trident")) {// IE浏览器
				finalFileName = URLEncoder.encode(fileName, "UTF8");
			} else if (org.apache.commons.lang3.StringUtils.contains(userAgent, "Mozilla")) {// google,火狐浏览器
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
		} catch (IOException e) {
		} catch (RowsExceededException e) {
		} catch (WriteException e) {
		}
	}
	
	
	
	@RequestMapping("/exportCouponList")
	public void exportCouponList(HttpServletResponse response, HttpServletRequest request){
		Map<String, Object> params = new HashMap<String, Object>();
		try {
			String strCouponNumber = request.getParameter("couponNumber");
			if (!StringUtils.isEmpty(strCouponNumber)) {
				params.put("couponCode", strCouponNumber);
			}

			String strCustomerTel = request.getParameter("customerTel");
			if (!StringUtils.isEmpty(strCustomerTel)) {
				params.put("mobile", strCustomerTel);
			}

			String strUseStatus = request.getParameter("useStatus");
			if (!StringUtils.isEmpty(strUseStatus)) {
				params.put("useStatus", strUseStatus);
			}

			String strThirdParty = request.getParameter("thirdParty");
			if (!StringUtils.isEmpty(strThirdParty)) {
				params.put("isThirdParty", strThirdParty);
			}

			String strThirdPartyName = request.getParameter("thirdPartyName");
			if (!StringUtils.isEmpty(strThirdPartyName)) {
				params.put("thirdPartyName", "%" + strThirdPartyName + "%");
			}
			
			String startTime = request.getParameter("startTime");
			if (!StringUtils.isEmpty(startTime)){
				params.put("startTime", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(startTime));
			}
			String endTime = request.getParameter("endTime");
			if (!StringUtils.isEmpty(endTime)){
				params.put("endTime", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(endTime));
			}
			
			String fromenum = request.getParameter("fromenum");
			if (!StringUtils.isEmpty(fromenum)) {
				params.put("fromenum", Integer.valueOf(fromenum));
			}
			
			// 查询列表
			List<CustomerCoupon> list = this.customerCouponService.getCustomerCouponList(params);
			exportCouponList("优惠券列表.xls", list, response, request);
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			
	  }
	
	/** */
	/**
	 * 导出数据为XLS格式
	 * 
	 * @param fileName
	 *            文件的名称，可以设为绝对路径，也可以设为相对路径
	 * @param content
	 *            数据的内容
	 */
	private void exportCouponList(String fileName, List<CustomerCoupon> list, HttpServletResponse response,HttpServletRequest request) {
		WritableWorkbook wwb;
		FileOutputStream fos;
		try {
			fos = new FileOutputStream(fileName);
			wwb = Workbook.createWorkbook(fos);

			WritableSheet ws = wwb.createSheet("优惠券列表", 0); // 创建一个工作表

			// 设置单元格的文字格式
			WritableFont wf = new WritableFont(WritableFont.ARIAL, 12, WritableFont.NO_BOLD, false,
					UnderlineStyle.NO_UNDERLINE, Colour.BLACK);
			WritableCellFormat wcf = new WritableCellFormat(wf);
			wcf.setVerticalAlignment(VerticalAlignment.CENTRE);
			wcf.setAlignment(Alignment.CENTRE);
			ws.setRowView(1, 500);
			jxl.write.NumberFormat nf = new jxl.write.NumberFormat("#,##0.00"); // 设置数字格式
			jxl.write.WritableCellFormat wcfN = new jxl.write.WritableCellFormat(nf); // 设置格式
			// 设置标题行
			ws.addCell(new Label(0, 0, "优惠券编号", wcf));
			ws.addCell(new Label(1, 0, "订单编号", wcf));
			ws.addCell(new Label(2, 0, "备注", wcf));
			ws.addCell(new Label(3, 0, "第三方名称", wcf));
			ws.addCell(new Label(4, 0, "优惠券类型", wcf));
			ws.addCell(new Label(5, 0, "优惠券金额", wcf));
			ws.addCell(new Label(6, 0, "折扣比例", wcf));
			ws.addCell(new Label(7, 0, "最高减免", wcf));
			ws.addCell(new Label(8, 0, "是否启用", wcf));
			ws.addCell(new Label(9, 0, "是否使用", wcf));
			ws.addCell(new Label(10, 0, "来源", wcf));
			ws.addCell(new Label(11, 0, "手机号", wcf));
			ws.addCell(new Label(12, 0, "生成日期", wcf));
			ws.addCell(new Label(13, 0, "生效日期", wcf));
			ws.addCell(new Label(14, 0, "失效日期", wcf));
			ws.addCell(new Label(15, 0, "使用时间", wcf));
			int rowsCount = list.size();
			// 填充数据的内容
			CustomerCoupon coupon;
			for (int i = 0; i < rowsCount; i++) {
				coupon = list.get(i);
				WritableCellFeatures x;
				ws.addCell(new Label(0, i + 1, coupon.getCouponcode(), wcf));
				ws.addCell(new Label(1, i + 1, coupon.getOrderno(), wcf));
				ws.addCell(new Label(2, i + 1, coupon.getRemark(), wcf));
				ws.addCell(new Label(3, i + 1, coupon.getThirdpartyname(), wcf));
				if(coupon.getType()==1){
					ws.addCell(new Label(4, i + 1, "折扣券", wcf));
				}else if(coupon.getType()==0){
					ws.addCell(new Label(4, i + 1, "减免券", wcf));
				}else{
					ws.addCell(new Label(4, i + 1, "", wcf));
				}
				double couponMoney = coupon.getCouponmoney() == null ? 0.00 : coupon.getCouponmoney().doubleValue();
				jxl.write.Number labelOrderCost = new jxl.write.Number(5, i + 1, couponMoney, wcfN); // 格式化数值
				ws.addCell(labelOrderCost);
				ws.addCell(new Label(6, i + 1, coupon.getDiscount()!=null?coupon.getDiscount()+"%":"", wcf));
				double topcouponMoney = coupon.getTopDiscountMoney() == null ? 0.00 : coupon.getTopDiscountMoney().doubleValue();
				jxl.write.Number toplabelOrderCost = new jxl.write.Number(7, i + 1, topcouponMoney, wcfN); // 格式化数值
				ws.addCell(toplabelOrderCost);
				if(coupon.getIsdisable()==1){
					ws.addCell(new Label(8, i + 1, "启用", wcf));
				}else{
					ws.addCell(new Label(8, i + 1, "禁用", wcf));
				}
				if(coupon.getUsestatus()==1){
					ws.addCell(new Label(9, i + 1, "已用", wcf));
				}else{
					ws.addCell(new Label(9, i + 1, "未用", wcf));
				}
				
				if(coupon.getFromenum()==0){
					ws.addCell(new Label(10, i + 1, "注册", wcf));
				}else if(coupon.getFromenum()==1){
					ws.addCell(new Label(10, i + 1, "邀请码赠送", wcf));
				}else if(coupon.getFromenum()==2){
					ws.addCell(new Label(10, i + 1, "积分兑换", wcf));
				}else if(coupon.getFromenum()==3){
					ws.addCell(new Label(10, i + 1, "活动红包兑换", wcf));
				}else if(coupon.getFromenum()==4){
					ws.addCell(new Label(10, i + 1, "共享计划赠送", wcf));
				}else if(coupon.getFromenum()==5){
					ws.addCell(new Label(10, i + 1, "满额送", wcf));
				}else if(coupon.getFromenum()==6){
					ws.addCell(new Label(10, i + 1, "节假日送", wcf));
				}else if(coupon.getFromenum()==7){
					ws.addCell(new Label(10, i + 1, "首次结单送", wcf));
				}else if(coupon.getFromenum()==8){
					ws.addCell(new Label(10, i + 1, "首次推荐送", wcf));
				}else{
					ws.addCell(new Label(10, i + 1, "系统录入", wcf));
				}
				
				ws.addCell(new Label(11, i + 1, coupon.getMobile(), wcf));
				ws.addCell(new Label(12, i + 1, coupon.getCreatedate() == null ? ""
						: DateFormatUtils.format(coupon.getCreatedate(), "yyyy-MM-dd HH:mm:ss"), wcf));
				ws.addCell(new Label(13, i + 1, coupon.getStartdate() == null ? ""
						: DateFormatUtils.format(coupon.getStartdate(), "yyyy-MM-dd HH:mm:ss"), wcf));
				ws.addCell(new Label(14, i + 1, coupon.getEnddate() == null ? ""
						: DateFormatUtils.format(coupon.getEnddate(), "yyyy-MM-dd HH:mm:ss"), wcf));
				ws.addCell(new Label(15, i + 1, coupon.getUsingdate() == null ? ""
						: DateFormatUtils.format(coupon.getUsingdate(), "yyyy-MM-dd HH:mm:ss"), wcf));
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
			fileName = "优惠券列表" + nowTime + ".xls";
			final String userAgent = request.getHeader("USER-AGENT");
			String finalFileName = null;
			if (org.apache.commons.lang3.StringUtils.contains(userAgent, "MSIE") || -1 != userAgent.indexOf("Trident")) {// IE浏览器
				finalFileName = URLEncoder.encode(fileName, "UTF8");
			} else if (org.apache.commons.lang3.StringUtils.contains(userAgent, "Mozilla")) {// google,火狐浏览器
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
		} catch (IOException e) {
		} catch (RowsExceededException e) {
		} catch (WriteException e) {
		}
	}

}
