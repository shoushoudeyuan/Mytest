package net.joystart.datanumerical.entity;

import java.io.Serializable;
/**
 * @ClassName StatisticsCarPort
 * @Description 车位信息统计
 * @author zhuwq
 * @Date 2017年4月14日 下午2:00:44
 * @version 1.0.0
 */
public class StatisticsCarPort implements Serializable {
    private static final long serialVersionUID = -8939844379043687320L;
    private int allCarPort;//全部车位
    private int usedCarPort;//已占车位
    
    public int getAllCarPort() {
        return allCarPort;
    }
    
    public void setAllCarPort(int allCarPort) {
        this.allCarPort = allCarPort;
    }
    
    public int getUsedCarPort() {
        return usedCarPort;
    }
    
    public void setUsedCarPort(int usedCarPort) {
        this.usedCarPort = usedCarPort;
    }
    
    
}
