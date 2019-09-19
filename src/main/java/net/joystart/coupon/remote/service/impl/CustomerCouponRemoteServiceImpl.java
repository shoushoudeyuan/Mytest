package net.joystart.coupon.remote.service.impl;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.dubbo.config.annotation.Service;

import net.joystart.common.util.CodingProductionUtil;
import net.joystart.common.util.date.UtilTimeFormatter;
import net.joystart.common.util.log.Log4jTask;
import net.joystart.coupon.dao.CouponMapper;
import net.joystart.coupon.dao.CouponRuleDetailMapper;
import net.joystart.coupon.dao.CustomerCouponMapper;
import net.joystart.coupon.entity.Coupon;
import net.joystart.coupon.entity.CouponRuleDetail;
import net.joystart.coupon.entity.CustomerCoupon;
import net.joystart.coupon.remote.service.ICustomerCouponRemoteService;
import net.joystart.coupon.service.impl.CustomerCouponService;
import net.joystart.customer.entity.Customer;
import net.joystart.coupon.entity.RuleItem;
import net.joystart.customer.remote.service.ICustomerRemoteService;
import net.joystart.invoice.entity.CustomerInvoice;
import net.joystart.invoice.remote.service.ICustomerInvoiceRemoteService;

@Service(timeout=60000,retries=0,interfaceClass=ICustomerCouponRemoteService.class)
public class CustomerCouponRemoteServiceImpl implements ICustomerCouponRemoteService {

	@Resource
	CustomerCouponMapper customerCouponMapper;
	
	@Resource
	ICustomerRemoteService customerRemoteService;
	
	@Resource
	ICustomerInvoiceRemoteService customerInvoiceRemoteService;
	
	@Autowired
    private CouponRuleDetailMapper couponRuleDetailMapper;
	
	@Autowired
    private CouponMapper couponMapper;
	
	@Override
	public List<CustomerCoupon> getCustomerCouponList(Map params) {
		// TODO Auto-generated method stub
		return this.customerCouponMapper.selectAll(params);
	}

	@Override
	public int getCount(Map params)
	{
		return this.customerCouponMapper.selectCount(params);
	}
	
	public int deleteCustomerCoupon(Integer id,Integer sysId)
	{
		CustomerCoupon coupon = new CustomerCoupon();
		coupon.setId(id);
		coupon.setIsdelete(1);
		coupon.setModifyUser(sysId);
		return this.customerCouponMapper.updateByPrimaryKeySelective(coupon);
	}
	
	public int updateCustomerCoupon(CustomerCoupon coupon)
	{
		Customer customer = null;
		if(!StringUtils.isBlank(coupon.getMobile()))
		{
			customer = this.customerRemoteService.getUserInfoByMobile(coupon.getMobile());
			
			if(customer != null){
				coupon.setCustomerid(customer.getId());
			}
		}
		else {
			coupon.setCustomerid(null);
		}
		
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");// 设置显示格式
		
		try {
			coupon.setStartdate(df.parse(coupon.getStartdateNew()));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		try {
			coupon.setEnddate(df.parse(coupon.getEnddateNew()));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		Date dtNow = new Date();
		if(coupon.getStartdate().getTime() > dtNow.getTime()){
			coupon.setIsexpires(2);
		}
		else{
			coupon.setIsexpires(0);
		}
		
		coupon.setIsthirdparty(0);
		//coupon.setFromenum(4);
		
//		coupon.setUsestatus(0); 
		coupon.setIsdelete(0);
		
		return this.customerCouponMapper.updateByPrimaryKeySelective(coupon);
	}
	
	public int insertCustomerCoupon(CustomerCoupon coupon)
	{
		Customer customer = null;
		if(!StringUtils.isBlank(coupon.getMobile()))
		{
			customer = this.customerRemoteService.getUserInfoByMobile(coupon.getMobile());
			
			if(customer != null)
			{
				coupon.setCustomerid(customer.getId());
			}
		}

		String code = CodingProductionUtil.getCodingByRule(1);
		Integer tempCount = this.customerCouponMapper.getCountByCode(code);
		if(tempCount>0)
		{
			code = CodingProductionUtil.getCodingByRule(1);
		}
		
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");// 设置显示格式
		DateFormat df2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");// 设置显示格式
		
		try {
			coupon.setStartdate(df.parse(coupon.getStartdateNew()));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		try {
			String str = coupon.getEnddateNew() + " 23:59:59";
			coupon.setEnddate(df2.parse(str));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		Date dtNow = new Date();
		if(coupon.getStartdate().getTime() > dtNow.getTime()){
			coupon.setIsexpires(2);
		}
		else{
			coupon.setIsexpires(0);
		}
		
		coupon.setCouponcode(code);
		coupon.setCreatedate(new Date());
		coupon.setIsthirdparty(0);
		coupon.setFromenum(9);
		coupon.setUsestatus(0);
		coupon.setIsdelete(0);
		return this.customerCouponMapper.insertSelective(coupon);
	}
	
	public CustomerCoupon selectCustomerCoupon(Integer id)
	{
		return this.customerCouponMapper.selectById(id);
	}
	
	@Transactional
	public int insertLotCoupon(CustomerCoupon coupon)
	{
		try {
			Date dtNow = new Date();
			//循环判断输入的数量
			for(int i=0;i<coupon.getProduceCount();i++)
			{
				String code = CodingProductionUtil.getCodingByRule(1);
				Integer tempCount = this.customerCouponMapper.getCountByCode(code);
				if(tempCount>0)
				{
					code = CodingProductionUtil.getCodingByRule(1);
				}
				coupon.setCouponcode(code);
				
				coupon.setStartdate(dtNow);
				coupon.setCreatedate(new Date());
				coupon.setFromenum(9);
				coupon.setIsexpires(0);
				coupon.setUsestatus(0);
				coupon.setIsdelete(0);
				
				this.customerCouponMapper.insertSelective(coupon);
			}
			
			return 1;
		} catch (Exception e) {
			// TODO: handle exception
			return 0;
		}
	}
	
	public List<CustomerInvoice> getInvoiceList(Map params)
	{
		return this.customerInvoiceRemoteService.getInvoiceList(params);
	}
	
	public int getInvoiceCount(Map params)
	{
		return this.customerInvoiceRemoteService.getInvoiceCount(params);
	}
	
	public int updateInvoiceStatus(Integer id)
	{
		CustomerInvoice invoice = new CustomerInvoice();
		invoice.setId(id);
		invoice.setIsopen(new Byte("1"));
		
		return this.customerInvoiceRemoteService.updateByPrimaryKeySelective(invoice);	
	}
	public void presentCoupon(Integer customerId) {
        Customer cus = this.customerRemoteService.selectByPrimaryKey(customerId);
		boolean isSend = false; // 是否发送
		boolean isSendRecommend = false; // 推荐人是否发送过礼券;
		// 如果没有赠送过，则赠送一次
		if (cus.getIsSendCoupon().intValue() == 0) {
			try {
                // 获取注册规则
                List<CouponRuleDetail> crList = couponRuleDetailMapper.selectByIdentification("CUSTOMER_REG");
                if (crList != null) {
                    for (int i = 0; i < crList.size(); i++) {
                        CouponRuleDetail cRuleDetail = crList.get(i);
                        Coupon cou = new Coupon();
                        String code = CodingProductionUtil.getCodingByRule(1);
                        Integer tempCount = couponMapper.getCountByCode(code);
                        if (tempCount > 0) {
                            code = CodingProductionUtil.getCodingByRule(1);
                        }
                        cou.setCouponCode(code);
                        if (cRuleDetail.getPresentmoney() != null) {
                            BigDecimal pMoney = new BigDecimal(cRuleDetail.getPresentmoney());
                            cou.setCouponMoney(pMoney);
                        }
                        cou.setRemark(cRuleDetail.getReamark());
                        cou.setFromEnum(0);// 用户注册
                        cou.setStartDate(new Date());
                        cou.setCreateDate(new Date());
                        cou.setEndDate(UtilTimeFormatter.afterNDay(cRuleDetail.getValidday()));
                        cou.setIsExpires(0);
                        cou.setCouponType(0);
                        cou.setCustomerId(cus.getId());
                        cou.setUseStatus(0);
                        cou.setIsDisable(1);
                        cou.setType(cRuleDetail.getType());
                        cou.setTopDiscountMoney(cRuleDetail.getTopDiscountMoney());
                        cou.setDiscount(cRuleDetail.getDiscount());
                        cou.setIsTimeControl(cRuleDetail.getTimecontrol());
                        for (int j = 0; j < cRuleDetail.getPresentcoumt(); j++) {
                            insertCoupon(cou);
                        }
                    }
                    isSend = true;
                }
            } catch (Exception ex) {
				Log4jTask.addLog("获取优惠卷规则报错", System.currentTimeMillis(), Log4jTask.ERROR, Coupon.class.getName(), ex);
			}
		}
		
		if (cus.getIsSendRecommendCoupon().intValue() == 0) {
    		try {
    		    if (cus.getRecommendcode() != null && !("".equals(cus.getRecommendcode().trim()))) {
    				// 优惠券兑换,如果当时用户未认证,则只给当前用户发送优惠券,等待该用户认证通过时,再给推荐人发送优惠券;
    		        Customer TempCus = customerRemoteService.getIdByInvitationCode(cus);
    				if (TempCus != null) {
    					List<CouponRuleDetail> crList = couponRuleDetailMapper.selectByIdentification("CUSTOMER_Recommend");
    						// 获取推荐好友规则
    						if (crList != null) {
    							for (int i = 0; i < crList.size(); i++) {
    								CouponRuleDetail cRuleDetail = crList.get(i);
    								Coupon cou = null;
    	                            String code = null;
    	                            Integer tempCount = null;
    								for (int j = 0; j < cRuleDetail.getPresentcoumt(); j++) {
    								    cou = new Coupon();
    								    Date date = new Date();
    								    code = CodingProductionUtil.getCodingByRule(3);
    								    tempCount = couponMapper.getCountByCode(code);
    								    if (tempCount > 0)
    								        code = CodingProductionUtil.getCodingByRule(3);
    								    
    								    cou.setCouponCode(code);
    								    cou.setCouponMoney(cRuleDetail.getPresentmoney() == null ? null
    								            : new BigDecimal(cRuleDetail.getPresentmoney()));
    								    cou.setRemark(cRuleDetail.getReamark());
    								    cou.setFromEnum(1);// 推荐好友
    								    cou.setStartDate(date);
    								    cou.setCreateDate(date);
    								    cou.setEndDate(UtilTimeFormatter.afterNDay(cRuleDetail.getValidday(), date));
    								    cou.setIsExpires(0);
    								    cou.setCouponType(Integer.valueOf(cRuleDetail.getUsingtype().toString()));
    								    cou.setCustomerId(TempCus.getId());
    								    cou.setUseStatus(0);
    								    cou.setIsDisable(1);
    								    cou.setIsTimeControl(cRuleDetail.getTimecontrol());
    								    cou.setType(cRuleDetail.getType());
    								    cou.setTopDiscountMoney(cRuleDetail.getTopDiscountMoney());
    								    cou.setDiscount(cRuleDetail.getDiscount());
    									insertCoupon(cou);
    								}
    							}
    						}
    						isSendRecommend = true;
    				}
    		    }
    		} catch (Exception exception) {
    		    Log4jTask.addLog("给推荐人发送优惠券异常", System.currentTimeMillis(), Log4jTask.ERROR, Coupon.class.getName(),
    		            exception);
    		}
		}
		
		Customer customer = new Customer();
        customer.setId(cus.getId());
        // 如果赠送了优惠卷
        if (isSend)
            customer.setIsSendCoupon(1);

        if (isSendRecommend)
            customer.setIsSendRecommendCoupon(1);

        if (isSend || isSendRecommend)
            customerRemoteService.updaeCustomer(customer);

	}
	
	@Override
    public int insertCoupon(Coupon record) {
        int insettCou = 0;
        try {

            insettCou = this.couponMapper.insert(record);
        } catch (Exception ex) {
            Log4jTask.addLog("添加优惠卷报错", System.currentTimeMillis(), Log4jTask.ERROR, Coupon.class.getName(), ex);
        }
        return insettCou;
    }
	@Override
	public CustomerCoupon selectByPrimaryKey(Integer couponId) {
		// TODO Auto-generated method stub
		return customerCouponMapper.selectByPrimaryKey(couponId);
	}

	@Override
	public List<Map<String, Object>> geCouponList(Map params) {
		// TODO Auto-generated method stub
		return customerCouponMapper.geCouponList(params);
	}

	@Override
	public int geCouponListCount(Map params) {
		// TODO Auto-generated method stub
		return customerCouponMapper.geCouponListCount(params);
	}
}
