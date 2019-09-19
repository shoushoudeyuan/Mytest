package net.joystart.setting.dao;

import java.util.List;
import java.util.Map;

import net.joystart.setting.entity.BaseInsurance;

public interface BaseInsuranceMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(BaseInsurance record);

    int insertSelective(BaseInsurance record);

    BaseInsurance selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(BaseInsurance record);

    int updateByPrimaryKey(BaseInsurance record);
    
    List<BaseInsurance> getBaseInsuranceList(Map params);
    
    int getBaseInsuranceListCount(Map params);
    /**
     * @Description 获取必选保险车型id
     * @author:  zhuwq
     * Create at: 2017年9月25日 下午3:37:43
     * @return
     */
    List<Integer> getRequiredInsuranceModel();
    /**
     * @Description 获取保险
     * @author:  zhuwq
     * Create at: 2018年1月4日 上午11:34:08
     * @param params
     * @return
     */
    List<BaseInsurance> getInsuranceList(Map<String, Object> params);
}