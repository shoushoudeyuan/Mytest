package net.joystart.couponmanage.entity;

import java.util.Date;

public class CouponBatchOplog {
    private Integer id;

    private Integer operateuser;

    private Date createdate;

    private Integer packageid;

    private Integer couponnum;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getOperateuser() {
        return operateuser;
    }

    public void setOperateuser(Integer operateuser) {
        this.operateuser = operateuser;
    }

    public Date getCreatedate() {
        return createdate;
    }

    public void setCreatedate(Date createdate) {
        this.createdate = createdate;
    }

    public Integer getPackageid() {
        return packageid;
    }

    public void setPackageid(Integer packageid) {
        this.packageid = packageid;
    }

    public Integer getCouponnum() {
        return couponnum;
    }

    public void setCouponnum(Integer couponnum) {
        this.couponnum = couponnum;
    }
}