package net.joystart.coupon.service;

import java.util.List;
import java.util.Map;

import net.joystart.coupon.entity.Coupon;
import net.joystart.coupon.entity.Redpacket;

public interface IRedpacketService {

	List<Redpacket> selectByParams(Map params);
	public List<Coupon> exchange(Redpacket record);
}
