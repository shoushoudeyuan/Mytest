package net.joystart.advert.dao;

import java.util.List;
import java.util.Map;

import net.joystart.advert.entity.Advertisement;

public interface AdvertisementMapper {
	
	List<Advertisement> list(Map<?,?> param);

    int deleteAdvert(List<String> idStrList);

    List<Advertisement> advertisementListWeb(Map<String, Object> params);

    int getCount(Map<String, Object> params);

    List<Map<String, Object>> getCityList(Map<String, Object> params);

    int addAdvert(Advertisement advert);

    Advertisement getAdvertByKey(Integer valueOf);

    int updateAdvert(Advertisement advert);

    List<Advertisement> getAdvertByKeys(Advertisement advert);
}