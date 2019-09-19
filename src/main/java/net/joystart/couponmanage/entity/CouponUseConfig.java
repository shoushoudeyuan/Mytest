package net.joystart.couponmanage.entity;

import java.util.Date;

import javax.ws.rs.GET;

import lombok.Data;

@Data
public class CouponUseConfig {

	private Integer id;

	/*
	 * 规则名
	 */
	private String configName;
	
	/*
	 * 1 启用 0 禁用
	 */
	private Integer isValidate;
	
	/*
	 * 优惠卷类型 1 折扣卷 2 满减卷 
	 */
	private Integer couponType;
	
	/*
	 * 折扣券，折扣率
	 */
	private Integer discountPercent;
	
	/*
	 * 折扣券，最高减免金额
	 */
	private Double maxDeductionMoney;
	
	/*
	 * 减免卷，优惠卷金额
	 */
	private Double couponMoney;
	
	/*
	 * 有效天数
	 */
	private Integer validateDay;
	
	/*
	 * 可使用城市,逗号分隔城市ID
	 */
	private String useCityId;
		
	/*
	 * 可使用时间,单位天（周几）,数字(1-7)
	 */
	private String useWeekDay;
	
	/*
	 * 可使用时段上限
	 */
	private String useUpperTime;
	
	/*
	 * 可使用时段下限
	 */
	private String useLowerTime;
	
	/*
	 * 订单满额用
	 */
	private Double baseOrderMoney;
	
	/*
	 * 可使用车型ID
	 */
	private String useVehicleModeId;
	
	
	/* 
	 * APP显示详情文案
	 */
	private String appDiscription;
	
	/*
	 * 创建时间
	 */
	private Date createTime;
	
	/*
	 * 配置详情
	 */
	private String configDetail;
}
