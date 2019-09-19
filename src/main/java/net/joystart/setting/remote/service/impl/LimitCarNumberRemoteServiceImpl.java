package net.joystart.setting.remote.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.dubbo.config.annotation.Service;

import net.joystart.setting.dao.LimitCarNumberMapper;
import net.joystart.setting.entity.LimitCarNumber;
import net.joystart.setting.entity.LimitCarNumberSetting;
import net.joystart.setting.remote.service.ILimitCarNumberRemoteService;
import net.joystart.vehicle.remote.service.IVehicleRemoteService;

@Service(timeout=60000,retries=0,interfaceClass=ILimitCarNumberRemoteService.class)
@Transactional
public class LimitCarNumberRemoteServiceImpl implements ILimitCarNumberRemoteService
{
    @Resource
    LimitCarNumberMapper limitCarNumberMapper;

    @Resource
    IVehicleRemoteService vehicleRemoteService;

    @Override
    public List<LimitCarNumber> limitCarNumberList(Map<String, Object> params)
    {
        // TODO Auto-generated method stub
        return this.limitCarNumberMapper.limitCarNumberList(params);
    }

    @Override
    public int getLimitCarNumberCount(Map<String, Object> params)
    {
        // TODO Auto-generated method stub
        return this.limitCarNumberMapper.getLimitCarNumberCount(params);
    }

    @Override
    public int addLimitCarNumber(Map<String, Object> params)
    {
        // TODO Auto-generated method stub
        return this.limitCarNumberMapper.addLimitCarNumber(params);
    }

    @Override
    public int deleteLimitCarNumber(Map<String, Object> params)
    {
        // TODO Auto-generated method stub
        return this.limitCarNumberMapper.deleteLimitCarNumber(params);
    }

    @Override
    public int updateLimitCarNumber(Map<String, Object> params)
    {
        // TODO Auto-generated method stub
        return this.limitCarNumberMapper.updateLimitCarNumber(params);
    }

    @Override
    public List<LimitCarNumberSetting> limitCarNumberSettingList(
            Map<String, Object> params)
    {
        // TODO Auto-generated method stub
        return this.limitCarNumberMapper.limitCarNumberSettingList(params);
    }

    @Override
    public int getLimitCarNumberSettingCount(Map<String, Object> params)
    {
        // TODO Auto-generated method stub
        return this.limitCarNumberMapper.getLimitCarNumberSettingCount(params);
    }

    @SuppressWarnings("unchecked")
	@Override
    public int addLimitCarNumberSetting(Map<String, Object> params)
    {
        // TODO Auto-generated method stub
        this.limitCarNumberMapper.addLimitCarNumberSetting(params);
        List<Map<String, Object>> tempList = (List<Map<String, Object>>) params
                .get("detailMap");
        if(tempList != null && tempList.size() > 0)
        {
            for (Map<String, Object> map : tempList)
            {
                this.limitCarNumberMapper.addLimitCarNumber(map);
            }
        }
        return 1;
    }

    @Override
    public int deleteLimitCarNumberSetting(Map<String, Object> params)
    {
        return this.limitCarNumberMapper.deleteLimitCarNumberSetting(params);
    }

    @Override
    public int deleteLimitCarNumberSettings(List<String> params)
    {
        // TODO Auto-generated method stub
        return this.limitCarNumberMapper.deleteLimitCarNumberSettings(params);
    }

    @Override
    public int deleteLimitCarNumbers(List<String> params)
    {
        // TODO Auto-generated method stub
        return this.limitCarNumberMapper.deleteLimitCarNumbers(params);
    }

    @Override
    public List<Map<String, Object>> cityList()
    {
        // TODO Auto-generated method stub
        return this.limitCarNumberMapper.cityList();
    }

    @Override
    public int updateLimitCarNumberSetting(Map<String, Object> params)
    {
        // TODO Auto-generated method stub
        int res = this.limitCarNumberMapper.updateLimitCarNumberSetting(params);
        if(res>0){
            limitCarNumberMapper.deleteLimitCarNumberByCityId(Integer.valueOf(params.get("cityId").toString()));
            List<Map<String, Object>> tempList = (List<Map<String, Object>>) params.get("detailMap");
            if(tempList != null && tempList.size() > 0){
                for (Map<String, Object> map : tempList){
                    this.limitCarNumberMapper.addLimitCarNumber(map);
                }
            }
        }
        return 1;
    }

    @Override
    public List<LimitCarNumber> getLimitCarNumberList(Map<String, Object> params) {
        return limitCarNumberMapper.getLimitCarNumberList(params);
    }

    @Override
    public int selectLimitCarNumberCount(Map<String, Object> params) {
        return limitCarNumberMapper.selectLimitCarNumberCount(params);
    }

    @Override
    public void vehicleLimitNumberTask() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String date = sdf.format(new Date());
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("date", date);
        List<LimitCarNumber> list = getLimitCarNumberList(params);
        Map<Object, Object> cityMap = new HashMap<Object, Object>();
        List<String> numberList = null;
        List<String> zmList = new ArrayList<String>(Arrays.asList("A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"));
        List<Integer> idsAllList = new ArrayList<Integer>();
        for (LimitCarNumber limitCarNumber : list) {
            if(cityMap.get(limitCarNumber.getCityId())==null){
                numberList = new ArrayList<String>();
            }else{
                numberList = (ArrayList)cityMap.get(limitCarNumber.getCityId());
            }
            if("字母".equals(limitCarNumber.getLimitCarNum())){
                numberList.addAll(zmList);
            }else{
                numberList.add(limitCarNumber.getLimitCarNum());
            }
            cityMap.put(limitCarNumber.getCityId(), numberList);
        }
        for (Map.Entry<Object, Object> entry : cityMap.entrySet()) {
            Map<String, Object> paramsMap = new HashMap<String, Object>(); 
            paramsMap.put("numbers", entry.getValue());
            paramsMap.put("city", entry.getKey());
            List<Integer> ids = vehicleRemoteService.getNoLimitNumberVehicle(paramsMap);
            idsAllList.addAll(ids);
            Map<String, Object> updateMap = new HashMap<String, Object>(); 
            if(ids!=null&&ids.size()>0){
                updateMap.put("limitCarNumber", 1);
                updateMap.put("ids", ids);
                vehicleRemoteService.disableByLimitNumber(updateMap);
            }
            List<Integer> enableIds = vehicleRemoteService.getLimitNumberVehicle(paramsMap);
            if(enableIds!=null&&enableIds.size()>0){
                updateMap.put("limitCarNumber", 0);
                updateMap.put("ids", enableIds);
                vehicleRemoteService.disableByLimitNumber(updateMap);
            }
        }
        List<Integer> enableAllIds = new ArrayList<Integer>();
        if(idsAllList.size()>0){
            enableAllIds = vehicleRemoteService.getEnableLimitNumberVehicle(idsAllList);
        }else{
            enableAllIds = vehicleRemoteService.getEnableLimitNumberVehicle(null);
        }
        if(enableAllIds!=null&&enableAllIds.size()>0){
            Map<String, Object> updateMap = new HashMap<String, Object>(); 
            updateMap.put("limitCarNumber", 0);
            updateMap.put("ids", enableAllIds);
            vehicleRemoteService.disableByLimitNumber(updateMap);
        }
    }

}
