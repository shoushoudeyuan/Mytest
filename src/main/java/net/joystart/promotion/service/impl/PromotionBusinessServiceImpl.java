package net.joystart.promotion.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.joystart.promotion.dao.PromotionBusinessMapper;
import net.joystart.promotion.entity.PromotionBusiness;
import net.joystart.promotion.service.IPromotionBusinessService;
import net.joystart.system.entity.SysUser;
import net.joystart.system.remote.service.ISysUserRemoteService;

/**
 *
 * @author 李大海
 * @create 2016年8月19日 下午3:25:56
 *
 */

@Transactional
@Service("promotionBusinessService")
public class PromotionBusinessServiceImpl implements IPromotionBusinessService {

	@Resource
	PromotionBusinessMapper promotionBusinessMapper;

	@Resource
	ISysUserRemoteService sysUserRemoteService;

	@Override
	public List<PromotionBusiness> list(Map param) {
		return promotionBusinessMapper.list(param);
	}

	@Override
	public int count(Map param) {
		return promotionBusinessMapper.count(param);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * net.joystart.promotion.service.IPromotionBusinessService#insertBusiness(
	 * net.joystart.promotion.entity.PromotionBusiness)
	 */
	@Override
	@Transactional
	public int insertBusiness(PromotionBusiness business, SysUser user) {
		int i = sysUserRemoteService.insert(user);
		business.setUserId(i);
		int j = promotionBusinessMapper.insertBusiness(business);
		return i + j;

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * net.joystart.promotion.service.IPromotionBusinessService#updateBusiness(
	 * net.joystart.promotion.entity.PromotionBusiness)
	 */
	@Override
	public int updateBusiness(PromotionBusiness business, SysUser user) {
		int i = sysUserRemoteService.updateByPrimaryKeySelective(user);
		int j = promotionBusinessMapper.updateBusiness(business);
		return i + j;
	}
	
	@Override
	public int updateCouponPackageId(Integer businessId,Integer packageId){
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("id", businessId);
		map.put("couponPackageId", packageId);
		return promotionBusinessMapper.updateCouponPackageId(map);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * net.joystart.promotion.service.IPromotionBusinessService#deleteBusiness(
	 * java.util.List)
	 */
	@Override
	public int deleteBusiness(List<String> param) {
		int i = sysUserRemoteService.deleteByBusinessIds(param);
		int j = promotionBusinessMapper.deleteBusiness(param);
		return i + j;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see net.joystart.promotion.service.IPromotionBusinessService#
	 * selectBusinessByUserName(java.lang.String)
	 */
	@Override
	public PromotionBusiness selectBusinessByUserName(String userName) {
		return promotionBusinessMapper.selectBusinessByUserName(userName);
	}

	public PromotionBusiness login(Map param) {
		return promotionBusinessMapper.login(param);
	}

	public PromotionBusiness selectBusinessByPersonId(Integer personId) {
		return promotionBusinessMapper.selectBusinessByPersonId(personId);
	}
	
	

}
