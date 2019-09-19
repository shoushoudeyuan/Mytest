package net.joystart.couponmanage.entity;

import java.util.Date;

import lombok.Data;

@Data
public class CustomerCouponNew {
	
    private Integer id;

    /*
     * 用户ID
     */
    private Integer customerId;

    /*
     * 优惠券配置id
     */
    private Integer couponConfigId;
    
    /*
     * 来源
     */
    private Byte sourceType;
    
    /*
     * 来源id
     */
    private Integer sourceId;

    /*
     * 优惠券名称
     */
    private String couponName;

    /*
     * 优惠券编码
     */
    private String couponNo;

    /*
     * 是否启用（1启用2禁用）
     */
    private Integer isEnable;
    
    /**
     * 是否已删除（1未删除2已删除）
     */
    private Integer isDelete;

    /*
     *是否已使用（1未使用2已使用） 
     */
    private Integer isUsed;
    
    /*
     *使用日期
     */
    private Date usedDate;

    /*
     * 领取时间
     */
    private Date createDate;

    /*
     * 失效时间
     */
    private Date expireDate;
}

    