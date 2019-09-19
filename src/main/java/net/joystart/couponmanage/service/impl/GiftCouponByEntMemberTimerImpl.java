package net.joystart.couponmanage.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.joystart.common.util.ConstantUtil;
import net.joystart.common.util.date.UtilTimeFormatter;
import net.joystart.couponmanage.entity.CustomerCouponNew;
import net.joystart.couponmanage.entity.GiftCouponArg;
import net.joystart.couponmanage.entity.giftconfig.AutoGiftConfig4EntMember;
import net.joystart.couponmanage.enums.CouponGiftModeEnum;
import net.joystart.customer.entity.Customer;
import net.joystart.enterprise.remote.service.ICompanyRemoteService;

@Service
public class GiftCouponByEntMemberTimerImpl extends AbstractGiftCouponService {

	@Autowired
	private ICompanyRemoteService companyRemoteService;

	@Override
	protected boolean canGiftCoupon(GiftCouponArg arg) throws Exception {
		AutoGiftConfig4EntMember giftConfig = svcGiftConfig.selectByEnumCode(CouponGiftModeEnum.企业会员按时间赠, AutoGiftConfig4EntMember.class);
		if(giftConfig.getIsValidate() == 0){
			logger.debug("企业会员按时间赠:规则已禁用");
			result.setCode(ConstantUtil.W_EXCEPTION);
			result.setMessage("暂无优惠券！");
			return false;
		}
		
		List<Integer> lstCompanyId = giftConfig.getCompanyId();
		if(lstCompanyId == null || lstCompanyId.size() == 0){
			logger.debug("企业会员按时间赠:未配置发送公司");
			result.setCode(ConstantUtil.W_EXCEPTION);
			result.setMessage("暂无优惠券！");
			return false;
		}
		
		List<String> lstSendDate = giftConfig.getAutoSendDate();
		if(lstSendDate == null || lstSendDate.size() == 0){
			logger.debug("企业会员按时间赠:未配置发送时间");
			result.setCode(ConstantUtil.W_EXCEPTION);
			result.setMessage("暂无优惠券！");
			return false;
		}
		
		if(!lstCompanyId.contains(arg.getTargetCustomerId())){
			logger.debug("企业会员按时间赠:公司{}不在推送列表中",arg.getTargetCustomerId());
			result.setCode(ConstantUtil.W_EXCEPTION);
			result.setMessage("暂无优惠券！");
			return false;
		}
		
		String currentDate = UtilTimeFormatter.getTimeToYMD(new Date());
		if(!lstSendDate.contains(currentDate)){
			logger.debug("企业会员按时间赠:今天不发送优惠券",currentDate);
			result.setCode(ConstantUtil.W_EXCEPTION);
			result.setMessage("暂无优惠券！");
			return false;
		}
		
		return true;
	}
	
	@Override
	protected List<CustomerCouponNew> beginGiftCoupon(GiftCouponArg arg,Integer packageId){
		Map<String, Object> params = new HashMap<>();
		List<Customer> lstCustomer = null;
		List<CustomerCouponNew> lstNew = new ArrayList<>();
		Integer startIndex = 0;
		Integer pageSize = 5;
		
		do{
			startIndex += 1;
			params.put("companyid", arg.getTargetCustomerId());
			params.put("startIndex", (startIndex - 1) * pageSize);
			params.put("pageSize", pageSize);
			lstCustomer = companyRemoteService.customerDep(params);
			for(Customer customer : lstCustomer){
				arg.setTargetCustomerId(customer.getId());
				lstNew.addAll(super.beginGiftCoupon(arg, arg.getSourceId()));
			}
		}while(lstCustomer != null && lstCustomer.size() > 0);
		
		return lstNew;
	}

	@Override
	protected void endGiftCoupon(GiftCouponArg arg, List<CustomerCouponNew> lstCoupon, int giftCount) {
		// TODO Auto-generated method stub

	}

}
