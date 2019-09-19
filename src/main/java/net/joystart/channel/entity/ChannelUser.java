package net.joystart.channel.entity;

import java.util.Date;
/**
 * 渠道商用户实体
 * @author lsy
 */
public class ChannelUser {

	private String userName;
	
	private String name;
	
	private Date registerDate;
	
	private Date loginDate;
	
	private Integer isApprove; // 是否身份证正
	
	private Integer isMember; // 是否缴纳保证金
	
	private Integer isCanOrder; // 能否下单

	public Integer getIsCanOrder() {
		return isCanOrder;
	}

	public void setIsCanOrder(Integer isCanOrder) {
		this.isCanOrder = isCanOrder;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Date getRegisterDate() {
		return registerDate;
	}

	public void setRegisterDate(Date registerDate) {
		this.registerDate = registerDate;
	}

	public Date getLoginDate() {
		return loginDate;
	}

	public void setLoginDate(Date loginDate) {
		this.loginDate = loginDate;
	}

	public Integer getIsApprove() {
		return isApprove;
	}

	public void setIsApprove(Integer isApprove) {
		this.isApprove = isApprove;
	}

	public Integer getIsMember() {
		return isMember;
	}

	public void setIsMember(Integer isMember) {
		this.isMember = isMember;
	}
}
