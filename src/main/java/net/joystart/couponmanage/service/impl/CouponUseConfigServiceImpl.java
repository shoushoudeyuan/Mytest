package net.joystart.couponmanage.service.impl;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.joystart.city.entity.ServiceCity;
import net.joystart.city.service.IServiceCitySerivce;
import net.joystart.couponmanage.dao.CouponUseConfigMapper;
import net.joystart.couponmanage.entity.CouponUseConfig;
import net.joystart.couponmanage.enums.CouponTypeEnum;
import net.joystart.couponmanage.service.ICouponUseConfigService;
import net.joystart.vehicle.entity.CarType;
import net.joystart.vehicle.remote.service.ICarTypeRemoteService;

@Service("svcUseConfig")
public class CouponUseConfigServiceImpl implements ICouponUseConfigService {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private CouponUseConfigMapper daoConfig;
	
	@Autowired
	private IServiceCitySerivce svcCity;

	@Autowired
	private ICarTypeRemoteService carTypeRemoteService;
	
	@Override
	public boolean saveCouponUseConfig(CouponUseConfig couponUseConfig) {
		List<String> lstCouponName = daoConfig.selectCouponNameList();
		if(lstCouponName.contains(couponUseConfig.getConfigName()))
			return false;
		
		int ret = daoConfig.insertSelective(couponUseConfig);
		return ret > 0;
	}

	@Override
	public boolean enableCouponUseConfig(Integer id) {
		if(id == null)
			return false;
		
		CouponUseConfig rule = new CouponUseConfig();
		rule.setId(id);
		rule.setIsValidate(1);
		boolean ret = daoConfig.updateCouponState(rule) > 0;
		
		logger.debug("启用了 Id:{} 优惠卷配置",id);
		return ret;
		
	}

	@Override
	public boolean disableCouponUseConfig(Integer id) {
		if(id == null)
			return false;
		
		CouponUseConfig rule = new CouponUseConfig();
		rule.setId(id);
		rule.setIsValidate(0);
		boolean ret = daoConfig.updateCouponState(rule) > 0;
		
		logger.debug("禁用了{}优惠卷配置",id);
		return ret;
	}
	
	@Override
	public int deleteCouponUseConfig(List<Integer> ids) {
		if(ids == null || ids.size() == 0) {
			return 0;
		}
		return daoConfig.deleteCouponUseConfig(ids);
	}

	@Override
	public CouponUseConfig getCouponUseConfig(Integer id) {
		if(id == null)
			return null;
		
		return daoConfig.selectById(id);
	}

	@Override
	public List<CouponUseConfig> selectCouponUseConfig(Integer pageIndex,Integer pageSize, String configName,CouponTypeEnum couponType,Integer isValidate) {
		Map<String,Object> params = setSelectCouponUseConfigParams(configName,couponType,isValidate);
		
		if(pageIndex != null && pageIndex > 0){
			pageIndex = (pageIndex - 1) * pageSize;
			params.put("pageIndex", pageIndex);
		}
		
		if(pageSize != null){
			params.put("pageSize", pageSize);
		}
		
		List<CouponUseConfig> lst = daoConfig.selectCouponUseConfig(params);
		params.clear();
		params.put("startIndex", 0);
		params.put("pageSize", 1000);
		List<CarType> lstCarType = carTypeRemoteService.selectByParam(params);
		List<ServiceCity> lstServiceCity = svcCity.getServerCity();
		StringBuilder sb = new StringBuilder();
		for(CouponUseConfig config : lst){
			List<String> lstConfigCityId = Arrays.asList(config.getUseCityId().split(","));  
			List<String> lstCityName = new ArrayList<>();
			for(ServiceCity city:lstServiceCity){
				if(lstConfigCityId.contains(city.getId().toString())){
					lstCityName.add(city.getShowname());
				}
				
			}
			
			List<String> lstConfigModeId = Arrays.asList(config.getUseVehicleModeId().split(","));
			List<String> lstConfigModeName = new ArrayList<>();
			for(CarType carType:lstCarType){
				if(lstConfigModeId.contains(carType.getId().toString())){
					lstConfigModeName.add(carType.getModelName());
				}
			}
			
			sb.setLength(0);
			if(lstCityName.size() == 0){
//				sb.append("所有城市可以使用；");
				sb.append("");
			}else{
				sb.append("只限" + StringUtils.join(lstCityName.toArray(), ",") + "使用;");
			}
			
			if(lstConfigModeName.size() == 0){
//				sb.append("适用所有车型；");
				sb.append("");
			}else{
				sb.append("以下车型可用("+ StringUtils.join(lstConfigModeName.toArray(), ",") +");");
			}
			
			if(StringUtils.isBlank(config.getUseLowerTime()) && StringUtils.isBlank(config.getUseUpperTime())){
//				sb.append("全天24时有效；");
				sb.append("");
			}else{
				sb.append(config.getUseLowerTime() + "至"+ config.getUseUpperTime() + "时段使用；");
			}
			
			String[] useWeekDayArr = config.getUseWeekDay().split(",");
			if(useWeekDayArr.length==7){
				sb.append("");
			}else{
				sb.append("使用时间(周" + config.getUseWeekDay().replace(",", ",周") + ");");
			}
			
			if(config.getValidateDay()==null){
				sb.append("");
			}else{
				sb.append("有效期" + config.getValidateDay() + "天;");
			}
			
			if(config.getBaseOrderMoney()==null||config.getBaseOrderMoney()<=0.0){
				sb.append("");
			}else{
				sb.append("订单费用满"+config.getBaseOrderMoney()+"元使用;");
			}
			DecimalFormat df = new DecimalFormat( "#,##0.00 ");
			//保留两位小数且不用科学计数法，并使用千分位
			if(config.getCouponType() == CouponTypeEnum.DISCOUNT.getValue()){
				sb.append("折扣" + config.getDiscountPercent() +"%;");
				sb.append("最高减免" + df.format(config.getMaxDeductionMoney()) + "元;");
			}else{
				sb.append("优惠券金额"+df.format(config.getCouponMoney())+"元;"); 
			}
			config.setConfigDetail(sb.toString());
		}
		
		return lst;
	}
	
	@Override
	public Integer selectCouponUseConfigCount(String configName,CouponTypeEnum couponType,Integer isValidate) {
		Map<String,Object> params = setSelectCouponUseConfigParams(configName,couponType,isValidate);
		
		return daoConfig.selectCouponUseConfigCount(params);
	}
	
	
	@Override
	public List<String> selectCouponNameList(){
		return daoConfig.selectCouponNameList();
	}
	
	private Map<String,Object> setSelectCouponUseConfigParams(String configName,CouponTypeEnum couponType,Integer isValidate){
		Map<String,Object> params = new HashMap<>();
		
		if(StringUtils.isNoneBlank(configName)){
			params.put("configName",configName);
		}
		
		if(couponType != null){
			params.put("couponType", couponType.getValue());
		}
		
		if(isValidate != null){
			params.put("isValidate",isValidate);
		}
		
		return params;
	}
	

}
