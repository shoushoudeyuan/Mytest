package net.joystart.coupon.service;

import java.util.Map;

import net.joystart.coupon.entity.Activity;

public interface IActivityService {

	Activity selectByParams(Map parmas);

}
