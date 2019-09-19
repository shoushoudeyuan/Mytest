package net.joystart.promotion.remote.service.impl;

import javax.annotation.Resource;

import org.springframework.transaction.annotation.Transactional;

import com.alibaba.dubbo.config.annotation.Service;

import net.joystart.promotion.dao.PromotionPerformanceMapper;
import net.joystart.promotion.entity.PromotionPerformance;
import net.joystart.promotion.remote.service.IPromotionPerformanceRemoteService;

/**
 *
 * @author 李大海
 * @create 2016年8月19日 下午3:25:56
 *
 */
@Transactional
@Service(timeout=60000,retries=0,interfaceClass=IPromotionPerformanceRemoteService.class)
public class PromotionPerformanceRemoteServiceImpl implements IPromotionPerformanceRemoteService {

	@Resource
	PromotionPerformanceMapper promotionPerformanceMapper;

	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return promotionPerformanceMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(PromotionPerformance record) {
		// TODO Auto-generated method stub
		return promotionPerformanceMapper.insert(record);
	}

	@Override
	public int insertSelective(PromotionPerformance record) {
		// TODO Auto-generated method stub
		return promotionPerformanceMapper.insertSelective(record);
	}

	@Override
	public PromotionPerformance selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return promotionPerformanceMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(PromotionPerformance record) {
		// TODO Auto-generated method stub
		return promotionPerformanceMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(PromotionPerformance record) {
		// TODO Auto-generated method stub
		return promotionPerformanceMapper.updateByPrimaryKey(record);
	}
	
	
	
}
