package net.joystart.channel.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.joystart.channel.dao.ChannelMapper;
import net.joystart.channel.entity.Channel;
import net.joystart.channel.entity.ChannelUser;
import net.joystart.channel.service.IChannelService;
import net.joystart.common.daox.GlobalUserMapper;
import net.joystart.common.util.log.Log4jTask;
import net.joystart.couponmanage.enums.CustomerBehaviorEnum;
import net.joystart.couponmanage.remote.service.IGiftCouponRemoteService;
import net.joystart.customer.entity.Customer;
import net.joystart.customer.entity.Message;
import net.joystart.customer.remote.service.ICustomerAppidRemoteService;
import net.joystart.customer.remote.service.ICustomerRemoteService;
import net.joystart.customer.remote.service.IMessageRemoteService;

@Service("channelService")
public class ChannelServiceImpl implements IChannelService {
	
	@Autowired
	private ChannelMapper channelMapper;
	@Autowired
	private GlobalUserMapper globalUserMapper;
	@Autowired
	private ICustomerRemoteService customerRemoteService;
	@Autowired
	private IMessageRemoteService messageRemoteService;
	@Autowired
	private ICustomerAppidRemoteService customerAppidRemoteServie;
	
	@Resource
	IGiftCouponRemoteService giftCouponRemoteService; 

	@Override
	public List<Channel> getChannelList(Map<String, Object> params) {
		return channelMapper.getChannelList(params);
	}
	
	@Override
	public int getChannelListCount(Map<String, Object> params) {
		return channelMapper.getChannelListCount(params);
	}

	@Override
	public int deleteChannelById(Integer id) {
		return channelMapper.deleteChannelById(id);
	}

	@Override
	public int updateChannelById(Channel channel) {
		return channelMapper.updateChannelById(channel);
	}

	@Override
	public int insertChannel(Channel channel) {
		return channelMapper.insertChannel(channel);
	}

	@Override
	public Channel getChannelByChannelCode(String channelCode) {
		return channelMapper.getChannelByChannelCode(channelCode);
	}

	@Transactional
	@Override
	public void h5Register(Customer customer, Message message) {
		
		customer.setGlobalUserId(globalUserMapper.getGlobalUserID(customer.getUsername(), customer.getPassword()));
		int result = customerRemoteService.insertCustomer(customer);
		
		customerAppidRemoteServie.bindCustomerAppID(0, "", result);
		if(result>0){
			try {
				//发送优惠券
				giftCouponRemoteService.giftCoupon(CustomerBehaviorEnum.用户注册成功,result);
			} catch (Exception e) {
				Log4jTask.addLog("渠道注册发优惠券异常", System.currentTimeMillis(), Log4jTask.ERROR,
						ChannelServiceImpl.class.getName(), e);
			}
			
		}
	}

	@Override
	public List<ChannelUser> getChannelUserListByChannelCode(Map<String, Object> params) {
		return channelMapper.getChannelUserListByChannelCode(params);
	}

	@Override
	public int getChannelUserListCountByChannelCode(Map<String, Object> params) {
		return channelMapper.getChannelUserListCountByChannelCode(params);
	}
	
	@Override
	public int updateCouponPackageId(Integer channelId,Integer packageId){
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("id", channelId);
		map.put("couponPackageId", packageId);
		return channelMapper.updateCouponPackageId(map);
	}
}
