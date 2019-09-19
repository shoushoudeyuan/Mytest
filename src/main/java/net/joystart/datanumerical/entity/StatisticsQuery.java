package net.joystart.datanumerical.entity;

import java.io.Serializable;
import java.util.Date;

/**
 * 数据统计查询
 * 
 * @author cuijinlong
 * @version 1.0
 * @since 1.0
 */
public class StatisticsQuery implements Serializable {
    private Date startDate;
    private Date endDate;
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
    
    

}

