package net.joystart.setting.controller;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import net.joystart.common.controller.BaseController;
import net.joystart.common.util.ConstantUtil;
import net.joystart.common.util.DataGridResult;
import net.joystart.common.util.MessageResult;
import net.joystart.common.util.PageUtil;
import net.joystart.common.util.SysLogUtil;
import net.joystart.common.util.date.UtilTimeFormatter;
import net.joystart.common.util.log.Log4jTask;
import net.joystart.customer.entity.Customer;
import net.joystart.setting.entity.LimitCarNumber;
import net.joystart.setting.entity.LimitCarNumberSetting;
import net.joystart.setting.service.ILimitCarNumberService;

@Controller
@RequestMapping("/limitCarNumber")
public class LimitCarNumberController extends BaseController
{
    @Resource
    ILimitCarNumberService limitCarNumberService;

    /**
     * 具体限号规则管理
     * 
     * @param cus
     * @param response
     * @param request
     * @param rows
     * @param page
     */
    @RequestMapping("/limitCarNumberList")
    public void limitCarNumberList(Customer cus, HttpServletResponse response,
            HttpServletRequest request, int rows, int page)
    {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("rowStart", PageUtil.rowStart(page - 1, rows));
        params.put("pageSize", rows);
        String cityId = request.getParameter("cityId");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        if (!StringUtils.isBlank(cityId)){
            params.put("cityId", cityId);
        }
        if (!StringUtils.isBlank(startDate)){
            params.put("startDate", startDate);
        }
        if (!StringUtils.isBlank(endDate)){
            params.put("endDate", endDate);
        }
        List<LimitCarNumber> list = limitCarNumberService
                .limitCarNumberList(params);
        int rowCount = limitCarNumberService.getLimitCarNumberCount(params);

        DataGridResult dgr = new DataGridResult();
        dgr.setTotal(rowCount);
        dgr.setRows(list);
        webOut(response, dgr);

    }

    @RequestMapping("/addLimitCarNumber")
    public void addLimitCarNumber(Customer cus, HttpServletResponse response,
            HttpServletRequest request)
    {
        MessageResult message = new MessageResult();
        try
        {
            // if (cus.getUsername() == null || "".equals(cus.getUsername()))
            // {
            // message.setCode(ConstantUtil.M_PARAMTER_NULL);
            // message.setMessage("请输入用户名");
            // this.out(response, message);
            // return;
            // }
            Map<String, Object> params = new HashMap<String, Object>();
            String date = request.getParameter("date");
            String limitCarNum = request.getParameter("limitCarNum");
            String cityId = request.getParameter("cityId");
            if (!StringUtils.isBlank(cityId))
            {
                params.put("cityId", cityId);
            }
            else
            {
                message.setCode(ConstantUtil.M_EXCEPTION);
                message.setMessage("省（城市）不能为空！");
                out(response, message);
                return;
            }
            if (!StringUtils.isBlank(date))
            {
                params.put("date", date);
            }
            else
            {
                message.setCode(ConstantUtil.M_EXCEPTION);
                message.setMessage("规则日期不能为空！");
                out(response, message);
                return;
            }
            if (!StringUtils.isBlank(limitCarNum))
            {
                params.put("limitCarNum", limitCarNum);
            }
            params.put("createDate", new Date());

            int result = limitCarNumberService.addLimitCarNumber(params);
            SysLogUtil.addLog(request, "新增限号规则", 1);
            if (result == 1)
            {
                limitCarNumberService.vehicleLimitNumberTask();
                message.setCode(ConstantUtil.M_SUCCESS);
                // message.setData(resultCustomer);
                message.setMessage("操作成功");
            }
            else
            {
                message.setCode("0");
                message.setMessage("操作失败");
            }

            this.out(response, message);

        }
        catch (Exception exception)
        {
        	SysLogUtil.addLog(request, "新增限号规则", 0);
            Log4jTask.addLog("addLimitCarNumber接口报错",
                    System.currentTimeMillis(), Log4jTask.ERROR,
                    LimitCarNumberController.class.getName(), exception);
            message.setCode(ConstantUtil.M_SYSTEM_ERROR);
            message.setMessage("系统发生未知错误");
            this.out(response, message);
        }
    }

    @RequestMapping("/deleteLimitCarNumber")
    public void deleteLimitCarNumber(Customer cus, HttpServletResponse response,
            HttpServletRequest request)
    {
        MessageResult message = new MessageResult();
        try
        {

            String ids = request.getParameter("ids");
            if (!StringUtils.isBlank(ids))
            {
                String[] arr = ids.split(",");
                List<String> list = java.util.Arrays.asList(arr);
                int result = limitCarNumberService.deleteLimitCarNumbers(list);
                SysLogUtil.addLog(request, "删除限号规则", 1);
                if (result > 0){
                	limitCarNumberService.vehicleLimitNumberTask();
                    message.setCode(ConstantUtil.M_SUCCESS);
                    message.setMessage("操作成功");
                }
                else
                {
                    message.setCode("0");
                    message.setMessage("操作失败");
                }
                out(response, message);
                return;
            }
            Map<String, Object> params = new HashMap<String, Object>();
            String id = request.getParameter("id");
            if (!StringUtils.isBlank(id))
            {
                params.put("id", id);
                int result = limitCarNumberService.deleteLimitCarNumber(params);
                if (result == 1)
                {
                    limitCarNumberService.vehicleLimitNumberTask();
                    message.setCode(ConstantUtil.M_SUCCESS);
                    message.setMessage("操作成功");
                }
                else
                {
                    message.setCode("0");
                    message.setMessage("操作失败");
                }
            }
            else
            {
                message.setCode(ConstantUtil.M_EXCEPTION);
                message.setMessage("id不能为空！");
                // out(response, message);
            }

            out(response, message);
        }
        catch (Exception exception)
        {
        	SysLogUtil.addLog(request, "删除限号规则", 0);
            Log4jTask.addLog("deleteLimitCarNumber接口报错",
                    System.currentTimeMillis(), Log4jTask.ERROR,
                    LimitCarNumberController.class.getName(), exception);
            message.setCode(ConstantUtil.M_SYSTEM_ERROR);
            message.setMessage("系统发生未知错误");
            this.out(response, message);
        }

    }

    @RequestMapping("/updateLimitCarNumber")
    public void updateLimitCarNumber(Customer cus, HttpServletResponse response,
            HttpServletRequest request)
    {
        MessageResult message = new MessageResult();
        try
        {
            Map<String, Object> params = new HashMap<String, Object>();

            String cityId = request.getParameter("cityId");
            String date = request.getParameter("date");
            String limitCarNum = request.getParameter("limitCarNum");
            String id = request.getParameter("id");
            if (!StringUtils.isBlank(id))
            {
                params.put("id", id);
            }
            else
            {
                message.setCode(ConstantUtil.M_EXCEPTION);
                message.setMessage("id不能为空！");
                out(response, message);
                return;
            }
            if (!StringUtils.isBlank(cityId))
            {
                params.put("cityId", cityId);
            }
            else
            {
                message.setCode(ConstantUtil.M_EXCEPTION);
                message.setMessage("省（城市）不能为空！");
                out(response, message);
                return;
            }
            if (!StringUtils.isBlank(date))
            {
                params.put("date", date);
            }
            else
            {
                message.setCode(ConstantUtil.M_EXCEPTION);
                message.setMessage("规则日期为空！");
                out(response, message);
                return;
            }
            if (!StringUtils.isBlank(limitCarNum))
            {
                params.put("limitCarNum", limitCarNum);
            }

            int result = limitCarNumberService.updateLimitCarNumber(params);
            
            SysLogUtil.addLog(request, "修改限号规则", 1);

            if (result == 1)
            {
                limitCarNumberService.vehicleLimitNumberTask();
                message.setCode(ConstantUtil.M_SUCCESS);
                message.setMessage("操作成功");
                // this.out(response, message);
            }
            else
            {
                message.setCode(result + "");
                message.setMessage("操作失败");
                // this.out(response, message);
            }
            this.out(response, message);

        }
        catch (Exception exception)
        {
        	SysLogUtil.addLog(request, "修改限号规则", 0);
            Log4jTask.addLog("updateLimitCarNumber接口报错",
                    System.currentTimeMillis(), Log4jTask.ERROR,
                    LimitCarNumberController.class.getName(), exception);
            message.setCode(ConstantUtil.M_SYSTEM_ERROR);
            message.setMessage("系统发生未知错误");
            this.out(response, message);
        }
    }

    /**
     * 限号规则设置管理
     * 
     * @param cus
     * @param response
     * @param request
     * @param rows
     * @param page
     */
    @RequestMapping("/limitCarNumberSettingList")
    public void limitCarNumberSettingList(Customer cus,
            HttpServletResponse response, HttpServletRequest request, int rows,
            int page)
    {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("rowStart", PageUtil.rowStart(page - 1, rows));
        params.put("pageSize", rows);
        String cityId = request.getParameter("cityId");
        String date = request.getParameter("date");
        if (!StringUtils.isBlank(cityId))
        {
            params.put("cityId", cityId);
        }
        if (!StringUtils.isBlank(date))
        {
            params.put("date", date);
        }
        List<LimitCarNumberSetting> list = limitCarNumberService
                .limitCarNumberSettingList(params);
        int rowCount = limitCarNumberService
                .getLimitCarNumberSettingCount(params);

        DataGridResult dgr = new DataGridResult();
        dgr.setTotal(rowCount);
        dgr.setRows(list);
        webOut(response, dgr);
    }

    public String getValueFrom(HttpServletRequest request, String key)
    {
        String value1 = request.getParameter(key + "0");
        String value2 = request.getParameter(key + "1");
        String value3 = request.getParameter(key + "2");
        if (!StringUtils.isBlank(value1) || !StringUtils.isBlank(value2) || !StringUtils.isBlank(value3))
        {
            String result = "";
            if (!StringUtils.isBlank(value1))
            {
                result = result + value1;
            }
            if (!StringUtils.isBlank(value2))
            {
                if (result.length() > 0)
                {
                    result = result + "和" + value2;
                }
                else
                {
                    result = result + value2;
                }

            }
            if (!StringUtils.isBlank(value3))
            {
                if (result.length() > 0)
                {
                    result = result + "和" + value3;
                }
                else
                {
                    result = result + value3;
                }
            }
            return result;
        }
        return null;
    }

    @RequestMapping("/addLimitCarNumberSetting")
    public void addLimitCarNumberSetting(Customer cus,
            HttpServletResponse response, HttpServletRequest request)
    {
        MessageResult message = new MessageResult();
        try
        {
            // if (cus.getUsername() == null || "".equals(cus.getUsername()))
            // {
            // message.setCode(ConstantUtil.M_PARAMTER_NULL);
            // message.setMessage("请输入用户名");
            // this.out(response, message);
            // return;
            // }
            Map<String, Object> params = new HashMap<String, Object>();
            String oneLimitCarNum = getValueFrom(request, "oneLimitCarNum");// request.getParameter("oneLimitCarNum");
            String twoLimitCarNum = getValueFrom(request, "twoLimitCarNum");// request.getParameter("twoLimitCarNum");
            String threeLimitCarNum = getValueFrom(request, "threeLimitCarNum");// request.getParameter("threeLimitCarNum");
            String fourLimitCarNum = getValueFrom(request, "fourLimitCarNum");// request.getParameter("fourLimitCarNum");
            String fiveLimitCarNum = getValueFrom(request, "fiveLimitCarNum");// request.getParameter("fiveLimitCarNum");
            String sixLimitCarNum = getValueFrom(request, "sixLimitCarNum");// request.getParameter("sixLimitCarNum");
            String sevenLimitCarNum = getValueFrom(request, "sevenLimitCarNum");// request.getParameter("sevenLimitCarNum");
            String startDate = request.getParameter("startDate");
            String endDate = request.getParameter("endDate");
            String cityId = request.getParameter("cityId");
            List<Map<String, Object>> values  = new ArrayList<Map<String, Object>>();
            if (!StringUtils.isBlank(cityId)){
                params.put("cityId", cityId);
                int rowCount = limitCarNumberService.getLimitCarNumberSettingCount(params);
                if(rowCount>0){
                    message.setCode(ConstantUtil.M_EXCEPTION);
                    message.setMessage("一个省（城市）只能添加一条记录");
                    out(response, message);
                    return;
                }
            }
            else
            {
                message.setCode(ConstantUtil.M_EXCEPTION);
                message.setMessage("省（城市）不能为空！");
                out(response, message);
                return;
            }
            if (!StringUtils.isBlank(startDate))
            {
                params.put("startDate", startDate);
            }
            else
            {
                message.setCode(ConstantUtil.M_EXCEPTION);
                message.setMessage("开始日期不能为空！");
                out(response, message);
                return;
            }
            if (!StringUtils.isBlank(endDate))
            {
                params.put("endDate", endDate);
            }
            else
            {
                message.setCode(ConstantUtil.M_EXCEPTION);
                message.setMessage("结束日期不能为空！");
                out(response, message);
                return;
            }
            if (!StringUtils.isBlank(oneLimitCarNum))
            {
                params.put("oneLimitCarNum", oneLimitCarNum);
                addDetails(oneLimitCarNum, values, UtilTimeFormatter
                        .getWeekDays(startDate, endDate, Calendar.MONDAY),
                        cityId);
            }
            if (!StringUtils.isBlank(twoLimitCarNum))
            {
                params.put("twoLimitCarNum", twoLimitCarNum);
                addDetails(twoLimitCarNum, values, UtilTimeFormatter
                        .getWeekDays(startDate, endDate, Calendar.TUESDAY),
                        cityId);
            }
            if (!StringUtils.isBlank(threeLimitCarNum))
            {
                params.put("threeLimitCarNum", threeLimitCarNum);
                addDetails(threeLimitCarNum, values, UtilTimeFormatter
                        .getWeekDays(startDate, endDate, Calendar.WEDNESDAY),
                        cityId);
            }
            if (!StringUtils.isBlank(fourLimitCarNum))
            {
                params.put("fourLimitCarNum", fourLimitCarNum);
                addDetails(fourLimitCarNum, values, UtilTimeFormatter
                        .getWeekDays(startDate, endDate, Calendar.THURSDAY),
                        cityId);
            }
            if (!StringUtils.isBlank(fiveLimitCarNum))
            {
                params.put("fiveLimitCarNum", fiveLimitCarNum);
                addDetails(fiveLimitCarNum, values, UtilTimeFormatter
                        .getWeekDays(startDate, endDate, Calendar.FRIDAY),
                        cityId);
            }
            if (!StringUtils.isBlank(sixLimitCarNum))
            {
                params.put("sixLimitCarNum", sixLimitCarNum);
                addDetails(sixLimitCarNum, values, UtilTimeFormatter
                        .getWeekDays(startDate, endDate, Calendar.SATURDAY),
                        cityId);
            }
            if (!StringUtils.isBlank(sevenLimitCarNum))
            {
                params.put("sevenLimitCarNum", sevenLimitCarNum);
                addDetails(sevenLimitCarNum, values, UtilTimeFormatter
                        .getWeekDays(startDate, endDate, Calendar.SUNDAY),
                        cityId);
            }
            params.put("detailMap", values);
            params.put("createDate", new Date());

            int result = limitCarNumberService.addLimitCarNumberSetting(params);
            SysLogUtil.addLog(request, "车辆限号规则添加", 1);

            if (result == 1)
            {
                limitCarNumberService.vehicleLimitNumberTask();
                message.setCode(ConstantUtil.M_SUCCESS);
                // message.setData(resultCustomer);
                message.setMessage("操作成功");
            }
            else
            {
                message.setCode("0");
                message.setMessage("操作失败");
            }

            this.out(response, message);

        }
        catch (Exception exception)
        {
        	SysLogUtil.addLog(request, "车辆限号规则添加", 0);
            Log4jTask.addLog("addLimitCarNumberSetting接口报错",
                    System.currentTimeMillis(), Log4jTask.ERROR,
                    LimitCarNumberController.class.getName(), exception);
            message.setCode(ConstantUtil.M_SYSTEM_ERROR);
            message.setMessage("系统发生未知错误");
            this.out(response, message);
        }
    }

    /**
     * 
     * @param limitNums
     * @param values
     * @param days
     * @param cityId
     */
    public void addDetails(String limitNums, List<Map<String, Object>> values,
            List<String> days, String cityId)
    {
        if (days != null && days.size() > 0 && !StringUtils.isBlank(limitNums)
                && values != null)
        {
            String[] str = limitNums.split("和");
            for (String string : days)
            {
                for (int i = 0; i < str.length; i++)
                {
                    Map<String, Object> params = new HashMap<String, Object>();
                    params.put("date", string);
                    params.put("cityId", cityId);
                    params.put("limitCarNum", str[i]);
                    params.put("createDate", new Date());
                    values.add(params);
                }

            }

        }
    }

    @RequestMapping("/updateLimitCarNumberSetting")
    public void updateLimitCarNumberSetting(Customer cus,
            HttpServletResponse response, HttpServletRequest request)
    {
        MessageResult message = new MessageResult();
        try
        {

            Map<String, Object> params = new HashMap<String, Object>();
            String oneLimitCarNum = getValueFrom(request, "oneLimitCarNum");// request.getParameter("oneLimitCarNum");
            String twoLimitCarNum = getValueFrom(request, "twoLimitCarNum");// request.getParameter("twoLimitCarNum");
            String threeLimitCarNum = getValueFrom(request, "threeLimitCarNum");// request.getParameter("threeLimitCarNum");
            String fourLimitCarNum = getValueFrom(request, "fourLimitCarNum");// request.getParameter("fourLimitCarNum");
            String fiveLimitCarNum = getValueFrom(request, "fiveLimitCarNum");// request.getParameter("fiveLimitCarNum");
            String sixLimitCarNum = getValueFrom(request, "sixLimitCarNum");// request.getParameter("sixLimitCarNum");
            String sevenLimitCarNum = getValueFrom(request, "sevenLimitCarNum");// request.getParameter("sevenLimitCarNum");
            String startDate = request.getParameter("startDate");
            String endDate = request.getParameter("endDate");
            String cityId = request.getParameter("cityId");
            String id = request.getParameter("id");
          
            if (!StringUtils.isBlank(id)){
                params.put("id", id);
            }else{
                message.setCode(ConstantUtil.M_EXCEPTION);
                message.setMessage("id不能为空！");
                out(response, message);
                return;
            }
            if (!StringUtils.isBlank(cityId)) {
                params.put("cityId", cityId);
                int rowCount = limitCarNumberService.getLimitCarNumberSettingCount(params);
                if(rowCount>0){
                    message.setCode(ConstantUtil.M_EXCEPTION);
                    message.setMessage("一个省（城市）只能添加一条记录");
                    out(response, message);
                    return;
                }
            }else{
                message.setCode(ConstantUtil.M_EXCEPTION);
                message.setMessage("省（城市）不能为空！");
                out(response, message);
                return;
            }
            if (!StringUtils.isBlank(startDate)){
                params.put("startDate", startDate);
            }else{
                message.setCode(ConstantUtil.M_EXCEPTION);
                message.setMessage("开始日期不能为空！");
                out(response, message);
                return;
            }
            if (!StringUtils.isBlank(endDate)){
                params.put("endDate", endDate);
            } else{
                message.setCode(ConstantUtil.M_EXCEPTION);
                message.setMessage("结束日期不能为空！");
                out(response, message);
                return;
            }
            List<Map<String, Object>> values  = new ArrayList<Map<String, Object>>();
            if (!StringUtils.isBlank(oneLimitCarNum)){
                params.put("oneLimitCarNum", oneLimitCarNum);
                addDetails(oneLimitCarNum, values, UtilTimeFormatter
                        .getWeekDays(startDate, endDate, Calendar.MONDAY),
                        cityId);
            }
            if (!StringUtils.isBlank(twoLimitCarNum)){
                params.put("twoLimitCarNum", twoLimitCarNum);
                addDetails(twoLimitCarNum, values, UtilTimeFormatter
                        .getWeekDays(startDate, endDate, Calendar.TUESDAY),
                        cityId);
            }
            if (!StringUtils.isBlank(threeLimitCarNum)){
                params.put("threeLimitCarNum", threeLimitCarNum);
                addDetails(threeLimitCarNum, values, UtilTimeFormatter
                        .getWeekDays(startDate, endDate, Calendar.WEDNESDAY),
                        cityId);
            }
            if (!StringUtils.isBlank(fourLimitCarNum)){
                params.put("fourLimitCarNum", fourLimitCarNum);
                addDetails(fourLimitCarNum, values, UtilTimeFormatter
                        .getWeekDays(startDate, endDate, Calendar.THURSDAY),
                        cityId);
            }
            if (!StringUtils.isBlank(fiveLimitCarNum)) {
                params.put("fiveLimitCarNum", fiveLimitCarNum);
                addDetails(fiveLimitCarNum, values, UtilTimeFormatter
                        .getWeekDays(startDate, endDate, Calendar.FRIDAY),
                        cityId);
            }
            if (!StringUtils.isBlank(sixLimitCarNum)){
                params.put("sixLimitCarNum", sixLimitCarNum);
                addDetails(sixLimitCarNum, values, UtilTimeFormatter
                        .getWeekDays(startDate, endDate, Calendar.SATURDAY),
                        cityId);
            }
            if (!StringUtils.isBlank(sevenLimitCarNum)){
                params.put("sevenLimitCarNum", sevenLimitCarNum);
                addDetails(sevenLimitCarNum, values, UtilTimeFormatter
                        .getWeekDays(startDate, endDate, Calendar.SUNDAY),
                        cityId);
            }
            params.put("detailMap", values);
     
            // params.put("createDate", new Date());

            int result = limitCarNumberService
                    .updateLimitCarNumberSetting(params);
            SysLogUtil.addLog(request, "编辑车辆限号规则", 1);
            
            if (result == 1)
            {
                limitCarNumberService.vehicleLimitNumberTask();
                message.setCode(ConstantUtil.M_SUCCESS);
                // message.setData(resultCustomer);
                message.setMessage("操作成功");
            }
            else
            {
                message.setCode("0");
                message.setMessage("操作失败");
            }

            this.out(response, message);

        }
        catch (Exception exception)
        {
        	SysLogUtil.addLog(request, "编辑车辆限号规则", 0);
            Log4jTask.addLog("updateLimitCarNumberSetting接口报错",
                    System.currentTimeMillis(), Log4jTask.ERROR,
                    LimitCarNumberController.class.getName(), exception);
            message.setCode(ConstantUtil.M_SYSTEM_ERROR);
            message.setMessage("系统发生未知错误");
            this.out(response, message);
        }
    }

    @RequestMapping("/deleteLimitCarNumberSetting")
    public void deleteLimitCarNumberSetting(Customer cus,
            HttpServletResponse response, HttpServletRequest request)
    {
        MessageResult message = new MessageResult();
        try
        {

            String ids = request.getParameter("ids");
            if (!StringUtils.isBlank(ids))
            {
                String[] arr = ids.split(",");
                List<String> list = java.util.Arrays.asList(arr);
                int result = limitCarNumberService.deleteLimitCarNumberSettings(list);
                SysLogUtil.addLog(request, "删除车辆限号规则", 1);
                if (result > 0){
                	limitCarNumberService.vehicleLimitNumberTask();
                    message.setCode(ConstantUtil.M_SUCCESS);
                    message.setMessage("操作成功");
                }
                else
                {
                    message.setCode("0");
                    message.setMessage("操作失败");
                }
                out(response, message);
                return;
            }
            Map<String, Object> params = new HashMap<String, Object>();
            String id = request.getParameter("id");
            if (!StringUtils.isBlank(id))
            {
                params.put("id", id);
                int result = limitCarNumberService
                        .deleteLimitCarNumberSetting(params);
                if (result == 1)
                {
                    limitCarNumberService.vehicleLimitNumberTask();
                    message.setCode(ConstantUtil.M_SUCCESS);
                    message.setMessage("操作成功");
                }
                else
                {
                    message.setCode("0");
                    message.setMessage("操作失败");
                }
            }
            else
            {
                message.setCode(ConstantUtil.M_EXCEPTION);
                message.setMessage("id不能为空！");
                // out(response, message);
            }

            out(response, message);
        }
        catch (Exception exception)
        {
        	SysLogUtil.addLog(request, "删除车辆限号规则", 0);
            Log4jTask.addLog("deleteLimitCarNumberSetting接口报错",
                    System.currentTimeMillis(), Log4jTask.ERROR,
                    LimitCarNumberController.class.getName(), exception);
            message.setCode(ConstantUtil.M_SYSTEM_ERROR);
            message.setMessage("系统发生未知错误");
            this.out(response, message);
        }

    }

    @RequestMapping("/cityList")
    public void cityList(Customer cus, HttpServletResponse response,
            HttpServletRequest request)
    {

        List<Map<String, Object>> list = limitCarNumberService.cityList();
        if (list != null)
        {
            Map<String, Object> tempMap = new HashMap<>();
             tempMap.put("cityId","");
            tempMap.put("city", "请选择");
            list.add(0, tempMap);
            webOut(response, list);
        }

    }

}
