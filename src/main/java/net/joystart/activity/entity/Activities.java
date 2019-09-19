package net.joystart.activity.entity;

import java.util.Date;

public class Activities {
	
    private Integer id;

    private String activityname;

    private Date startdate;

    private Date enddate;

    private Integer isdisable;

    private Integer ispublish;

    private Integer exchangelimit;

    private String remark;

    private Integer isdelete;

    private String activitylink;
    
    private Integer couponruleid;
    
    private String couponruleidentification;
    
    private String couponrulename;
    //规则标识
    private String identification;

    private Date createdate;

    private Date modifydate;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getActivityname() {
		return activityname;
	}

	public void setActivityname(String activityname) {
		this.activityname = activityname;
	}

	public Date getStartdate() {
		return startdate;
	}

	public void setStartdate(Date startdate) {
		this.startdate = startdate;
	}

	public Date getEnddate() {
		return enddate;
	}

	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}

	public Integer getIsdisable() {
		return isdisable;
	}

	public void setIsdisable(Integer isdisable) {
		this.isdisable = isdisable;
	}

	public Integer getIspublish() {
		return ispublish;
	}

	public void setIspublish(Integer ispublish) {
		this.ispublish = ispublish;
	}

	public Integer getExchangelimit() {
		return exchangelimit;
	}

	public void setExchangelimit(Integer exchangelimit) {
		this.exchangelimit = exchangelimit;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Integer getIsdelete() {
		return isdelete;
	}

	public void setIsdelete(Integer isdelete) {
		this.isdelete = isdelete;
	}

	public String getActivitylink() {
		return activitylink;
	}

	public void setActivitylink(String activitylink) {
		this.activitylink = activitylink;
	}

	public Date getCreatedate() {
		return createdate;
	}

	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}

	public Date getModifydate() {
		return modifydate;
	}

	public void setModifydate(Date modifydate) {
		this.modifydate = modifydate;
	}

	/**
	 * @return the couponruleid
	 */
	public Integer getCouponruleid() {
		return couponruleid;
	}

	/**
	 * @param couponruleid the couponruleid to set
	 */
	public void setCouponruleid(Integer couponruleid) {
		this.couponruleid = couponruleid;
	}

	/**
	 * @return the couponruleidentification
	 */
	public String getCouponruleidentification() {
		return couponruleidentification;
	}

	/**
	 * @param couponruleidentification the couponruleidentification to set
	 */
	public void setCouponruleidentification(String couponruleidentification) {
		this.couponruleidentification = couponruleidentification;
	}

	/**
	 * @return the couponrulename
	 */
	public String getCouponrulename() {
		return couponrulename;
	}

	/**
	 * @param couponrulename the couponrulename to set
	 */
	public void setCouponrulename(String couponrulename) {
		this.couponrulename = couponrulename;
	}

	/**
	 * @return the identification
	 */
	public String getIdentification() {
		return identification;
	}

	/**
	 * @param identification the identification to set
	 */
	public void setIdentification(String identification) {
		this.identification = identification;
	}

   
}