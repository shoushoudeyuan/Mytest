package net.joystart.couponmanage.entity;

import java.util.Date;

import lombok.Data;

/**
 * 优惠券券包配置条目
* 
* @author zm.mu   
* @date 2018年5月31日 上午11:32:47
 */
@Data
public class CouponPackageItem {
	
	private Integer id;
	
	/*
	 * 券包编号
	 */
	private Integer packageId;
	
	/**
	 * 优惠券名称
	 */
	private String couponName;
	
	/**
	 * 优惠券配置ID
	 */
	private Integer couponConfigId;
	
	/**
	 * 优惠券数量
	 */
	private Integer couponCount;
	
	/**
	 * 是否启用
	 */
	private Integer isEnable;
	
	/**
	 * 创建时间
	 */
	private Date createDate;
	
	/**
	 * 修改时间
	 */
	private Date modifyDate;
	
	/*
	 * 优惠券配置
	 */
	CouponUseConfig couponUseConfig;
	
	
}
