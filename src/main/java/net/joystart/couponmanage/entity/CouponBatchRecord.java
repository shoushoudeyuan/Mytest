package net.joystart.couponmanage.entity;

import java.util.Date;

import net.joystart.common.entity.CommonDTO;

public class CouponBatchRecord extends CommonDTO {
	
	private static final long serialVersionUID = -6110344282861302194L;

	private Integer id;//发券流水id

    private Integer customerid;//用户id

    private Integer oplogid;//批量发券操作日志id

    private Integer packageid;//券包id

    private Integer sendstatus;//发送状态

    private Date sendtime;//发送时间
    
    private String name;//姓名
    
    private String mobile;//手机号
    
    private Integer gender;//性别
    
    private Byte identityApprove;//认证状态
    
    private Byte isDisable;//是否禁用

    private Byte isCanOrder;//是否下单

    private Date regDate;//注册时间
    
    private Integer memberType;//会员标识 0：非会员  1：会员

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getCustomerid() {
        return customerid;
    }

    public void setCustomerid(Integer customerid) {
        this.customerid = customerid;
    }

    public Integer getOplogid() {
        return oplogid;
    }

    public void setOplogid(Integer oplogid) {
        this.oplogid = oplogid;
    }

    public Integer getPackageid() {
        return packageid;
    }

    public void setPackageid(Integer packageid) {
        this.packageid = packageid;
    }

    public Integer getSendstatus() {
        return sendstatus;
    }

    public void setSendstatus(Integer sendstatus) {
        this.sendstatus = sendstatus;
    }

    public Date getSendtime() {
        return sendtime;
    }

    public void setSendtime(Date sendtime) {
        this.sendtime = sendtime;
    }

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public Integer getGender() {
		return gender;
	}

	public void setGender(Integer gender) {
		this.gender = gender;
	}

	public Byte getIdentityApprove() {
		return identityApprove;
	}

	public void setIdentityApprove(Byte identityApprove) {
		this.identityApprove = identityApprove;
	}

	public Byte getIsDisable() {
		return isDisable;
	}

	public void setIsDisable(Byte isDisable) {
		this.isDisable = isDisable;
	}

	public Byte getIsCanOrder() {
		return isCanOrder;
	}

	public void setIsCanOrder(Byte isCanOrder) {
		this.isCanOrder = isCanOrder;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public Integer getMemberType() {
		return memberType;
	}

	public void setMemberType(Integer memberType) {
		this.memberType = memberType;
	}
}