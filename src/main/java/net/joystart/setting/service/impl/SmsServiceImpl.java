package net.joystart.setting.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.joystart.common.daox.SmsLogMapper;
import net.joystart.setting.service.ISmsService;

@Service("smsService")
@Transactional
public class SmsServiceImpl implements ISmsService {
    @Autowired
    private SmsLogMapper smsLogMapper;

    @Override
    public Integer getSmsLogListCount(Map<String, Object> params) {
        return smsLogMapper.getSmsLogListCount(params);
    }

    @Override
    public List<Map<String, Object>> getSmsLogList(Map<String, Object> params) {
        return smsLogMapper.getSmsLogList(params);
    }
}
