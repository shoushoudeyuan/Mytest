package net.joystart.couponmanage.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import net.joystart.couponmanage.dao.CouponExchangeCodeMapper;
import net.joystart.couponmanage.entity.CouponExchangeCode;
import net.joystart.couponmanage.service.ICouponExchangeCodeService;

@Service("couponExchangeCodeService")
public class CouponExchangeCodeServiceImpl implements ICouponExchangeCodeService {

	@Resource
	private CouponExchangeCodeMapper couponExchangeCodeMapper;

	@Override
	public List<CouponExchangeCode> getCouponExchangeCodeList(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return couponExchangeCodeMapper.getCouponExchangeCodeList(paramMap);
	}

	@Override
	public Integer getCouponExchangeCodeCount(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return couponExchangeCodeMapper.getCouponExchangeCodeCount(paramMap);
	}

	@Override
	public CouponExchangeCode checkCouponExchangeCodeExist(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return couponExchangeCodeMapper.checkCouponExchangeCodeExist(paramMap);
	}

	@Override
	public int addCouponExchangeCodeBatch(List<CouponExchangeCode> list) {
		// TODO Auto-generated method stub
		return couponExchangeCodeMapper.addCouponExchangeCodeBatch(list);
	}

	@Override
	public int updateCouponExchangeCode(CouponExchangeCode couponExchangeCode) {
		// TODO Auto-generated method stub
		return couponExchangeCodeMapper.updateCouponExchangeCode(couponExchangeCode);
	}

	@Override
	public int deleteCouponExchangeCode(List<Integer> list) {
		// TODO Auto-generated method stub
		return couponExchangeCodeMapper.deleteCouponExchangeCode(list);
	}

	@Override
	public List<CouponExchangeCode> getCouponExchangeCodeList4Export(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return couponExchangeCodeMapper.getCouponExchangeCodeList4Export(paramMap);
	}

}
