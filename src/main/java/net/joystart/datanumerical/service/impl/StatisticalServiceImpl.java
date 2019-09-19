package net.joystart.datanumerical.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.joystart.common.daox.SmsLogMapper;
import net.joystart.datanumerical.service.IStatisticalService;

@Service("statisticalService")
@Transactional
public class StatisticalServiceImpl implements IStatisticalService {
    @Autowired
    private SmsLogMapper smsLogMapper;
    
    @Override
    public Integer getSmsStatisticalListCount(Map<String, Object> params) {
        return smsLogMapper.getSmsStatisticalListCount(params);
    }

    @Override
    public List<Map<String, Object>> getSmsStatisticalList(Map<String, Object> params) {
        return smsLogMapper.getSmsStatisticalList(params);
    }

    @Override
    public int getSmsStatisticalListAllCount(Map<String, Object> params) {
        return smsLogMapper.getSmsStatisticalListAllCount(params);
    }

}
