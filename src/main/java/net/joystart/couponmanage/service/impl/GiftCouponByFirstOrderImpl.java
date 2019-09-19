package net.joystart.couponmanage.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.joystart.common.util.ConstantUtil;
import net.joystart.couponmanage.entity.CustomerCouponNew;
import net.joystart.couponmanage.entity.GiftCouponArg;
import net.joystart.couponmanage.entity.giftconfig.GiftConfig4FirstOrder;
import net.joystart.couponmanage.enums.CouponGiftModeEnum;
import net.joystart.customer.remote.service.ICustomerRemoteService;
import net.joystart.order.entity.Order;
import net.joystart.order.enums.OrderStatus;
import net.joystart.order.remote.service.IOrderRemoteService;

@Service
public class GiftCouponByFirstOrderImpl extends AbstractGiftCouponService {

	@Autowired
	private ICustomerRemoteService customerRemoteService;
	
	@Autowired
	private IOrderRemoteService orderService;
	
	@Override
	protected boolean canGiftCoupon(GiftCouponArg arg) throws Exception {
		
//		boolean isFirst = orderService.selectCountByCustomerId(arg.getTargetCustomerId()) == 1;
//		if(!isFirst){
//			logger.debug("首次用车结单赠规则:用户{}不是首次用车不能赠送优惠券",arg.getTargetCustomerId());
//			result.setCode(ConstantUtil.W_EXCEPTION);
//			result.setMessage(result.getMessage() + "您不是首次用车不能赠送优惠券;");
//			return false;
//		}
		
		GiftConfig4FirstOrder giftConfig = svcGiftConfig.selectByEnumCode(CouponGiftModeEnum.首次用车结单赠, GiftConfig4FirstOrder.class);
		if(giftConfig.getIsValidate() == 0){
			logger.debug("首次用车结单赠规则:已禁用不能赠送用户{}优惠券",arg.getTargetCustomerId());
			result.setCode(ConstantUtil.W_EXCEPTION);
			result.setMessage("暂无优惠券");
			return false;
		}
		

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("customerId", arg.getTargetCustomerId());
		params.put("pageSize", 10);
		params.put("pageNumber", 0);
		List<Order> lstOrder = orderService.getOrderList(params);
		if(lstOrder == null || lstOrder.size() != 1){
			logger.debug("首次用车结单赠规则:用户{}不是首单",arg.getTargetCustomerId());
			result.setCode(ConstantUtil.W_EXCEPTION);
			result.setMessage("暂无优惠券！");
			return false;
		}
		
		Order order = lstOrder.get(0);
		if(giftConfig.getOrderStatus() == OrderStatus.COMPLETED.getValue()){
			if(order.getOrderstatus() != OrderStatus.COMPLETED.getValue()){
				logger.debug("首次用车结单赠规则:用户{}尚未支付不能获取优惠券",arg.getTargetCustomerId());
				result.setCode(ConstantUtil.W_EXCEPTION);
				result.setMessage("暂无优惠券");
				return false;
			}
		}else if(giftConfig.getOrderStatus() == OrderStatus.RETURNEDCAR.getValue()){
			if(order.getOrderstatus() != OrderStatus.RETURNEDCAR.getValue()){
				logger.debug("首次用车结单赠规则:用户{}尚未还车不能获取优惠券",arg.getTargetCustomerId());
				result.setCode(ConstantUtil.W_EXCEPTION);
				result.setMessage("暂无优惠券");
				return false;
			}
		}
		
		if(giftConfig.getCheckFirstOrderMileage()){
			if((order.getReturnMiles() - order.getTakeMiles()) < giftConfig.getFirstOrderMileage()){
				logger.debug("首次用车结单赠规则:用户{}行驶里程小于{}公里，不能赠送优惠券",arg.getTargetCustomerId(),giftConfig.getFirstOrderMileage());
				result.setCode(ConstantUtil.W_EXCEPTION);
				result.setMessage("用户行驶里程小于{}"+giftConfig.getFirstOrderMileage()+"公里不能赠送优惠券;");
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
