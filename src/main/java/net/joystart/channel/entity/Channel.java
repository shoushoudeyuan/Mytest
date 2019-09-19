package net.joystart.channel.entity;

import java.util.Date;

/**
 * 渠道管理实体
 * @author lsy
 */
public class Channel {

	private Integer id;
	
	private String channelName;
	
	private Integer status;
	
	private Date createDate;
	
	private Date startDate;
	
	private Date endDate;
	
	private String channelCode;
	
	private String activityUrl;
	
	private String activityHomeImg;
	
	private String activityAppImg;
	
	private String iosDownloadUrl;
	
	private String androidDownloadUrl;
	
	private Integer couponPackageId;

	public Integer getCouponPackageId() {
		return couponPackageId;
	}

	public void setCouponPackageId(Integer couponPackageId) {
		this.couponPackageId = couponPackageId;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getChannelName() {
		return channelName;
	}

	public void setChannelName(String channelName) {
		this.channelName = channelName;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public String getChannelCode() {
		return channelCode;
	}

	public void setChannelCode(String channelCode) {
		this.channelCode = channelCode;
	}

	public String getActivityUrl() {
		return activityUrl;
	}

	public void setActivityUrl(String activityUrl) {
		this.activityUrl = activityUrl;
	}

	public String getActivityHomeImg() {
		return activityHomeImg;
	}

	public void setActivityHomeImg(String activityHomeImg) {
		this.activityHomeImg = activityHomeImg;
	}

	public String getActivityAppImg() {
		return activityAppImg;
	}

	public void setActivityAppImg(String activityAppImg) {
		this.activityAppImg = activityAppImg;
	}

	public String getIosDownloadUrl() {
		return iosDownloadUrl;
	}

	public void setIosDownloadUrl(String iosDownloadUrl) {
		this.iosDownloadUrl = iosDownloadUrl;
	}

	public String getAndroidDownloadUrl() {
		return androidDownloadUrl;
	}

	public void setAndroidDownloadUrl(String androidDownloadUrl) {
		this.androidDownloadUrl = androidDownloadUrl;
	}
}
