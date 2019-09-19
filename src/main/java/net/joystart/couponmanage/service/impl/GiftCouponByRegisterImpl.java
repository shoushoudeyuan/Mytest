package net.joystart.couponmanage.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.joystart.common.util.ConstantUtil;
import net.joystart.couponmanage.entity.CustomerCouponNew;
import net.joystart.couponmanage.entity.GiftCouponArg;
import net.joystart.couponmanage.entity.giftconfig.GiftConfig4UserRegister;
import net.joystart.couponmanage.enums.CouponGiftModeEnum;
import net.joystart.customer.entity.Customer;
import net.joystart.customer.remote.service.ICustomerRemoteService;
import net.joystart.order.entity.ActiveAccountRecord;

@Service
public class GiftCouponByRegisterImpl extends AbstractGiftCouponService{
	
	@Autowired
	private ICustomerRemoteService customerRemoteService;
	
	@Override
	protected boolean canGiftCoupon(GiftCouponArg arg) throws Exception {
		Customer customer = this.customerRemoteService.selectByPrimaryKey(arg.getTargetCustomerId());
		if(customer.getIsSendCoupon() == 1){
			logger.debug("注册用户赠:{}用户已经领取了注册用户赠优惠券",arg.getTargetCustomerId());
			result.setCode(ConstantUtil.W_EXCEPTION);
			result.setMessage("已经领取了优惠券");
			return false;
		}
		
		GiftConfig4UserRegister giftConfig = svcGiftConfig.selectByEnumCode(CouponGiftModeEnum.注册用户赠, GiftConfig4UserRegister.class);
		if(!giftConfig.getUserRegistered() && !giftConfig.getUserIdentified() && !giftConfig.getPayDeposit()){
			logger.debug("注册用户赠:规则未配置",arg.getTargetCustomerId());
			result.setCode(ConstantUtil.W_EXCEPTION);
			result.setMessage("暂无优惠券");
			return false;
		}
		
		if(giftConfig.getIsValidate() == 0){
			logger.debug("注册用户赠:优惠券规则禁用{}用户不能赠送优惠券",arg.getTargetCustomerId());
			result.setCode(ConstantUtil.W_EXCEPTION);
			result.setMessage("注册用户赠规则已禁用");
			return false;
		}
		
		if(giftConfig.getUserIdentified()){
			if(customer.getIdentityapprove() == 0){
				logger.debug("注册用户赠:{}用户未认证不能赠送优惠券",arg.getTargetCustomerId());
				result.setCode(ConstantUtil.W_EXCEPTION);
				result.setMessage("用户未认证不能赠送优惠券");
				return false;
			}
		}
		
		if(giftConfig.getPayDeposit()){
			/*Map<String, Object> params = new HashMap<String, Object>();
			params.put("customerid", arg.getTargetCustomerId());
			ActiveAccountRecord accout = customerRemoteService.memberDepositActive(params);
			if(null != accout) {
				if (accout.getState()==1) {
					logger.info("{}用户正在申请退保证金不能赠送优惠券",arg.getTargetCustomerId());
					result.setCode(ConstantUtil.W_EXCEPTION);
					result.setMessage("用户正在申请退保证金不能赠送优惠券");
					return false;
				}
				if(accout.getState()==2 ) {
					logger.info("{}用户已退保证金不能赠送优惠券",arg.getTargetCustomerId());
					result.setCode(ConstantUtil.W_EXCEPTION);
					result.setMessage("用户已退保证金不能赠送优惠券");
					return true;
				}
			}*/
			
			if(customer.getMemberType() == 0){
				logger.debug("注册用户赠:{}用户未缴纳保证金不能赠送优惠券",arg.getTargetCustomerId());
				result.setCode(ConstantUtil.W_EXCEPTION);
				result.setMessage("用户未缴纳保证金不能赠送优惠券");
				return false;
			}
		}
		
		return true;
	}

	@Override
	protected void endGiftCoupon(GiftCouponArg arg,List<CustomerCouponNew> lstCoupon,int giftCount) {
		if(giftCount <= 0){
			return;
		}
			
		Customer customer = new Customer();
		customer.setId(arg.getTargetCustomerId());
		customer.setIsSendCoupon(1);
		customerRemoteService.updaeCustomer(customer);
	}
	
	
}
