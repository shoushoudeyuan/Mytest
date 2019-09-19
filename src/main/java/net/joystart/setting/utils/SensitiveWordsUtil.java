package net.joystart.setting.utils;


import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.apache.log4j.Logger;

import net.joystart.common.util.ConfigUtil;


public class SensitiveWordsUtil {
    static Logger logger = Logger.getLogger(SensitiveWordsUtil.class);
    private static List<String> sensitiveWords = new ArrayList<String>();
    static{
        try {
            sensitiveWords = Arrays.asList(ConfigUtil.pro.getProperty("sensitiveWords").split(","));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public static List<String> getSensitiveWords(){
        return sensitiveWords;
    }
}

