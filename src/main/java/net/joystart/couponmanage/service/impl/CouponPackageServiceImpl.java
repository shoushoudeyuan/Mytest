package net.joystart.couponmanage.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.joystart.couponmanage.dao.CouponPackageMapper;
import net.joystart.couponmanage.entity.CouponPackage;
import net.joystart.couponmanage.entity.CouponPackageItem;
import net.joystart.couponmanage.entity.CouponUseConfig;
import net.joystart.couponmanage.service.ICouponPackageService;
import net.joystart.couponmanage.service.ICouponUseConfigService;

@Service
public class CouponPackageServiceImpl implements ICouponPackageService {

	@Autowired
	private CouponPackageMapper dao;
	
	@Autowired
	ICouponUseConfigService svcConfig;
	
	@Override
	public List<CouponPackageItem> selectCouponPackageItem(Integer packageId) {
		return selectCouponPackageItem(null,null,packageId);
	}
	
	@Override
	public List<CouponPackageItem> selectCouponPackageItem(Integer pageIndex, Integer pageSize,Integer packageId) {
		Map<String,Object> params = new HashMap<>();
		if(pageIndex != null && pageIndex > 0){
			pageIndex = (pageIndex - 1) * pageSize;
		}
		params.put("pageIndex", pageIndex);
		params.put("pageSize", pageSize);
		params.put("packageId", packageId);
		List<CouponPackageItem> lstPackage = dao.selectCouponPackageItem(params);
		if(lstPackage.size() > 0){
			List<CouponUseConfig> lstConfig = svcConfig.selectCouponUseConfig(null, null, null, null, null);
			for(CouponPackageItem item : lstPackage){
				Optional<CouponUseConfig> opt = lstConfig.stream().filter(e->e.getId().equals(item.getCouponConfigId())).findFirst();
				if(!opt.isPresent()){
					continue;
				}
				
				CouponUseConfig config = opt.get();
				if(config.getIsValidate() == 0){
					continue;
				}
				item.setCouponConfigId(config.getId());
				item.setCouponUseConfig(config);
			}
		}
		return lstPackage;
	}

	@Override
	public int selectCouponPackageItemCount(Integer packageId) {
		Map<String,Object> params = new HashMap<>();
		params.put("packageId", packageId);
		return dao.selectCouponPackageItemCount(params);
	}
	
	@Override
	public Boolean deleteCouponPackageItem(List<Integer> ids){
		if(ids == null || ids.size() == 0)
			return false;
		
		return dao.deleteCouponPackageItem(ids) > 0;
	}

	@Override
	public Boolean saveCouponPackageItem(CouponPackageItem packageItem) {
		if(packageItem.getId() != null){
			return dao.updateCouponPackageItem(packageItem) > 0;
		}else{
			return dao.insertCouponPackageItem(packageItem) > 0;
		}
	}

	@Override
	public Boolean createPackage(CouponPackage couponPackage) {
		if(couponPackage == null){
			return false;
		}
		
		return dao.createCouponPackage(couponPackage) > 0;
	}

}
