package net.joystart.promotion.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import net.joystart.promotion.dao.PromotionPersonMapper;
import net.joystart.promotion.entity.PromotionBusiness;
import net.joystart.promotion.entity.PromotionPerson;
import net.joystart.promotion.service.IPromotionPersonService;

/**
 *
 * @author 李大海
 * @create 2016年8月19日 下午3:25:56
 *
 */

@Service("promotionPersonService")
public class PromotionPersonServiceImpl implements IPromotionPersonService {

	@Resource
	PromotionPersonMapper promotionPersonMapper;
	/* (non-Javadoc)
	 * @see net.joystart.promotion.service.IPromotionBusinessService#list(java.util.Map)
	 */
	@Override
	public List<PromotionPerson> list(Map param) 
	{
		return promotionPersonMapper.list(param);
	}
	/* (non-Javadoc)
	 * @see net.joystart.promotion.service.IPromotionBusinessService#count(java.util.Map)
	 */
	@Override
	public int count(Map param) {
		return promotionPersonMapper.count(param);
	}
	/* (non-Javadoc)
	 * @see net.joystart.promotion.service.IPromotionBusinessService#insertBusiness(net.joystart.promotion.entity.PromotionBusiness)
	 */
	@Override
	public int insertPerson(PromotionPerson business) {
		return promotionPersonMapper.insertPerson(business);
	}
	/* (non-Javadoc)
	 * @see net.joystart.promotion.service.IPromotionBusinessService#updateBusiness(net.joystart.promotion.entity.PromotionBusiness)
	 */
	@Override
	public int updatePerson(PromotionPerson business) {
		return promotionPersonMapper.updatePerson(business);
	}
	/* (non-Javadoc)
	 * @see net.joystart.promotion.service.IPromotionBusinessService#deleteBusiness(java.util.List)
	 */
	@Override
	public int deletePerson(List<String> param) {
		return promotionPersonMapper.deletePerson(param);
	}
	/* (non-Javadoc)
	 * @see net.joystart.promotion.service.IPromotionBusinessService#selectBusinessByUserName(java.lang.String)
	 */
	@Override
	public PromotionPerson selectPersonByUserName(String userName) {
		return promotionPersonMapper.selectPersonByUserName(userName);
	}
	
	
	/* (non-Javadoc)
	 * @see net.joystart.order.service.IOrderService#getPerformanceList(java.util.Map)
	 */
	@Override
	public List<Map<String, Object>> getPerformanceList(Map<String, Object> param)
	{
		return promotionPersonMapper.getPerformanceList(param);
	}
	
	public int performanceCount(Map param)
	{
		return promotionPersonMapper.performanceCount(param);
	}
	
	public PromotionPerson selectPersonByCustomerId(Integer customerId)
	{
		return promotionPersonMapper.selectPersonByCustomerId(customerId);
	}
	
	public PromotionPerson selectPersonByBindCustomerId(Integer customerId)
	{
		return promotionPersonMapper.selectPersonByBindCustomerId(customerId);
	}
	
	public PromotionPerson selectPersonById(Integer id)
	{
		return promotionPersonMapper.selectPersonById(id);
	}
	@Override
	public PromotionPerson selectByChanneCode(String channelCode) {
		return promotionPersonMapper.selectByChanneCode(channelCode);
	}
    @Override
    public PromotionPerson selectProPersonByChanneCode(String channelCode) {
        return promotionPersonMapper.selectProPersonByChanneCode(channelCode);
    }
}
