package net.joystart.couponmanage.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.Transformer;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import net.joystart.common.controller.BaseController;
import net.joystart.common.util.ConstantUtil;
import net.joystart.common.util.MessageResult;
import net.joystart.common.util.SysLogUtil;
import net.joystart.common.util.log.Log4jTask;
import net.joystart.couponmanage.entity.CouponBatchOplog;
import net.joystart.couponmanage.entity.CouponBatchRecord;
import net.joystart.couponmanage.entity.CouponPackage;
import net.joystart.couponmanage.service.ICouponBatchRecordService;
import net.joystart.couponmanage.service.ICouponPackageService;
import net.joystart.couponmanage.service.impl.GiftCouponContext;
import net.joystart.system.entity.SysUser;

/**
 * 批量发券
 * @author zhuwq
 */
@Controller
@RequestMapping("/couponBatchRecord")
public class CouponBatchRecordController extends BaseController{

	@Resource
	ICouponBatchRecordService couponBatchRecordService;
	
	@Resource
	GiftCouponContext giftCouponFactory;
	
	@Resource
	ICouponPackageService svcPackage;
	
	final Logger logger = LoggerFactory.getLogger(CouponBatchRecordController.class);
    /**
     * 会员列表 lidahai
     * @param response
     * @param request
     * @param rows 每页显示条数
     * @param page 当前页码
     */
    @RequestMapping("/batchRecordList")
    public void batchRecordList(HttpServletResponse response,HttpServletRequest request){
        Map<String, Object> params = new HashMap<String, Object>();
//        params.put("rowStart", PageUtil.rowStart(page - 1, rows));
//        params.put("pageSize", rows);
        String username = request.getParameter("username");
        String name = request.getParameter("name");
        String mobile = request.getParameter("mobile");
        String identityApprove = request.getParameter("identityApprove");
        String createStartTime = request.getParameter("createStartTime");
        String createEndTime = request.getParameter("createEndTime");
        String memberType = request.getParameter("memberType");
        String isCanOrder = request.getParameter("isCanOrder");
        String isDisable = request.getParameter("isDisable");
        String gender = request.getParameter("gender");
        String packageId = request.getParameter("packageId");
        if(!StringUtils.isBlank(memberType)){
        	params.put("memberType", memberType);
        }
        if(!StringUtils.isBlank(isDisable)){
        	params.put("isDisable", isDisable);
        }
        if(!StringUtils.isBlank(gender)){
        	params.put("gender", gender);
        }
        if(!StringUtils.isBlank(packageId)){
        	params.put("packageId", packageId);
        }
        if (!StringUtils.isBlank(username)){
            params.put("username", "%" + username + "%");
        }
        if (!StringUtils.isBlank(name)){
            params.put("name", "%" + name + "%");
        }
        if (!StringUtils.isBlank(mobile)){
            params.put("mobile", "%" + mobile + "%");
        }
        if (!StringUtils.isBlank(identityApprove)){
            params.put("identityApprove", identityApprove);
        }
        if (!StringUtils.isBlank(createStartTime)){
            params.put("createStartTime", createStartTime);
        }
        if (!StringUtils.isBlank(createEndTime)){
            params.put("createEndTime", createEndTime);
        }
        if (!StringUtils.isBlank(isCanOrder)) {
        	params.put("isCanOrder", isCanOrder);
        }
        List<CouponBatchRecord> customerList = couponBatchRecordService.selectCouponBatchRecordData(params);
        int rowCount = couponBatchRecordService.selectCouponBatchRecordDataCount(params);
        HashMap<String, Object> messageMap = new HashMap<String, Object>();
		messageMap.put("total", rowCount);
		messageMap.put("rows", customerList);
		this.webOut(response, messageMap);
		return;
    }
    
    @RequestMapping("/importExcel")
	public void importExcel(HttpServletResponse response, HttpServletRequest request) {
		MessageResult message = new MessageResult();
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        MultipartFile multipartFile = multipartRequest.getFile("excelFile");
		List<String> list = new ArrayList<String>();
		Workbook rwb = null;
		Cell cell = null;
		try {
			rwb = Workbook.getWorkbook(multipartFile.getInputStream());
			// 获取文件的指定工作表 默认的第一个
			Sheet sheet = rwb.getSheet(0);
			// 行数(表头的目录不需要，从1开始)
			for (int i = 1; i < sheet.getRows(); i++) {
				// 获取第i行，第j列的值
				cell = sheet.getCell(0, i);//取第一列
				if(StringUtils.isBlank(cell.getContents())){
					logger.error("批量发券导入手机号报错第"+(i+1)+"行 数据为空");
				}else{
//					String regExp = null;
//					regExp = ConstantUtil.REG_PHNOE_EXP;
//		            Pattern p = Pattern.compile(regExp);
//		            Matcher mm = p.matcher(cell.getContents().trim());
//		            if (!mm.find()){
//		            	throw new Exception("Excel 第"+(i+1)+"行 第"+(j+1)+"列手机号不合法");
//		            }
					list.add(cell.getContents());
				}
				// 把刚获取的列存入list
			}
			List<CouponBatchRecord> customerList = couponBatchRecordService.selectByImportData(list);
	        int rowCount = couponBatchRecordService.selectByImportDataCount(list);
	        message.setCode(ConstantUtil.M_SUCCESS);
	        message.setMessage("导入成功，共导入"+list.size()+"条记录，用户匹配成功"+rowCount+"条");
			HashMap<String, Object> messageMap = new HashMap<String, Object>();
			messageMap.put("total", rowCount);
			messageMap.put("rows", customerList);
			message.setData(messageMap);
			webOut(response, message);
		} catch (Exception e) {
			e.printStackTrace();
			message.setCode(ConstantUtil.M_SYSTEM_ERROR);
			message.setMessage("系统异常");
			this.out(response, message);
		}
    }
    
    /**
     * 批量发券
     * @param request
     * @param response
     */
    @RequestMapping("/batchSendCoupon")
    public void batchSendCoupon(HttpServletRequest request, HttpServletResponse response) {
    	MessageResult message = new MessageResult();
        String ids = request.getParameter("ids");
        String packageId = request.getParameter("packageId");
        if (StringUtils.isBlank(ids)||StringUtils.isBlank(packageId)){
        	message.setCode(ConstantUtil.W_EXCEPTION);
        	message.setMessage("请加入用户并配置好优惠券再点击发送");
            this.out(response, message);
            return;
        }
        try {
            String[] idsArr = ids.split(",");
            List<String> idStrList = Arrays.asList(idsArr);
            List<Integer> customerIdList = CollStringToIntegerLst(idStrList);
            CouponBatchOplog opLog = new CouponBatchOplog();
            SysUser user = (SysUser)request.getSession().getAttribute("user");
//            opLog.setCouponnum(couponnum);
            opLog.setCreatedate(new Date());
            opLog.setOperateuser(user.getId());
            opLog.setPackageid(Integer.valueOf(packageId));
            couponBatchRecordService.saveCouponBatchOplog(opLog);
            message = giftCouponFactory.batchSendGoupon(customerIdList,Integer.valueOf(packageId),opLog.getId());
            if(message.getCode().equals(ConstantUtil.W_SUCCESS)){
            	message.setCode(ConstantUtil.W_SUCCESS);
            	message.setMessage("发送完成");
            	 Map<String, Object> params = new HashMap<String, Object>();
            	 params.put("packageId", packageId);
            	List<CouponBatchRecord> customerList = couponBatchRecordService.selectCouponBatchRecordData(params);
                int rowCount = couponBatchRecordService.selectCouponBatchRecordDataCount(params);
                HashMap<String, Object> messageMap = new HashMap<String, Object>();
    			messageMap.put("total", rowCount);
    			messageMap.put("rows", customerList);
    			message.setData(messageMap);
    			SysLogUtil.addLog(request, "批量发券", 1);
            }else{
            	message.setCode(ConstantUtil.W_EXCEPTION);
            	message.setMessage("发送失败");
            	SysLogUtil.addLog(request, "批量发券", 0);
            }
            webOut(response, message);
        } catch (Exception e) {
        	message.setCode(ConstantUtil.M_SYSTEM_ERROR);
        	message.setMessage("发送失败");
            this.out(response, message);
            SysLogUtil.addLog(request, "批量发券", 0);
            Log4jTask.addLog("批量发送优惠券异常", System.currentTimeMillis(), Log4jTask.ERROR, this.getClass().getName(),e);
        }
    }
    /**
     * 获取packageId
     * @param request
     * @param response
     */
    @RequestMapping("/getPackageId")
    public void getPackageId(HttpServletRequest request, HttpServletResponse response) {
    	MessageResult message = new MessageResult();
        try {
        	CouponPackage p = new CouponPackage();
			p.setPkgname("批量发券");
			svcPackage.createPackage(p);
            if(p.getId()!=null){
            	message.setCode(ConstantUtil.W_SUCCESS);
            	message.setMessage("获取成功");
    			message.setData(p.getId());
            }else{
            	message.setCode(ConstantUtil.W_EXCEPTION);
            	message.setMessage("获取失败");
            }
            this.out(response, message);
        } catch (Exception e) {
        	message.setCode(ConstantUtil.M_SYSTEM_ERROR);
        	message.setMessage("获取失败");
            this.out(response, message);
            Log4jTask.addLog("获取批量发券券包id异常", System.currentTimeMillis(), Log4jTask.ERROR, this.getClass().getName(),e);
        }
    }
    
    /**
     * 获取优惠券配置条数
     * @param request
     * @param response
     */
    @RequestMapping("/selectCouponPackageItemCount")
    public void selectCouponPackageItemCount(HttpServletRequest request, HttpServletResponse response) {
    	String packageId = request.getParameter("packageId");
    	if (StringUtils.isBlank(packageId)){
            this.out(response, 0);
            return;
        }
        try {
			int count = svcPackage.selectCouponPackageItemCount(Integer.valueOf(packageId));
            if(count>0){
    			this.out(response, 1);
            }else{
            	this.out(response, 0);
            }
        } catch (Exception e) {
            this.out(response, -1);
            Log4jTask.addLog("获取批量发券配置条数异常", System.currentTimeMillis(), Log4jTask.ERROR, this.getClass().getName(),e);
        }
    }
    private List<Integer> CollStringToIntegerLst(List<String> inList){
        List<Integer> iList =new ArrayList<Integer>(inList.size());
        CollectionUtils.collect(inList, 
                  new Transformer(){
                    public java.lang.Object transform(java.lang.Object input){
                      return new Integer((String)input);
                    }
                  } ,iList );
        return iList;
    }
    
    @RequestMapping("/downExcel")
	public void download(HttpServletRequest request, HttpServletResponse response) throws Exception {   
        response.setContentType("text/html;charset=utf-8");   
        request.setCharacterEncoding("UTF-8");   
        java.io.BufferedInputStream bis = null;   
        java.io.BufferedOutputStream bos = null;   
        String fileName = "demo.xls";
        String ctxPath = request.getSession().getServletContext().getRealPath("/")+File.separator+"jsp"+ File.separator+"couponmanage"+ File.separator;
        String downLoadPath = ctxPath +fileName;   
        logger.info(downLoadPath);   
        try {   
            long fileLength = new File(downLoadPath).length();   
            response.setContentType("application/x-msdownload;");   
            response.setHeader("Content-disposition", "attachment; filename="  
                    + new String(fileName.getBytes("utf-8"), "ISO8859-1"));   
            response.setHeader("Content-Length", String.valueOf(fileLength));   
            bis = new BufferedInputStream(new FileInputStream(downLoadPath));   
            bos = new BufferedOutputStream(response.getOutputStream());   
            byte[] buff = new byte[2048];   
            int bytesRead;   
            while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {   
                bos.write(buff, 0, bytesRead);   
            }   
        } catch (Exception e) {   
            e.printStackTrace();   
        } finally {   
            if (bis != null)   
                bis.close();   
            if (bos != null)   
                bos.close();   
        }   
    } 
}
