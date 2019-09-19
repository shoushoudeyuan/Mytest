package net.joystart.couponmanage.remote.impl;

import java.util.Map;

import javax.annotation.Resource;

import com.alibaba.dubbo.config.annotation.Service;

import net.joystart.couponmanage.dao.CouponExchangeCodeMapper;
import net.joystart.couponmanage.entity.CouponExchangeCode;
import net.joystart.couponmanage.remote.service.ICouponExchangeCodeRemoteService;

@Service(timeout=60000,retries=0,interfaceClass=ICouponExchangeCodeRemoteService.class)
public class CouponExchangeCodeRemoteServiceImpl implements ICouponExchangeCodeRemoteService {

	@Resource
	private CouponExchangeCodeMapper couponExchangeCodeMapper;
	
	@Override
	public CouponExchangeCode getValideCouponExchangeCodeByCode(Map<String, Object> paramMap) {
		return couponExchangeCodeMapper.getValideCouponExchangeCodeByCode(paramMap);
	}

}
