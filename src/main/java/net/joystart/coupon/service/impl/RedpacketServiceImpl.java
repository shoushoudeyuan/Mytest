package net.joystart.coupon.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import net.joystart.common.util.CodingProductionUtil;
import net.joystart.common.util.date.UtilTimeFormatter;
import net.joystart.coupon.dao.CouponMapper;
import net.joystart.coupon.dao.RedpacketMapper;
import net.joystart.coupon.dao.RedpacketRuledetailMapper;
import net.joystart.coupon.entity.Activity;
import net.joystart.coupon.entity.Coupon;
import net.joystart.coupon.entity.Redpacket;
import net.joystart.coupon.entity.RedpacketRuledetail;
import net.joystart.coupon.service.IRedpacketService;

@Component("redpacketService")
@Transactional
public class RedpacketServiceImpl implements IRedpacketService{

	@Resource
	private RedpacketMapper redpacketMapper;
	
	@Resource
	private RedpacketRuledetailMapper redpacketRuledetailMapper;
	
	@Resource
	private CouponMapper couponMapper;
	
	@Transactional
	public List<Coupon> exchange(Redpacket record) {
		//根据活动id查询活动规则
		Activity activity = new Activity();
		activity.setId(record.getActivityid());
		List<RedpacketRuledetail> redpacketRuledetails = redpacketRuledetailMapper.selectByActivityID(activity);
		ArrayList<Coupon> arrayList = new ArrayList<Coupon>();
		//根据红包规则创建优惠券
		for(RedpacketRuledetail redpacketRuledetail : redpacketRuledetails){
			
			for(int i = 0;i<redpacketRuledetail.getPresentcount();i++){
				Coupon coupon = new Coupon();
				//精度转换
				BigDecimal pMoney = new BigDecimal(redpacketRuledetail.getPresentmoney());
				coupon.setCouponMoney(pMoney);
				coupon.setCouponType(redpacketRuledetail.getUsingtype());
				coupon.setIsTimeControl(redpacketRuledetail.getTimecontrol());
				Date dtCreate = new Date();
				//coupon.setStartDate(dtCreate);
				coupon.setCreateDate(dtCreate);
				coupon.setRemark(redpacketRuledetail.getReamark());
				//考虑有效期延后
				
				if(1 == redpacketRuledetail.getIspostpone()){
					coupon.setStartDate(UtilTimeFormatter.afterNDay(redpacketRuledetail.getValidday()*i ,dtCreate));
					coupon.setEndDate(UtilTimeFormatter.afterNDay(redpacketRuledetail.getValidday(), coupon.getStartDate()));
				}else if(0 == redpacketRuledetail.getIspostpone()){
					coupon.setStartDate(dtCreate);
					coupon.setEndDate(UtilTimeFormatter.afterNDay(redpacketRuledetail.getValidday(), dtCreate));
				}
				coupon.setIsExpires(0);
				coupon.setUseStatus(0);
				coupon.setIsDisable(1);
				
				coupon.setCustomerId(record.getUsinguserid());
				String code = CodingProductionUtil.getCodingByRule(1);
				coupon.setCouponCode(code);
				//红包兑换来源
				coupon.setFromEnum(3);
				
				//创建优惠券
				couponMapper.insert(coupon);
				arrayList.add(coupon);
				
			}
			
		}
		
		if(arrayList.size() > 0){
			//更新红包
			this.redpacketMapper.update(record);
		}
		
		return arrayList;
	}



	public List<Redpacket> selectByParams(Map params) {
		return this.redpacketMapper.selectByParams(params);
	}
	
}
