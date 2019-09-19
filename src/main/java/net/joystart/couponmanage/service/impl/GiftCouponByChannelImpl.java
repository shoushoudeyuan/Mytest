package net.joystart.couponmanage.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.joystart.channel.entity.Channel;
import net.joystart.channel.service.IChannelService;
import net.joystart.common.util.ConstantUtil;
import net.joystart.couponmanage.entity.CustomerCouponNew;
import net.joystart.couponmanage.entity.GiftCouponArg;
import net.joystart.customer.entity.Customer;
import net.joystart.customer.remote.service.ICustomerRemoteService;

@Service
public class GiftCouponByChannelImpl extends AbstractGiftCouponService{

	@Resource
	private IChannelService channelService;
	
	@Autowired
	private ICustomerRemoteService customerRemoteService;
	
	@Override
	protected boolean canGiftCoupon(GiftCouponArg arg) throws Exception {
		// 查询此渠道码有无对应的推广人员(未删除的,删除的推广人员的渠道码失效)
		Channel channel = channelService.getChannelByChannelCode(arg.getExchangeCode());
		if (null == channel) {
			logger.debug("{}兑换的渠道码{}无效",arg.getTargetCustomerId(),arg.getExchangeCode());
			result.setCode(ConstantUtil.W_EXCEPTION);
			result.setMessage("该渠道码输入错误");
			return false;
		}

		if(channel.getStatus() == 0){
			logger.debug("{}兑换的渠道码{}已关闭",arg.getTargetCustomerId(),arg.getExchangeCode());
			result.setCode(ConstantUtil.W_EXCEPTION);
			result.setMessage("该渠道码不存在");
			return false;
		}
		
		Date dt = new Date();
		if(dt.getTime() >= channel.getEndDate().getTime() || dt.getTime() < channel.getStartDate().getTime()){
			logger.debug("{}兑换的渠道码{}不在有效期内",arg.getTargetCustomerId(),arg.getExchangeCode());
			result.setCode(ConstantUtil.W_EXCEPTION);
			result.setMessage("渠道码已过期");
			return false;
		}
		
		// 查询该用户有没有使用别人的邀请码兑换过优惠券
		boolean isInvited = customerRemoteService.selectUseInvitationCodeGetCounponCount(arg.getTargetCustomerId()) > 0;
		if (isInvited) {
			logger.debug("{}已使用推广码或邀请码兑换过",arg.getTargetCustomerId());
			result.setCode(ConstantUtil.W_EXCEPTION);
			result.setMessage("兑换失败，已通过其他方式进行过兑换");
			return false;
		}
		
		//保存渠道用户关系
		if(!isInvited){
			Map<String, Object> params = new HashMap<String, Object>(4);
			params.put("createDate", new Date());
			params.put("useId", arg.getTargetCustomerId());
			params.put("usedId", channel.getId());
			params.put("type", 2);
			customerRemoteService.insertCustomerInvite(params);
		}
		
		if(channel.getCouponPackageId() == null){
			logger.debug("{}兑换的渠道码{}没有配置优惠券",arg.getTargetCustomerId(),arg.getExchangeCode());
			result.setCode(ConstantUtil.W_EXCEPTION);
			result.setMessage("该渠道码无优惠券");
			return false;
		}
		
		arg.setSourceId(channel.getCouponPackageId());
		return true;
	}

	@Override
	protected void endGiftCoupon(GiftCouponArg arg, List<CustomerCouponNew> lstCoupon, int giftCount) {
		if(lstCoupon != null && lstCoupon.size() > 0 && giftCount <= 0){
			result.setCode(ConstantUtil.W_EXCEPTION);
			result.setData(false);
			return;
		}
		
		Customer customer = new Customer();
		customer.setId(arg.getTargetCustomerId());
		customer.setRecommendcode(arg.getExchangeCode());
		customer.setIsSendInviteCoupon(1);
		customerRemoteService.updaeCustomer(customer);
	}

}
