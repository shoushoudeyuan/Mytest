package net.joystart.couponmanage.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.joystart.common.util.ConstantUtil;
import net.joystart.common.util.date.DateDiffUtil;
import net.joystart.couponmanage.entity.CustomerCouponNew;
import net.joystart.couponmanage.entity.GiftCouponArg;
import net.joystart.couponmanage.entity.giftconfig.GiftConfig4RegisterEntMember;
import net.joystart.couponmanage.enums.CouponGiftModeEnum;
import net.joystart.customer.entity.Customer;
import net.joystart.customer.remote.service.ICustomerRemoteService;
import net.joystart.enterprise.entity.EmployeeDeparment;
import net.joystart.enterprise.remote.service.ICompanyRemoteService;
import net.joystart.order.entity.Order;
import net.joystart.order.enums.OrderStatus;
import net.joystart.order.remote.service.IOrderRemoteService;

@Service
public class GiftCouponByFirstEntMemberImple extends AbstractGiftCouponService {

	@Autowired
	private ICustomerRemoteService customerRemoteService;
	
	@Autowired
	private ICompanyRemoteService companyRemoteService;
	
	@Autowired
	private IOrderRemoteService orderService;
	
	@Override
	protected boolean canGiftCoupon(GiftCouponArg arg) throws Exception {
		GiftConfig4RegisterEntMember giftConfig = svcGiftConfig.selectByEnumCode(CouponGiftModeEnum.首次成为企业用户赠, GiftConfig4RegisterEntMember.class);
		if(giftConfig.getIsValidate() == 0){
			logger.debug("首次成为企业会员赠:规则已禁用");
			result.setCode(ConstantUtil.W_EXCEPTION);
			result.setMessage("暂无优惠券！");
			return false;
		}
		
		if(!giftConfig.getRegisterEntMember() && !giftConfig.getFirstOrderAndPayment()){
			logger.debug("首次成为企业会员赠:规则未配置",arg.getTargetCustomerId());
			result.setCode(ConstantUtil.W_EXCEPTION);
			result.setMessage("暂无优惠券");
			return false;
		}
		
		Customer customer = customerRemoteService.selectByPrimaryKey(arg.getTargetCustomerId());	
		if(customer.getIsCompany() == 0){
			logger.debug("首次成为企业会员赠:用户{}不是企业会员",arg.getTargetCustomerId());
			result.setCode(ConstantUtil.W_EXCEPTION);
			result.setMessage("您还不是企业会员不能赠送优惠券！");
			return false;
		}
		
		EmployeeDeparment ed = companyRemoteService.getEmployeeDeparment(arg.getTargetCustomerId());
		Date firstDeleteDate = companyRemoteService.fistDeleteRegisterMember(arg.getTargetCustomerId());	
		Date today = new Date();
		if(giftConfig.getRegisterEntMember() && !giftConfig.getFirstOrderAndPayment()){
			if(firstDeleteDate != null || ed == null || ed.getCreateDate() == null || ed.getCreateDate().getTime() < DateDiffUtil.getMinutesAgoDate(today, -10).getTime()){
				logger.debug("首次成为企业会员赠:用户{}不是首次成为企业会员",arg.getTargetCustomerId());
				result.setCode(ConstantUtil.W_EXCEPTION);
				result.setMessage("暂无优惠券！");
				return false;
			}
		}
		
		if(giftConfig.getFirstOrderAndPayment()){
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("customerId", arg.getTargetCustomerId());
			params.put("pageSize", 10);
			params.put("pageNumber", 0);
			params.put("createDate", firstDeleteDate);
			List<Order> lstOrder = orderService.getOrderList(params);
			if(lstOrder == null || lstOrder.size() != 1 ){
				logger.debug("首次成为企业会员赠:用户{}不是首单",arg.getTargetCustomerId());
				result.setCode(ConstantUtil.W_EXCEPTION);
				result.setMessage("暂无优惠券！");
				return false;
			}
			
			Order order = lstOrder.get(0);
			if(order.getOrderstatus() != OrderStatus.COMPLETED.getValue() || 
					(order.getReturnMiles() - order.getTakeMiles()) < giftConfig.getFirstOrderMileage()){
				logger.debug("首次成为企业会员赠:用户{}行驶里程小于{}公里不能赠送优惠券",arg.getTargetCustomerId(),giftConfig.getFirstOrderMileage());
				result.setCode(ConstantUtil.W_EXCEPTION);
				result.setMessage("暂无赠送优惠券！");
				return false;
			}
			
		}
		
		return true;
	}

	@Override
	protected void endGiftCoupon(GiftCouponArg arg, List<CustomerCouponNew> lstCoupon, int giftCount) {
		if(giftCount <= 0){
			result.setCode(ConstantUtil.W_EXCEPTION);
			result.setData(false);
			return ;
		}

	}

}
