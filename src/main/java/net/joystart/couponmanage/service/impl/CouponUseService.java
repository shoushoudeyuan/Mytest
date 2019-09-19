package net.joystart.couponmanage.service.impl;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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
import org.springframework.stereotype.Component;

import net.joystart.city.entity.ServiceCity;
import net.joystart.city.service.IServiceCitySerivce;
import net.joystart.common.util.date.DateDiffUtil;
import net.joystart.common.util.date.UtilTimeFormatter;
import net.joystart.coupon.dao.CouponMapper;
import net.joystart.coupon.entity.Coupon;
import net.joystart.coupon.entity.CustomerCoupon;
import net.joystart.coupon.service.ICouponService;
import net.joystart.coupon.service.ICustomerCouponService;
import net.joystart.couponmanage.dao.CustomerCouponNewMapper;
import net.joystart.couponmanage.entity.CouponUseConfig;
import net.joystart.couponmanage.entity.CustomerCouponNew;
import net.joystart.couponmanage.entity.CustomerCouponNewVO;
import net.joystart.couponmanage.enums.CouponTypeEnum;
import net.joystart.couponmanage.service.ICustomerCouponNewService;
import net.joystart.order.entity.Order;
import net.joystart.order.remote.service.IOrderRemoteService;
import net.joystart.vehicle.entity.CarType;
import net.joystart.vehicle.entity.Vehicle;
import net.joystart.vehicle.remote.service.ICarTypeRemoteService;
import net.joystart.vehicle.remote.service.IVehicleRemoteService;

@Component
public class CouponUseService {

	@Autowired
	private ICouponService svcCoupon;
	
	@Autowired
	private ICustomerCouponService customerCouponService;
	
	@Autowired
	private IOrderRemoteService orderService;
	
	@Autowired
	private IVehicleRemoteService vehicleRemoteService;
	
	@Autowired
	private CustomerCouponNewMapper daoCustomerCoupon;
	
	@Resource
	private CouponMapper daoOldCouponMapper;
	
	@Autowired
	private ICustomerCouponNewService customerCouponNewService;
	
	@Autowired
	private IServiceCitySerivce svcCity;

	@Autowired
	private ICarTypeRemoteService carTypeRemoteService;
	
	public List<Coupon> CouponList(Integer customerId) {
		List<Coupon> lstCoupon = new ArrayList<>();
		lstCoupon.addAll(newCouponList(customerId,null));
		lstCoupon.addAll(oldCouponList(customerId));
		return lstCoupon;
	}
	

	public List<Coupon> CouponList(Integer customerId,Integer orderId){
		List<Coupon> lstCoupon = new ArrayList<>();
		lstCoupon.addAll(newCouponList(customerId,orderId));
		lstCoupon.addAll(oldCouponList(customerId));
		return lstCoupon;
	}
	
	public List<Coupon> historyCoupon(Integer customerId,Integer pageSize,Integer pageNumber){
		List<Coupon> lstCoupon = new ArrayList<>();
		lstCoupon.addAll(newHistoryCouponList(customerId,pageSize,pageNumber));
		if(lstCoupon.size() == 0)
			lstCoupon.addAll(oldHistoryCouponList(customerId,pageSize,pageNumber));
		
		return lstCoupon;
	}
	
	public CustomerCoupon getCouponById(Integer id){
		if(id < 150000)
			return customerCouponService.selectByPrimaryKey(id);
		else
			return getCustomerCouponNewById(id);
	}
	
	public Coupon getCouponByOrderId(Integer orderId){
		CustomerCouponNewVO coupon = daoCustomerCoupon.selectByOrderId(orderId);
		if(coupon == null){
			return daoOldCouponMapper.getCouponByOrderId(orderId);
		}
			
			
		List<CustomerCouponNewVO> lstNewCoupon = new ArrayList<>();
		lstNewCoupon.add(coupon);
		List<Coupon> lstCoupon = ConvertCoupon(lstNewCoupon,null,true);
		return lstCoupon.get(0);
	}
	

	public Integer setCustomerCouponIsUsed(Coupon coupon){
		if(coupon.getId() < 150000){
			return daoOldCouponMapper.update(coupon);
		}else{
			return setNewCouponIsUsed(coupon.getId());
		}
	}
	
	private List<Coupon> newHistoryCouponList(Integer customerId,Integer pageSize,Integer pageNumber){
		Map<String, Object> params = new HashMap<String, Object>();
		if (pageSize != null)
			params.put("pageSize", pageSize);
		else
			params.put("pageSize", 10);

		if (pageNumber != null && pageNumber > 1)
			params.put("pageIndex", (pageNumber - 1) * pageSize);
		else
			params.put("pageIndex", 0);
		
		params.put("customerId", customerId);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		params.put("expireDate", sdf.format(new Date()));
		List<CustomerCouponNewVO> lstNewCoupon = daoCustomerCoupon.selectHistoryCoupon(params);
		List<Coupon> lstCoupon = ConvertCoupon(lstNewCoupon,null,true);
		
		return lstCoupon;
	}
	
	private List<Coupon> oldHistoryCouponList(Integer customerId,Integer pageSize,Integer pageNumber){
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("customerId", customerId);
		
		if (pageSize != null)
			params.put("pageSize", pageSize);
		else
			params.put("pageSize", 10);

		if (pageNumber != null && pageNumber > 1)
			params.put("pageIndex", (pageNumber - 1) * pageSize);
		else
			params.put("pageIndex", 0);
		
		List<Coupon> list = svcCoupon.historyCoupon(params);
		
		for (Coupon coupon : list) {
			if (coupon.getType() == 1) {
				String ret = formatMoney(coupon.getDiscount() * 1.0);
				coupon.setZhekou(ret);
			}
			
			coupon.setIsUse(0);
		}
		
		return list;
	}
	
	private List<Coupon> newCouponList(Integer customerId,Integer orderId){
		Map<String,Object> params = new HashMap<>();
		params.put("isUsed", 1);
		params.put("isEnable", 1);
		params.put("expireDate", new Date());
		params.put("customerId", customerId);
		
		List<CustomerCouponNewVO> lstNewCoupon = daoCustomerCoupon.getCustomerCouponNewList(params);
		List<Coupon> lstCoupon = ConvertCoupon(lstNewCoupon,orderId,false);
		
		return lstCoupon;
	}
	
	private List<Coupon> oldCouponList(Integer customerId){
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("isExpires", 0);//未过期
		params.put("isDisable", 1);//启用
		params.put("useStatus", 0);//未使用
		params.put("isDelete", 0);//未删除
		params.put("customerId",customerId );
		
		//没有提交订单号
		List<Coupon> lstCoupon = svcCoupon.list(params);
		for (Coupon coupon : lstCoupon) {
			if (coupon.getType() == 1) {
				String ret = formatMoney(coupon.getDiscount() * 1.0);
				coupon.setZhekou(ret);
			}
			coupon.setIsUse(1);
		}
		return lstCoupon;
	}
	
	//支付中使用优惠券的方法返回特定字段
	private CustomerCoupon getCustomerCouponNewById(Integer id){
		CustomerCoupon customerCoupon = new CustomerCoupon();
		CouponUseConfig config = daoCustomerCoupon.selectCustomerCouponConfig(id);
		CustomerCouponNew newCoupon = daoCustomerCoupon.selectById(id);
		
		if(config != null && newCoupon != null && newCoupon.getIsDelete() == 1){
			customerCoupon.setId(id);
			if(config.getCouponType() == CouponTypeEnum.DISCOUNT.getValue()){
				customerCoupon.setType(1);
				customerCoupon.setDiscount(config.getDiscountPercent());
				customerCoupon.setTopDiscountMoney(config.getMaxDeductionMoney());
			}else{
				customerCoupon.setType(0);
				customerCoupon.setCouponmoney(new BigDecimal(config.getCouponMoney()));
			}

			customerCoupon.setIsdelete(0);
			customerCoupon.setIsdisable(newCoupon.getIsEnable() == 1 ? 1 : 0);
			customerCoupon.setUsestatus(newCoupon.getIsUsed() == 1 ? 0 : 1);
			Calendar dCalendar = Calendar.getInstance();
			dCalendar.setTime(newCoupon.getExpireDate());
			dCalendar.set(Calendar.HOUR_OF_DAY, 23);
			dCalendar.set(Calendar.MINUTE, 59);
			dCalendar.set(Calendar.SECOND, 59);
			dCalendar.set(Calendar.MILLISECOND, 0);
			if(dCalendar.getTime().getTime() < (new Date()).getTime())
				customerCoupon.setIsexpires(1);
			else
				customerCoupon.setIsexpires(0);
		}
		
		return customerCoupon;
	}
	
	private List<Coupon> ConvertCoupon(List<CustomerCouponNewVO> lstNewCoupon,Integer orderId,boolean isHistory){
		List<Coupon> lstCoupon = new ArrayList<>();
		Order order = null;
		Vehicle vehicle = null;
		boolean isUse = false;
		if(orderId != null && !isHistory){
			order = orderService.selectByPrimaryKey(orderId);
			vehicle = vehicleRemoteService.selectByPrimaryKey(order.getVehicleid());
		}
		
		Map<String,Object> params = new HashMap<>();
		params.put("startIndex", 0);
		params.put("pageSize", 1000);
		List<CarType> lstCarType = carTypeRemoteService.selectByParam(params);
		List<ServiceCity> lstServiceCity = svcCity.getServerCity();
		Calendar dCalendar = Calendar.getInstance();
		for(CustomerCouponNewVO vo : lstNewCoupon){
			Coupon coupon = new Coupon();
			coupon.setId(vo.getId());
			coupon.setCouponName(vo.getCouponName());
			coupon.setRuleName(vo.getConfigName());
			coupon.setCustomerId(vo.getCustomerId());
			coupon.setCouponCode(vo.getCouponNo());

			if(vo.getCouponType() == CouponTypeEnum.DEDUCTION.getValue()){
				coupon.setCouponMoney(new BigDecimal(vo.getCouponMoney()).setScale(2,BigDecimal.ROUND_HALF_UP));
				coupon.setTopDiscountMoney(0);
				coupon.setType(0);
			}else{
				String ret = formatMoney(vo.getDiscountPercent() * 1.0);
				coupon.setTopDiscountMoney(vo.getMaxDeductionMoney());
				coupon.setDiscount(vo.getDiscountPercent());
				coupon.setZhekou(ret);				
				coupon.setType(1);
			}
			
			coupon.setCouponType(0);
			coupon.setStartDate(vo.getCreateDate());
			dCalendar.setTime(vo.getExpireDate());
			dCalendar.set(Calendar.HOUR_OF_DAY, 23);
			dCalendar.set(Calendar.MINUTE, 59);
			dCalendar.set(Calendar.SECOND, 59);
			dCalendar.set(Calendar.MILLISECOND, 0);
			coupon.setEndDate(dCalendar.getTime());
			if(dCalendar.getTime().getTime() < (new Date()).getTime())
				coupon.setIsExpires(1);
			else
				coupon.setIsExpires(0);
			
			if(vo.getIsUsed() == 1){
				coupon.setUseStatus(0);
				if(isHistory)
					coupon.setHistoryType(1);
			}else{
				coupon.setUseStatus(1);
				coupon.setHistoryType(0);
			}
			
			coupon.setIsDisable(vo.getIsEnable() == 1 ? 1 : 0);
			
			
			if(isHistory){
				coupon.setIsUse(0);
			}else{
				if(orderId != null){
					isUse = filterCouponByRule(vo, order, vehicle);
					coupon.setIsUse(isUse ? 1 : 0);
				}else{
					coupon.setIsUse(coupon.getIsExpires() == 1 ? 0 : 1);
				}
			}
			
			String detail = generateConifgDetail(vo,coupon,lstCarType,lstServiceCity);
			coupon.setRemark(detail);
			
			lstCoupon.add(coupon);
		}
		
		return lstCoupon;
	}
	
	private String generateConifgDetail(CustomerCouponNewVO vo,Coupon coupon,List<CarType> lstCarType,List<ServiceCity> lstServiceCity ){
		List<String> lstConfigCityId = Arrays.asList(vo.getUseCityId().split(","));  
		List<String> lstCityName = new ArrayList<>();
		for(ServiceCity city:lstServiceCity){
			if(lstConfigCityId.contains(city.getId().toString())){
				lstCityName.add(city.getShowname());
			}
			
		}
		
		List<String> lstConfigModeId = Arrays.asList(vo.getUseVehicleModeId().split(","));
		List<String> lstConfigModeName = new ArrayList<>();
		for(CarType carType:lstCarType){
			if(lstConfigModeId.contains(carType.getId().toString())){
				lstConfigModeName.add(carType.getModelName());
			}
		}
		
		StringBuilder sb = new StringBuilder();
		if(lstCityName.size() == 0){
//			sb.append("所有城市可以使用；");
			sb.append("");
		}else{
			sb.append("只限" + StringUtils.join(lstCityName.toArray(), ",") + "使用;");
		}
		
		if(lstConfigModeName.size() == 0){
//			sb.append("适用所有车型；");
			sb.append("");
		}else{
			sb.append("以下车型可用("+ StringUtils.join(lstConfigModeName.toArray(), ",") +");");
		}
		

		if(StringUtils.isBlank(vo.getUseLowerTime()) && StringUtils.isBlank(vo.getUseUpperTime())){
//			sb.append("全天24时有效；");
			sb.append("");
		}else{
			sb.append(vo.getUseLowerTime() + "至"+ vo.getUseUpperTime() + "时段使用；");
		}
		String[] useWeekDayArr = vo.getUseWeekDay().split(",");
		if(useWeekDayArr.length==7){
			sb.append("");
		}else{
			sb.append("使用时间(周" + vo.getUseWeekDay().replace(",", ",周") + ");");
		}
		if(vo.getExpireDate()==null){
			sb.append("");
		}else{
			if(vo.getValidateDay()==null){
				sb.append("");
			}else{
				sb.append("有效期" + vo.getValidateDay() + "天;");
			}
		}
		if(vo.getBaseOrderMoney()==null||vo.getBaseOrderMoney()<=0.0){
			sb.append("");
		}else{
			sb.append("订单费用满"+vo.getBaseOrderMoney()+"元使用;");
		}
		
		DecimalFormat df = new DecimalFormat( "#,##0.00 ");
		//保留两位小数且不用科学计数法，并使用千分位
		if(vo.getCouponType() == CouponTypeEnum.DISCOUNT.getValue()){
			sb.append("折扣" + df.format(vo.getDiscountPercent()) +"%;");
			sb.append("最高减免" + vo.getMaxDeductionMoney() + "元;");
		}else{
			sb.append("优惠券金额"+df.format(vo.getCouponMoney())+"元;"); 
		}
		
		return sb.toString();
	}
	
	//过滤当前订单可以使用的优惠券
	private boolean filterCouponByRule(CustomerCouponNewVO vo,Order order,Vehicle vehicle){
		List<String> lstConfigModeId = new ArrayList<String>();
		List<String> lstConfigCityId = new ArrayList<String>();
		List<String> lstConfigWeek = new ArrayList<String>();
		if(StringUtils.isNotBlank(vo.getUseVehicleModeId())){
			lstConfigModeId = Arrays.asList(vo.getUseVehicleModeId().split(","));
		}
		if(StringUtils.isNotBlank(vo.getUseCityId())){
			lstConfigCityId = Arrays.asList(vo.getUseCityId().split(","));  
		}
		if(StringUtils.isNotBlank(vo.getUseWeekDay())){
			lstConfigWeek = Arrays.asList(vo.getUseWeekDay().split(","));  
		}
		
		if(lstConfigModeId.size() > 0 && !lstConfigModeId.contains(vehicle.getVehicleModelID().toString()))
			return false;
		
		if(lstConfigCityId.size() > 0 && !lstConfigCityId.contains(vehicle.getCityid().toString()))
			return false;
		
		if(vo.getBaseOrderMoney() != null && order.getOrdercost().doubleValue() < vo.getBaseOrderMoney())
			return false;
		
		
		Date today = new Date();
		
        Calendar c= Calendar.getInstance();
        c.setTime(today);
        Integer weekday = c.get(Calendar.DAY_OF_WEEK);
		if(weekday == 1)
			weekday = 7;
		else
			weekday = weekday - 1;
		
		if(lstConfigWeek.size() > 0 && !lstConfigWeek.contains(weekday.toString()))
			return false;
		
		if(StringUtils.isNotBlank(vo.getUseUpperTime()) && StringUtils.isNotBlank(vo.getUseLowerTime())){
			int upperHour = Integer.parseInt(vo.getUseUpperTime().split(":")[0]);
			int upperMinutes = Integer.parseInt(vo.getUseUpperTime().split(":")[1]);
			int lowerHour = Integer.parseInt(vo.getUseLowerTime().split(":")[0]);
			int lowerMinutes = Integer.parseInt(vo.getUseLowerTime().split(":")[1]);
			int currentHour = c.get(Calendar.HOUR_OF_DAY);
			int currentMinutes = c.get(Calendar.MINUTE);
			
			if(currentHour > lowerHour && currentHour < upperHour)
				return true;
			
			if(currentHour == lowerHour && currentHour == upperHour){
				if(currentMinutes >= lowerMinutes && currentMinutes <= upperMinutes)
					return true;
				else
					return false;
			}else if(currentHour == lowerHour){
				if(currentMinutes >= lowerMinutes)
					return true;
				else
					return false;
			}else if(currentHour == upperHour){
				if(currentMinutes <= upperMinutes)
					return true;
				else
					return false;
			}
			
			return false;
		}
		
		return true;
			
	}
	
	private String formatMoney(double discount){
		if (discount % 10 > 0) {
			DecimalFormat df = new DecimalFormat("######0.0");  
			Double zheKou = discount / 10.0;
			return df.format(zheKou);
		}else{
			DecimalFormat df = new DecimalFormat("######0");
			Double zheKou = discount / 10.0;
			return df.format(zheKou);
		}

	}
	
	private Integer setNewCouponIsUsed(Integer couponId){
		return customerCouponNewService.updateCustomerCouponNewIsUsed(couponId) ;
	}
	
	public boolean getIfCanUseCouponByRule(Integer couponId,Integer orderId){
		boolean isUse = false;
		Order order = orderService.selectByPrimaryKey(orderId);
		Vehicle vehicle = vehicleRemoteService.selectByPrimaryKey(order.getVehicleid());
		CustomerCouponNewVO vo = null;
		if(couponId < 150000){
			return true;
		}else{
			vo =  customerCouponNewService.getCustomerCouponNewVOByCouponId(couponId);
		}
		if(vo!=null){
			Calendar dCalendar = Calendar.getInstance();
			dCalendar.setTime(vo.getExpireDate());
			dCalendar.set(Calendar.HOUR_OF_DAY, 23);
			dCalendar.set(Calendar.MINUTE, 59);
			dCalendar.set(Calendar.SECOND, 59);
			dCalendar.set(Calendar.MILLISECOND, 0);
			if(dCalendar.getTime().getTime() < (new Date()).getTime()){
				return false;
			}
			if(vo.getIsUsed() == 2 || vo.getIsEnable()==2){
				return false;
			}
			isUse = filterCouponByRule(vo, order, vehicle);
		}
		return isUse;
	}
}
