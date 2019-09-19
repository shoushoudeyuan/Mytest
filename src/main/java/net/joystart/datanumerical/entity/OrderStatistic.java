package net.joystart.datanumerical.entity;

import java.io.Serializable;
import java.math.BigDecimal;
/**
 * @ClassName RealIncomeFourteenDays
 * @Description 订单统计
 * @author zhuwq
 * @Date 2017年4月14日 下午2:00:44
 * @version 1.0.0
 */
public class OrderStatistic implements Serializable {
    private static final long serialVersionUID = -77280781165243857L;
    private BigDecimal orderCost;//租金收入
    private BigDecimal actualPaymentCost;//实际收入
    private Integer payCount;//成交支付数量
    
    public BigDecimal getOrderCost() {
        return orderCost;
    }
    
    public void setOrderCost(BigDecimal orderCost) {
        this.orderCost = orderCost;
    }
    
    public BigDecimal getActualPaymentCost() {
        return actualPaymentCost;
    }
    
    public void setActualPaymentCost(BigDecimal actualPaymentCost) {
        this.actualPaymentCost = actualPaymentCost;
    }
    
    public Integer getPayCount() {
        return payCount;
    }
    
    public void setPayCount(Integer payCount) {
        this.payCount = payCount;
    }
}
