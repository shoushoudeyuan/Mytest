package net.joystart.couponmanage.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.joystart.common.util.ConstantUtil;
import net.joystart.couponmanage.dao.CouponExchangeCodeMapper;
import net.joystart.couponmanage.entity.CouponExchangeCode;
import net.joystart.couponmanage.entity.CustomerCouponNew;
import net.joystart.couponmanage.entity.GiftCouponArg;
import net.joystart.couponmanage.service.ICouponExchangeCodeService;

@Service
public class GiftCouponByExchangeActivityImpl extends AbstractGiftCouponService {

	@Resource
	private CouponExchangeCodeMapper couponExchangeCodeMapper;
	
	@Autowired
	private ICouponExchangeCodeService couponExchangeCodeService;
	
	private CouponExchangeCode couponExCode;
	
	@Override
	protected boolean canGiftCoupon(GiftCouponArg arg) throws Exception {
		//兑换优惠券
		HashMap<String,Object> params = new HashMap<String,Object> ();
		params.put("code", arg.getExchangeCode());
		//通过优惠券编码查询优惠券
		couponExCode = couponExchangeCodeMapper.getValideCouponExchangeCodeByCode(params);
		
		if(couponExCode == null){
			result.setCode(ConstantUtil.W_EXCEPTION);
			result.setMessage("该券码输入错误");
			return false;
		}
		
		//已被兑换
		if(couponExCode.getIsExchanged()==2){
			result.setCode(ConstantUtil.W_EXCEPTION);
			result.setMessage("该券码已被他人兑换");
			return false;
		}
		
		//已过期
		if(null !=couponExCode.getEndDate() && System.currentTimeMillis() > couponExCode.getEndDate().getTime()){
			result.setCode(ConstantUtil.W_EXCEPTION);
			result.setMessage("该券码已过期");
			return false;
		}
		
		//已禁用
		if(null !=couponExCode.getIsEnable() && 2==couponExCode.getIsEnable()){
			result.setCode(ConstantUtil.W_EXCEPTION);
			result.setMessage("该券码无效");
			return false;
		}
		
		//已删除
		if(null !=couponExCode.getIsDelete() && couponExCode.getIsDelete() == 2){
			result.setCode(ConstantUtil.W_EXCEPTION);
			result.setMessage("该券码无效");
			return false;
		}
		
		arg.setSourceId(couponExCode.getCouponPackageId());
		return true;
	}

	@Override
	protected void endGiftCoupon(GiftCouponArg arg, List<CustomerCouponNew> lstCoupon, int giftCount) {
		if(giftCount <= 0){
			result.setCode(ConstantUtil.W_EXCEPTION);
			result.setMessage("没有找到该兑换券！");
			return;
		}
		
		Date dt = new Date();
		couponExCode.setIsExchanged(2);
		couponExCode.setExchangeDate(dt);
		couponExCode.setModifyDate(dt);
		couponExCode.setCustomerId(arg.getTargetCustomerId());
		couponExchangeCodeService.updateCouponExchangeCode(couponExCode);

	}

}
