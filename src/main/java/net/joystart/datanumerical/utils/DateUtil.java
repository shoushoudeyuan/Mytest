package net.joystart.datanumerical.utils;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

public class DateUtil {
    /**
     * @Description 获取时间段内的所有日期值
     * @author zhuwq
     * @param dBegin
     * @param dEnd
     * @return
     */
    public static List<Date> findDates(String dBegin, String dEnd){
        try {
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
            Date begin = df.parse(dBegin);
            Date end = df.parse(dEnd);
            List<Date> lDate = new ArrayList<Date>();  
            lDate.add(begin);  
            Calendar calBegin = Calendar.getInstance();   
            calBegin.setTime(begin);  
            Calendar calEnd = Calendar.getInstance();  
            calEnd.setTime(end);  
            while (end.after(calBegin.getTime())) {  
                // 根据日历的规则，为给定的日历字段添加或减去指定的时间量  
                calBegin.add(Calendar.DAY_OF_MONTH, 1);  
                lDate.add(calBegin.getTime());  
            }  
            return lDate;  
        } catch (Exception e) {
            // TODO: handle exception
        }
        return null;
    } 
    /**
     * @Description 获取前后推日期
     * @author zhuwq
     * @param dayNum 天数
     * @return
     */
    public static Date getNextDate(int dayNum){
        Calendar calendar = Calendar.getInstance();
        Date now = new Date();
        calendar.setTime(now);
        calendar.add(Calendar.DAY_OF_MONTH, dayNum);
        return calendar.getTime();
    }
}
