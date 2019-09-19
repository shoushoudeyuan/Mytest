package net.joystart.datanumerical.remote.service.impl;

import java.util.Map;

import javax.annotation.Resource;

import com.alibaba.dubbo.config.annotation.Service;

import net.joystart.datanumerical.remote.service.IStatisticalRemoteService;
import net.joystart.datanumerical.service.IStatisticalService;
import net.joystart.vehicle.remote.service.IParkinglotRemoteService;

@Service(timeout=60000,retries=0,interfaceClass=IStatisticalRemoteService.class)
public class StatisticalRemoteServiceImpl implements IStatisticalRemoteService {

	@Resource
	private IStatisticalService statisticalService;
	
	@Override
	public int getSmsStatisticalListAllCount(Map<String, Object> params) {
		return statisticalService.getSmsStatisticalListCount(params);
	}

}
