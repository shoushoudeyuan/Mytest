package net.joystart.coupon.service.impl;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import net.joystart.common.util.CodingProductionUtil;
import net.joystart.common.util.date.UtilTimeFormatter;
import net.joystart.coupon.dao.CouponMapper;
import net.joystart.coupon.dao.CouponRuleDetailMapper;
import net.joystart.coupon.entity.Coupon;
import net.joystart.coupon.entity.CouponOld;
import net.joystart.coupon.entity.CouponRuleDetail;
import net.joystart.coupon.service.ICouponService;
import net.joystart.customer.entity.Customer;
import net.joystart.customer.entity.Integral;
import net.joystart.customer.remote.service.ICustomerRemoteService;
import net.joystart.customer.remote.service.IIntegralRemoteService;

@Transactional
@Component("couponService")
public class CouponServiceImpl implements ICouponService {

	@Resource
	CouponMapper couponMapper;

	@Resource
	CouponRuleDetailMapper couponRuleDetailMapper;
	
	@Resource
	ICustomerRemoteService customerRemoteService;

	@Resource
	IIntegralRemoteService integralRemoteService;

	@Override
	public int insert(Coupon coupon) {
		return this.couponMapper.insert(coupon);
	}

	@Transactional
	public Integer update(Coupon coupon) {
		Integer update = this.couponMapper.update(coupon);
		return update;

	}

	@Override
	@Transactional
	// 用户通过积分兑换优惠卷方法
	public Integer saveIntegralExchange(int customerid, int RuleDetailID, int count) {
		// 定义返回标识 0代表失败
		Integer result = 1;

		// 根据用户选择的规则详细ID，获取此规则详细的具体内容
		CouponRuleDetail detail = new CouponRuleDetail();
		detail.setId(RuleDetailID);
		detail.setStatus(1);
		CouponRuleDetail ruleDetail = this.couponRuleDetailMapper.selectDetailById(detail);
		if (ruleDetail != null) {
			// 获取用户当前积分,用来判断积分是否够兑换
			Customer cus = this.customerRemoteService.getIntegralByID(customerid);

			if (cus.getIntegrateDisable() == 1) {
				Integer cusIntegral = cus.getIntegrate();
				if (cusIntegral > (count * ruleDetail.getNeedintegrate())) {
					// 获取金额
					long longMoney = ruleDetail.getPresentmoney();
					// 获取所需积分
					Integer longNeedIntegral = ruleDetail.getNeedintegrate();
					// 获取用户兑换总共需要的积分
					Integer longIntegral = longNeedIntegral * count;

					// 定义用户实体
					Customer customer = new Customer();
					customer.setId(customerid);
					customer.setIntegrate(cusIntegral - longIntegral);
					// 更新用户积分
					if (this.customerRemoteService.updateByID(customer) <= 0) {
						result = 5;
					} else {
						Date dtCreate = new Date();
						// 按数量兑换优惠卷 ;
						for (int i = 0; i < count; i++) {
							// 定义优惠卷实体类
							Coupon cou = new Coupon();
							String code = CodingProductionUtil.getCodingByRule(1);
							Integer tempCount = getCountByCode(code);
							if (tempCount > 0) {
								code = CodingProductionUtil.getCodingByRule(1);
							}
							cou.setCouponCode(code);
							BigDecimal pMoney = new BigDecimal(ruleDetail.getPresentmoney());
							cou.setCouponMoney(pMoney);
							cou.setRemark(ruleDetail.getReamark());
							cou.setFromEnum(2);// 积分兑换
							cou.setStartDate(dtCreate);
							cou.setCreateDate(dtCreate);
							cou.setEndDate(UtilTimeFormatter.afterNDay(ruleDetail.getValidday(), dtCreate));
							cou.setIsExpires(0);
							cou.setCouponType(Integer.valueOf(ruleDetail.getUsingtype().toString()));
							cou.setCustomerId(customerid);
							cou.setUseStatus(0);
							cou.setIsDisable(1);
							cou.setIsTimeControl(Integer.valueOf(ruleDetail.getTimecontrol().toString()));
							if (this.couponMapper.insert(cou) <= 0) {
								// 3代表没有成功添加用户优惠卷
								result = 3;
								break;
							} else {
								// 添加优惠卷成后添加对应的积分消费记录
								// 定义积分记录的实体
								Integral integral = new Integral();
								integral.setCustomerid(customerid);
								integral.setIntegral(ruleDetail.getNeedintegrate());
								integral.setIntegraltype(1);
								integral.setCreatedate(dtCreate);
								integral.setCouponcode(code);
								integral.setIntegralsource(2);
								if (this.integralRemoteService.insertSelective(integral) <= 0) {
									// 4代表保存积分记录错误
									result = 4;
									break;
								}
							}

							// 是否开启延期赠送,且赠送数量大于1
							if (ruleDetail.getIspostpone() == 1 && ruleDetail.getPresentcoumt() > 1) {
								for (int j = 1; j < ruleDetail.getPresentcoumt(); j++) {
									Date dtStart = UtilTimeFormatter.afterNDay(ruleDetail.getValidday() * j, dtCreate);
									Date dtEnd = UtilTimeFormatter.afterNDay(ruleDetail.getValidday(), dtStart);

									cou = new Coupon();
									code = CodingProductionUtil.getCodingByRule(1);
									tempCount = getCountByCode(code);
									if (tempCount > 0) {
										code = CodingProductionUtil.getCodingByRule(1);
									}
									cou.setCouponCode(code);
									pMoney = new BigDecimal(ruleDetail.getPresentmoney());
									cou.setCouponMoney(pMoney);
									cou.setRemark(ruleDetail.getReamark());
									cou.setFromEnum(2);// 积分兑换
									cou.setStartDate(dtStart);
									cou.setCreateDate(dtCreate);
									cou.setEndDate(dtEnd);
									cou.setIsExpires(0);
									cou.setCouponType(Integer.valueOf(ruleDetail.getUsingtype().toString()));
									cou.setCustomerId(customerid);
									cou.setUseStatus(0);
									cou.setIsDisable(1);
									cou.setIsTimeControl(Integer.valueOf(ruleDetail.getTimecontrol().toString()));
									if (this.couponMapper.insert(cou) <= 0) {
										// 3代表没有成功添加用户优惠卷
										result = 3;
										break;
									} else {
										// 添加优惠卷成后添加对应的积分消费记录
										// 定义积分记录的实体
										Integral integral = new Integral();
										integral.setCustomerid(customerid);
										integral.setIntegral(ruleDetail.getNeedintegrate());
										integral.setIntegraltype(1);
										integral.setCreatedate(dtCreate);
										integral.setCouponcode(code);
										integral.setIntegralsource(2);
										if (this.integralRemoteService.insertSelective(integral) <= 0) {
											// 4代表保存积分记录错误
											result = 4;
											break;
										}
									}
								}

								if (result == 3 || result == 4) {
									break;
								}
							}
							
							// 是否开启延期赠送,且赠送数量大于1
							if (ruleDetail.getIspostpone() == 0 && ruleDetail.getPresentcoumt() > 1) {
								for (int j = 1; j < ruleDetail.getPresentcoumt(); j++) {
									cou = new Coupon();
									code = CodingProductionUtil.getCodingByRule(1);
									tempCount = getCountByCode(code);
									if (tempCount > 0) {
										code = CodingProductionUtil.getCodingByRule(1);
									}
									cou.setCouponCode(code);
									pMoney = new BigDecimal(ruleDetail.getPresentmoney());
									cou.setCouponMoney(pMoney);
									cou.setRemark(ruleDetail.getReamark());
									cou.setFromEnum(2);// 积分兑换
									cou.setStartDate(dtCreate);
									cou.setCreateDate(dtCreate);
									cou.setEndDate(UtilTimeFormatter.afterNDay(ruleDetail.getValidday(), dtCreate));
									cou.setIsExpires(0);
									cou.setCouponType(Integer.valueOf(ruleDetail.getUsingtype().toString()));
									cou.setCustomerId(customerid);
									cou.setUseStatus(0);
									cou.setIsDisable(1);
									cou.setIsTimeControl(Integer.valueOf(ruleDetail.getTimecontrol().toString()));
									if (this.couponMapper.insert(cou) <= 0) {
										// 3代表没有成功添加用户优惠卷
										break;
									}
								}
							}
						}
					}
				}
				else {
					// 6代表用户积分不够
					result = 6;
				}
			} 
			else{
				// 7代表用户积分禁用
				result = 7;
			}
		} else {
			// 2代表没有找到规则详细或股则不可用
			result = 2;
		}

		return result;
	}

	@Override
	public Integer getCountByCode(String code) {
		return couponMapper.getCountByCode(code);
	}

	@Override
	public List<Coupon> list(Map params) {
		return this.couponMapper.list(params);
	}

	@Override
	public List<CouponOld> listOld(Map params) {
		// TODO Auto-generated method stub
		return this.couponMapper.listOld(params);
	}

	@Override
	public List<Coupon> historyCoupon(Map<String, Object> params) {
		return couponMapper.historyCoupon(params);
	}
}
