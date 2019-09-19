package net.joystart.couponmanage.service.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.citrus.util.StringUtil;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.serializer.SimplePropertyPreFilter;

import net.joystart.couponmanage.dao.CouponGiftConfigMapper;
import net.joystart.couponmanage.entity.giftconfig.AutoGiftConfig4EntMember;
import net.joystart.couponmanage.entity.giftconfig.CouponGiftConfig;
import net.joystart.couponmanage.entity.giftconfig.GiftConfig4FirstOrder;
import net.joystart.couponmanage.entity.giftconfig.GiftConfig4InviteFriends;
import net.joystart.couponmanage.entity.giftconfig.GiftConfig4OrderCost;
import net.joystart.couponmanage.entity.giftconfig.GiftConfig4RegisterEntMember;
import net.joystart.couponmanage.entity.giftconfig.GiftConfig4UserRegister;
import net.joystart.couponmanage.enums.CouponGiftModeEnum;
import net.joystart.couponmanage.service.ICouponGiftConfigService;

@Service
public class CouponGiftConfigServiceImpl implements ICouponGiftConfigService {

	@Autowired
	CouponGiftConfigMapper dao;
	
	@Override
	public Boolean saveGiftConfig4UserRegister(GiftConfig4UserRegister config) {
		String configItem = JSON.toJSONString(config, new SimplePropertyPreFilter(GiftConfig4UserRegister.class,"userRegistered","userIdentified","payDeposit"));
		config.setConfigItem(configItem);
		return dao.updateByIdSelective(config) > 0;
	}
	
	@Override
	public Boolean saveGiftConfig4InviteFriends(GiftConfig4InviteFriends config){
		if(!config.getInviteeFirstRentCarAndPayment4Inviter()) 
			config.setInviteeFirstDriverMileage4Inviter(null);
		String configItem = JSON.toJSONString(config, new SimplePropertyPreFilter(GiftConfig4InviteFriends.class,
				"inviteeRegistedAndUseInviteCode4Invitee","inviteeIdentified4Invitee","inviteePayDeposit4Invitee",
				"inviteeIdentified4Inviter","inviteePayDeposit4Inviter","inviteeFirstRentCarAndPayment4Inviter","inviteeFirstDriverMileage4Inviter"));
		config.setConfigItem(configItem);
		return dao.updateByIdSelective(config) > 0;
	}
	
	@Override
	public Boolean saveGiftConfig4OrderCost(GiftConfig4OrderCost config){
		if(!config.getGiftByPaymentOrderCost())
			config.setOrderCost(null);
		String configItem = JSON.toJSONString(config,new SimplePropertyPreFilter(GiftConfig4OrderCost.class,"costMode","giftByPaymentOrderCost","orderCost"));
		config.setConfigItem(configItem);
		return dao.updateByIdSelective(config) > 0;
	}
	
	@Override
	public Boolean saveGiftConfig4FirstOrder(GiftConfig4FirstOrder config){
		if(!config.getCheckFirstOrderMileage())
			config.setFirstOrderMileage(null);
		
		String configItem = JSON.toJSONString(config, new SimplePropertyPreFilter(GiftConfig4FirstOrder.class,"orderStatus","checkFirstOrderMileage","firstOrderMileage"));
		config.setConfigItem(configItem);
		return dao.updateByIdSelective(config) > 0;
	}
	
	@Override
	public Boolean saveGiftConfig4RegisterEntMember(GiftConfig4RegisterEntMember config){
		if(!config.getFirstOrderAndPayment())
			config.setFirstOrderMileage(null);
		String configItem = JSON.toJSONString(config,new SimplePropertyPreFilter(GiftConfig4RegisterEntMember.class,"registerEntMember","firstOrderAndPayment","firstOrderMileage"));
		config.setConfigItem(configItem);
		return dao.updateByIdSelective(config) > 0;
	}
	
	@Override
	public Boolean saveAutoGiftConfig4RegisterEntMember(AutoGiftConfig4EntMember config){
		String configItem = JSON.toJSONString(config,new SimplePropertyPreFilter(GiftConfig4RegisterEntMember.class,"companyId","autoSendDate"));
		config.setConfigItem(configItem);
		return dao.updateByIdSelective(config) > 0;
	}

	@Override
	public List<CouponGiftConfig> selectByRuleName(String ruleName) {
		if(StringUtil.isBlank(ruleName)){
			return dao.selectAll();
		}else{
			return dao.selectByRuleName(ruleName);
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public <T extends CouponGiftConfig> T selectByEnumCode(CouponGiftModeEnum mode,Class<T> e) throws InstantiationException, IllegalAccessException {
		//T t = e.newInstance();
		CouponGiftConfig giftConfig = dao.selectByEnumCode(mode.getValue());
		T t = e.newInstance();
		t.setId(giftConfig.getId());
		t.setEnumCode(giftConfig.getEnumCode());
		t.setIsValidate(giftConfig.getIsValidate());
		t.setRuleName(giftConfig.getRuleName());
		
		switch(mode){
			case 注册用户赠:
				GiftConfig4UserRegister register = (GiftConfig4UserRegister)t;
				setUserRegisterConfig(giftConfig,register);
				return (T) register;
			case 邀请好友赠:
				GiftConfig4InviteFriends invite = (GiftConfig4InviteFriends)t;
				setInviteFriendsConfig(giftConfig,invite);
				return(T) invite;
			case 订单满额赠:
				GiftConfig4OrderCost cost = (GiftConfig4OrderCost)t;
				setOrderCostConfig(giftConfig,cost);
				return(T) cost;
			case 首次用车结单赠:
				GiftConfig4FirstOrder order = (GiftConfig4FirstOrder)t;
				setFirstOrderConfig(giftConfig,order);
				return (T) order;
			case 首次成为企业用户赠:
				GiftConfig4RegisterEntMember ent = (GiftConfig4RegisterEntMember)t;
				setRegisterEntMember(giftConfig,ent);
				return (T)ent;
			case 企业会员按时间赠:
				AutoGiftConfig4EntMember auto = (AutoGiftConfig4EntMember)t;
				setAutoGift4EntMember(giftConfig,auto);
				return(T)auto;
		}
		
		return t;
	}
	
	private void setUserRegisterConfig(CouponGiftConfig giftConfig,GiftConfig4UserRegister register){
		if(StringUtil.isBlank(giftConfig.getConfigItem())){
			register.setUserRegistered(false);
			register.setUserIdentified(false);
			register.setPayDeposit(false);
		}else{
			JSONObject jsonObj = JSONObject.parseObject(giftConfig.getConfigItem());
			register.setUserRegistered(jsonObj.getBoolean("userRegistered"));
			register.setUserIdentified(jsonObj.getBoolean("userIdentified"));
			register.setPayDeposit(jsonObj.getBoolean("payDeposit"));
		}
	}

	private void setInviteFriendsConfig(CouponGiftConfig giftConfig,GiftConfig4InviteFriends entity){
		if(StringUtil.isBlank(giftConfig.getConfigItem())){
			entity.setInviteeIdentified4Invitee(false);
			entity.setInviteeRegistedAndUseInviteCode4Invitee(false);
			entity.setInviteePayDeposit4Invitee(false);
			entity.setInviteeIdentified4Inviter(false);
			entity.setInviteePayDeposit4Inviter(false);
			entity.setInviteeFirstRentCarAndPayment4Inviter(false);
		}else{
			JSONObject jsonObj = JSONObject.parseObject(giftConfig.getConfigItem());
			entity.setInviteeIdentified4Invitee(jsonObj.getBoolean("inviteeIdentified4Invitee"));
			entity.setInviteeRegistedAndUseInviteCode4Invitee(jsonObj.getBoolean("inviteeRegistedAndUseInviteCode4Invitee"));
			entity.setInviteePayDeposit4Invitee(jsonObj.getBoolean("inviteePayDeposit4Invitee"));
			entity.setInviteeIdentified4Inviter(jsonObj.getBoolean("inviteeIdentified4Inviter"));
			entity.setInviteePayDeposit4Inviter(jsonObj.getBoolean("inviteePayDeposit4Inviter"));
			entity.setInviteeFirstRentCarAndPayment4Inviter(jsonObj.getBoolean("inviteeFirstRentCarAndPayment4Inviter"));
			entity.setInviteeFirstDriverMileage4Inviter(jsonObj.getInteger("inviteeFirstDriverMileage4Inviter"));
		}
	}
	
	private void setOrderCostConfig(CouponGiftConfig giftConfig,GiftConfig4OrderCost entity){
		if(StringUtil.isBlank(giftConfig.getConfigItem())){
			entity.setCostMode(null);
			entity.setGiftByPaymentOrderCost(false);
			entity.setOrderCost(null);
		}else{
			JSONObject jsonObj = JSONObject.parseObject(giftConfig.getConfigItem());
			entity.setCostMode(jsonObj.getInteger("costMode"));
			entity.setGiftByPaymentOrderCost(jsonObj.getBoolean("giftByPaymentOrderCost"));
			entity.setOrderCost(jsonObj.getDouble("orderCost"));
		}
	}
	
	private void setFirstOrderConfig(CouponGiftConfig giftConfig,GiftConfig4FirstOrder entity){
		if(StringUtil.isBlank(giftConfig.getConfigItem())){
			entity.setOrderStatus(null);
			entity.setCheckFirstOrderMileage(false);
			entity.setFirstOrderMileage(null);
		}else{
			JSONObject jsonObj = JSONObject.parseObject(giftConfig.getConfigItem());
			entity.setOrderStatus(jsonObj.getIntValue("orderStatus"));
			entity.setCheckFirstOrderMileage(jsonObj.getBoolean("checkFirstOrderMileage"));
			entity.setFirstOrderMileage(jsonObj.getInteger("firstOrderMileage"));
		}
	}
	
	private void setRegisterEntMember(CouponGiftConfig giftConfig,GiftConfig4RegisterEntMember entity){
		if(StringUtil.isBlank(giftConfig.getConfigItem())){
			entity.setFirstOrderAndPayment(false);
			entity.setFirstOrderMileage(null);
			entity.setRegisterEntMember(false);
		}else{
			JSONObject jsonObj = JSONObject.parseObject(giftConfig.getConfigItem());
			entity.setRegisterEntMember(jsonObj.getBoolean("registerEntMember"));
			entity.setFirstOrderAndPayment(jsonObj.getBoolean("firstOrderAndPayment"));
			entity.setFirstOrderMileage(jsonObj.getInteger("firstOrderMileage"));
		}
	}
	
	private void setAutoGift4EntMember(CouponGiftConfig giftConfig,AutoGiftConfig4EntMember entity){
		if(StringUtil.isBlank(giftConfig.getConfigItem())){
			entity.setCompanyId(null);
			entity.setAutoSendDate(null);
		}else{
			JSONObject jsonObj = JSONObject.parseObject(giftConfig.getConfigItem());
			List<Integer> lstCompanyId = JSON.parseArray(jsonObj.getString("companyId"), Integer.class);  
			entity.setCompanyId(lstCompanyId);  
			entity.setAutoSendDate(JSON.parseArray(jsonObj.getString("autoSendDate"), String.class));
		}
	}

}
