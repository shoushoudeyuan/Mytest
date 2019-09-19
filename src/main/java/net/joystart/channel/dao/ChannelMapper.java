package net.joystart.channel.dao;

import java.util.List;
import java.util.Map;

import net.joystart.channel.entity.Channel;
import net.joystart.channel.entity.ChannelUser;

public interface ChannelMapper {

	List<Channel> getChannelList(Map<String, Object> params);
	
	int getChannelListCount(Map<String, Object> params);
	
	int deleteChannelById(Integer id);
	
	int updateChannelById(Channel channel);
	
	int insertChannel(Channel channel);
	
	Channel getChannelByChannelCode(String channelCode);
	
	List<ChannelUser> getChannelUserListByChannelCode(Map<String, Object> params);
	
	int getChannelUserListCountByChannelCode(Map<String, Object> params);
	
	int updateCouponPackageId(Map<String,Object> param);
}
