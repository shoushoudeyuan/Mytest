package net.joystart.coupon.dao;

import java.util.Map;

import net.joystart.coupon.entity.Activity;

public interface ActivityMapper {

	Activity selectByParams(Map parmas);

}