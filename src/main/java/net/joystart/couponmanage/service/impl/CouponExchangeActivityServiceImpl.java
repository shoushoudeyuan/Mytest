package net.joystart.couponmanage.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.joystart.common.database.HandleDataSource;
import net.joystart.couponmanage.dao.CouponExchangeActivityMapper;
import net.joystart.couponmanage.entity.CouponExchangeActivity;
import net.joystart.couponmanage.entity.CouponExchangeCode;
import net.joystart.couponmanage.entity.CouponPackage;
import net.joystart.couponmanage.service.ICouponExchangeActivityService;
import net.joystart.couponmanage.service.ICouponExchangeCodeService;
import net.joystart.couponmanage.service.ICouponPackageService;
import net.joystart.system.entity.SysUser;

@Service("couponExchangeActivityService")
public class CouponExchangeActivityServiceImpl implements ICouponExchangeActivityService {

	@Resource
	private CouponExchangeActivityMapper couponExchangeActivityMapper;
	
	@Resource
	private ICouponExchangeCodeService couponExchangeCodeService;
	
	@Autowired
	private ICouponPackageService couponPackageService;
	
	private static Random random = new Random();
	
	@Override
	public List<CouponExchangeActivity> getCouponExchangeActivityList(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return couponExchangeActivityMapper.getCouponExchangeActivityList(paramMap);
	}

	@Override
	public Integer getCouponExchangeActivityCount(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return couponExchangeActivityMapper.getCouponExchangeActivityCount(paramMap);
	}

	@Transactional
	@Override
	public void addActivityAndCreateExchangeCode(CouponExchangeActivity activity) {
		HttpServletRequest request = HandleDataSource.getRequest();
		SysUser user = (SysUser)request.getSession().getAttribute("user");
		CouponPackage couponPackage = new CouponPackage();
		couponPackage.setCreater(user.getUsername());
		couponPackage.setPkgname("券码活动自动生成");
		couponPackage.setCreateDate(new Date());
		
		boolean b = couponPackageService.createPackage(couponPackage);
		if (!b) {
			throw new RuntimeException("生成兑换活动失败");
		}
		
		int couponPackageId = couponPackage.getId();
		activity.setCouponPackageId(couponPackageId);
		//创建兑换活动
		int status = couponExchangeActivityMapper.insertCouponExchangeActivity(activity);
		if (status <= 0) {
			throw new RuntimeException("生成兑换活动失败");
		}
		int activityId = activity.getId();
		
		List<String> codeList = new ArrayList<>();
		List<CouponExchangeCode> exCodeList = new ArrayList<>();
		while (codeList.size() < activity.getExchangeCount()) {
			String code = randomCode();
			Map<String, Object> paramMap = new HashMap<>();
			paramMap.put("code", code);
			if (codeList.contains(code)) {
				continue;
			}
			CouponExchangeCode couponExchangeCode = couponExchangeCodeService.checkCouponExchangeCodeExist(paramMap);
			if (couponExchangeCode == null) {
				codeList.add(code);
				CouponExchangeCode x = new CouponExchangeCode();
				x.setActivityId(activityId);
				x.setCode(code);
				x.setCouponPackageId(couponPackageId);
				exCodeList.add(x);
			}
		}
		couponExchangeCodeService.addCouponExchangeCodeBatch(exCodeList);
	}
	
	private String randomCode(){
		StringBuilder sBuilder = new StringBuilder("C");
		for (int i = 0; i < 6; i++) {
			sBuilder.append(random.nextInt(10));
		}
		return sBuilder.toString();
	}

	@Override
	public Integer updateCouponExchangeActivity(CouponExchangeActivity activity) {
		// TODO Auto-generated method stub
		return couponExchangeActivityMapper.updateCouponExchangeActivity(activity);
	}

	@Override
	public Integer deleteCouponExchangeActivity(List<Integer> idList) {
		// TODO Auto-generated method stub
		return couponExchangeActivityMapper.deleteCouponExchangeActivity(idList);
	}

	@Override
	public CouponExchangeActivity getCouponExchangeActivityById(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return couponExchangeActivityMapper.getCouponExchangeActivityById(paramMap);
	}
	
	

}
