package net.joystart.couponmanage.service.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import com.alibaba.citrus.util.StringUtil;

import net.joystart.common.database.DataSourceAspect;
import net.joystart.common.util.CodingProductionUtil;
import net.joystart.common.util.ConstantUtil;
import net.joystart.common.util.MessageResult;
import net.joystart.common.util.date.UtilTimeFormatter;
import net.joystart.couponmanage.dao.CustomerCouponNewMapper;
import net.joystart.couponmanage.entity.CouponPackageItem;
import net.joystart.couponmanage.entity.CouponUseConfig;
import net.joystart.couponmanage.entity.CustomerCouponNew;
import net.joystart.couponmanage.entity.GiftCouponArg;
import net.joystart.couponmanage.enums.CouponEnableEnum;
import net.joystart.couponmanage.enums.CouponGiftModeEnum;
import net.joystart.couponmanage.service.ICouponGiftConfigService;
import net.joystart.couponmanage.service.ICouponPackageService;
import net.joystart.couponmanage.service.IGiftCouponService;

public abstract class AbstractGiftCouponService implements IGiftCouponService {

	protected final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired 
	protected CustomerCouponNewMapper daoCustomerCoupon; 
	
	@Autowired
	protected ICouponGiftConfigService svcGiftConfig;
	
	@Autowired
	protected ICouponPackageService svcCouponPackage;
	
	@Autowired
	protected SendGiftCouponMessage sendMessage;
	
	protected MessageResult result = new MessageResult();
	
	public MessageResult batchSendGoupon(List<Integer> lstCustomerId,Integer packageId,Integer opLogId){
		return null;
	}
	
	@Transactional
	public MessageResult giftCoupon(GiftCouponArg arg){
		try{
			result = new MessageResult(ConstantUtil.W_EXCEPTION,"兑换中,请稍后在优惠券列表中查看结果");
			if(arg == null || arg.getSource() == null || arg.getSourceId() == null || arg.getTargetCustomerId() == null){
				result.setCode(ConstantUtil.W_EXCEPTION);
				result.setMessage("赠送优惠券参数错误");
				return result;
			}
			
			logger.debug("开始给{}赠送{}类型编号{}优惠券",arg.getTargetCustomerId(),CouponGiftModeEnum.valueOf(arg.getSource().getValue()),arg.getSourceId());
	
			boolean can = canGiftCoupon(arg);
			if(!can){
				logger.debug("{}不满足{}类型的优惠券发放规则",arg.getTargetCustomerId(),CouponGiftModeEnum.valueOf(arg.getSource().getValue()));
				return result;
			}
			
			
			List<CustomerCouponNew> lstCoupon = beginGiftCoupon(arg,arg.getSourceId());
			int giftCount = 0;
			if(lstCoupon == null || lstCoupon.size() == 0) {
				logger.debug("{}类型的优惠券规则未配置或被禁用不能发放给{}用户",CouponGiftModeEnum.valueOf(arg.getSource().getValue()),arg.getTargetCustomerId());
				if(CouponGiftModeEnum.推广.equals(arg.getSource())){
					result.setCode(ConstantUtil.W_EXCEPTION);
					result.setMessage("该推广码无优惠券");
					return result;
				}else if(CouponGiftModeEnum.渠道.equals(arg.getSource())){
					result.setCode(ConstantUtil.W_EXCEPTION);
					result.setMessage("该渠道码无优惠券");
					return result;
				}if(CouponGiftModeEnum.邀请好友赠.equals(arg.getSource()) || CouponGiftModeEnum.手动兑换邀请码.equals(arg.getSource())){
					result.setCode(ConstantUtil.W_EXCEPTION);
					result.setMessage("已成功邀请");
					return result;
				}if(CouponGiftModeEnum.券码兑换.equals(arg.getSource())){
					result.setCode(ConstantUtil.W_EXCEPTION);
					result.setMessage("该券码无效");
					return result;
				}else{
					result.setCode(ConstantUtil.W_EXCEPTION);
					result.setMessage("已被禁止使用");
					return result;
				}
			}
			else{
				giftCount = batchInsert(lstCoupon); //daoCustomerCoupon.insert(lstCoupon);
			}
					
			endGiftCoupon(arg,lstCoupon,giftCount);
			
			if(giftCount > 0){
				sendMessage.sendMessage(CouponGiftModeEnum.valueOf(arg.getSource().getValue()),arg.getSourceId(),arg.getTargetCustomerId(),
				DataSourceAspect.getCurrentDataSource(),DataSourceAspect.getCurrentHostName());
			}
			
			if(StringUtil.isBlank(result.getMessage())){
				result.setCode(ConstantUtil.W_SUCCESS);
				result.setMessage("赠送优惠券成功");
			}
			if(result.getData() == null)
				result.setData(true);
			return result;
		}catch (Exception e) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			logger.error("获取{}用户的{}类型优惠券发放规则失败",arg.getTargetCustomerId(),CouponGiftModeEnum.valueOf(arg.getSource().getValue()),e);
			result.setCode(ConstantUtil.W_EXCEPTION);
			result.setMessage("赠送优惠券失败");
			return result;
		}
	}
	
	protected List<CustomerCouponNew> beginGiftCoupon(GiftCouponArg arg,Integer packageId){
		List<CouponPackageItem> lstCouponPackageItem = svcCouponPackage.selectCouponPackageItem(packageId);
		List<CustomerCouponNew> lstCoupon = new ArrayList<>();
		for(CouponPackageItem item : lstCouponPackageItem){
			if(item.getIsEnable() == 0){
				continue;
			}
			
			CouponUseConfig useConfig = item.getCouponUseConfig();
			if(useConfig == null || useConfig.getIsValidate() == 0){
				continue;
			}
			
			for(int i = 0 ; i < item.getCouponCount() ; i++){
				CustomerCouponNew coupon = new CustomerCouponNew();
				coupon.setCustomerId(arg.getTargetCustomerId());
				coupon.setCouponName(item.getCouponName());
				coupon.setCouponConfigId(useConfig.getId());
				String code = getCouponCode(arg.getSource());
				coupon.setCouponNo(code);
				coupon.setIsEnable(CouponEnableEnum.ENABLE.getCode());
				coupon.setIsUsed(CouponEnableEnum.ENABLE.getCode());
				coupon.setSourceType((byte) arg.getSource().getValue());
				coupon.setSourceId(arg.getSourceId());
				coupon.setCreateDate(new Date());
				if(useConfig.getValidateDay() <= 0){
					coupon.setExpireDate(new Date());
				}
				else{
					coupon.setExpireDate(UtilTimeFormatter.afterNDay(useConfig.getValidateDay()));
				}
				
				String strDate = UtilTimeFormatter.getTimeToYMD(coupon.getExpireDate());
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				Date dt = null;
				try {
					dt = sdf.parse(strDate);
				} catch (ParseException e) {
					e.printStackTrace();
				}
				
				coupon.setExpireDate(dt);
				lstCoupon.add(coupon);
			}
		}
		
		return lstCoupon;
	}
	
	protected abstract  boolean canGiftCoupon(GiftCouponArg arg) throws Exception;
	
	protected abstract void endGiftCoupon(GiftCouponArg arg,List<CustomerCouponNew> lstCoupon,int giftCount);

	protected String getCouponCode(CouponGiftModeEnum mode) {
		String code = "";
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
		switch (mode) {
		case 系统录入:	
			code = "XT"+format.format(new Date())+CodingProductionUtil.generateShortUuid().toUpperCase();
			break;
		case 券码兑换:
			code = "HD"+format.format(new Date())+CodingProductionUtil.generateShortUuid().toUpperCase();
			break;
		case 渠道:
			code = "QD"+format.format(new Date())+CodingProductionUtil.generateShortUuid().toUpperCase();
		case 推广:
			code = "TG"+format.format(new Date())+CodingProductionUtil.generateShortUuid().toUpperCase();
			break;
		default:
			code = "YH"+format.format(new Date())+CodingProductionUtil.generateShortUuid().toUpperCase();
			break;
		}
		
		return code;
	}
	
	private int batchInsert(List<CustomerCouponNew> lstCoupon){
		int from = 0;
		int to = 0;
		int page = 0;
		int pageSize = 30;
		List<CustomerCouponNew> lstSub = new ArrayList<>();
		int retCount = 0;
		
		do{
			page += 1;
			from = (page - 1) * pageSize;
			to = page * pageSize;
			if(to > lstCoupon.size())
				to = lstCoupon.size();
			lstSub = lstCoupon.subList(from, to);
			if(lstSub != null || lstSub.size() > 0){
				retCount += daoCustomerCoupon.insert(lstCoupon);
			}
		}while(lstSub != null && lstSub.size() > 0 && to < lstCoupon.size());
		
		return retCount;
	}
}
