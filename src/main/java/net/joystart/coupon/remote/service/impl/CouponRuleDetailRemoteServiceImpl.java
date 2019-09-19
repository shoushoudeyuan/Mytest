package net.joystart.coupon.remote.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;

import com.alibaba.dubbo.config.annotation.Service;

import net.joystart.coupon.dao.CouponRuleDetailMapper;
import net.joystart.coupon.entity.CouponRuleDetail;
import net.joystart.coupon.entity.RuleItem;
import net.joystart.coupon.remote.service.ICouponRuleDetailRemoteService;
import net.joystart.couponmanage.entity.CouponPackageItem;
import net.joystart.couponmanage.entity.CouponUseConfig;
import net.joystart.couponmanage.enums.CouponGiftModeEnum;
import net.joystart.couponmanage.service.ICouponPackageService;

@Service(timeout=60000,retries=0)
public class CouponRuleDetailRemoteServiceImpl implements ICouponRuleDetailRemoteService {

	@Resource
	private CouponRuleDetailMapper couponRuleDetail;
	
	@Autowired
	protected ICouponPackageService svcCouponPackage;
	
	@Override
	public List<CouponRuleDetail> selectByIdentification(String Identification) {
		// TODO Auto-generated method stub
		return couponRuleDetail.selectByIdentification(Identification);
	}

	@Override
	public List<RuleItem> getItemByInvitationCode(String invitationCode) {
		
		return couponRuleDetail.getItemByInvitationCode(invitationCode);
	}

	@Override
	public List<CouponRuleDetail> selectValidCouponByIdentification(String Identification) {
		return couponRuleDetail.selectValidCouponByIdentification(Identification);
	}
	
	
	@Override
	public String getInviteContent() {
		List<CouponPackageItem> lstCouponPackageItem = svcCouponPackage.selectCouponPackageItem(CouponGiftModeEnum.邀请好友赠.getValue());
		StringBuffer content = new StringBuffer();
		for(CouponPackageItem item : lstCouponPackageItem){
			if(item.getIsEnable() == 0){
				continue;
			}
			CouponUseConfig useConfig = item.getCouponUseConfig();
			if(useConfig == null || useConfig.getIsValidate() == 0){
				continue;
			}
			String type = useConfig.getCouponType() == 1 ? "折扣优惠券" : "减免优惠券";
			String desc = useConfig.getCouponType() == 1 ? (useConfig.getDiscountPercent() / 10) + "折" : useConfig.getCouponMoney() + "元";
			content.append(desc + type + item.getCouponCount() + "张、");
		}
		if(StringUtils.isNotBlank(content.toString())){
			return content.toString().substring(0, content.toString().length() - 1);
		}else{
			return null;
		}
	}

	@Override
	public List<CouponRuleDetail> getCouponItemByBusinessId(Integer businessId) {
		// TODO Auto-generated method stub
		return couponRuleDetail.getCouponItemByBusinessId(businessId);
	}

}
