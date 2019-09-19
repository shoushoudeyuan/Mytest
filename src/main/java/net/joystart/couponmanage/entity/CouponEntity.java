package net.joystart.couponmanage.entity;

public class CouponEntity {

	private Integer id;
	
	/**
	 * 客户id
	 */
	private Integer customerId;
	
	/**
	 * 优惠券配置id
	 */
	
	private Integer couponConfigId;
	
	/**
	 * 优惠券名称
	 */
	private Integer couponName;
	
	/**
	 * 优惠券编码
	 */
	private Integer couponNo;
	
	/**
	 * 优惠券来源
	 */
	private Integer sourceType;
	
	/**
	 * 是否启用（1启用2禁用）
	 */
	private Integer isEnable;
	
	/**
	 * 是否已使用（1未使用2已使用）
	 */
	private Integer isUsed;
	
	/**
	 * 领取发放时间
	 */
	private Integer createDate;
	
	/**
	 * 失效时间
	 */
	private Integer expireDate;
	
	/**
	 * 修改时间
	 */
	private Integer modifyDate;

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

	public Integer getCouponName() {
		return couponName;
	}

	public void setCouponName(Integer couponName) {
		this.couponName = couponName;
	}

	public Integer getCouponNo() {
		return couponNo;
	}

	public void setCouponNo(Integer couponNo) {
		this.couponNo = couponNo;
	}

	public Integer getSourceType() {
		return sourceType;
	}

	public void setSourceType(Integer sourceType) {
		this.sourceType = sourceType;
	}

	public Integer getIsEnable() {
		return isEnable;
	}

	public void setIsEnable(Integer isEnable) {
		this.isEnable = isEnable;
	}

	public Integer getIsUsed() {
		return isUsed;
	}

	public void setIsUsed(Integer isUsed) {
		this.isUsed = isUsed;
	}

	public Integer getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Integer createDate) {
		this.createDate = createDate;
	}

	public Integer getExpireDate() {
		return expireDate;
	}

	public void setExpireDate(Integer expireDate) {
		this.expireDate = expireDate;
	}

	public Integer getModifyDate() {
		return modifyDate;
	}

	public void setModifyDate(Integer modifyDate) {
		this.modifyDate = modifyDate;
	}
	
	
	
}
