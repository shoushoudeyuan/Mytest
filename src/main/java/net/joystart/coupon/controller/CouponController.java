package net.joystart.coupon.controller;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import net.joystart.channel.entity.Channel;
import net.joystart.channel.service.IChannelService;
import net.joystart.common.controller.BaseController;
import net.joystart.common.util.ConstantUtil;
import net.joystart.common.util.MessageResult;
import net.joystart.common.util.log.Log4jTask;
import net.joystart.coupon.entity.Activity;
import net.joystart.coupon.entity.Coupon;
import net.joystart.coupon.entity.CouponOld;
import net.joystart.coupon.entity.Redpacket;
import net.joystart.coupon.service.IActivityService;
import net.joystart.coupon.service.ICouponService;
import net.joystart.coupon.service.IRedpacketRuledetailService;
import net.joystart.coupon.service.IRedpacketService;
import net.joystart.couponmanage.enums.CouponGiftModeEnum;
import net.joystart.couponmanage.enums.CustomerBehaviorEnum;
import net.joystart.couponmanage.service.impl.GiftCouponContext;
import net.joystart.customer.entity.Customer;
import net.joystart.customer.remote.service.ICustomerRemoteService;
import net.joystart.order.entity.Order;
import net.joystart.order.remote.service.IOrderRemoteService;
import net.joystart.promotion.entity.PromotionPerson;
import net.joystart.promotion.service.IPromotionPersonService;

/**
 * 
 * @author yang yanqing
 * @date 2016年7月7日
 * CouponController 优惠券
 */

@Controller
@RequestMapping("/coupon")
public class CouponController extends BaseController{

	
	@Resource
	ICouponService couponService;
	
	@Resource
	ICustomerRemoteService customerService;
	
	@Resource
	IActivityService activityService;
	
	@Resource
	IRedpacketService redpacketService;
	
	@Resource
	IOrderRemoteService orderRemoteService;
	
	@Resource
	IRedpacketRuledetailService redpacketRuledetailService;
	
	@Resource
	IPromotionPersonService promotionPersonService;
	
	@Resource
	GiftCouponContext couponFactory;
	
	@Resource
	IChannelService channelService;
	
	/**
	 * 优惠券列表
	 * @param request
	 * @param response
	 */
	@RequestMapping("/list")
	public void CouponList(HttpServletRequest request,HttpServletResponse response){
		
		
		List<CouponOld> timeControl = new ArrayList<>();
		List<CouponOld> common = new ArrayList<>();
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("isExpires", 0);//未过期
		params.put("isDisable", 1);//启用
		params.put("useStatus", 0);//未使用
		params.put("isDelete", 0);//未删除
		
		HashMap<String,Object> dataMap = new HashMap<String,Object>();
		MessageResult messageResult = new MessageResult();
		
		String customerId = request.getParameter("customerId");
		if(isH5(request)){
			Customer customerx = getLoginUser(request);
			if(customerx==null){
				customerId="";
			}
			customerId=customerx.getId().toString();
		}
		if(StringUtils.isBlank(customerId)){
			messageResult.setCode(ConstantUtil.M_PARAMTER_NULL);
			messageResult.setMessage("会员ID参数为空！");
			this.out(response, messageResult);
			return;
		}
		
		params.put("customerId",customerId );
		
		String orderId = request.getParameter("orderId");
		if(StringUtils.isBlank(orderId)){
			//没有提交订单号
			timeControl = this.couponService.listOld(params);
			dataMap.put("list", timeControl);
			messageResult.setCode(ConstantUtil.M_SUCCESS);
			messageResult.setMessage("操作成功！");
			messageResult.setData(dataMap);
			this.out(response, messageResult);
			return;
		}else{
			//提交了订单号
			Order order = this.orderRemoteService.selectByPrimaryKey(Integer.valueOf(orderId));
			//过滤类型
			params.put("couponType", order.getOrdertype());
			//订单开始时间
			Calendar o_start = Calendar.getInstance(); 
			o_start.setTime(order.getCreatedate());
			
			//订单开始时间
			Calendar o_end = Calendar.getInstance(); 
			o_end.setTime(order.getReturnvehicledate());
			
			//当天早9点时间
			Calendar o_nine = Calendar.getInstance(); 
			o_nine.setTime(order.getCreatedate());
			o_nine.set(Calendar.HOUR_OF_DAY, 9);
			o_nine.set(Calendar.MINUTE, 0);
			o_nine.set(Calendar.SECOND, 0);
			
			//当天晚7点时间
			Calendar o_six = Calendar.getInstance(); 
			o_six.setTime(order.getCreatedate());
			o_six.set(Calendar.HOUR_OF_DAY, 19);
			o_six.set(Calendar.MINUTE, 0);
			o_six.set(Calendar.SECOND, 0);
			
			//第二天早9点时间
			Calendar o_six_next = Calendar.getInstance(); 
			o_six_next.setTime(order.getCreatedate());
			o_six_next.add(Calendar.DAY_OF_MONTH,1);
			o_six_next.set(Calendar.HOUR_OF_DAY, 9);
			o_six_next.set(Calendar.MINUTE, 0);
			o_six_next.set(Calendar.SECOND, 0);
			//过滤时间限制  晚间优惠券 白天优惠券
			//开始时间在当天早九点开始  晚19点之前结束，纯白天订单
			//a.compareTo(c)
			//a比c早,返回-1,
	        //a与c相同,返回0
	        //a比c晚,返回1
			if((o_start.compareTo(o_nine)==1)&&(o_end.compareTo(o_six)==-1)){
				params.put("isTimeControl", 1);
				timeControl = this.couponService.listOld(params);
			}else
			
			//开始时间在当天早九点 结束时间在 晚上19点之后，第二天早九点前
			//开始时间在当天晚19点 结束时间在第二天早九点之前，纯夜间订单
			if((o_start.compareTo(o_six)==1)&&(o_end.compareTo(o_six_next)==-1)){
				params.put("isTimeControl", 2);
				timeControl = this.couponService.listOld(params);
			}
			
			params.put("isTimeControl", 0);
			common = this.couponService.listOld(params);
			timeControl.addAll(common);
			
			if(timeControl.size()==0){
				dataMap.put("list", timeControl);
				messageResult.setCode(ConstantUtil.M_SUCCESS);
				messageResult.setMessage("操作成功！");
				messageResult.setData(dataMap);
				this.out(response, messageResult);
				return;
			}
			
			
			
			//最合适的优惠券默认选中
			
			TreeMap<BigDecimal, Integer> treeMap = new TreeMap<>();
			BigDecimal ordercost = order.getOrdercost();
			for(int i=0;i<timeControl.size();i++){
				BigDecimal abs = timeControl.get(i).getCouponMoney().subtract(ordercost).abs();
				treeMap.put(abs, i); 
			}
			
			
			
			
			timeControl.get(treeMap.firstEntry().getValue()).setIsUse(1);
			
			
		/*	BigDecimal max = new BigDecimal(0);
			Integer maxId = new Integer(0);
			for(Coupon  temp : timeControl){
				if(1 == temp.getCouponMoney().compareTo(max)){
					max = temp.getCouponMoney();
					maxId = temp.getId();
				}
			}
			
			for(Coupon  temp : timeControl){
				if(maxId == temp.getId()){
					temp.setIsUse(1);
				}
			}*/
			
			
			
			
			
			dataMap.put("list", timeControl);
			messageResult.setCode(ConstantUtil.M_SUCCESS);
			messageResult.setMessage("操作成功！");
			messageResult.setData(dataMap);
			this.out(response, messageResult);
			return;
		}
	}
	/**
	 * 优惠券列表
	 * @param request
	 * @param response
	 */
	@RequestMapping("/listV230")
	public void CouponListV230(HttpServletRequest request,HttpServletResponse response){
		
		
		List<Coupon> timeControl = new ArrayList<>();
		List<Coupon> common = new ArrayList<>();
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("isExpires", 0);//未过期
		params.put("isDisable", 1);//启用
		params.put("useStatus", 0);//未使用
		params.put("isDelete", 0);//未删除
		
		
		HashMap<String,Object> dataMap = new HashMap<String,Object>();
		MessageResult messageResult = new MessageResult();
		
		String customerId = request.getParameter("customerId");
		if(StringUtils.isBlank(customerId)){
			messageResult.setCode(ConstantUtil.M_PARAMTER_NULL);
			messageResult.setMessage("会员ID参数为空！");
			this.out(response, messageResult);
			return;
		}
		
		params.put("customerId",customerId );
		
		String orderId = request.getParameter("orderId");
		if(StringUtils.isBlank(orderId)){
			//没有提交订单号
			timeControl = this.couponService.list(params);
			for (int i = 0; i < timeControl.size(); i++) {
				if (timeControl.get(i).getType()==1) {
					if (timeControl.get(i).getDiscount()%10>0) {
						DecimalFormat    df   = new DecimalFormat("######0.0");  
						Double zheKou = Double.valueOf(timeControl.get(i).getDiscount())/Double.valueOf(10);
						timeControl.get(i).setZhekou(df.format(zheKou));
					}else{
						DecimalFormat    df   = new DecimalFormat("######0");
						Double zheKou = Double.valueOf(timeControl.get(i).getDiscount())/Double.valueOf(10);
						timeControl.get(i).setZhekou(df.format(zheKou));
					}
				}
			}
			dataMap.put("list", timeControl);
			messageResult.setCode(ConstantUtil.M_SUCCESS);
			messageResult.setMessage("操作成功！");
			messageResult.setData(dataMap);
			this.out(response, messageResult);
			return;
		}else{
			//提交了订单号
			Order order = this.orderRemoteService.selectByPrimaryKey(Integer.valueOf(orderId));
			//过滤类型
			params.put("couponType", order.getOrdertype());
			//订单开始时间
			Calendar o_start = Calendar.getInstance(); 
			o_start.setTime(order.getCreatedate());
			
			//订单开始时间
			Calendar o_end = Calendar.getInstance(); 
			o_end.setTime(order.getReturnvehicledate());
			
			//当天早9点时间
			Calendar o_nine = Calendar.getInstance(); 
			o_nine.setTime(order.getCreatedate());
			o_nine.set(Calendar.HOUR_OF_DAY, 9);
			o_nine.set(Calendar.MINUTE, 0);
			o_nine.set(Calendar.SECOND, 0);
			
			//当天晚7点时间
			Calendar o_six = Calendar.getInstance(); 
			o_six.setTime(order.getCreatedate());
			o_six.set(Calendar.HOUR_OF_DAY, 19);
			o_six.set(Calendar.MINUTE, 0);
			o_six.set(Calendar.SECOND, 0);
			
			//第二天早9点时间
			Calendar o_six_next = Calendar.getInstance(); 
			o_six_next.setTime(order.getCreatedate());
			o_six_next.add(Calendar.DAY_OF_MONTH,1);
			o_six_next.set(Calendar.HOUR_OF_DAY, 9);
			o_six_next.set(Calendar.MINUTE, 0);
			o_six_next.set(Calendar.SECOND, 0);
			//过滤时间限制  晚间优惠券 白天优惠券
			//开始时间在当天早九点开始  晚19点之前结束，纯白天订单
			//a.compareTo(c)
			//a比c早,返回-1,
	        //a与c相同,返回0
	        //a比c晚,返回1
			if((o_start.compareTo(o_nine)==1)&&(o_end.compareTo(o_six)==-1)){
				params.put("isTimeControl", 1);
				timeControl = this.couponService.list(params);
			}else
			
			//开始时间在当天早九点 结束时间在 晚上19点之后，第二天早九点前
			//开始时间在当天晚19点 结束时间在第二天早九点之前，纯夜间订单
			if((o_start.compareTo(o_six)==1)&&(o_end.compareTo(o_six_next)==-1)){
				params.put("isTimeControl", 2);
				timeControl = this.couponService.list(params);
			}
			params.put("isTimeControl", 0);
			common = this.couponService.list(params);
			for (int i = 0; i < common.size(); i++) {
				if (common.get(i).getType()==1) {
					
					if (common.get(i).getDiscount()%10>0) {
						DecimalFormat    df   = new DecimalFormat("######0.0");  
						Double zheKou = Double.valueOf(common.get(i).getDiscount())/Double.valueOf(10);
						common.get(i).setZhekou(df.format(zheKou));
					}else{
						DecimalFormat    df   = new DecimalFormat("######0");
						Double zheKou = Double.valueOf(common.get(i).getDiscount())/Double.valueOf(10);
						common.get(i).setZhekou(df.format(zheKou));
					}
				}
				
			}
			timeControl.addAll(common);
			
			if(timeControl.size()==0){
				dataMap.put("list", timeControl);
				messageResult.setCode(ConstantUtil.M_SUCCESS);
				messageResult.setMessage("操作成功！");
				messageResult.setData(dataMap);
				this.out(response, messageResult);
				return;
			}
			
			
		/*	
			//最合适的优惠券默认选中
			
			TreeMap<BigDecimal, Integer> treeMap = new TreeMap<>();
			BigDecimal ordercost = order.getOrdercost();
			for(int i=0;i<timeControl.size();i++){
				BigDecimal abs = timeControl.get(i).getCouponMoney().subtract(ordercost).abs();
				treeMap.put(abs, i); 
			}
			
			timeControl.get(treeMap.firstEntry().getValue()).setIsUse(1);;*/
			
		/*	BigDecimal max = new BigDecimal(0);
			Integer maxId = new Integer(0);
			for(Coupon  temp : timeControl){
				if(1 == temp.getCouponMoney().compareTo(max)){
					max = temp.getCouponMoney();
					maxId = temp.getId();
				}
			}
			
			for(Coupon  temp : timeControl){
				if(maxId == temp.getId()){
					temp.setIsUse(1);
				}
			}*/
			
			dataMap.put("list", timeControl);
			messageResult.setCode(ConstantUtil.M_SUCCESS);
			messageResult.setMessage("操作成功！");
			messageResult.setData(dataMap);
			this.out(response, messageResult);
			return;
		}
	}
	
	/**
	 * 查询过期的/使用的过的优惠券
	 * lsy 2017-01-03
	 */
	@RequestMapping("/historyCoupon")
	public void historyCoupon(HttpServletRequest req, HttpServletResponse resp) {
		MessageResult result = new MessageResult();
		try {
			
			Map<String, Object> params = new HashMap<String, Object>(4);
			
			String customerId = req.getParameter("customerId");
			
			if(StringUtils.isBlank(customerId)){
				result.setCode(ConstantUtil.M_PARAMTER_NULL);
				result.setMessage("会员ID参数为空！");
				this.out(resp, result);
				return;
			}
			
			params.put("customerId", Integer.valueOf(customerId));
			
			String pageNumber = req.getParameter("pageNumber");
			
			String pageSize = req.getParameter("pageSize");
			
			if (!StringUtils.isEmpty(pageSize))
				params.put("pageSize", Integer.valueOf(pageSize));
			else
				params.put("pageSize", 10);

			if (!StringUtils.isEmpty(pageNumber))
				params.put("pageIndex", (Integer.valueOf(pageNumber) - 1) * Integer.valueOf(pageSize));
			else
				params.put("pageIndex", 0);
			
			List<Coupon> list = couponService.historyCoupon(params);
			
			for (Coupon coupon : list) {
				if (coupon.getType() == 1) {
					if (coupon.getDiscount() % 10 > 0) {
						DecimalFormat df = new DecimalFormat("######0.0");
						Double zheKou = Double.valueOf(coupon.getDiscount()) / Double.valueOf(10);
						coupon.setZhekou(df.format(zheKou));
					} else {
						DecimalFormat df = new DecimalFormat("######0");
						Double zheKou = Double.valueOf(coupon.getDiscount()) / Double.valueOf(10);
						coupon.setZhekou(df.format(zheKou));
					}
				}
			}
			HashMap<String, Object> resMap = new HashMap<String, Object>();
			resMap.put("list", list);
			result.setCode(ConstantUtil.M_SUCCESS);
			result.setData(resMap);
			result.setMessage("查询成功！");
			this.out(resp, result);
			
		} catch (Exception e) {
			e.printStackTrace();
			result.setCode(ConstantUtil.M_SYSTEM_ERROR);
			result.setMessage("服务器繁忙，请稍后重试！");
			Log4jTask.addLog("历史优惠券接口异常[/coupon/historyCoupon]", System.currentTimeMillis(), Log4jTask.ERROR, this.getClass().getName(), e);
			this.out(resp, result);
		}
	}

	/**
	 * 根据会员账号查询优惠券数量
	 * @param request
	 * @param response
	 */
	@RequestMapping("/count")
	public void count(HttpServletRequest request,HttpServletResponse response){
		//存储查询参数
		 Map<String,Object> params = new HashMap<String,Object>();
		//存储返回Data
		 Map<String,Object> dataMap = new HashMap<String,Object>();
		 MessageResult	messageResult = new MessageResult();
		
		
		String customerId = request.getParameter("customerId");
		if(StringUtils.isBlank(customerId)){
			messageResult.setCode(ConstantUtil.M_PARAMTER_NULL);
			messageResult.setMessage("会员ID参数为空！");
			this.out(response, messageResult);
			return;
		}
		
		params.put("customerId",customerId );
		params.put("isDisable", 1);
		params.put("useStatus", 0);
		params.put("isDelete", 0);
		List<Coupon> list = this.couponService.list(params);
		messageResult.setCode(ConstantUtil.M_SUCCESS);
		messageResult.setMessage("操作成功！");
		dataMap.put("size", list.size());
		messageResult.setData(dataMap);
		this.out(response, messageResult);
		return;
	}


	/**
	 * 优惠券/红包 兑换
	 * @param request
	 * @param response
	 */
	@RequestMapping("/exchange")
	public void exchange(HttpServletRequest request,HttpServletResponse response){
		
		MessageResult messageResult = new MessageResult();
		messageResult.setData(1);
		String customerId = request.getParameter("customerId");
		if(isH5(request)){
			Customer customerx = getLoginUser(request);
			if(customerx == null){
				customerId = "";
			} else {
				customerId = customerx.getId().toString();
			}
		}
		if(StringUtils.isBlank(customerId)){
			messageResult.setCode(ConstantUtil.M_PARAMTER_NULL);
			messageResult.setMessage("会员ID参数为空！");
			this.out(response, messageResult);
			return;
		}
		
		String code = request.getParameter("code");
		code = code.toUpperCase();
		if(StringUtils.isBlank(code)){
			messageResult.setCode(ConstantUtil.M_PARAMTER_NULL);
			messageResult.setMessage("优惠券编码参数为空！");
			this.out(response, messageResult);
			return;
		}
		
		if(code.startsWith("HB")){
			// 兑换红包
			this.exchangeRedpacket(request, response);
			return;
		}else if(code.startsWith("YH")){
			// 兑换优惠券
			this.exchangeCoupon(request, response);	
			return;
		}else if (code.startsWith("Q")) {
			// 渠道码兑换优惠券
			this.exchangeCouponByChannelCode(request, response);
			return;
		}else{
			// 邀请码兑换优惠券
			this.exchangeCouponByInvitationCode(request, response);
			return;
		}
	}
	
	@RequestMapping("/exchageWithoutCoupon")
	public void exchageWithoutCoupon(HttpServletRequest request,HttpServletResponse response) {
		MessageResult messageResult = new MessageResult();
		try {
			String customerId = request.getParameter("customerId");
			String code = request.getParameter("code"); // 邀请码/渠道码
			
			if(isH5(request)){
				Customer customerx = getLoginUser(request);
				if(customerx == null){
					messageResult.setCode(ConstantUtil.M_EXCEPTION);
					messageResult.setMessage("用户未登录！");
					this.out(response, messageResult);
					return;
				} else {
					customerId = customerx.getId().toString();
				}
			}
			
			customerService.exchageWithoutCoupon(Integer.valueOf(customerId), code);
			
			messageResult.setCode(ConstantUtil.M_SUCCESS);
			messageResult.setMessage("成功");
			
			this.out(response, messageResult);
		} catch (Exception e) {
			e.printStackTrace();
			messageResult.setCode(ConstantUtil.M_SYSTEM_ERROR);
			messageResult.setMessage("服务器繁忙，请稍后重试！");
			Log4jTask.addLog("方法：exchageWithoutCoupon", System.currentTimeMillis(), Log4jTask.ERROR, this.getClass().getName(), e);
			this.out(response, messageResult);
		}
	}
	
	/**
	 * 邀请码兑换优惠券
	 * @param request
	 * @param response
	 * @return void
	 * @author 刘诗越
	 * @date 2017年9月8日
	 */
	private void exchangeCouponByInvitationCode(HttpServletRequest request,HttpServletResponse response) {
		MessageResult messageResult = new MessageResult();
		messageResult.setData(1);
		try {
			String customerId = request.getParameter("customerId");
			String invitationCode = request.getParameter("code"); // 邀请码
			
			if(isH5(request)){
				Customer customerx = getLoginUser(request);
				if(customerx == null){
					messageResult.setCode(ConstantUtil.M_EXCEPTION);
					messageResult.setMessage("用户未登录！");
					this.out(response, messageResult);
					return;
				} else {
					customerId = customerx.getId().toString();
				}
			}
			
			Customer customer = customerService.selectByPrimaryKey(Integer.valueOf(customerId));
			
			if (null == customer) {
				messageResult.setCode(ConstantUtil.M_EXCEPTION);
				messageResult.setMessage("用户不存在！");
				this.out(response, messageResult);
				return;
			}
			
			
			Map<CouponGiftModeEnum,MessageResult> ret = couponFactory.giftCoupon(CustomerBehaviorEnum.邀请码兑换, customer.getId(), invitationCode,null);
			messageResult = ret.get(CouponGiftModeEnum.邀请好友赠);
			if(messageResult != null){
				if(messageResult.getCode() == ConstantUtil.W_SUCCESS)
				messageResult.setCode(ConstantUtil.M_SUCCESS);
				messageResult.setData(1);
				out(response,messageResult);
			}
			
			messageResult.setCode(ConstantUtil.M_EXCEPTION);
			messageResult.setData(0);
			out(response,messageResult);
			
			
/*************************************原有邀请码兑换优惠券*****************************************************			
			
			
			// 根据邀请码获取用户id
			JSONObject obj = customerService.getCustomerIdByInvitationCode(invitationCode);
			
			// 该邀请码没有对应的用户
			if (null == obj) {
				messageResult.setCode(ConstantUtil.M_EXCEPTION);
				messageResult.setMessage("此邀请码不存在！");
				this.out(response, messageResult);
				return;
			}
			
			// 对方账户未审核通过
//			if (obj.getInteger("identityApprove") != 1) {
//				messageResult.setCode(ConstantUtil.M_EXCEPTION);
//				messageResult.setMessage("对方账户未通过认证，暂不可兑换优惠券！");
//				this.out(response, messageResult);
//				return;
//			}
			
			// 使用自己的邀请码
			if (Integer.valueOf(customerId).equals(obj.getInteger("id"))) {
				messageResult.setCode(ConstantUtil.M_EXCEPTION);
				messageResult.setMessage("不可使用您自己的邀请码！");
				this.out(response, messageResult);
				return;
			}
			
			// 查询该用户有没有使用别人的邀请码兑换过优惠券
			int count = customerService.selectUseInvitationCodeGetCounponCount(Integer.valueOf(customerId));
			if (count > 0 || StringUtils.isNoneBlank(customer.getRecommendcode())) {
				messageResult.setCode(ConstantUtil.M_EXCEPTION);
				messageResult.setMessage("您已使用别人的邀请码或渠道码兑换过，不可再次兑换！");
				this.out(response, messageResult);
				return;
			}
			
			int result = 0;
			boolean isSendRecommend = false; // 推荐人是否发送过礼券;
			// 如果兑换者未审核通过,则先给本人发放优惠券,等认证通过之后,再给推荐人发放优惠券;
			if (customer.getIdentityapprove() != 1) {
				result = customerService.sendCouponToSomeone(Integer.valueOf(customerId), obj.getInteger("id"));
			} else {
				// 否则给兑换的双方都增加优惠券
				result = customerService.sendCouponToEachone(Integer.valueOf(customerId), obj.getInteger("id"));
				isSendRecommend = true;
			}
			
			if (result == 0) {
				messageResult.setCode(ConstantUtil.M_SUCCESS);
				messageResult.setMessage("暂无优惠券，请耐心等待！");
				messageResult.setData(0);
				this.out(response, messageResult);
			} else {
				// 新版没有注册页面了,推荐人在使用邀请码兑换优惠券时添加;
				Customer cus = new Customer();
				cus.setId(Integer.valueOf(customerId));
				cus.setRecommendcode(invitationCode);
				cus.setIsSendInviteCoupon(1);
				if (isSendRecommend){
				    cus.setIsSendRecommendCoupon(1);
				}
				customerService.updaeCustomer(cus);
				
				messageResult.setCode(ConstantUtil.M_SUCCESS);
				messageResult.setMessage("兑换成功！");
				messageResult.setData(1);
				this.out(response, messageResult);
			}
			
			
******************************************************************************************************************/				
			
		} catch (Exception e) {
			e.printStackTrace();
			messageResult.setCode(ConstantUtil.M_SYSTEM_ERROR);
			messageResult.setMessage("服务器繁忙，请稍后重试！");
			Log4jTask.addLog("邀请码兑换优惠券失败！", System.currentTimeMillis(), Log4jTask.ERROR, this.getClass().getName(), e);
			this.out(response, messageResult);
		}
	}
	
	private void exchangeCouponByChannelCode(HttpServletRequest request,HttpServletResponse response) {
		MessageResult messageResult = new MessageResult();
		messageResult.setData(1);
		try {
			String customerId = request.getParameter("customerId");
			String channelCode = request.getParameter("code"); // 渠道码
			
			if(isH5(request)){
				Customer customerx = getLoginUser(request);
				if(customerx == null){
					messageResult.setCode(ConstantUtil.M_EXCEPTION);
					messageResult.setMessage("用户未登录！");
					this.out(response, messageResult);
					return;
				} else {
					customerId = customerx.getId().toString();
				}
			}
			
			CustomerBehaviorEnum behavior = CustomerBehaviorEnum.推广码兑换;
			Channel channel = channelService.getChannelByChannelCode(channelCode);
			PromotionPerson person = promotionPersonService.selectProPersonByChanneCode(channelCode);
			if(channel==null&&person==null){
				messageResult.setCode(ConstantUtil.M_EXCEPTION);
				messageResult.setMessage("此码无效");
				messageResult.setData(0);
				this.out(response, messageResult);
				return;
			}
			
			if(channel != null) behavior = CustomerBehaviorEnum.渠道码兑换;
				
			Map<CouponGiftModeEnum,MessageResult> result = couponFactory.giftCoupon(behavior, Integer.valueOf(customerId), channelCode,null);
			if(channel != null)
				messageResult = result.get(CouponGiftModeEnum.渠道);
			else
				messageResult = result.get(CouponGiftModeEnum.推广);
			
			if((boolean)messageResult.getData()){
				messageResult.setCode(ConstantUtil.M_SUCCESS);
				messageResult.setData(1);
			}else{
				messageResult.setCode(ConstantUtil.M_EXCEPTION);
				messageResult.setData(0);
			}
			out(response,messageResult);
/****************************************原来渠道码兑换优惠券代码*****************************************************
			
			// 查询此渠道码有无对应的推广人员(未删除的,删除的推广人员的渠道码失效)
			PromotionPerson person = promotionPersonService.selectProPersonByChanneCode(channelCode);
			if (null == person) {
				messageResult.setCode(ConstantUtil.M_EXCEPTION);
				messageResult.setMessage("此渠道码无效！");
				this.out(response, messageResult);
				return;
			}
			
			// 查询该用户有没有使用别人的邀请码兑换过优惠券
			int count = customerService.selectUseInvitationCodeGetCounponCount(Integer.valueOf(customerId));
			if (count > 0) {
				messageResult.setCode(ConstantUtil.M_EXCEPTION);
				messageResult.setMessage("您已使用渠道码或邀请码兑换过，不可再次兑换！");
				this.out(response, messageResult);
				return;
			}
			
			int result = customerService.sendCouponUseChannelCode(Integer.valueOf(customerId), person.getId(), person.getBusinessId());
			
			if (result == 0) {
				messageResult.setCode(ConstantUtil.M_SUCCESS);
				messageResult.setMessage("暂无优惠券，请耐心等待！");
				messageResult.setData(0);
				this.out(response, messageResult);
			} else {
				// 新版没有注册页面了,推荐人在使用邀请码兑换优惠券时添加;
				Customer cus = new Customer();
				cus.setId(Integer.valueOf(customerId));
				cus.setRecommendcode(channelCode);
				cus.setIsSendInviteCoupon(1);
				customerService.updaeCustomer(cus);
				
				messageResult.setCode(ConstantUtil.M_SUCCESS);
				messageResult.setMessage("兑换成功！");
				messageResult.setData(1);
				this.out(response, messageResult);
			}
********************************************************************************************************************************/
			
			
		} catch (Exception e) {
			e.printStackTrace();
			messageResult.setCode(ConstantUtil.M_SYSTEM_ERROR);
			messageResult.setMessage("服务器繁忙，请稍后重试！");
			Log4jTask.addLog("渠道码兑换优惠券失败！", System.currentTimeMillis(), Log4jTask.ERROR, this.getClass().getName(), e);
			this.out(response, messageResult);
		}
	}
	
	/**
	 * 兑换优惠券
	 * @param request
	 * @param response
	 */
	private void exchangeCoupon(HttpServletRequest request,HttpServletResponse response){
		MessageResult messageResult = new MessageResult();
		messageResult.setData(1);
		String customerId = request.getParameter("customerId");
		String code = request.getParameter("code");
		if(isH5(request)){
			Customer customerx = getLoginUser(request);
			if(customerx == null){
				messageResult.setCode(ConstantUtil.M_EXCEPTION);
				messageResult.setMessage("用户未登录！");
				this.out(response, messageResult);
				return;
			} else {
				customerId = customerx.getId().toString();
			}
		}
		
		//兑换优惠券
		HashMap<String,Object> params = new HashMap<String,Object> ();
		params.put("couponCode", code);
		//通过优惠券编码查询优惠券
		List<Coupon> list = this.couponService.list(params);
		
		if(list.size() <= 0){
			messageResult.setCode(ConstantUtil.M_EXCEPTION);
			messageResult.setMessage("没有找到该兑换券！");
			this.out(response, messageResult);
			return;
		}
		
		Coupon temp = list.get(0);
		//未找到该兑换券
		if(null == temp){
			messageResult.setCode(ConstantUtil.M_EXCEPTION);
			messageResult.setMessage("没有找到该兑换券！");
			this.out(response, messageResult);
			return;
		}
		
		//已被兑换
		if(null !=temp && null != temp.getCustomerId() && 0 != temp.getCustomerId()){
			messageResult.setCode(ConstantUtil.M_EXCEPTION);
			messageResult.setMessage("优惠券已兑换！");
			this.out(response, messageResult);
			return;
		}
		//已使用
		if(null != temp.getUseStatus() && 1 == temp.getUseStatus()){
			messageResult.setCode(ConstantUtil.M_EXCEPTION);
			messageResult.setMessage("优惠券已使用！");
			this.out(response, messageResult);
			return;
		}
		//已过期
		if(null !=temp.getEndDate() && System.currentTimeMillis() > temp.getEndDate().getTime()){
			messageResult.setCode(ConstantUtil.M_EXCEPTION);
			messageResult.setMessage("优惠券已过期！");
			this.out(response, messageResult);
			return;
		}
		//已禁用
		if(null !=temp.getIsDisable() && 0==temp.getIsDisable()){
			messageResult.setCode(ConstantUtil.M_EXCEPTION);
			messageResult.setMessage("优惠券已禁用！");
			this.out(response, messageResult);
			return;
		}
		//已删除
		if(null !=temp.getIsDelete() && 1==temp.getIsDelete()){
			messageResult.setCode(ConstantUtil.M_EXCEPTION);
			messageResult.setMessage("优惠券已删除！");
			this.out(response, messageResult);
			return;
		}
		Integer exchangeResult = 0;
		//成功兑换
		//temp.setCustomerId(Integer.valueOf(customerId));
		Coupon coupon = new Coupon();
		coupon.setId(temp.getId());
		coupon.setCustomerId(Integer.valueOf(customerId));
		exchangeResult = this.couponService.update(coupon);
		if(exchangeResult > 0){
			messageResult.setCode(ConstantUtil.M_SUCCESS);
			messageResult.setMessage("兑换成功！");
			this.out(response, messageResult);
			return;
		}
	
	}
	
	/**
	 * 兑换红包
	 * @param request
	 * @param response
	 */
	private void exchangeRedpacket(HttpServletRequest request,HttpServletResponse response){
		MessageResult messageResult = new MessageResult();
		messageResult.setData(1);
		String customerId = request.getParameter("customerId");
		String code = request.getParameter("code");
	
		if(isH5(request)){
			Customer customerx = getLoginUser(request);
			if(customerx == null){
				messageResult.setCode(ConstantUtil.M_EXCEPTION);
				messageResult.setMessage("用户未登录！");
				this.out(response, messageResult);
				return;
			} else {
				customerId = customerx.getId().toString();
			}
		}
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		
		params.put("packetNum", code);
		//通过红包编码查询红包
		List<Redpacket> redpacketList = this.redpacketService.selectByParams(params);
		//未找到该红包
		if(null == redpacketList || redpacketList.size()< 1){
			messageResult.setCode(ConstantUtil.M_EXCEPTION);
			messageResult.setMessage("没有找到该红包！");
			this.out(response, messageResult);
			return;
		}
		Redpacket temp = redpacketList.get(0);
		//通过红包编码查询活动
		params.put("a_id", temp.getActivityid());
		Activity activity = this.activityService.selectByParams(params);
		
		//已兑换过该活动红包
		HashMap<String,Object> params2 = new HashMap<String,Object>();
		params2.put("usingUserId", customerId);
		params2.put("activityID", temp.getActivityid());
		
		List<Redpacket> selectByParams = this.redpacketService.selectByParams(params2);
		if(null != selectByParams && selectByParams.size()>0){
			messageResult.setCode(ConstantUtil.M_EXCEPTION);
			messageResult.setMessage("您已兑换过该红包！");
			this.out(response, messageResult);
			return;
		}
		
		
		//活动禁用
		//活动发布
		
		//判断活动是否有限制
		Customer r_customer = this.customerService.selectByPrimaryKey(Integer.valueOf(customerId));
		
		if(null == r_customer){
			messageResult.setCode(ConstantUtil.M_EXCEPTION);
			messageResult.setMessage("没有此用户！");
			this.out(response, messageResult);
			return;
		}
		
		long a_start = activity.getStartdate().getTime();
		long a_end = activity.getEnddate().getTime();
		long r_create = r_customer.getCreatedate().getTime();
		if(!(a_start<=r_create)&&(a_end>=r_create) && activity.getExchangelimit().intValue() == 1){
			messageResult.setCode(ConstantUtil.M_EXCEPTION);
			messageResult.setMessage("仅限活动期内注册用户领取！");
			this.out(response, messageResult);
			return;
		}
		
		
		//已被兑换
		if(null !=temp && null != temp.getUsinguserid() && 0 != temp.getUsinguserid()){
			messageResult.setCode(ConstantUtil.M_EXCEPTION);
			messageResult.setMessage("红包已兑换！");
			this.out(response, messageResult);
			return;
		}
		
		//已过期
		if(null !=temp.getEnddate() && System.currentTimeMillis() > temp.getEnddate().getTime()){
			messageResult.setCode(ConstantUtil.M_EXCEPTION);
			messageResult.setMessage("红包已过期！");
			this.out(response, messageResult);
			return;
		}
		//已禁用
		if(null !=temp.getIsdisable() && 0==temp.getIsdisable()){
			messageResult.setCode(ConstantUtil.M_EXCEPTION);
			messageResult.setMessage("红包已禁用！");
			this.out(response, messageResult);
			return;
		}
		//已删除
		if(null !=temp.getIsdelete() && 1==temp.getIsdelete()){
			messageResult.setCode(ConstantUtil.M_EXCEPTION);
			messageResult.setMessage("红包已删除！");
			this.out(response, messageResult);
			return;
		}
		
		
		Redpacket redpacket = new Redpacket();
		redpacket.setPacketnum(code);
		redpacket.setUsinguserid(Integer.valueOf(customerId));
		redpacket.setUsingdate(new Date());
		redpacket.setActivityid(activity.getId());
		//兑换
		List<Coupon> list = this.redpacketService.exchange(redpacket);
		if(list.size() > 0){
			messageResult.setCode(ConstantUtil.M_SUCCESS);
			messageResult.setMessage("兑换成功！");
			this.out(response, messageResult);
			return;
		}
		else{
			messageResult.setCode(ConstantUtil.M_DATA_EXPIRE);
			messageResult.setMessage("兑换失败！");
			this.out(response, messageResult);
			return;
		}
	}

}
