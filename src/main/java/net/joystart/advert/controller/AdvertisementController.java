package net.joystart.advert.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
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

import net.joystart.addvert.service.IAdvertisementService;
import net.joystart.advert.entity.Advertisement;
import net.joystart.common.controller.BaseController;
import net.joystart.common.util.ConstantUtil;
import net.joystart.common.util.MessageResult;
import net.joystart.common.util.PageUtil;
import net.joystart.common.util.SysLogUtil;
import net.joystart.common.util.log.Log4jTask;
import net.joystart.system.entity.SysUser;

/**
 *
 * @author 李大海
 * @create 2016年7月29日 下午2:07:01
 * 获取图片
 */

@Controller
@RequestMapping("/advertisement")
public class AdvertisementController extends BaseController 
{
	@Resource
	private IAdvertisementService advertisementService;
	
	
	@RequestMapping("/advertisementList")
	public void advertisementList(HttpServletRequest request,HttpServletResponse response,Integer imagesType)
	{
		MessageResult messageResult = new MessageResult();
		Map<String,Object>	params = new HashMap<String,Object>();
		HashMap<String,Object>	dataMap = new HashMap<String,Object>();
		
		String title = request.getParameter("title");
        String content = request.getParameter("content");
        String status = request.getParameter("status");
        if (!StringUtils.isBlank(title)) {
            params.put("title","%"+title+"%" );
        }
        if (!StringUtils.isBlank(content)) {
            params.put("content","%"+content+"%" );
        }
        if (!StringUtils.isBlank(status) && !status.equals("-1")) {
            params.put("status",status );
        }
		
		
		if(imagesType == null)
		{
			messageResult.setCode(ConstantUtil.M_PARAMTER_NULL);
			messageResult.setMessage("图片imagesType参数为空！");
			this.out(response, messageResult);
			return;
		}
		
		if(!StringUtils.isBlank(request.getParameter("pageSize")))
		{
			this.pageSize = Integer.valueOf(pageSize);
		}
		if(!StringUtils.isBlank(request.getParameter("pageNumber")))
		{
			this.pageNumber = Integer.valueOf(pageNumber);
		}
		params.put("rowStart",PageUtil.rowStart(this.pageNumber - 1, this.pageSize) );
		params.put("pageSize",this.pageSize );
		params.put("imagesType",imagesType );
		
		try 
		{
		    if (imagesType == 3)
            {
                //类型为3，返回价格图片的地址
		        
		        String url3 = "/jsp/common/jiage.jsp";//bagechuxing/image/2016-09-13/price.png
		        
                List<Advertisement> listR = new ArrayList<Advertisement>();
                Advertisement advert = new Advertisement();
                advert.setTitle("价格");
                advert.setAndroidImgUrl(url3);
                advert.setIosImgUrl(url3);
                advert.setImagetype(3);
                listR.add(advert);
                
                dataMap.put("pageSize", this.pageSize);
                dataMap.put("pageNumber", this.pageNumber);
                dataMap.put("list", listR);
                messageResult.setCode(ConstantUtil.M_SUCCESS);
                messageResult.setMessage("操作成功！");
                messageResult.setData(dataMap);
                this.outWithNull(response, messageResult);
                return;
            }
		    
		    
			List<Advertisement> list = advertisementService.list(params);
			dataMap.put("pageSize", this.pageSize);
			dataMap.put("pageNumber", this.pageNumber);
			dataMap.put("list", list);
			messageResult.setCode(ConstantUtil.M_SUCCESS);
			messageResult.setMessage("操作成功！");
			messageResult.setData(dataMap);
			this.outWithNull(response, messageResult);
		} 
		catch (Exception e) 
		{
		    e.printStackTrace();
			messageResult.setCode(ConstantUtil.M_SYSTEM_ERROR);
			messageResult.setMessage("服务器繁忙，请稍后重试！");
			this.out(response, messageResult);
		    Log4jTask.addLog("获得发票列表/详情 发生错误!", System.currentTimeMillis(), Log4jTask.ERROR, this.getClass().getName(), e);		
			return;
		}
	}
	
	@RequestMapping("/advertisementListWeb")
    public void advertisementListWeb(HttpServletRequest request,HttpServletResponse response,int rows , int page)
    {
        MessageResult messageResult = new MessageResult();
         HashMap<String,Object>   params = new HashMap<String,Object>();
         HashMap<String,Object>    dataMap = new HashMap<String,Object>();
        
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String status = request.getParameter("status");
        String imageType = request.getParameter("imageType");
        String sourceType = request.getParameter("sourceType");
        if (!StringUtils.isBlank(title)) {
            params.put("title","%"+title+"%" );
        }
        if (!StringUtils.isBlank(content)) {
            params.put("content","%"+content+"%" );
        }
        if (!StringUtils.isBlank(status) && !status.equals("-1")) {
            params.put("status",status );
        }
        if (!StringUtils.isBlank(imageType) && !imageType.equals("-1")) {
            params.put("imageType",imageType );
        }
        if (!StringUtils.isBlank(sourceType) && !sourceType.equals("-1")) {
            params.put("sourceType",sourceType );
        }
        
        
//        if(imagesType == null)
//        {
//            messageResult.setCode(ConstantUtil.M_PARAMTER_NULL);
//            messageResult.setMessage("图片imagesType参数为空！");
//            this.out(response, messageResult);
//            return;
//        }
        
        params.put("rowStart",PageUtil.rowStart(page - 1, rows) );
        params.put("pageSize",rows );
        
        //params.put("imagesType","1" );
        
        try 
        {
            List<Advertisement> list = advertisementService.advertisementListWeb(params);
            int countAdvert = advertisementService.getCount(params);

            HashMap<String, Object> messageMap = new HashMap<String, Object>();
            messageMap.put("pageSize", this.pageSize);
            messageMap.put("pageNumber", this.pageNumber);
            messageMap.put("total", countAdvert);
            messageMap.put("rows", list);
            this.webOut(response, messageMap);
        } 
        catch (Exception e) 
        {
            e.printStackTrace();
            messageResult.setCode(ConstantUtil.M_SYSTEM_ERROR);
            messageResult.setMessage("服务器繁忙，请稍后重试！");
            this.out(response, messageResult);
            Log4jTask.addLog("获得广告列表/详情 发生错误!", System.currentTimeMillis(), Log4jTask.ERROR, this.getClass().getName(), e);     
            return;
        }
    }
	
	
	@RequestMapping("/deleteAdvert")
    public void deleteAdvert(HttpServletResponse response, HttpServletRequest request,String ids) 
    {
        MessageResult message = new MessageResult();
        try {
        
//        Map<String,Object> params = new HashMap<String,Object>();
        
        if (ids == null || "".equals(ids))
        {
            message.setCode(ConstantUtil.M_EXCEPTION);
            message.setMessage("id不能为空！");
        }
        else 
        {
            
//            params.put("id",id );
             String[]  idsArr = ids.split(",");
            List<String> idStrList = Arrays.asList(idsArr);
            
            
            
            int result = 0;
            result = advertisementService.deleteAdvert(idStrList); 
            
            SysLogUtil.addLog(request, "删除广告", result > 0 ? 1 : 0);
            if (result != 0)
            {
                message.setCode(ConstantUtil.M_SUCCESS);
                message.setMessage("操作成功");
            }
            else
            {
                message.setCode(request+"");
                message.setMessage("操作失败");
            }
        }
                
        out(response, message);
        } catch (Exception exception) {
        	SysLogUtil.addLog(request, "删除广告", 0);
            Log4jTask.addLog("删除广告接口报错", System.currentTimeMillis(), Log4jTask.ERROR,
            		AdvertisementController.class.getName(), exception);
            message.setCode(ConstantUtil.M_SYSTEM_ERROR);
            message.setMessage("系统发生未知错误");
            this.out(response, message);
        }
    
    }
	
	@RequestMapping("/getCityList")
    public void getCityList(HttpServletResponse response, HttpServletRequest request) 
    {
        MessageResult message = new MessageResult();
        try {            
            
            Map<String,Object> params = new HashMap<String,Object>();        
            List<Map<String, Object>> cityNameList = advertisementService.getCityList(params);
            
            if (cityNameList != null)
            {
                this.out(response, cityNameList);
//                message.setCode(ConstantUtil.M_SUCCESS);
//                message.setMessage("操作成功");
            }
            else
            {
                message.setCode("0");
                message.setMessage("操作失败");
                this.out(response, message);
            }
                
        } catch (Exception exception) {
            Log4jTask.addLog("获取城市列表接口报错", System.currentTimeMillis(), Log4jTask.ERROR,
            		AdvertisementController.class.getName(), exception);
            message.setCode(ConstantUtil.M_SYSTEM_ERROR);
            message.setMessage("系统发生未知错误");
            this.out(response, message);
        }
    
    }
	
	
	@RequestMapping("/updateAdvert")
    public void updateAdvert(Advertisement advert , HttpServletResponse response, HttpServletRequest request) 
    {
        MessageResult message = new MessageResult();
        try {            
            
//            String sourceType = request.getParameter("sourceType");
//            advert.setSourcetype(Integer.parseInt(sourceType) );
//            
//            if (sourceType.equals("1"))
//            {
//                //小图，轮播图，手机端1是大图，2是小图
//                advert.setImagetype(2);
//                advert.setShowtype((byte) 1);
//            }
//            else if(sourceType.equals("2"))
//            {
//                //大图，欢迎图
//                advert.setImagetype(1);
//                advert.setShowtype((byte) 0);
//            }
            
            String imgUrl = request.getParameter("advertImgPath");
            String imgUrl1 = request.getParameter("advertImgPath1");
            
            String imgUrlA = request.getParameter("advertImgPathA");
            String imgUrl1A = request.getParameter("advertImgPath1A");
            if (imgUrl != null && !"".equals(imgUrl))
            {
                advert.setIosImgUrl(imgUrl);
            }
            else if (imgUrl1 != null && !"".equals(imgUrl1)) {
                advert.setIosImgUrl(imgUrl1);
            }
            
            if (imgUrlA != null && !"".equals(imgUrlA))
            {
                advert.setAndroidImgUrl(imgUrlA);;
            }
            else if (imgUrl1A != null && !"".equals(imgUrl1A)) 
            {
                advert.setAndroidImgUrl(imgUrl1A);
            }
            
            if(null == advert.getId())
            {
                
                advert.setCreatedate(new Date()); 
//                advert.setSourcetype(1);
                
                SysUser sysUser = (SysUser)request.getSession().getAttribute("user");
                advert.setCreateuser(sysUser.getId());
                //advert.setCreateuser(1);
                
//                List<Advertisement> rrList = this.advertisementService.getAdvertByKeys(advert);
//                
//                if (!(rrList == null || rrList.size()==0))
//                {
//                    message.setCode(ConstantUtil.M_REQUEST_INCORRECT);
//                    message.setMessage("显示顺序重复，请重新添加");
//                    this.out(response, message);
//                    return;
//                }
                if(!StringUtils.isBlank(advert.getImglink()))
                {
                	if(!advert.getImglink().startsWith("http") && !advert.getImglink().startsWith("https"))
                	{
                		advert.setImglink("http://"+advert.getImglink());
                	}
                }
                
                int result = 0;
                result = this.advertisementService.addAdvert(advert);
                SysLogUtil.addLog(request, "添加广告", result > 0 ? 1 : 0);
                if (result != 0)
                {
                    message.setCode(ConstantUtil.M_SUCCESS);
                    message.setMessage("操作成功");
                    this.out(response, message);
                    return;
                }
                else {
                    message.setCode(ConstantUtil.M_REQUEST_INCORRECT);
                    message.setMessage("请求不合法");
                    this.out(response, message);
                    return;
                }
                
            }
            
            //修改
//            String imgUrl = request.getParameter("advertImgPath");
//            if (imgUrl != null && !"".equals(imgUrl))
//            {
//                advert.setImgurl(imgUrl);
//            }
            
            advert.setModifydate(new Date()); 
            //advert.setSourcetype(1);
            
            SysUser sysUser = (SysUser)request.getSession().getAttribute("user");
            advert.setMofifyuser(sysUser.getId());
            //advert.setMofifyuser(1);

            int resultM = 0; 
            resultM = this.advertisementService.updateAdvert(advert);
            
            SysLogUtil.addLog(request, "更新广告", resultM);
            
            if (resultM != 0)
            {
                message.setCode(ConstantUtil.M_SUCCESS);
                message.setMessage("操作成功");
                this.out(response, message);
                return;
            }
            else {
                message.setCode(ConstantUtil.M_REQUEST_INCORRECT);;
                this.out(response, message);
                return;
            }
                  
                
        } catch (Exception exception) {
            Log4jTask.addLog("新增或修改广告接口报错", System.currentTimeMillis(), Log4jTask.ERROR,
            		AdvertisementController.class.getName(), exception);
            message.setCode(ConstantUtil.M_SYSTEM_ERROR);
            message.setMessage("系统发生未知错误");
            this.out(response, message);
        }
    
    }
	
	
	@RequestMapping("/selectAdvert")
    public void selectAdvert(HttpServletResponse response, HttpServletRequest request) 
    {
        MessageResult message = new MessageResult();
        try {       
            
            String advertId = request.getParameter("advertId");
            Advertisement advert = this.advertisementService.getAdvertByKey(Integer.valueOf(advertId));
            if (advert.getIosImgUrl() !=null && !"".equals(advert.getIosImgUrl()))
            {
                String imgurl =  advert.getIosImgUrl();
                imgurl = imgurl.replaceAll("\\\\", "/");
            	int lastIndexOf_b = imgurl.lastIndexOf("/");
            	if (lastIndexOf_b != -1) {
            		StringBuilder imgurl_preview_b = new StringBuilder();
                    imgurl_preview_b.append(imgurl.substring(0, lastIndexOf_b));
                    imgurl_preview_b.append(File.separator+"zip"+File.separator);
                    imgurl_preview_b.append(imgurl.substring(lastIndexOf_b+1));
                    advert.setIosImgUrl_pre(imgurl_preview_b.toString());
				}
            }
            if (advert.getAndroidImgUrl() !=null && !"".equals(advert.getAndroidImgUrl()))
            {
                String imgurlA =  advert.getAndroidImgUrl();
                imgurlA = imgurlA.replaceAll("\\\\", "/");
                int lastIndexOf_b = imgurlA.lastIndexOf("/");
                if (lastIndexOf_b != -1) {
                	StringBuilder imgurlA_preview_b = new StringBuilder();
                    imgurlA_preview_b.append(imgurlA.substring(0, lastIndexOf_b));
                    imgurlA_preview_b.append(File.separator+"zip"+File.separator);
                    imgurlA_preview_b.append(imgurlA.substring(lastIndexOf_b+1));
                    advert.setAndroidImgUrl_pre(imgurlA_preview_b.toString());
				}
            }
      
            
            HashMap<String,Object> resuleMap = new HashMap<>();
            resuleMap.put("success", true);
            resuleMap.put("advert", advert);
            this.webOut(response, resuleMap);
            return;
            
           
                                 
                
        } catch (Exception exception) {
            Log4jTask.addLog("获取需要修改的广告接口报错", System.currentTimeMillis(), Log4jTask.ERROR,
            		AdvertisementController.class.getName(), exception);
            message.setCode(ConstantUtil.M_SYSTEM_ERROR);
            message.setMessage("系统发生未知错误");
            this.out(response, message);
        }
    
    }
	
	@RequestMapping("/getContent")
    public void getContent(HttpServletResponse response, HttpServletRequest request) 
    {
        MessageResult message = new MessageResult();
        try {       
            
            String advertId = request.getParameter("id");
            Advertisement advert = this.advertisementService.getAdvertByKey(Integer.valueOf(advertId));
            
            HashMap<String,Object> resuleMap = new HashMap<>();
            resuleMap.put("success", true);
            resuleMap.put("advert", advert);
            this.webOut(response, resuleMap);
            return;
                
        } catch (Exception exception) {
            Log4jTask.addLog("获得广告接口报错", System.currentTimeMillis(), Log4jTask.ERROR,
            		AdvertisementController.class.getName(), exception);
            message.setCode(ConstantUtil.M_SYSTEM_ERROR);
            message.setMessage("系统发生未知错误");
            this.out(response, message);
        }
    
    }




}
