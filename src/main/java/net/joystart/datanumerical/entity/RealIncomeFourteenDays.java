package net.joystart.datanumerical.entity;

import java.io.Serializable;
/**
 * @ClassName RealIncomeFourteenDays
 * @Description 实际收入折线图实体
 * @author zhuwq
 * @Date 2017年4月14日 下午2:00:44
 * @version 1.0.0
 */
public class RealIncomeFourteenDays implements Serializable {
    private static final long serialVersionUID = 6651395264892329492L;
    private String Date;//横轴日期
    private String money;//竖轴金额
    private String lineColor;//区域颜色
    
    public String getDate() {
        return Date;
    }
    
    public void setDate(String date) {
        Date = date;
    }
    
    public String getMoney() {
        return money;
    }
    
    public void setMoney(String money) {
        this.money = money;
    }
    
    public String getLineColor() {
        return lineColor;
    }
    
    public void setLineColor(String lineColor) {
        this.lineColor = lineColor;
    }
    
}
