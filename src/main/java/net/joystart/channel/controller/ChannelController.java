package net.joystart.channel.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.text.MessageFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.concurrent.TimeUnit;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSONObject;

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
import net.joystart.channel.entity.Channel;
import net.joystart.channel.entity.ChannelUser;
import net.joystart.channel.service.IChannelService;
import net.joystart.common.controller.BaseController;
import net.joystart.common.entity.PayConfig;
import net.joystart.common.entity.RedisKey;
import net.joystart.common.service.IPayConfigService;
import net.joystart.common.util.ConstantUtil;
import net.joystart.common.util.MessageResult;
import net.joystart.common.util.PostMsgHttpContent;
import net.joystart.common.util.log.Log4jTask;
import net.joystart.common.util.security.EncryptionUtil;
import net.joystart.couponmanage.entity.CouponPackage;
import net.joystart.couponmanage.service.ICouponPackageService;
import net.joystart.customer.entity.Customer;
import net.joystart.customer.entity.Message;
import net.joystart.customer.remote.service.ICustomerRemoteService;
import net.joystart.setting.entity.BaseMessageTemplate;
import net.joystart.setting.remote.service.IBaseMessageTemplateRemoteService;

/**
 * 渠道管理
 * @author lsy
 */
@Controller
@RequestMapping("/channel")
public class ChannelController extends BaseController {

	@Autowired
	private IChannelService channelService;
	@Autowired
	private IPayConfigService payConfigService;
	@Autowired
	private	RedisTemplate<String, String> redisTemplate;
	@Autowired
	IBaseMessageTemplateRemoteService baseMessageTemplateRemoteService;
	@Autowired
	private ICustomerRemoteService customerRemoteService;
	
	@Autowired
	private ICouponPackageService svcPackage;

	@Override
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		dateFormat.setLenient(false);
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}

	@RequestMapping("/channelList")
	public void channelList(HttpServletRequest request, HttpServletResponse response) {
		try {

			Map<String, Object> params = new HashMap<String, Object>(6);

			String p_pageSize = request.getParameter("rows");
			String p_pageNumber = request.getParameter("page");
			String channelName = request.getParameter("channelName");
			String channelCode = request.getParameter("channelCode");
			String status = request.getParameter("status");

			if (!StringUtils.isEmpty(p_pageSize))
				params.put("pageSize", Integer.valueOf(p_pageSize));
			else
				params.put("pageSize", 10);

			if (!StringUtils.isEmpty(p_pageNumber))
				params.put("startIndex", (Integer.valueOf(p_pageNumber) - 1) * Integer.valueOf(p_pageSize));
			else
				params.put("startIndex", 0);

			if (!StringUtils.isBlank(channelName))
				params.put("channelName", channelName);

			if (!StringUtils.isBlank(channelCode))
				params.put("channelCode", channelCode);

			if (!StringUtils.isBlank(status))
				params.put("status", Integer.valueOf(status));

			HashMap<String, Object> dataMap = new HashMap<String, Object>(2);

			List<Channel> channelList = channelService.getChannelList(params);
			int count = channelService.getChannelListCount(params);

			dataMap.put("total", count);
			dataMap.put("rows", channelList);

			webOut(response, dataMap);
			return;
		} catch (Exception e) {
			Log4jTask.addLog("获取渠道管理列表错误[channel/channelList]", System.currentTimeMillis(), Log4jTask.ERROR,
					ChannelController.class.getName(), e);
			out(response, new MessageResult(ConstantUtil.M_SYSTEM_ERROR, "系统发生未知错误"));
		}
	}
	
	@RequestMapping("/exportChannelUser")
	public void exportChannelUser(HttpServletRequest request, HttpServletResponse response) {
		try {
			
			Map<String, Object> params = new HashMap<String, Object>(6);
			
			String registerStartDate = request.getParameter("registerStartDate");
			String registerEndDate = request.getParameter("registerEndDate");
			String isApprove = request.getParameter("isApprove");
			String isMember = request.getParameter("isMember");
			String isCanOrder = request.getParameter("isCanOrder");
			String channelCode = request.getParameter("channelCode");
			
			if (!StringUtils.isBlank(registerStartDate))
				params.put("registerStartDate", registerStartDate);
			
			if (!StringUtils.isBlank(registerEndDate))
				params.put("registerEndDate", registerEndDate);
			
			if (!StringUtils.isBlank(isApprove))
				params.put("isApprove", Integer.valueOf(isApprove));
			
			if (!StringUtils.isBlank(isMember))
				params.put("isMember", Integer.valueOf(isMember));
			
			if (!StringUtils.isBlank(isCanOrder))
				params.put("isCanOrder", Integer.valueOf(isCanOrder));
			
			if (!StringUtils.isBlank(channelCode))
				params.put("channelCode", channelCode);
			
			List<ChannelUser> list = channelService.getChannelUserListByChannelCode(params);
			
			exportChannelUserList("渠道注册人员统计.xls", list, response, request);
			
		} catch (Exception e) {
			Log4jTask.addLog("导出渠道统计列表错误[channel/exportChannelUser]", System.currentTimeMillis(), Log4jTask.ERROR,
					ChannelController.class.getName(), e);
			out(response, new MessageResult(ConstantUtil.M_SYSTEM_ERROR, "系统发生未知错误"));
		}
	}
	
	@RequestMapping("/channelUserList")
	public void channelUserList(HttpServletRequest request, HttpServletResponse response) {
		try {
			Map<String, Object> params = new HashMap<String, Object>(6);
			
			String p_pageSize = request.getParameter("rows");
			String p_pageNumber = request.getParameter("page");
			String registerStartDate = request.getParameter("registerStartDate");
			String registerEndDate = request.getParameter("registerEndDate");
			String isApprove = request.getParameter("isApprove");
			String isMember = request.getParameter("isMember");
			String isCanOrder = request.getParameter("isCanOrder");
			String channelCode = request.getParameter("channelCode");
			
			if (!StringUtils.isEmpty(p_pageSize))
				params.put("pageSize", Integer.valueOf(p_pageSize));
			else
				params.put("pageSize", 10);

			if (!StringUtils.isEmpty(p_pageNumber))
				params.put("startIndex", (Integer.valueOf(p_pageNumber) - 1) * Integer.valueOf(p_pageSize));
			else
				params.put("startIndex", 0);
			
			if (!StringUtils.isBlank(registerStartDate))
				params.put("registerStartDate", registerStartDate);
			
			if (!StringUtils.isBlank(registerEndDate))
				params.put("registerEndDate", registerEndDate);
			
			if (!StringUtils.isBlank(isApprove))
				params.put("isApprove", Integer.valueOf(isApprove));
			
			if (!StringUtils.isBlank(isMember))
				params.put("isMember", Integer.valueOf(isMember));
			
			if (!StringUtils.isBlank(isCanOrder))
				params.put("isCanOrder", Integer.valueOf(isCanOrder));
			
			if (!StringUtils.isBlank(channelCode))
				params.put("channelCode", channelCode);
			
			HashMap<String, Object> dataMap = new HashMap<String, Object>(2);
			
			List<ChannelUser> list = channelService.getChannelUserListByChannelCode(params);
			int count = channelService.getChannelUserListCountByChannelCode(params);

			dataMap.put("total", count);
			dataMap.put("rows", list);
			
			webOut(response, dataMap);
			return;
			
		} catch (Exception e) {
			Log4jTask.addLog("获取渠道统计列表错误[channel/channelUserList]", System.currentTimeMillis(), Log4jTask.ERROR,
					ChannelController.class.getName(), e);
			out(response, new MessageResult(ConstantUtil.M_SYSTEM_ERROR, "系统发生未知错误"));
		}
	}

	@RequestMapping("/saveChannel")
	public void saveChannel(Channel channel, HttpServletRequest request, HttpServletResponse response) {
		try {
			if (null == channel.getId()) {
				String channelCode = productChannelCode();
				Channel channel_ = channelService.getChannelByChannelCode(channelCode);
				while (null != channel_) {
					channelCode = productChannelCode();
					channel_ = channelService.getChannelByChannelCode(channelCode);
				}
				// TODO:拼接活动链接(渠道码)
				String baseUrl = "/h5/tuiguang.jsp";
				String scheme = request.getScheme();
				String hostName = request.getServerName();
				String contextPath = request.getContextPath();
				String activityUrl = scheme + "://" + hostName + contextPath + baseUrl + "?channelCode=" + channelCode;

				channel.setActivityUrl(activityUrl);
				channel.setChannelCode(channelCode);
				channel.setCreateDate(new Date());
				channelService.insertChannel(channel);
			} else {
				channelService.updateChannelById(channel);
			}
			out(response, new MessageResult(ConstantUtil.M_SUCCESS, "保存成功"));
		} catch (Exception e) {
			Log4jTask.addLog("保存渠道异常[channel/saveChannel]", System.currentTimeMillis(), Log4jTask.ERROR,
					ChannelController.class.getName(), e);
			out(response, new MessageResult(ConstantUtil.M_SYSTEM_ERROR, "系统发生未知错误"));
		}
	}

	@RequestMapping("/deleteChannel")
	public void deleteChannel(Integer id, HttpServletRequest request, HttpServletResponse response) {
		try {
			channelService.deleteChannelById(id);
			out(response, new MessageResult(ConstantUtil.M_SUCCESS, "删除成功"));
		} catch (Exception e) {
			Log4jTask.addLog("根据id删除渠道异常[channel/deleteChannel]", System.currentTimeMillis(), Log4jTask.ERROR,
					ChannelController.class.getName(), e);
			out(response, new MessageResult(ConstantUtil.M_SYSTEM_ERROR, "系统发生未知错误"));
		}
	}

	@RequestMapping("/h5ChannelInfo")
	public void h5ChannelInfo(HttpServletRequest request, HttpServletResponse response) {
		MessageResult result = new MessageResult();
		try {
			String channelCode = request.getParameter("channelCode");
			if (StringUtils.isBlank(channelCode)) {
				result.setCode(ConstantUtil.M_PARAMTER_NULL);
				result.setMessage("渠道码为空");
				out(response, result);
				return;
			}

			Channel channel = channelService.getChannelByChannelCode(channelCode);

			if (null == channel) {
				result.setCode(ConstantUtil.W_REQUEST_VERRIFY_ERROR);
				result.setMessage("该链接无效");
				out(response, result);
				return;
			}

			// 如果活动状态为关闭
			if (channel.getStatus() == 0) {
				result.setCode(ConstantUtil.W_REQUEST_VERRIFY_ERROR);
				result.setMessage("该活动暂未开放");
				out(response, result);
				return;
			}

			// 如果活动开始时间大于当前时间;[2017-12-20,2017-12-21]
			if (channel.getStartDate().compareTo(new Date()) > 0) {
				result.setCode(ConstantUtil.W_REQUEST_VERRIFY_ERROR);
				result.setMessage("该活动暂未开放");
				out(response, result);
				return;
			}

			// 如果活动结束时间小于当前时间;[2017-12-20,2017-12-21]
			if (channel.getEndDate().compareTo(new Date()) < 0) {
				result.setCode(ConstantUtil.W_REQUEST_VERRIFY_ERROR);
				result.setMessage("该活动已截止");
				out(response, result);
				return;
			}

			result.setCode(ConstantUtil.M_SUCCESS);
			result.setMessage("成功");
			result.setData(channel);
			out(response, result);
			return;

		} catch (Exception e) {
			Log4jTask.addLog("根据id获取渠道商信息异常[channel/h5ChannelInfo]", System.currentTimeMillis(), Log4jTask.ERROR,
					ChannelController.class.getName(), e);
			result.setCode(ConstantUtil.M_SYSTEM_ERROR);
			result.setMessage("系统发生未知错误");
			out(response, result);
		}
	}
	
	@RequestMapping("/sendVerificationCode4h5")
	public void sendVerificationCode4h5(HttpServletRequest request, HttpServletResponse response) {
		MessageResult result = new MessageResult();
		try {
			String phone = request.getParameter("phone");
			String verifyCode = request.getParameter("verifyCode");
			if (StringUtils.isBlank(phone)) {
            	result.setCode(ConstantUtil.M_PARAMTER_NULL);
            	result.setMessage("请输入手机号");
                out(response, result);
                return;
			}
			if (StringUtils.isBlank(verifyCode)) {
				result.setCode(ConstantUtil.M_PARAMTER_ERROR);
				result.setMessage("请输入图形验证码");
				out(response, result);
				return;
			}
			// 获取域名;
			String hostName = request.getServerName();
			String verifyCodeKey = MessageFormat.format(RedisKey.VERIFYCODEIMGH5_LOGIN, hostName);
			Object cacheVerifyCode = request.getSession().getAttribute(verifyCodeKey);
			request.getSession().removeAttribute(verifyCodeKey);
			if (null == cacheVerifyCode) {
				result.setCode(ConstantUtil.M_PARAMTER_ERROR);
				result.setMessage("图形验证码已过期，请重新获取");
				out(response, result);
				return;
			}
			if (!verifyCode.equals(cacheVerifyCode.toString())) {
				result.setCode(ConstantUtil.M_PARAMTER_ERROR);
				result.setMessage("图形验证码错误");
				out(response, result);
				return;
			}
			
            // 生成验证码;
            String verificationCode = String.valueOf(Math.abs(new Random().nextLong()));
            verificationCode = verificationCode.substring(verificationCode.length() - 4, verificationCode.length());
            
            final String key = phone + "_verificationCode_" + hostName;
            final String value = verificationCode;
            
            // 存入redis,并设置5分钟过期时间;
            redisTemplate.opsForValue().set(key, value, 5, TimeUnit.MINUTES);
            
            // 获取注册短信模板;
            BaseMessageTemplate template = baseMessageTemplateRemoteService.selectTitleAndContentByIdentification(ConstantUtil.M_SMSCODE_LOGIN);
            
            if (template != null){   
            	// 将替换区域替换成生成的验证码;
                String content = template.getContent().replaceAll("【validationCode】", verificationCode);
                // 获取该商户下的配置信息;
                PayConfig payConfig = payConfigService.seleConfigByHost(hostName);
                // 发送短信;
                String msgResult = PostMsgHttpContent.sendMessage(phone, content, payConfig.getSmstaskid());
                if("Success".equals(msgResult)){
                	result.setCode(ConstantUtil.M_SUCCESS);
                	result.setMessage("发送成功");
                    out(response, result);
                    return;
                }else{
                	result.setCode(ConstantUtil.M_REQUEST_INCORRECT);
                	result.setMessage("发送失败");
                    out(response, result);	
                    return;
                }
            } else { // 若没有短信注册模板
            	
            }
		} catch (Exception e) {
			Log4jTask.addLog("h5页面发送验证码异常[channel/sendVerificationCode4h5]", System.currentTimeMillis(), Log4jTask.ERROR,
					ChannelController.class.getName(), e);
			result.setCode(ConstantUtil.M_SYSTEM_ERROR);
			result.setMessage("系统发生未知错误");
			out(response, result);
		}
	}

	@RequestMapping("/channelRegister4h5")
	public void h5Register(Customer customer, HttpServletRequest request, HttpServletResponse response) {
		MessageResult result = new MessageResult();
		try {
			String verificationCode = request.getParameter("verificationCode"); // 验证码
			String channelCode = request.getParameter("channelCode"); // 渠道码
			String hostName = request.getServerName();
			if (StringUtils.isBlank(customer.getUsername())) {
				result.setCode(ConstantUtil.M_PARAMTER_NULL);
				result.setMessage("请输入手机号");
				out(response, result);
				return;
			}

			if (StringUtils.isBlank(verificationCode)) {
				result.setCode(ConstantUtil.M_PARAMTER_NULL);
				result.setMessage("请输入验证码");
				out(response, result);
				return;
			}
			
			final String key = customer.getUsername() + "_verificationCode_" + hostName;
			Object cacheVerificationCode = redisTemplate.opsForValue().get(key);

			if (null == cacheVerificationCode) {
				result.setCode(ConstantUtil.M_DATA_EXPIRE);
				result.setMessage("验证码已过期,请重新获取");
				out(response, result);
				return;
			}

			if (!verificationCode.equals(cacheVerificationCode.toString())) {
				result.setCode(ConstantUtil.M_EXCEPTION);
				result.setMessage("验证码错误");
				out(response, result);
				return;
			}
			
			if (null != customerRemoteService.isExistCustomer(customer)) {
				result.setCode(ConstantUtil.M_SUCCESS);
				result.setMessage("成功");
				out(response, result);
				return;
			}
			
			customer.setMobile(customer.getUsername());
			customer.setSourcechannelid(0); // 渠道
			customer.setCreatedate(new Date());
			
			// 生成邀请码;
			String invitationCode = productInvitationCode();
            JSONObject obj = customerRemoteService.getCustomerIdByInvitationCode(invitationCode);
            while (null != obj) {
            	invitationCode = productInvitationCode();
            	obj = customerRemoteService.getCustomerIdByInvitationCode(invitationCode);
            }
            customer.setInvitationcode(invitationCode);
            
            customer.setPassword(EncryptionUtil.md5(customer.getUsername() + System.currentTimeMillis()));
            customer.setRecommendcode(channelCode); // 绑定渠道商户
            
            BaseMessageTemplate mTemplate = baseMessageTemplateRemoteService.selectTitleAndContentByIdentification(ConstantUtil.M_REGISTER_SUCCESS);	
            Message message = new Message();
            boolean isSmsSend = false;
            if(mTemplate!=null&&mTemplate.getMessageType()!=null){
            	if(mTemplate.getMessageType().indexOf(ConstantUtil.MESSAGETYPE_SMS)!=-1){
            		isSmsSend = true;
            	}else if(mTemplate.getMessageType().indexOf(ConstantUtil.MESSAGETYPE_SYS)!=-1){
        			// 添加站内信
        			message.setTitle(mTemplate.getTitle());
                    message.setContent(mTemplate.getContent());
                    message.setSenddate(new Date());
                    message.setReadstatus(new Byte("0"));
                    message.setIsdelete(new Byte("0"));
                    message.setCreatedate(new Date());
            	}
            }
            channelService.h5Register(customer, message);
            if (isSmsSend) {
            	PayConfig payConfig = payConfigService.seleConfigByHost(hostName);
            	PostMsgHttpContent.sendMessage(customer.getUsername(), mTemplate.getContent(),payConfig.getSmstaskid());
            }
            redisTemplate.delete(key);
			
            result.setCode(ConstantUtil.M_SUCCESS);
			result.setMessage("成功");
            out(response, result);
		} catch (Exception e) {
			Log4jTask.addLog("h5通过渠道码注册异常[channel/channelRegister4h5]", System.currentTimeMillis(), Log4jTask.ERROR,
					ChannelController.class.getName(), e);
			result.setCode(ConstantUtil.M_SYSTEM_ERROR);
			result.setMessage("系统发生未知错误");
			out(response, result);
		}
	}
	
	@RequestMapping("/downloadModel")
	public void downloadModel(HttpServletRequest request, HttpServletResponse response) {
		try {
			String url = this.getClass().getResource("/").getPath();
			if ("\\".equals(File.separator)) { // windows
				url = url.substring(1, url.indexOf("/WEB-INF/classes"));  
				url = url.replace("/", "\\");
				url = url + "\\img\\model.zip";
			} else if ("/".equals(File.separator)) { // linux
				url = url.substring(0, url.indexOf("/WEB-INF/classes"));  
				url = url.replace("\\", "/");
				url = url + "/img/model.zip";
			}
			response.reset();
			response.setHeader("Content-Disposition", "attachment;filename=model.zip");
			FileInputStream fis = new FileInputStream(url);
			OutputStream os = response.getOutputStream();
			byte[] content = new byte[fis.available()];
			int length = 0;
			while ((length = fis.read(content)) != -1) {
				os.write(content, 0, length);
			}
			os.write(content);
			os.flush();
			os.close();
			fis.close();
		} catch (Exception e) {
			Log4jTask.addLog("下载渠道模板异常[channel/downloadModel]", System.currentTimeMillis(), Log4jTask.ERROR,
					ChannelController.class.getName(), e);
			out(response, new MessageResult(ConstantUtil.M_SYSTEM_ERROR, "系统发生未知错误"));
		}
	}
	
	@RequestMapping("/couponpackageid")
    public void getCouponPackageId(HttpServletResponse response, HttpServletRequest request,Integer channelId,String channelName) {
		MessageResult result = new MessageResult();
		try{
			CouponPackage p = new CouponPackage();
			p.setPkgname(channelName + "渠道优惠券");
			svcPackage.createPackage(p);
			channelService.updateCouponPackageId(channelId,p.getId());
			result.setCode(ConstantUtil.W_SUCCESS);
			result.setData(p.getId());
			outJson(response,result);
		}catch(Exception e){
			result.setCode(ConstantUtil.W_EXCEPTION);
			outJson(response,result);
		}
		
	}
	
	private void exportChannelUserList(String fileName, List<ChannelUser> list, HttpServletResponse response,
			HttpServletRequest request) {
		WritableWorkbook wwb;
		FileOutputStream fos;
		try {
			fos = new FileOutputStream(fileName);
			wwb = Workbook.createWorkbook(fos);

			WritableSheet ws = wwb.createSheet("渠道注册人员统计", 0);

			WritableFont wf = new WritableFont(WritableFont.ARIAL, 12, WritableFont.NO_BOLD, false,
					UnderlineStyle.NO_UNDERLINE, Colour.BLACK);
			WritableCellFormat wcf = new WritableCellFormat(wf);
			wcf.setVerticalAlignment(VerticalAlignment.CENTRE);
			wcf.setAlignment(Alignment.CENTRE);
			ws.setRowView(1, 500);

			ws.addCell(new Label(0, 0, "手机号码", wcf));
			ws.addCell(new Label(1, 0, "真实姓名", wcf));
			ws.addCell(new Label(2, 0, "注册时间", wcf));
			ws.addCell(new Label(3, 0, "登录时间", wcf));
			ws.addCell(new Label(4, 0, "身份认证", wcf));
			ws.addCell(new Label(5, 0, "缴纳保证金", wcf));
			ws.addCell(new Label(6, 0, "是否下单", wcf));

			int rowsCount = list.size();

			ChannelUser channelUser;

			for (int i = 0; i < rowsCount; i++) {
				channelUser = list.get(i);
				ws.addCell(new Label(0, i + 1, channelUser.getUserName(), wcf));
				ws.addCell(new Label(1, i + 1, channelUser.getName(), wcf));
				ws.addCell(
						new Label(2, i + 1,
								channelUser.getRegisterDate() == null ? ""
										: DateFormatUtils.format(channelUser.getRegisterDate(), "yyyy-MM-dd HH:mm:ss"),
								wcf));
				ws.addCell(
						new Label(3, i + 1,
								channelUser.getLoginDate() == null ? ""
										: DateFormatUtils.format(channelUser.getLoginDate(), "yyyy-MM-dd HH:mm:ss"),
								wcf));
				if (channelUser.getIsApprove() == 0) {
					ws.addCell(new Label(4, i + 1, "否", wcf));
				} else if (channelUser.getIsApprove() == 1) {
					ws.addCell(new Label(4, i + 1, "是", wcf));
				}
				if (channelUser.getIsMember() == 0) {
					ws.addCell(new Label(5, i + 1, "否", wcf));
				} else if (channelUser.getIsApprove() == 1) {
					ws.addCell(new Label(5, i + 1, "是", wcf));
				}
				if (channelUser.getIsCanOrder() == 0) {
					ws.addCell(new Label(6, i + 1, "否", wcf));
				} else if (channelUser.getIsApprove() == 1) {
					ws.addCell(new Label(6, i + 1, "是", wcf));
				}
			}

			wwb.write();
			wwb.close();
			FileInputStream fileInputStream = new FileInputStream(new File(fileName));
			response.reset();
			String nowTime = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(new Date());
			fileName = "渠道注册人员统计" + nowTime + ".xls";
			final String userAgent = request.getHeader("USER-AGENT");
			String finalFileName = null;
			if (StringUtils.contains(userAgent, "MSIE")) { // IE浏览器
				finalFileName = URLEncoder.encode(fileName, "UTF8");
			} else if (StringUtils.contains(userAgent, "Mozilla")) { // google,火狐浏览器
				finalFileName = new String(fileName.getBytes(), "ISO8859-1");
			} else {
				finalFileName = URLEncoder.encode(fileName, "UTF8"); // 其他浏览器
			}
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
			Log4jTask.addLog("导出渠道用户统计excel错误[channel/exportChannelUserList]", System.currentTimeMillis(), Log4jTask.ERROR,
					ChannelController.class.getName(), e);
			MessageResult result = new MessageResult();
			result.setCode(ConstantUtil.M_SYSTEM_ERROR);
			result.setMessage("系统发生未知错误");
			out(response, result);
		}
	}
	
	private String productChannelCode() {
		String channelCode = String.valueOf(Math.abs(new Random().nextLong()));
		channelCode = "Q" + channelCode.substring(channelCode.length() - 8, channelCode.length());
		return channelCode;
	}
	
	private String productInvitationCode() {
        String invitationCode = String.valueOf(Math.abs(new Random().nextLong()));
        invitationCode = invitationCode.substring(invitationCode.length() - 8, invitationCode.length());
        return invitationCode;
	}
}
