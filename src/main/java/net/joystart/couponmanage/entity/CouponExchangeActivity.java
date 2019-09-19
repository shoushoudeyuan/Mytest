package net.joystart.couponmanage.entity;

import java.util.Date;

/**
 * 优惠券兑换活动
* 
* @author zm.mu   
* @date 2018年5月31日 上午11:42:18
 */
public class CouponExchangeActivity {
	
	private Integer id;
	
	/**
	 * 兑换活动名称
	 */
	private String activityName;
	
	/**
	 * 券码兑换数量
	 */
	private Integer exchangeCount;
	
	/**
	 * 是否已删除(1未删除2已删除)
	 */
	private Integer isDelete;
	
	/**
	 * 是否启用（1启用2禁用）
	 */
	private Integer isEnable;
	
	/**
	 * 结束时间
	 */
	private Date endDate;
	
	/**
	 * 备注
	 */
	private String remark;
	
	/**
	 * 创建时间
	 */
	private Date createDate;
	
	/**
	 * 修改时间
	 */
	private Date modifyDate;
	
	/**
	 * 已兑换数量
	 */
	private Integer usedCount;
	
	private Integer couponPackageId;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getActivityName() {
		return activityName;
	}

	public void setActivityName(String activityName) {
		this.activityName = activityName;
	}
	
	public Integer getExchangeCount() {
		return exchangeCount;
	}

	public void setExchangeCount(Integer exchangeCount) {
		this.exchangeCount = exchangeCount;
	}

	public Integer getIsDelete() {
		return isDelete;
	}

	public void setIsDelete(Integer isDelete) {
		this.isDelete = isDelete;
	}

	public Integer getIsEnable() {
		return isEnable;
	}

	public void setIsEnable(Integer isEnable) {
		this.isEnable = isEnable;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Date getModifyDate() {
		return modifyDate;
	}

	public void setModifyDate(Date modifyDate) {
		this.modifyDate = modifyDate;
	}

	public Integer getUsedCount() {
		return usedCount;
	}

	public void setUsedCount(Integer usedCount) {
		this.usedCount = usedCount;
	}

	public Integer getCouponPackageId() {
		return couponPackageId;
	}

	public void setCouponPackageId(Integer couponPackageId) {
		this.couponPackageId = couponPackageId;
	}
	
	
}
