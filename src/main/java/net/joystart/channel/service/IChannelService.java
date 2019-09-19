package net.joystart.channel.service;

import java.util.List;
import java.util.Map;

import net.joystart.channel.entity.Channel;
import net.joystart.channel.entity.ChannelUser;
import net.joystart.customer.entity.Customer;
import net.joystart.customer.entity.Message;

public interface IChannelService {

	List<Channel> getChannelList(Map<String, Object> params);
	
	int getChannelListCount(Map<String, Object> params);
	
	int deleteChannelById(Integer id);
	
	int updateChannelById(Channel channel);
	
	int insertChannel(Channel channel);
	
	Channel getChannelByChannelCode(String channelCode);
	
	void h5Register(Customer customer, Message message);
	
	List<ChannelUser> getChannelUserListByChannelCode(Map<String, Object> params);
	
	int getChannelUserListCountByChannelCode(Map<String, Object> params);
	
	int updateCouponPackageId(Integer channelId, Integer packageId);
}
