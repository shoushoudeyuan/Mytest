package net.joystart.couponmanage.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import net.joystart.couponmanage.entity.CouponPackage;
import net.joystart.couponmanage.entity.CouponPackageItem;

public interface CouponPackageMapper {

	List<CouponPackageItem> selectCouponPackageItem(Map<String,Object> map);
	
	Integer selectCouponPackageItemCount(Map<String,Object> map);
	
	Integer deleteCouponPackageItem(@Param ("ids") List<Integer> ids);
	
	Integer insertCouponPackageItem(CouponPackageItem packageItem);
	
	Integer updateCouponPackageItem(CouponPackageItem packageItem);
	
	Integer getCouponPackageId(Map<String,Object> map);
	
	Integer createCouponPackage(CouponPackage couponPackage);
	
}
