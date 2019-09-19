package net.joystart.couponmanage.service.impl;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.joystart.city.entity.ServiceCity;
import net.joystart.city.service.IServiceCitySerivce;
import net.joystart.common.util.CodingProductionUtil;
import net.joystart.couponmanage.dao.CustomerCouponNewMapper;
import net.joystart.couponmanage.entity.CouponUseConfig;
import net.joystart.couponmanage.entity.CustomerCouponNew;
import net.joystart.couponmanage.entity.CustomerCouponNewVO;
import net.joystart.couponmanage.enums.CouponEnableEnum;
import net.joystart.couponmanage.enums.CouponTypeEnum;
import net.joystart.couponmanage.enums.CouponUsedEnum;
import net.joystart.couponmanage.service.ICouponUseConfigService;
import net.joystart.couponmanage.service.ICustomerCouponNewService;
import net.joystart.vehicle.entity.CarType;
import net.joystart.vehicle.remote.service.ICarTypeRemoteService;

@Service("customerCouponNewService")
public class CustomerCouponNewServiceImpl implements ICustomerCouponNewService {

	@Resource
	private CustomerCouponNewMapper customerCouponNewMapper;
	
	@Resource
	private ICouponUseConfigService svcUseConfig;
	
	@Autowired
	private IServiceCitySerivce svcCity;

	@Autowired
	ICarTypeRemoteService carTypeRemoteService;

	@Override
	public List<CustomerCouponNewVO> getCustomerCouponNewList(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		List<ServiceCity> lstServiceCity = svcCity.getServerCity();
		List<CustomerCouponNewVO> list = customerCouponNewMapper.getCustomerCouponNewList(paramMap);
		StringBuilder sb = new StringBuilder();
		Calendar dCalendar = Calendar.getInstance();
		
		Map<String,Object> params = new HashMap<>();
		params.put("startIndex", 0);
		params.put("pageSize", 1000);
		List<CarType> lstCarType = carTypeRemoteService.selectByParam(params);
		for (CustomerCouponNewVO customerCouponNewVO : list) {
			dCalendar.setTime(customerCouponNewVO.getExpireDate());
			dCalendar.set(Calendar.HOUR_OF_DAY, 23);
			dCalendar.set(Calendar.MINUTE, 59);
			dCalendar.set(Calendar.SECOND, 59);
			dCalendar.set(Calendar.MILLISECOND, 0);
			if (customerCouponNewVO.getIsUsed().intValue()==CouponUsedEnum.NOTUSED.getCode() &&
					dCalendar.getTime().before(new Date())) {
				customerCouponNewVO.setIsUsed(CouponUsedEnum.EXPIRED.getCode());
			}
			
			List<String> lstConfigCityId = Arrays.asList(customerCouponNewVO.getUseCityId().split(","));  
			List<String> lstCityName = new ArrayList<>();
			for(ServiceCity city:lstServiceCity){
				if(lstConfigCityId.contains(city.getId().toString())){
					lstCityName.add(city.getShowname());
				}
			}
			
			List<String> lstConfigModeId = Arrays.asList(customerCouponNewVO.getUseVehicleModeId().split(","));
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
			
			if(StringUtils.isBlank(customerCouponNewVO.getUseLowerTime()) && StringUtils.isBlank(customerCouponNewVO.getUseUpperTime())){
//				sb.append("全天24时有效；");
				sb.append("");
			}else{
				sb.append(customerCouponNewVO.getUseLowerTime() + "至"+ customerCouponNewVO.getUseUpperTime() + "时段使用；");
			}
			
			String[] useWeekDayArr = customerCouponNewVO.getUseWeekDay().split(",");
			if(useWeekDayArr.length==7){
				sb.append("");
			}else{
				sb.append("使用时间(周" + customerCouponNewVO.getUseWeekDay().replace(",", ",周") + ");");
			}
			
			if(customerCouponNewVO.getValidateDay()==null){
				sb.append("");
			}else{
				sb.append("有效期" + customerCouponNewVO.getValidateDay() + "天;");
			}
			if(customerCouponNewVO.getBaseOrderMoney()==null||customerCouponNewVO.getBaseOrderMoney()<=0.0){
				sb.append("");
			}else{
				sb.append("订单费用满"+customerCouponNewVO.getBaseOrderMoney()+"元使用;");
			}
			DecimalFormat df = new DecimalFormat( "#,##0.00 ");
			if(customerCouponNewVO.getCouponType() == CouponTypeEnum.DISCOUNT.getValue()){
				sb.append("折扣" + customerCouponNewVO.getDiscountPercent() +"%;");
				sb.append("最高减免" + df.format(customerCouponNewVO.getMaxDeductionMoney()) + "元;");
			}else{
				sb.append("优惠券金额"+df.format(customerCouponNewVO.getCouponMoney())+"元;"); 
			}
			
			customerCouponNewVO.setConfigDetail(sb.toString());
		}
		
		return list;
	}

	@Override
	public Integer getCustomerCouponNewCount(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return customerCouponNewMapper.getCustomerCouponNewCount(paramMap);
	}

	@Transactional
	@Override
	public int addCustomerCouponNewBatch(List<CustomerCouponNew> lstCoupon) {
		for (CustomerCouponNew customerCouponNew : lstCoupon) {
			String couponNo = CodingProductionUtil.getCodingByRule(1);
			Integer tempCount = this.customerCouponNewMapper.getCouponCodeIsExists(couponNo);
			if(tempCount > 0){
				couponNo = CodingProductionUtil.getCodingByRule(1);
			}
			CouponUseConfig config = svcUseConfig.getCouponUseConfig(customerCouponNew.getCouponConfigId());
			if(config == null || config.getValidateDay() == null){
				throw new RuntimeException("优惠配置不存在");
			}
			Calendar date = Calendar.getInstance();
			date.add(Calendar.DATE, config.getValidateDay());
			date.set(Calendar.HOUR_OF_DAY, 23);
			date.set(Calendar.MINUTE, 59);
			date.set(Calendar.SECOND,59);
			date.set(Calendar.MILLISECOND, 0);
			customerCouponNew.setExpireDate(date.getTime());
			customerCouponNew.setCreateDate(new Date());
			customerCouponNew.setCouponNo(couponNo);
			customerCouponNew.setIsUsed(CouponEnableEnum.ENABLE.getCode());
		}
		return customerCouponNewMapper.insert(lstCoupon);
	}

	@Override
	public Integer updateCustomerCouponNew(CustomerCouponNew customerCouponNew) {
		if (customerCouponNew.getExpireDate() != null) {
			Date date = customerCouponNew.getExpireDate();
			Calendar dCalendar = Calendar.getInstance();
			dCalendar.setTime(date);
			dCalendar.set(Calendar.HOUR_OF_DAY, 23);
			dCalendar.set(Calendar.MINUTE, 59);
			dCalendar.set(Calendar.SECOND, 59);
			dCalendar.set(Calendar.MILLISECOND, 0);
			customerCouponNew.setExpireDate(dCalendar.getTime());
		}
		return customerCouponNewMapper.updateCustomerCouponNew(customerCouponNew);
	}
	
	@Override
	public Integer updateCustomerCouponNewIsUsed(Integer couponId){
		return customerCouponNewMapper.updateCustomerCouponNewIsUsed(couponId);
	}

	@Override
	public Integer deleteCustomerCouponNew(List<Integer> idList) {
		return customerCouponNewMapper.deleteCustomerCouponNew(idList);
	}

	@Override
	public CustomerCouponNew selectById(Integer id) {
		return customerCouponNewMapper.selectById(id);
	}

	@Override
	public int getCouponCodeIsExists(String couponCode) {
		return this.customerCouponNewMapper.getCouponCodeIsExists(couponCode);
	}

	@Override
	public CustomerCouponNewVO getCustomerCouponNewVOByCouponId(Integer couponId) {
		return customerCouponNewMapper.getCustomerCouponNewVOByCouponId(couponId);
	}
	
	

}
