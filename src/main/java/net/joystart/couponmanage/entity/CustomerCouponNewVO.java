package net.joystart.couponmanage.entity;

import java.util.Date;

/**
 * 优惠券VO类
 * @author zm.mu
 *
 */
public class CustomerCouponNewVO {
	
    private Integer id;

    /**
     * 用户ID
     */
    private Integer customerId;

    /**
     * 优惠券配置id
     */
    private Integer couponConfigId;
    
    /**
     * 来源
     */
    private Byte sourceType;
    
    /**
     * 来源id
     */
    private Integer sourceId;

    /**
     * 优惠券名称
     */
    private String couponName;

    /**
     * 优惠券编码
     */
    private String couponNo;

    /**
     * 是否启用（1启用2禁用）
     */
    private Integer isEnable;
    
    /**
     * 是否已删除（1未删除2已删除）
     */
    private Integer isDelete;

    /**
     *是否已使用（1未使用2已使用） 
     */
    private Integer isUsed;
    
    /**
     *使用时间
     */
    private Date usedDate;

    /**
     * 领取时间
     */
    private Date createDate;

    /**
     * 失效时间
     */
    private Date expireDate;
    
	/**
	 * 规则名
	 */
	private String configName;
	
	/**
	 * 优惠卷类型 1 折扣卷 2 满减卷 
	 */
	private Integer couponType;
	
	/**
	 * 折扣券，折扣率
	 */
	private Integer discountPercent;
	
	/**
	 * 折扣券，最高减免金额
	 */
	private Double maxDeductionMoney;
	
	/**
	 * 减免卷，优惠卷金额
	 */
	private Double couponMoney;
	
	/**
	 * 有效天数
	 */
	private Integer validateDay;
	
	/**
	 * 可使用城市,逗号分隔城市ID
	 */
	private String useCityId;
		
	/**
	 * 可使用时间,单位天（周几）,数字(1-7)
	 */
	private String useWeekDay;
	
	/**
	 * 可使用时段上限
	 */
	private String useUpperTime;
	
	/**
	 * 可使用时段下限
	 */
	private String useLowerTime;
	
	/**
	 * 订单满额用
	 */
	private Double baseOrderMoney;
	
	/**
	 * 可使用车型ID
	 */
	private String useVehicleModeId;
	
	
	/**
	 * APP显示详情文案
	 */
	private String appDiscription;
	
	/**
	 * 创建时间
	 */
	private Date createTime;
	
	/**
	 * 配置详情
	 */
	private String configDetail;
	
	/**
	 * 订单号
	 */
	private String orderNo;
	
	/**
	 * 手机号
	 */
	private String mobile;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getCustomerId() {
		return customerId;
	}

	public void setCustomerId(Integer customerId) {
		this.customerId = customerId;
	}

	public Integer getCouponConfigId() {
		return couponConfigId;
	}

	public void setCouponConfigId(Integer couponConfigId) {
		this.couponConfigId = couponConfigId;
	}

	public Byte getSourceType() {
		return sourceType;
	}

	public void setSourceType(Byte sourceType) {
		this.sourceType = sourceType;
	}

	public Integer getSourceId() {
		return sourceId;
	}

	public void setSourceId(Integer sourceId) {
		this.sourceId = sourceId;
	}

	public String getCouponName() {
		return couponName;
	}

	public void setCouponName(String couponName) {
		this.couponName = couponName;
	}

	public String getCouponNo() {
		return couponNo;
	}

	public void setCouponNo(String couponNo) {
		this.couponNo = couponNo;
	}

	public Integer getIsEnable() {
		return isEnable;
	}

	public void setIsEnable(Integer isEnable) {
		this.isEnable = isEnable;
	}
	
	public Integer getIsDelete() {
		return isDelete;
	}

	public void setIsDelete(Integer isDelete) {
		this.isDelete = isDelete;
	}

	public Integer getIsUsed() {
		return isUsed;
	}

	public void setIsUsed(Integer isUsed) {
		this.isUsed = isUsed;
	}

	public Date getUsedDate() {
		return usedDate;
	}

	public void setUsedDate(Date usedDate) {
		this.usedDate = usedDate;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Date getExpireDate() {
		return expireDate;
	}

	public void setExpireDate(Date expireDate) {
		this.expireDate = expireDate;
	}

	public String getConfigName() {
		return configName;
	}

	public void setConfigName(String configName) {
		this.configName = configName;
	}

	public Integer getCouponType() {
		return couponType;
	}

	public void setCouponType(Integer couponType) {
		this.couponType = couponType;
	}

	public Integer getDiscountPercent() {
		return discountPercent;
	}

	public void setDiscountPercent(Integer discountPercent) {
		this.discountPercent = discountPercent;
	}

	public Double getMaxDeductionMoney() {
		return maxDeductionMoney;
	}

	public void setMaxDeductionMoney(Double maxDeductionMoney) {
		this.maxDeductionMoney = maxDeductionMoney;
	}

	public Double getCouponMoney() {
		return couponMoney;
	}

	public void setCouponMoney(Double couponMoney) {
		this.couponMoney = couponMoney;
	}

	public Integer getValidateDay() {
		return validateDay;
	}

	public void setValidateDay(Integer validateDay) {
		this.validateDay = validateDay;
	}

	public String getUseCityId() {
		return useCityId;
	}

	public void setUseCityId(String useCityId) {
		this.useCityId = useCityId;
	}

	public String getUseWeekDay() {
		return useWeekDay;
	}

	public void setUseWeekDay(String useWeekDay) {
		this.useWeekDay = useWeekDay;
	}

	public String getUseUpperTime() {
		return useUpperTime;
	}

	public void setUseUpperTime(String useUpperTime) {
		this.useUpperTime = useUpperTime;
	}

	public String getUseLowerTime() {
		return useLowerTime;
	}

	public void setUseLowerTime(String useLowerTime) {
		this.useLowerTime = useLowerTime;
	}

	public Double getBaseOrderMoney() {
		return baseOrderMoney;
	}

	public void setBaseOrderMoney(Double baseOrderMoney) {
		this.baseOrderMoney = baseOrderMoney;
	}

	public String getUseVehicleModeId() {
		return useVehicleModeId;
	}

	public void setUseVehicleModeId(String useVehicleModeId) {
		this.useVehicleModeId = useVehicleModeId;
	}

	public String getAppDiscription() {
		return appDiscription;
	}

	public void setAppDiscription(String appDiscription) {
		this.appDiscription = appDiscription;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getConfigDetail() {
		return configDetail;
	}

	public void setConfigDetail(String configDetail) {
		this.configDetail = configDetail;
	}

	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	
}

    