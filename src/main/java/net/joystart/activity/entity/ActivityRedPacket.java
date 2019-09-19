package net.joystart.activity.entity;

import java.util.Date;

/**
 * 活动红包实体
 * @author LDY20151214
 * 此实体实现了Cloneable接口,若需要修改请注意
 */
public class ActivityRedPacket implements Cloneable {
	//实现类的浅拷贝方法
	public Object clone(){
		ActivityRedPacket arp=null;
		try {
			arp = (ActivityRedPacket)super.clone();
		} catch (CloneNotSupportedException e) {
			e.printStackTrace();
		}
		return arp;
	}
    private Integer id;

    private Integer activityid;

    private String remark;

    private Date startdate;

    private Date enddate;

    private Byte isdisable;

    private String imgurl;

    private Byte isdelete;

    private String packetnum;

    private Integer smokeinuserid;

    private Date smokeindate;

    private Integer usinguserid;

    private Date usingdate;

    private Date createdate;

    private Date modifydate;
    //是否已使用
    private Integer isused;
    //生成红包数量
    private Integer number;
    //来源(即活动规则名称)
    private String rulename;
    
    private String usingusername;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getActivityid() {
        return activityid;
    }

    public void setActivityid(Integer activityid) {
        this.activityid = activityid;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
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

    public Byte getIsdisable() {
        return isdisable;
    }

    public void setIsdisable(Byte isdisable) {
        this.isdisable = isdisable;
    }

    public String getImgurl() {
        return imgurl;
    }

    public void setImgurl(String imgurl) {
        this.imgurl = imgurl == null ? null : imgurl.trim();
    }

    public Byte getIsdelete() {
        return isdelete;
    }

    public void setIsdelete(Byte isdelete) {
        this.isdelete = isdelete;
    }

    public String getPacketnum() {
        return packetnum;
    }

    public void setPacketnum(String packetnum) {
        this.packetnum = packetnum == null ? null : packetnum.trim();
    }

    public Integer getSmokeinuserid() {
        return smokeinuserid;
    }

    public void setSmokeinuserid(Integer smokeinuserid) {
        this.smokeinuserid = smokeinuserid;
    }

    public Date getSmokeindate() {
        return smokeindate;
    }

    public void setSmokeindate(Date smokeindate) {
        this.smokeindate = smokeindate;
    }

    public Integer getUsinguserid() {
        return usinguserid;
    }

    public void setUsinguserid(Integer usinguserid) {
        this.usinguserid = usinguserid;
        if(null != usinguserid){
        	this.isused=1;
        }else{
        	this.isused=0;
        }
    }

    public Date getUsingdate() {
        return usingdate;
    }

    public void setUsingdate(Date usingdate) {
        this.usingdate = usingdate;
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
	 * @return the isused
	 */
	public Integer getIsused() {
		return isused;
	}

	/**
	 * @return the number
	 */
	public Integer getNumber() {
		return number;
	}

	/**
	 * @param number the number to set
	 */
	public void setNumber(Integer number) {
		this.number = number;
	}

	/**
	 * @return the rulename
	 */
	public String getRulename() {
		return rulename;
	}

	/**
	 * @param rulename the rulename to set
	 */
	public void setRulename(String rulename) {
		this.rulename = rulename;
	}

	public String getUsingusername() {
		return usingusername;
	}

	public void setUsingusername(String usingusername) {
		this.usingusername = usingusername;
	}
	
	
    
}