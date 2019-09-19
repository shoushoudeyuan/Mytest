package net.joystart.couponmanage.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import net.joystart.couponmanage.entity.CouponBatchRecord;

public interface CouponBatchRecordMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(CouponBatchRecord record);

    int insertSelective(CouponBatchRecord record);

    CouponBatchRecord selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(CouponBatchRecord record);

    int updateByPrimaryKey(CouponBatchRecord record);
    

	List<CouponBatchRecord> selectCouponBatchRecordData(Map<String, Object> map);
	
	int selectCouponBatchRecordDataCount(Map<String, Object> map);
	
	List<CouponBatchRecord> selectByImportData(@Param ("phoneList")List<String> phoneList);

	int selectByImportDataCount(@Param ("phoneList")List<String> phoneList);
}