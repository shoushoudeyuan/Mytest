package net.joystart.datanumerical.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

public class SeriesVo implements Serializable{
	 private String name;//车场名称
	 
	 private String type = "line";
	 
	 private long[] data;//数据统计count

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public long[] getData() {
		return data;
	}

	public void setData(long[] data) {
		this.data = data;
	}
	 
	 
	 

}
