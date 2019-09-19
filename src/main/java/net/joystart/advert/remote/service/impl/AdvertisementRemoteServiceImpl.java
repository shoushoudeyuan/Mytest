package net.joystart.advert.remote.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.alibaba.dubbo.config.annotation.Service;

import net.joystart.advert.dao.AdvertisementMapper;
import net.joystart.advert.entity.Advertisement;
import net.joystart.advert.remote.service.IAdvertisementRemoteService;

/**
 *
 * @author 李大海
 * @create 2016年7月29日 上午11:50:43
 *
 */
@Service(timeout = 60000, retries = 0)
public class AdvertisementRemoteServiceImpl implements IAdvertisementRemoteService{

	@Resource
	AdvertisementMapper advertisementMapper;
	
	@Override
	public List<Advertisement> list(Map<?,?> param)
	{
		return advertisementMapper.list(param);
	}

    @Override
    public int deleteAdvert(List<String> idStrList)
    {
        // TODO Auto-generated method stub
        return advertisementMapper.deleteAdvert(idStrList);
    }



    @Override
    public List<Advertisement> advertisementListWeb(Map<String, Object> params)
    {
        // TODO Auto-generated method stub
        return advertisementMapper.advertisementListWeb(params);
    }

    @Override
    public int getCount(Map<String, Object> params)
    {
        // TODO Auto-generated method stub
        return advertisementMapper.getCount(params);
    }

    @Override
    public List<Map<String, Object>> getCityList(Map<String, Object> params)
    {
        // TODO Auto-generated method stub
        return advertisementMapper.getCityList(params);
    }

    @Override
    public int addAdvert(Advertisement advert)
    {
        // TODO Auto-generated method stub
        return advertisementMapper.addAdvert(advert);
    }

    @Override
    public Advertisement getAdvertByKey(Integer valueOf)
    {
        // TODO Auto-generated method stub
        return advertisementMapper.getAdvertByKey(valueOf);
    }

    @Override
    public int updateAdvert(Advertisement advert)
    {
        // TODO Auto-generated method stub
        return advertisementMapper.updateAdvert(advert);
    }

    @Override
    public List<Advertisement> getAdvertByKeys(Advertisement advert)
    {
        // TODO Auto-generated method stub
        return advertisementMapper.getAdvertByKeys(advert);
    }
	

}
