package net.joystart.couponmanage.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import net.joystart.couponmanage.entity.CouponBatchOplog;
import net.joystart.couponmanage.entity.CouponBatchRecord;

public interface ICouponBatchRecordService {
	/**
	 * 查询批量发券的用户数据
	 * @param map
	 * @return
	 */
	List<CouponBatchRecord> selectCouponBatchRecordData(Map<String, Object> map);
	/**
	 * 查询批量发券的用户数据条数
	 * @param map
	 * @return
	 */
	int selectCouponBatchRecordDataCount(Map<String, Object> map);
	/**
	 * 批量发券导入数据查询的用户数据
	 * @param map
	 * @return
	 */
	List<CouponBatchRecord> selectByImportData(@Param ("phoneList")List<String> phoneList);
	/**
	 * 批量发券导入数据查询的用户数据条数
	 * @param map
	 * @return
	 */
	int selectByImportDataCount(@Param ("phoneList")List<String> phoneList);
	/**
	 * 保存操作记录
	 * @param record
	 * @return
	 */
	int saveCouponBatchOplog(CouponBatchOplog record);
}
