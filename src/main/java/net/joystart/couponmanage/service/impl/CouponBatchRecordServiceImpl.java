package net.joystart.couponmanage.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import net.joystart.couponmanage.dao.CouponBatchOplogMapper;
import net.joystart.couponmanage.dao.CouponBatchRecordMapper;
import net.joystart.couponmanage.entity.CouponBatchOplog;
import net.joystart.couponmanage.entity.CouponBatchRecord;
import net.joystart.couponmanage.service.ICouponBatchRecordService;

@Service
public class CouponBatchRecordServiceImpl implements ICouponBatchRecordService {

	@Resource
	private CouponBatchRecordMapper couponBatchRecordMapper;
	@Resource
	private CouponBatchOplogMapper couponBatchOplogMapper;
	@Override
	public List<CouponBatchRecord> selectCouponBatchRecordData(Map<String, Object> map) {
		return couponBatchRecordMapper.selectCouponBatchRecordData(map);
	}

	@Override
	public int selectCouponBatchRecordDataCount( Map<String, Object> map) {
		return couponBatchRecordMapper.selectCouponBatchRecordDataCount(map);
	}

	@Override
	public List<CouponBatchRecord> selectByImportData(List<String> phoneList) {
		return couponBatchRecordMapper.selectByImportData(phoneList);
	}

	@Override
	public int selectByImportDataCount(List<String> phoneList) {
		return couponBatchRecordMapper.selectByImportDataCount(phoneList);
	}

	@Override
	public int saveCouponBatchOplog(CouponBatchOplog record) {
		return couponBatchOplogMapper.insertSelective(record);
	}
	
}
