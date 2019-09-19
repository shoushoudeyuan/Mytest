package net.joystart.couponmanage.entity.giftconfig;

import lombok.Data;

@Data
public class CouponGiftConfig {

	private Integer id;

	/*
	 * 规则枚举码
	 */
	private Integer enumCode;
	
	/*
	 * 规则名称
	 */
	private String ruleName;
	
	/*
	 * 启用状态 1启用 0 禁用
	 */
	private Integer isValidate;
	
	/*
	 * 规则介绍
	 */
	private String configDescription;

	/*
	 * 设定的规则项
	 */
	private String configItem;
	
	
}
