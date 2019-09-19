package net.joystart.couponmanage.entity;

import java.util.Date;

/**
 * 优惠券券包
* 
* @author zm.mu   
* @date 2018年5月31日 上午11:32:47
 */
public class CouponPackage {
	
	private Integer id;
	
	/**
	 * 券包名称
	 */
	private String pkgname;
	
	/**
	 * 创建人
	 */
	private String creater;
	
	/**
	 * 创建时间
	 */
	private Date createDate;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getPkgname() {
		return pkgname;
	}

	public void setPkgname(String pkgname) {
		this.pkgname = pkgname;
	}

	public String getCreater() {
		return creater;
	}

	public void setCreater(String creater) {
		this.creater = creater;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	
}
