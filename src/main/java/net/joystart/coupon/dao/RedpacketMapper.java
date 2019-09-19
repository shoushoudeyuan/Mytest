package net.joystart.coupon.dao;

import java.util.List;
import java.util.Map;

import net.joystart.coupon.entity.Redpacket;

public interface RedpacketMapper {

    List<Redpacket> selectByParams(Map params);

	Integer update(Redpacket record);
}