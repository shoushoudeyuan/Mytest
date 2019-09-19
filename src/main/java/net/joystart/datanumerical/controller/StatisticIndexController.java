package net.joystart.datanumerical.controller;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.MessageFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import net.joystart.carmanager.remote.service.ICarManagerRemoteService;
import net.joystart.common.cache.ICache;
import net.joystart.common.cache.ICacheFunction;
import net.joystart.common.cache.RedisCache;
import net.joystart.common.controller.BaseController;
import net.joystart.common.database.DataSourceAspect;
import net.joystart.common.entity.RedisKey;
import net.joystart.common.util.ConstantUtil;
import net.joystart.common.util.MessageResult;
import net.joystart.common.util.log.Log4jTask;
import net.joystart.customer.remote.service.ICustomerRemoteService;
import net.joystart.datanumerical.entity.OrderStatistic;
import net.joystart.datanumerical.entity.RealIncomeFourteenDays;
import net.joystart.datanumerical.entity.StatisticsCarPort;
import net.joystart.datanumerical.utils.DateUtil;
import net.joystart.order.remote.service.IOrderRemoteService;
import net.joystart.vehicle.remote.service.ICarPortRemoteService;
import net.joystart.vehicle.remote.service.IParkinglotRemoteService;
import net.joystart.vehicle.remote.service.IVehicleRemoteService;

/**
 * @ClassName StatisticIndexController
 * @Description 统计首页
 * @author zhuwq
 * @Date 2017年4月13日 下午4:22:13
 * @version 1.0.0
 */
@Controller
@RequestMapping("/statisticIndex")
public class StatisticIndexController extends BaseController {
	
    @Resource
    private IOrderRemoteService orderRemoteService;
    
    @Autowired
    IVehicleRemoteService vehicleRemoteService;
    
    @Autowired
    ICarPortRemoteService carPortRemoteService;
    
    @Autowired 
    IParkinglotRemoteService parkinglotRemoteService;
    
    @Autowired
    private ICustomerRemoteService customerService;
    
    @Autowired
    private ICarManagerRemoteService carManagerRemoteService;
    
    @Resource
	private RedisTemplate<String, Object> redisTemplate;
    
	/**
	 * @Description 实际收入折线图数据
	 * @param response
	 * @author zhuwq
	 * @param request
	 */
	@RequestMapping("/realIncomeMoney")
	public void realIncomeMoney(HttpServletResponse response, HttpServletRequest request) {
	    Map<String, Object> params = new HashMap<String, Object>();
	    ICache<MessageResult> redisCache = new RedisCache<>();
	    MessageResult result = new MessageResult();
	    String key = MessageFormat.format(RedisKey.CACHE_STATISTICCONTROLLER, DataSourceAspect.getCurrentDataSource(),"realIncomeMoney");
	    result = redisCache.getIfNotExistThenSetCache(key, new ICacheFunction() {
			@Override
			public Object queryResult() {
				List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();
		        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		        Date startDate = DateUtil.getNextDate(-14);
		        Date endDate = DateUtil.getNextDate(-1);
		        MessageResult res = new MessageResult(); 
		        try {
		            params.put("startDate", df.format(startDate));
		            params.put("endDate", df.format(new Date()));
		            List<RealIncomeFourteenDays> list = orderRemoteService.getRealIncomeFourteenDays(params);
		            List<Date> lDate = DateUtil.findDates(df.format(startDate), df.format(endDate));  
		            Map<String, Object> map =  null;
		            for (int i=0;i<lDate.size();i++) {
		                map = new HashMap<String, Object>();
		                String dateStr = df.format(lDate.get(i));
		                map.put("date", dateStr);
		                map.put("duration", 0);
		                for (RealIncomeFourteenDays realIncomeFourteenDays : list) {
		                    if(realIncomeFourteenDays.getDate().equals(dateStr)){
		                        map.put("date", dateStr);
		                        map.put("duration", realIncomeFourteenDays.getMoney());
		                        break;
		                    }
		                }
		                if(i==0){
		                    map.put("lineColor", "#48CDD6");
		                }
		                if(i==6){
		                    map.put("lineColor", "#00ABF0");
		                }
		                resultList.add(map);
		            }           
		            res = new MessageResult(ConstantUtil.M_SUCCESS, "成功", resultList.toArray());
		        } catch (Exception e) {
		        	res = new MessageResult(ConstantUtil.M_SYSTEM_ERROR, "统计实际收入折线图数据");
		            Log4jTask.addLog("统计实际收入折线图数据", System.currentTimeMillis(), Log4jTask.ERROR,
		                    StatisticIndexController.class.getName(), e);
		        }
		        return res;
			}
		}, 300);
	    out(response, result);
	}
	/**
	 * @Description 车辆信息统计
	 * @author zhuwq
	 * @param response
	 * @param request
	 */
	@RequestMapping("/vehicleInfoCount")
    public void carInfoCount(HttpServletResponse response, HttpServletRequest request) {
        MessageResult result = new MessageResult();
        ICache<MessageResult> redisCache = new RedisCache<>();
	    String key = MessageFormat.format(RedisKey.CACHE_STATISTICCONTROLLER, DataSourceAspect.getCurrentDataSource(),"carInfoCount");
	    result = redisCache.getIfNotExistThenSetCache(key, new ICacheFunction() {
			@Override
			public Object queryResult() {
				List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();
		        Map<String, Object> params = new HashMap<String, Object>();
		        MessageResult res = new MessageResult();
		        try {
		            int allCount = vehicleRemoteService.selectOoperatingVehicleCount(params);//所有车辆
		            params.put("type","under");
		            int undervehicleCount = vehicleRemoteService.selectOoperatingVehicleCount(params);//下架车辆(禁用车辆)
		            int operatingvehicleCount = allCount-undervehicleCount;//运营车辆
		            Map<String, Object> operatingMap =  new HashMap<String, Object>();   
		            operatingMap.put("name", "运营车辆");
		            operatingMap.put("value", operatingvehicleCount);
		            resultList.add(operatingMap);
		            Map<String, Object> underMap =  new HashMap<String, Object>();   
		            underMap.put("name", "下线车辆");
		            underMap.put("value", undervehicleCount);
		            resultList.add(underMap);
		            Map<String, Object> json = new HashMap<String, Object>();
		            json.put("charts", resultList.toArray());//饼图需要数据
		            json.put("allCount", allCount);//全部车辆
		            json.put("operatingvehicleCount", operatingvehicleCount);//运营车辆
		            res = new MessageResult(ConstantUtil.M_SUCCESS, "成功", json);
		        } catch (Exception e) {
		        	res = new MessageResult(ConstantUtil.M_SYSTEM_ERROR, "车辆信息统计");
		            Log4jTask.addLog("车辆信息统计", System.currentTimeMillis(), Log4jTask.ERROR,
		                    StatisticIndexController.class.getName(), e);
		        }
		        return res;
			}
		}, 300);
	    out(response, result);
    }
	
	/**
     * @Description 车场信息统计
     * @author zhuwq
     * @param response
     * @param request
     */
    @RequestMapping("/vehicleParkInfoCount")
    public void vehicleParkInfoCount(HttpServletResponse response, HttpServletRequest request) {
        MessageResult result = new MessageResult();
        ICache<MessageResult> redisCache = new RedisCache<>();
	    String key = MessageFormat.format(RedisKey.CACHE_STATISTICCONTROLLER, DataSourceAspect.getCurrentDataSource(),"vehicleParkInfoCount");
	    result = redisCache.getIfNotExistThenSetCache(key, new ICacheFunction() {
			@Override
			public Object queryResult() {
				MessageResult res = new MessageResult();
				 List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();
			        try {
			            StatisticsCarPort statisticsCarPort = carPortRemoteService.selectCarPortCount();
			            int allCount = statisticsCarPort.getAllCarPort(); //全部车位
			            int usedCount = statisticsCarPort.getUsedCarPort();//已占车位
			            int canUseCount = allCount-usedCount;//可用车位
			            Map<String, Object> canUseMap =  new HashMap<String, Object>();   
			            canUseMap.put("name", "可用车位");
			            canUseMap.put("value", canUseCount);
			            resultList.add(canUseMap);
			            Map<String, Object> usedMap =  new HashMap<String, Object>();   
			            usedMap.put("name", "已占车位");
			            usedMap.put("value", usedCount);
			            resultList.add(usedMap);
			            
			            //统计车场总数：
			            int parklotCount = parkinglotRemoteService.allparkinglotCount();
			            
			            //统计网点
			            int branckCount = parkinglotRemoteService.allBranchCount();
			            
			            Map<String, Object> json = new HashMap<String, Object>();
			            json.put("charts", resultList.toArray());//饼图需要数据
			            json.put("allCount", allCount);//全部车位
			            json.put("usedCount", usedCount);//已占车位
			            json.put("canUseCount", canUseCount);//可用车位
			            json.put("parklotCount", parklotCount);//车场总数
			            json.put("branckCount", branckCount);//车场总数
			            res = new MessageResult(ConstantUtil.M_SUCCESS, "成功", json);
			        } catch (Exception e) {
			        	res = new MessageResult(ConstantUtil.M_SYSTEM_ERROR, "车场信息统计");
			            Log4jTask.addLog("车场信息统计", System.currentTimeMillis(), Log4jTask.ERROR,
			                    StatisticIndexController.class.getName(), e);
			        }
			        return res;
			}
		}, 300);
	    out(response, result);
    }
    
    /**
     * @Description 用户信息统计
     * @author zhuwq
     * @param response
     * @param request
     */
    @RequestMapping("/userInfoCount")
    public void userInfoCount(HttpServletResponse response, HttpServletRequest request) {
        MessageResult result = new MessageResult();
        ICache<MessageResult> redisCache = new RedisCache<>();
	    String key = MessageFormat.format(RedisKey.CACHE_STATISTICCONTROLLER, DataSourceAspect.getCurrentDataSource(),"userInfoCount");
	    result = redisCache.getIfNotExistThenSetCache(key, new ICacheFunction() {
			@Override
			public Object queryResult() {
				MessageResult res = new MessageResult();
				List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();
		        Map<String, Object> params = new HashMap<String, Object>();
		        try {
		            //注册总数
		            int allCount = customerService.customerInfoCount(params);
		            params.put("type", "nonmalUser");
		            //普通用户
		            int nonmalUserCount = customerService.customerInfoCount(params);
		            params.put("type", "bondUser");
		            //保证金用户
		            int bondUserCount = customerService.customerInfoCount(params);
		            //非保证金用户=总数-普通用户-保证金用户
		            int nobondUserCount = allCount-nonmalUserCount-bondUserCount;
		            //认证用户=保证金用户+非保证金用户
		            int authenticationCount = bondUserCount+nobondUserCount;
		            
		            Map<String, Object> nonmalUserMap =  new HashMap<String, Object>();   
		            nonmalUserMap.put("name", "普通用户");
		            nonmalUserMap.put("value", nonmalUserCount);
		            resultList.add(nonmalUserMap);
		            Map<String, Object> bondUserMap =  new HashMap<String, Object>();   
		            bondUserMap.put("name", "保证金用户");
		            bondUserMap.put("value", bondUserCount);
		            resultList.add(bondUserMap);
		            Map<String, Object> nobondUserMap =  new HashMap<String, Object>();   
		            nobondUserMap.put("name", "意向用户");
		            nobondUserMap.put("value", nobondUserCount);
		            resultList.add(nobondUserMap);
		            Map<String, Object> json = new HashMap<String, Object>();
		            json.put("charts", resultList.toArray());//饼图需要数据
		            json.put("allCount", allCount);//注册总数
		            json.put("bondUserCount", bondUserCount);//保证金用户
		            json.put("authenticationCount", authenticationCount);//认证用户
	            	res = new MessageResult(ConstantUtil.M_SUCCESS, "成功", json);
	            	return res;
		        } catch (Exception e) {
		        	res = new MessageResult(ConstantUtil.M_SYSTEM_ERROR, "用户信息统计");
		            Log4jTask.addLog("用户信息统计", System.currentTimeMillis(), Log4jTask.ERROR,
		                    StatisticIndexController.class.getName(), e);
		            return null;
		        }
			}
		}, 300);
	    out(response, result);
    }
    
    /**
     * @Description 统计信息
     * @author zhuwq
     * @param response
     * @param request
     */
    @RequestMapping("/statisticDataInfo")
    public void statisticDataInfo(HttpServletResponse response, HttpServletRequest request) {
        MessageResult result = new MessageResult();
        ICache<MessageResult> redisCache = new RedisCache<>();
	    String key = MessageFormat.format(RedisKey.CACHE_STATISTICCONTROLLER, DataSourceAspect.getCurrentDataSource(),"statisticDataInfo");
	    result = redisCache.getIfNotExistThenSetCache(key, new ICacheFunction() {
			@Override
			public Object queryResult() {
				MessageResult res = new MessageResult();
				Map<String, Object> params = new HashMap<String, Object>();
		        Map<String, Object> weekParams = new HashMap<String, Object>();
		        Map<String, Object> atWorkParams = new HashMap<String, Object>();
		        try {
		            OrderStatistic allOrderStatistic = orderRemoteService.getOrderStatistic(params);
		            //累计订单租金收入
		            BigDecimal allOrderCost = allOrderStatistic.getOrderCost();
		            //累计订单实际收入
		            BigDecimal allActualPaymentCost = allOrderStatistic.getActualPaymentCost();
		            //成交总数
		            int allPayCount = allOrderStatistic.getPayCount();
		            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		            String today = df.format(new Date());
		            String nextDay = df.format(DateUtil.getNextDate(1));
		            params.put("type", "today");
		            params.put("startTime", today);
		            params.put("endTime", nextDay);
		            OrderStatistic orderStatistic = orderRemoteService.getOrderStatistic(params);
		            //本日订单租金收入
		            BigDecimal orderCost = orderStatistic.getOrderCost();
		            //本日订单实际收入
		            BigDecimal actualPaymentCost = orderStatistic.getActualPaymentCost();
		            //本日成交总数
		            int payCount = orderStatistic.getPayCount();
		            
		            //周活跃
		            Date startDate = DateUtil.getNextDate(-7);
		            Date endDate = new Date();
		            weekParams.put("startDate", df.format(startDate));
		            weekParams.put("endDate", df.format(endDate));
		            int weekActiveCount = orderRemoteService.getWeekActiveCount(weekParams);
		            //在租车辆
		            int rentCarCount = vehicleRemoteService.selectVehicleCarCount(new HashMap<String, Object>());
		            //在岗人员
		            atWorkParams.put("workstatus", 2);
		            int atWorkManagerCount = carManagerRemoteService.carManagerCount(atWorkParams);
		            
		            Map<String, Object> json = new HashMap<String, Object>();
		            json.put("allOrderCost", allOrderCost!=null?DecimalFormat.getNumberInstance().format(allOrderCost):new BigDecimal(0.00));//累计订单租金收入
		            json.put("allActualPaymentCost", allActualPaymentCost!=null?DecimalFormat.getNumberInstance().format(allActualPaymentCost):new BigDecimal(0.00));//累计订单实际收入
		            json.put("allPayCount", allPayCount);//成交总数
		            json.put("orderCost", orderCost!=null?DecimalFormat.getNumberInstance().format(orderCost):new BigDecimal(0.00));//本日订单租金收入
		            json.put("actualPaymentCost", actualPaymentCost!=null?DecimalFormat.getNumberInstance().format(actualPaymentCost):new BigDecimal(0.00));//本日订单实际收入
		            json.put("payCount", payCount);//本日成交总数
		            json.put("weekActiveCount", weekActiveCount);//周活跃
		            json.put("rentCarCount", rentCarCount);//在租车辆
		            json.put("atWorkManagerCount", atWorkManagerCount);//在岗人员
		            res = new MessageResult(ConstantUtil.M_SUCCESS, "成功", json);
		        } catch (Exception e) {
		        	res = new MessageResult(ConstantUtil.M_SYSTEM_ERROR, "车辆信息统计");
		            Log4jTask.addLog("基本信息统计", System.currentTimeMillis(), Log4jTask.ERROR,
		                    StatisticIndexController.class.getName(), e);
		        }
		        return res;
			}
		},300);
	    out(response, result); 
    }
}
