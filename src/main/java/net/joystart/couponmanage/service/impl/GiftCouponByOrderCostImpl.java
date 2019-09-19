package net.joystart.couponmanage.service.impl;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.citrus.util.StringUtil;

import net.joystart.common.util.ConstantUtil;
import net.joystart.couponmanage.entity.CustomerCouponNew;
import net.joystart.couponmanage.entity.GiftCouponArg;
import net.joystart.couponmanage.entity.giftconfig.GiftConfig4OrderCost;
import net.joystart.couponmanage.enums.CouponGiftModeEnum;
import net.joystart.order.entity.Order;
import net.joystart.order.enums.OrderStatus;
import net.joystart.order.remote.service.IOrderRemoteService;

@Service
public class GiftCouponByOrderCostImpl extends AbstractGiftCouponService {

	@Autowired
	private IOrderRemoteService orderService;
	
	@Override
	protected boolean canGiftCoupon(GiftCouponArg arg) throws Exception {
		
		GiftConfig4OrderCost giftConfig = svcGiftConfig.selectByEnumCode(CouponGiftModeEnum.订单满额赠, GiftConfig4OrderCost.class);
		if(giftConfig.getIsValidate() == 0){
			logger.debug("订单满额赠:规则已禁用用户{}",arg.getTargetCustomerId());
			result.setCode(ConstantUtil.W_EXCEPTION);
			result.setMessage("暂无优惠券！");
			return false;
		}
		
		if(!giftConfig.getGiftByPaymentOrderCost()){
			logger.debug("订单满额赠:未配置订单金额用户{}",arg.getTargetCustomerId());
			result.setCode(ConstantUtil.W_EXCEPTION);
			result.setMessage("暂无优惠券！");
			return false;
		}
		
		Order order = orderService.selectByPrimaryKey(arg.getOrderId());
		if(order.getOrderstatus() != OrderStatus.COMPLETED.getValue()){
			logger.debug("订单满额赠:用户{}的订单未支付{}",arg.getTargetCustomerId(),order.getId());
			result.setCode(ConstantUtil.W_EXCEPTION);
			result.setMessage("订单未支付！");
			return false;
		}
		
		BigDecimal configCost = new BigDecimal(giftConfig.getOrderCost().toString());
		//按应付金额
		if(giftConfig.getCostMode() == 1){
			if(order.getOrdercost().compareTo(configCost) == -1){
				logger.debug("订单满额赠:用户{}订单应付金额不满足赠送规则{}",arg.getTargetCustomerId(),order.getOrdercost());
				result.setCode(ConstantUtil.W_EXCEPTION);
				result.setMessage("订单应付金额不满足赠送规则");
				return false;
			}
		}
		
		//按实付金额
		if(giftConfig.getCostMode() == 2){
			if(order.getActualpaymentcost().compareTo(configCost) == -1){
				logger.debug("订单满额赠:用户{}订单实付金额不满足赠送规则{}",arg.getTargetCustomerId(),order.getActualpaymentcost());
				result.setCode(ConstantUtil.W_EXCEPTION);
				result.setMessage("不赠送优惠券！");
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
