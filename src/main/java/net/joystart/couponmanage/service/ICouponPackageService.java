package net.joystart.couponmanage.service;

import java.util.List;

import net.joystart.couponmanage.entity.CouponPackage;
import net.joystart.couponmanage.entity.CouponPackageItem;

public interface ICouponPackageService {

	List<CouponPackageItem> selectCouponPackageItem(Integer packageId);
	
	List<CouponPackageItem> selectCouponPackageItem(Integer pageIndex,Integer pageSize,Integer packageId);
	
	int selectCouponPackageItemCount(Integer packageId);

	Boolean deleteCouponPackageItem(List<Integer> lstId);
	
	Boolean saveCouponPackageItem(CouponPackageItem packageItem);

	Boolean createPackage(CouponPackage couponPackage);
}
