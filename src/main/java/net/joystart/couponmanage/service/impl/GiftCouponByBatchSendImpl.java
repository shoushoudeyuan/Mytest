package net.joystart.couponmanage.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import net.joystart.common.database.DataSourceAspect;
import net.joystart.common.util.ConstantUtil;
import net.joystart.common.util.MessageResult;
import net.joystart.couponmanage.dao.CouponBatchRecordMapper;
import net.joystart.couponmanage.entity.CouponBatchRecord;
import net.joystart.couponmanage.entity.CustomerCouponNew;
import net.joystart.couponmanage.entity.GiftCouponArg;
import net.joystart.couponmanage.enums.CouponGiftModeEnum;

@Service
public class GiftCouponByBatchSendImpl extends AbstractGiftCouponService {

	private List<Integer> lstCustomerId = null;
	private Integer packageId;
	
	@Resource
	private CouponBatchRecordMapper couponBatchRecordMapper;
	
	@Override
	public MessageResult batchSendGoupon(List<Integer> lstCustomerId,Integer packageId,Integer opLogId){
		if((lstCustomerId == null || lstCustomerId.size() == 0) && packageId == null){
			result.setCode(ConstantUtil.W_PARAWTER_NULL);
			return result;
		}
		
		this.lstCustomerId = lstCustomerId;
		this.packageId = packageId;
		GiftCouponArg arg = new GiftCouponArg();
		List<Integer> failedCustomerId = new ArrayList<>();
		arg.setSource(CouponGiftModeEnum.系统录入);
		arg.setSourceId(packageId);
		Date date = new Date();
		for(Integer customerId : lstCustomerId){
			arg.setTargetCustomerId(customerId);
			List<CustomerCouponNew> lstCoupon = beginGiftCoupon(arg,packageId);
			int ret = daoCustomerCoupon.insert(lstCoupon);
			int state = 1;
			if(ret <= 0){
				failedCustomerId.add(customerId);
				state=0;
			}
			CouponBatchRecord cbr = new CouponBatchRecord();
			cbr.setCustomerid(customerId);
			cbr.setOplogid(opLogId);
			cbr.setPackageid(packageId);
			cbr.setSendstatus(state);
			cbr.setSendtime(date);
			couponBatchRecordMapper.insert(cbr);
			
			sendMessage.sendMessage(CouponGiftModeEnum.系统录入,packageId,customerId,
					DataSourceAspect.getCurrentDataSource(),DataSourceAspect.getCurrentHostName());
		}
		
		result.setCode(ConstantUtil.W_SUCCESS);
		result.setData(failedCustomerId);
		

		return result;
	}
	
	@Override
	protected boolean canGiftCoupon(GiftCouponArg arg) {
		return true;
	}

	@Override
	protected void endGiftCoupon(GiftCouponArg arg,List<CustomerCouponNew> lstCoupon ,int giftCount) {

	}
	
}
